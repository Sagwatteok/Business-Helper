package com.bizmate.controller;

import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.format.DateTimeParseException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bizmate.dao.SalesDao;
import com.bizmate.model.Sale;

@WebServlet("/sales/list")
public class SalesListServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private final SalesDao salesDao = new SalesDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Sale> sales;

        try {
            sales = salesDao.findAll();
        } catch (SQLException e) {
            throw new ServletException("매출 목록을 조회하지 못했습니다.", e);
        }

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
        Sale sale = new Sale(saleDate, productName.trim(), quantity, amount, orderNo, orderChannel);

        try {
            salesDao.insert(sale);
        } catch (SQLException e) {
            if ("22003".equals(e.getSQLState())) {
                showFormError(request, response, "누적 매출 금액이 처리 가능한 범위를 초과합니다.");
            } else {
                log("매출 등록 실패", e);
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                showFormError(request, response, "매출을 저장하지 못했습니다. 다시 시도해 주세요.");
            }
            return;
        }

        response.sendRedirect(request.getContextPath() + "/sales/list");
    }

    private void showFormError(HttpServletRequest request, HttpServletResponse response, String message) throws ServletException, IOException {
        request.setAttribute("errorMessage", message);
        request.getRequestDispatcher("/views/sales/sales_form.jsp").forward(request, response);
    }
    
}
