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
import com.bizmate.model.SalesCsvDraft;

@WebServlet("/sales/validate")
public class SalesValidationServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/sales/mapping.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("salesCsvUpload") == null) {
            response.sendRedirect(request.getContextPath() + "/sales/upload");
            return;
        }

        CsvUploadData uploadData = (CsvUploadData) session.getAttribute("salesCsvUpload");

        String amountBasis = request.getParameter("amountBasis");

        if (!"lineTotal".equals(amountBasis) && !"unitPrice".equals(amountBasis)) {
            showMappingError(request, response, "금액 기준을 확인해 주세요.");
            return;
        }

        String[] fieldNames = {
                "saleDateColumn",
                "productNameColumn",
                "quantityColumn",
                "amountColumn",
                "orderNoColumn",
                "orderChannelColumn"
        };

        String[] fieldLabels = {
                "판매일자", "상품명", "수량",
                "금액", "주문번호", "주문 경로"
        };

        Map<String, Integer> mapping = new HashMap<>();
        Set<Integer> selectedColumns = new HashSet<>();

        for (int i = 0; i < fieldNames.length; i++) {
            int column;

            try {
                column = readColumn(
                        request.getParameter(fieldNames[i]),
                        i < 4,
                        uploadData.getHeaders().size());
            } catch (IllegalArgumentException e) {
                showMappingError(request, response,
                        fieldLabels[i] + ": " + e.getMessage());
                return;
            }

            if (column != -1 && !selectedColumns.add(column)) {
                showMappingError(request, response, "같은 열을 여러 항목에 연결할 수 없습니다.");
                return;
            }

            mapping.put(fieldNames[i], column);
        }

        SalesCsvDraft draft = new SalesCsvDraft(uploadData, mapping, amountBasis);

        session.setAttribute("salesCsvDraft", draft);
        request.setAttribute("csvDraftToken", draft.getToken());
        request.setAttribute("csvUpload", uploadData);
        request.setAttribute("csvMapping", mapping);
        request.setAttribute("amountBasis", amountBasis);

        request.getRequestDispatcher("/views/sales/validation.jsp").forward(request, response);
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

        request.getRequestDispatcher("/views/sales/mapping.jsp")
                .forward(request, response);
    }
}