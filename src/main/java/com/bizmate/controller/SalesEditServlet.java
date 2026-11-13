package com.bizmate.controller;

import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeParseException;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.bizmate.model.Sale;

@WebServlet("/sales/edit")
public class SalesEditServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    @SuppressWarnings("unchecked")
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession session = request.getSession();

        List<Sale> sales = (List<Sale>) session.getAttribute("sales");

        if (sales == null) {
            response.sendRedirect(request.getContextPath() + "/sales/list");
            return;
        }

        long totalSalesAmount = 0;

        for (Sale sale : sales) {
            totalSalesAmount += sale.getAmount();
        }

        request.setAttribute("sales", sales);
        request.setAttribute("totalSalesAmount", totalSalesAmount);

        request.getRequestDispatcher("/views/sales/sales_edit.jsp").forward(request, response);
    }

    @Override
    @SuppressWarnings("unchecked")
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("sales") == null) {
            response.sendRedirect(request.getContextPath() + "/sales/list");
            return;
        }

        List<Sale> sales = (List<Sale>) session.getAttribute("sales");

        String[] saleIds = getValues(request, "saleId");
        String[] saleDates = getValues(request, "saleDate");
        String[] productNames = getValues(request, "productName");
        String[] quantities = getValues(request, "quantity");
        String[] amounts = getValues(request, "amount");
        String[] orderChannels = getValues(request, "orderChannel");
        String[] deletedSaleIds = getValues(request, "deletedSaleId");

        if (saleIds == null || saleDates == null || productNames == null
                || quantities == null || amounts == null
                || orderChannels == null) {

            showEditError(request, response, "수정할 매출 정보를 확인해 주세요.");
            return;
        }

        int count = saleIds.length;

        if (saleDates.length != count || productNames.length != count
                || quantities.length != count || amounts.length != count
                || orderChannels.length != count) {

            showEditError(request, response, "전송된 매출 정보의 개수가 맞지 않습니다.");
            return;
        }

        List<Sale> targets = new ArrayList<>();
        List<Sale> deleteTargets = new ArrayList<>();
        Set<String> checkedIds = new HashSet<>();

        for (int i = 0; i < count; i++) {
            if (!checkedIds.add(saleIds[i])) {
                showEditError(request, response, "같은 매출이 중복 전송되었습니다.");
                return;
            }

            Sale target = findSale(sales, saleIds[i]);

            if (target == null) {
                showEditError(request, response, "목록에 없는 매출입니다. 수정 화면을 다시 열어 주세요.");
                return;
            }

            String errorMessage = validateSale(saleDates[i], productNames[i], quantities[i], amounts[i]);

            if (errorMessage != null) {
                showEditError(request, response, (i + 1) + "번째 매출: " + errorMessage);
                return;
            }

            targets.add(target);
        }

        //합계 검사 전에 삭제 대상 검사
        for (String saleId : deletedSaleIds) {
            if (!checkedIds.add(saleId)) {
                showEditError(request, response, "수정 또는 삭제 대상 매출 ID가 중복되었습니다.");
                return;
            }

            Sale target = findSale(sales, saleId);

            if (target == null) {
                showEditError(request, response, "삭제할 매출이 없습니다. 수정 화면을 다시 열어 주세요.");
                return;
            }

            deleteTargets.add(target);
        }
        
        try {
            long total = 0;

            for (Sale sale : sales) {
                if (!checkedIds.contains(sale.getSaleId())) {
                    total = Math.addExact(total, sale.getAmount());
                }
            }

            for (String amount : amounts) {
                total = Math.addExact(total, Long.parseLong(amount));
            }
        } catch (ArithmeticException e) {
            showEditError(request, response, "누적 매출 금액이 처리 가능한 범위를 초과합니다.");
            return;
        }

        //모든 검사가 끝난 뒤 세션의 기존 매출 객체 수정
        for (int i = 0; i < count; i++) {
            Sale target = targets.get(i);

            target.setSaleDate(LocalDateTime.parse(saleDates[i].trim()));
            target.setProductName(productNames[i].trim());
            target.setQuantity(Integer.parseInt(quantities[i]));
            target.setAmount(Long.parseLong(amounts[i]));
            target.setOrderChannel(orderChannels[i].trim());
        }
        
        sales.removeAll(deleteTargets);
        
        //목록으로 이동해 수정된 매출과 합계 표시
        response.sendRedirect(request.getContextPath() + "/sales/list");
    }

    //매출 조회 메서드
    private Sale findSale(List<Sale> sales, String saleId) {
        for (Sale sale : sales) {
            if (sale.getSaleId().equals(saleId)) {
                return sale;
            }
        }

        return null;
    }

    //문제가 있으면 오류 문구 반환, 모두 정상이면 null 반환
    private String validateSale(String saleDateValue, String productName, String quantityValue, String amountValue) {

        if (productName == null || productName.trim().isEmpty()) {
            return "상품명을 입력해 주세요.";
        }

        if (saleDateValue == null || saleDateValue.trim().isEmpty()) {
            return "판매일시를 입력해 주세요.";
        }

        try {
            LocalDateTime.parse(saleDateValue.trim());
        } catch (DateTimeParseException e) {
            return "판매일시를 올바르게 입력해 주세요.";
        }

        try {
            int quantity = Integer.parseInt(quantityValue);
            long amount = Long.parseLong(amountValue);

            if (quantity < 1 || amount < 1) {
                return "수량과 품목 합계는 1 이상의 정수로 입력해 주세요.";
            }
        } catch (NumberFormatException e) {
            return "수량과 품목 합계는 1 이상의 정수로 입력해 주세요.";
        }

        return null;
    }

    private void showEditError(HttpServletRequest request, HttpServletResponse response, String message) throws ServletException, IOException {
        request.setAttribute("errorMessage", message);
        doGet(request, response);
    }
    
    private String[] getValues(HttpServletRequest request, String name) {
        String[] values = request.getParameterValues(name);
        return values == null ? new String[0] : values;
    }
}