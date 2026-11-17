package com.bizmate.controller;

import java.io.IOException;
import java.time.LocalDate;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.bizmate.model.Expense;
import com.bizmate.model.ProductSalesSummary;
import com.bizmate.model.Sale;

@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    @SuppressWarnings("unchecked")
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        List<Sale> sales = (List<Sale>) session.getAttribute("sales");

        List<Expense> expenses = (List<Expense>) session.getAttribute("expenses");

        LocalDate today = LocalDate.now(ZoneId.of("Asia/Seoul")); //한국 시간 기준 오늘 날짜

        long todaySalesAmount = 0;
        long todayExpenseAmount = 0;

        if (sales != null) {
            for (Sale sale : sales) {
                if (today.equals(sale.getSaleDate().toLocalDate())) {
                    todaySalesAmount += sale.getAmount();
                }
            }
        }

        if (expenses != null) {
            for (Expense expense : expenses) {
                if (today.equals(expense.getExpenseDate())) {
                    todayExpenseAmount += expense.getAmount();
                }
            }
        }

        long todayBalance = todaySalesAmount - todayExpenseAmount;

        LocalDate weeklySalesStartDate = today.minusDays(6);
        DateTimeFormatter labelFormatter = DateTimeFormatter.ofPattern("MM/dd");

        List<String> weeklySalesLabels = new ArrayList<>();
        List<Long> weeklySalesAmounts = new ArrayList<>();
        long weeklySalesTotal = 0;

        for (int i = 0; i < 7; i++) {
            LocalDate date = weeklySalesStartDate.plusDays(i);
            long dailyAmount = 0;

            if (sales != null) {
                for (Sale sale : sales) {
                    if (date.equals(sale.getSaleDate().toLocalDate())) {
                        dailyAmount += sale.getAmount();
                    }
                }
            }

            weeklySalesLabels.add(date.format(labelFormatter));
            weeklySalesAmounts.add(dailyAmount);
            weeklySalesTotal += dailyAmount;
        }
        
        Map<String, ProductSalesSummary> productSummaries = new HashMap<>();

        if (sales != null) {
            for (Sale sale : sales) {
                LocalDate saleDate = sale.getSaleDate().toLocalDate();

                if (saleDate.isBefore(weeklySalesStartDate) || saleDate.isAfter(today)) {
                    continue;
                }

                String productName = sale.getProductName();
                ProductSalesSummary summary = productSummaries.get(productName);

                if (summary == null) {
                    summary = new ProductSalesSummary(productName, 0, 0);
                    productSummaries.put(productName, summary);
                }

                summary.setTotalQuantity(summary.getTotalQuantity() + sale.getQuantity());
                summary.setTotalAmount(summary.getTotalAmount() + sale.getAmount());
            }
        }

        List<ProductSalesSummary> topProducts = new ArrayList<>(productSummaries.values());

        topProducts.sort(
                Comparator.comparingLong(ProductSalesSummary::getTotalQuantity)
                        .reversed()
                        .thenComparing(Comparator.comparingLong(ProductSalesSummary::getTotalAmount).reversed())
                        .thenComparing(ProductSalesSummary::getProductName));

        if (topProducts.size() > 3) {
            topProducts = new ArrayList<>(topProducts.subList(0, 3));
        }
        
        request.setAttribute("dashboardDate", today);
        request.setAttribute("todaySalesAmount", todaySalesAmount);
        request.setAttribute("todayExpenseAmount", todayExpenseAmount);
        request.setAttribute("todayBalance", todayBalance);
        request.setAttribute("weeklySalesStartDate", weeklySalesStartDate);
        request.setAttribute("weeklySalesLabels", weeklySalesLabels);
        request.setAttribute("weeklySalesAmounts", weeklySalesAmounts);
        request.setAttribute("weeklySalesTotal", weeklySalesTotal);
        request.setAttribute("topProducts", topProducts);
        
        request.getRequestDispatcher("/views/dashboard.jsp").forward(request, response);
    }
}