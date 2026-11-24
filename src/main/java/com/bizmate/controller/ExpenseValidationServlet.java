package com.bizmate.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.bizmate.model.CsvUploadData;
import com.bizmate.model.ExpenseCsvDraft;

@WebServlet("/expense/validate")
public class ExpenseValidationServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/expense/expense_mapping.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("expenseCsvUpload") == null) {
            response.sendRedirect(request.getContextPath() + "/expense/upload");
            return;
        }

        CsvUploadData uploadData = (CsvUploadData) session.getAttribute("expenseCsvUpload");

        String[] fieldNames = {"expenseDateColumn", "categoryColumn", "descriptionColumn", "amountColumn", "memoColumn"};
        String[] fieldLabels = {"지출일", "분류", "지출 내용", "금액", "메모"};

        Map<String, Integer> mapping = new HashMap<>();
        Set<Integer> selectedColumns = new HashSet<>();

        for (int i = 0; i < fieldNames.length; i++) {
            int column;

            try {
                column = readColumn(request.getParameter(fieldNames[i]), i < 4, uploadData.getHeaders().size());
            } catch (IllegalArgumentException e) {
                showMappingError(request, response, fieldLabels[i] + ": " + e.getMessage());
                return;
            }

            if (column != -1 && !selectedColumns.add(column)) {
                showMappingError(request, response, "같은 열을 여러 항목에 연결할 수 없습니다.");
                return;
            }

            mapping.put(fieldNames[i], column);
        }

        ExpenseCsvDraft draft = new ExpenseCsvDraft(uploadData, mapping);
        session.setAttribute("expenseCsvDraft", draft);
        request.setAttribute("csvDraftToken", draft.getToken());
        request.setAttribute("csvUpload", uploadData);
        request.setAttribute("csvMapping", mapping);

        request.getRequestDispatcher("/views/expense/expense_review.jsp").forward(request, response);
    }

    private int readColumn(String value, boolean required, int columnCount) {
        if (value == null || value.isEmpty()) {
            if (required) {
                throw new IllegalArgumentException("열을 선택해 주세요.");
            }

            return -1;
        }

        int column;

        try {
            column = Integer.parseInt(value);
        } catch (NumberFormatException e) {
            throw new IllegalArgumentException("열 번호가 올바르지 않습니다.");
        }

        if (column < 0 || column >= columnCount) {
            throw new IllegalArgumentException("파일에 없는 열입니다.");
        }

        return column;
    }

    private void showMappingError(HttpServletRequest request, HttpServletResponse response, String message) throws ServletException, IOException {
        request.setAttribute("mappingError", message);
        request.getRequestDispatcher("/views/expense/expense_mapping.jsp").forward(request, response);
    }
}