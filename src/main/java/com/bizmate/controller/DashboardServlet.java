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

        String salesPeriod = request.getParameter("period");
        LocalDate salesStartDate;
        String salesPeriodLabel;

        switch (salesPeriod == null ? "7d" : salesPeriod) {
            case "1m":
                salesStartDate = today.minusMonths(1).plusDays(1);
                salesPeriodLabel = "최근 한 달";
                break;
            case "3m":
                salesStartDate = today.minusMonths(3).plusDays(1);
                salesPeriodLabel = "최근 3개월";
                break;
            case "6m":
                salesStartDate = today.minusMonths(6).plusDays(1);
                salesPeriodLabel = "최근 6개월";
                break;
            case "1y":
                salesStartDate = today.minusYears(1).plusDays(1);
                salesPeriodLabel = "최근 1년";
                break;
            default:
                salesPeriod = "7d";
                salesStartDate = today.minusDays(6);
                salesPeriodLabel = "최근 7일";
                break;
        }

        DateTimeFormatter labelFormatter = DateTimeFormatter.ofPattern("MM/dd");
        Map<LocalDate, Long> dailySales = new HashMap<>();

        if (sales != null) {
            for (Sale sale : sales) {
                LocalDate saleDate = sale.getSaleDate().toLocalDate();

                if (!saleDate.isBefore(salesStartDate) && !saleDate.isAfter(today)) {
                    dailySales.put(saleDate, dailySales.getOrDefault(saleDate, 0L) + sale.getAmount());
                }
            }
        }

        List<String> salesLabels = new ArrayList<>();
        List<Long> salesAmounts = new ArrayList<>();
        long salesTotal = 0;

        for (LocalDate date = salesStartDate; !date.isAfter(today); date = date.plusDays(1)) {
            long dailyAmount = dailySales.getOrDefault(date, 0L);
            salesLabels.add(date.format(labelFormatter));
            salesAmounts.add(dailyAmount);
            salesTotal += dailyAmount;
        }

        LocalDate topProductsStartDate = today.minusDays(6);
        Map<String, ProductSalesSummary> productSummaries = new HashMap<>();

        if (sales != null) {
            for (Sale sale : sales) {
                LocalDate saleDate = sale.getSaleDate().toLocalDate();

                if (saleDate.isBefore(topProductsStartDate) || saleDate.isAfter(today)) {
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
        request.setAttribute("salesPeriod", salesPeriod);
        request.setAttribute("salesPeriodLabel", salesPeriodLabel);
        request.setAttribute("salesStartDate", salesStartDate);
        request.setAttribute("salesLabels", salesLabels);
        request.setAttribute("salesAmounts", salesAmounts);
        request.setAttribute("salesTotal", salesTotal);
        request.setAttribute("topProducts", topProducts);
        
        request.getRequestDispatcher("/views/dashboard.jsp").forward(request, response);
    }
}
