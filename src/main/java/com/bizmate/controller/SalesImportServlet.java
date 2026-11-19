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
import com.bizmate.model.Sale;
import com.bizmate.model.SalesCsvDraft;
import com.bizmate.util.SalesCsvConverter;

@WebServlet("/sales/import")
public class SalesImportServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/sales/upload");
    }

    @Override
    @SuppressWarnings("unchecked")
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);

        if (session == null) {
            response.sendRedirect(request.getContextPath() + "/sales/upload");
            return;
        }

        synchronized (session) {
            SalesCsvDraft draft = (SalesCsvDraft) session.getAttribute("salesCsvDraft");

            if (draft == null) {
                response.sendRedirect(request.getContextPath() + "/sales/upload");
                return;
            }

            String token = request.getParameter("csvDraftToken");

            if (!draft.getToken().equals(token)) {
                response.sendError(HttpServletResponse.SC_CONFLICT, "저장 준비 정보가 변경됐습니다. 파일을 다시 확인해 주세요.");
                return;
            }

            String[] rowIndexes = request.getParameterValues("rowIndex");
            String[] saleDates = request.getParameterValues("saleDate");
            String[] productNames = request.getParameterValues("productName");
            String[] quantities = request.getParameterValues("quantity");
            String[] amounts = request.getParameterValues("amount");

            int count = draft.getUploadData().getRowCount();

            if (!matchesCount(rowIndexes, count)
                    || !matchesCount(saleDates, count)
                    || !matchesCount(productNames, count)
                    || !matchesCount(quantities, count)
                    || !matchesCount(amounts, count)) {

                showImportError(request, response, draft, "전송된 데이터 개수가 맞지 않습니다. 입력 내용을 확인해 주세요.");
                return;
            }

            List<Sale> newSales = new ArrayList<>();

            for (int i = 0; i < count; i++) {
                try {
                    int rowIndex = Integer.parseInt(rowIndexes[i]);

                    if (rowIndex != i) {
                        throw new IllegalArgumentException("원본 행의 순서가 맞지 않습니다.");
                    }

                    Sale sale = SalesCsvConverter.createSale(draft, rowIndex, saleDates[i], productNames[i], quantities[i], amounts[i]);
                    newSales.add(sale);

                } catch (IllegalArgumentException e) {
                    showImportError(request, response, draft, (i + 1) + "번째 데이터: " + e.getMessage());
                    return;
                }
            }

            List<Sale> sales = (List<Sale>) session.getAttribute("sales");

            if (sales == null) {
                sales = new ArrayList<>();
            }

            try {
                long total = 0;

                for (Sale sale : sales) {
                    total = Math.addExact(total, sale.getAmount());
                }

                for (Sale sale : newSales) {
                    total = Math.addExact(total, sale.getAmount());
                }

            } catch (ArithmeticException e) {
                showImportError(request, response, draft, "누적 매출 금액이 처리 가능한 범위를 초과합니다.");
                return;
            }

            sales.addAll(newSales);
            session.setAttribute("sales", sales);

            session.removeAttribute("salesCsvDraft");
            session.removeAttribute("salesCsvUpload");

            response.sendRedirect(request.getContextPath() + "/sales/list");
        }
    }

    private boolean matchesCount(String[] values, int count) {
        return values != null && values.length == count;
    }

    private void showImportError(HttpServletRequest request, HttpServletResponse response, SalesCsvDraft draft, String message) throws ServletException, IOException {

        CsvUploadData original = draft.getUploadData();
        List<List<String>> reviewRows = new ArrayList<>();

        for (List<String> row : original.getRows()) {
            reviewRows.add(new ArrayList<>(row));
        }

        String[] fieldNames = {"saleDate", "productName", "quantity", "amount"};
        String[] columnNames = {"saleDateColumn", "productNameColumn", "quantityColumn", "amountColumn"};

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
        request.setAttribute("amountBasis", draft.getAmountBasis());
        request.setAttribute("csvDraftToken", draft.getToken());

        request.getRequestDispatcher("/views/sales/validation.jsp").forward(request, response);
    }
}