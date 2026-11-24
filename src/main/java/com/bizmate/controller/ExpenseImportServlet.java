package com.bizmate.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.bizmate.model.CsvUploadData;
import com.bizmate.model.Expense;
import com.bizmate.model.ExpenseCsvDraft;
import com.bizmate.util.ExpenseCsvConverter;

//전체 검사를 통과했을 때만 지출 목록에 추가
@WebServlet("/expense/import")
public class ExpenseImportServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/expense/upload");
    }

    @Override
    @SuppressWarnings("unchecked")
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);

        if (session == null) {
            response.sendRedirect(request.getContextPath() + "/expense/upload");
            return;
        }

        synchronized (session) {
            ExpenseCsvDraft draft = (ExpenseCsvDraft) session.getAttribute("expenseCsvDraft");

            if (draft == null) {
                response.sendRedirect(request.getContextPath() + "/expense/upload");
                return;
            }

            String token = request.getParameter("csvDraftToken");

            if (!draft.getToken().equals(token)) {
                response.sendError(HttpServletResponse.SC_CONFLICT, "저장 준비 정보가 변경됐습니다. 파일을 다시 확인해 주세요.");
                return;
            }

            String[] rowIndexes = request.getParameterValues("rowIndex");
            String[] expenseDates = request.getParameterValues("expenseDate");
            String[] categories = request.getParameterValues("category");
            String[] descriptions = request.getParameterValues("description");
            String[] amounts = request.getParameterValues("amount");
            String[] memos = request.getParameterValues("memo");

            int count = draft.getUploadData().getRowCount();

            if (!matchesCount(rowIndexes, count) || !matchesCount(expenseDates, count) || !matchesCount(categories, count) || !matchesCount(descriptions, count) || !matchesCount(amounts, count) || !matchesCount(memos, count)) {
                showImportError(request, response, draft, "전송된 데이터 개수가 맞지 않습니다. 입력 내용을 확인해 주세요.");
                return;
            }

            List<Expense> newExpenses = new ArrayList<>();

            for (int i = 0; i < count; i++) {
                try {
                    int rowIndex = Integer.parseInt(rowIndexes[i]);

                    if (rowIndex != i) {
                        throw new IllegalArgumentException("원본 행의 순서가 맞지 않습니다.");
                    }

                    Expense expense = ExpenseCsvConverter.createExpense(draft, rowIndex, expenseDates[i], categories[i], descriptions[i], amounts[i], memos[i]);
                    newExpenses.add(expense);

                } catch (IllegalArgumentException e) {
                    showImportError(request, response, draft, (i + 1) + "번째 데이터: " + e.getMessage());
                    return;
                }
            }

            List<Expense> expenses = (List<Expense>) session.getAttribute("expenses");

            if (expenses == null) {
                expenses = new ArrayList<>();
            }

            try {
                long total = 0;

                for (Expense expense : expenses) {
                    total = Math.addExact(total, expense.getAmount());
                }

                for (Expense expense : newExpenses) {
                    total = Math.addExact(total, expense.getAmount());
                }

            } catch (ArithmeticException e) {
                showImportError(request, response, draft, "누적 지출 금액이 처리 가능한 범위를 초과합니다.");
                return;
            }

            expenses.addAll(newExpenses);
            session.setAttribute("expenses", expenses);

            session.removeAttribute("expenseCsvDraft");
            session.removeAttribute("expenseCsvUpload");

            response.sendRedirect(request.getContextPath() + "/expense/list");
        }
    }

    private boolean matchesCount(String[] values, int count) {
        return values != null && values.length == count;
    }

    private void showImportError(HttpServletRequest request, HttpServletResponse response, ExpenseCsvDraft draft, String message) throws ServletException, IOException {
        CsvUploadData original = draft.getUploadData();
        List<List<String>> reviewRows = new ArrayList<>();

        for (List<String> row : original.getRows()) {
            reviewRows.add(new ArrayList<>(row));
        }

        String[] fieldNames = {"expenseDate", "category", "description", "amount"};
        String[] columnNames = {"expenseDateColumn", "categoryColumn", "descriptionColumn", "amountColumn"};

        for (int field = 0; field < fieldNames.length; field++) {
            String[] values = request.getParameterValues(fieldNames[field]);

            if (values == null) {
                continue;
            }

            int column = draft.getMapping().get(columnNames[field]);

            for (int i = 0; i < reviewRows.size() && i < values.length; i++) {
                reviewRows.get(i).set(column, values[i]);
            }
        }

        CsvUploadData reviewData = new CsvUploadData(original.getFileName(), original.getHeaders(), reviewRows);

        request.setAttribute("importError", message);
        request.setAttribute("csvUpload", reviewData);
        request.setAttribute("csvMapping", draft.getMapping());
        request.setAttribute("csvDraftToken", draft.getToken());

        request.getRequestDispatcher("/views/expense/expense_review.jsp").forward(request, response);
    }
}