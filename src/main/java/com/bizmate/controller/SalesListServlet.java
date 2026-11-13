package com.bizmate.controller;

import java.io.IOException;
import java.time.LocalDateTime;
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
}