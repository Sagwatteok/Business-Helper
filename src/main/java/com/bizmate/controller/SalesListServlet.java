package com.bizmate.controller;

import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeParseException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.bizmate.model.Sale;

@WebServlet("/sales/list")
public class SalesListServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @SuppressWarnings("unchecked")
    private List<Sale> getSales(HttpSession session) {
        List<Sale> sales = (List<Sale>) session.getAttribute("sales");

        if (sales == null) {
            sales = new ArrayList<>();

            sales.add(new Sale(
                    LocalDateTime.of(2026, 11, 1, 9, 12),
                    "아메리카노", 2, 9000, "", "매장 POS"));

            sales.add(new Sale(
                    LocalDateTime.of(2026, 11, 1, 9, 18),
                    "카페라떼", 1, 5500, "", "키오스크"));

            sales.add(new Sale(
                    LocalDateTime.of(2026, 11, 1, 9, 25),
                    "바닐라라떼", 1, 6000, "", "배달의민족"));

            session.setAttribute("sales", sales);
        }

        return sales;
    }

    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        List<Sale> sales = getSales(session);

        long totalSalesAmount = 0;

        for (Sale sale : sales) {
            totalSalesAmount += sale.getAmount();
        }

        request.setAttribute("sales", sales);
        request.setAttribute("totalSalesAmount", totalSalesAmount);

        request.getRequestDispatcher("/views/sales/sales_list.jsp")
                .forward(request, response);
    }
    
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String saleDateValue = request.getParameter("saleDate");
        String productName = request.getParameter("productName");
        String quantityValue = request.getParameter("quantity");
        String amountValue = request.getParameter("amount");
        String orderNo = request.getParameter("orderNo");
        String orderChannel = request.getParameter("orderChannel");

        if (productName == null || productName.trim().isEmpty()) {
            showFormError(request, response, "상품명을 입력해 주세요.");
            return;
        }

        if (saleDateValue == null || saleDateValue.trim().isEmpty()) {
            showFormError(request, response, "판매일시를 입력해 주세요.");
            return;
        }

        LocalDateTime saleDate;

        try {
            saleDate = LocalDateTime.parse(saleDateValue.trim());
        } catch (DateTimeParseException e) {
            showFormError(request, response, "판매일시를 올바르게 입력해 주세요.");
            return;
        }

        int quantity;
        long amount;

        try {
            quantity = Integer.parseInt(quantityValue);
            amount = Long.parseLong(amountValue);

            if (quantity < 1 || amount < 1) {
                throw new NumberFormatException();
            }
        } catch (NumberFormatException e) {
            showFormError(request, response, "수량과 품목 합계는 1 이상의 정수로 입력해 주세요.");
            return;
        }

        orderNo = orderNo == null ? "" : orderNo.trim();
        orderChannel = orderChannel == null ? "" : orderChannel.trim();

        HttpSession session = request.getSession();
        List<Sale> sales = getSales(session);

        try {
            long total = amount;

            for (Sale sale : sales) {
                total = Math.addExact(total, sale.getAmount());
            }
        } catch (ArithmeticException e) {
            showFormError(request, response, "누적 매출 금액이 처리 가능한 범위를 초과합니다.");
            return;
        }

        Sale sale = new Sale(
                saleDate, productName.trim(), quantity,
                amount, orderNo, orderChannel);

        sales.add(sale);

        response.sendRedirect(request.getContextPath() + "/sales/list");
    }

    private void showFormError(HttpServletRequest request, HttpServletResponse response, String message) throws ServletException, IOException {
        request.setAttribute("errorMessage", message);
        request.getRequestDispatcher("/views/sales/sales_form.jsp").forward(request, response);
    }
    
}