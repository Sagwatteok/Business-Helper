package com.bizmate.controller;

import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeParseException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.bizmate.model.Expense;

@WebServlet("/expense/list")
public class ExpenseListServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @SuppressWarnings("unchecked")
    private List<Expense> getExpenses(HttpSession session) {
        List<Expense> expenses = (List<Expense>) session.getAttribute("expenses");

        if (expenses == null) {
            expenses = new ArrayList<>();

            expenses.add(new Expense(LocalDate.of(2026, 11, 5), "기타", "포장 용기 구입", 32000, ""));
            expenses.add(new Expense(LocalDate.of(2026, 11, 3), "재료비", "원두 구입", 80000, ""));
            expenses.add(new Expense(LocalDate.of(2026, 11, 1), "임대료", "11월 매장 임대료", 700000, ""));

            session.setAttribute("expenses", expenses);
        }
        return expenses;
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession session = request.getSession();
        List<Expense> expenses = getExpenses(session);

        long totalExpenseAmount = 0;

        for (Expense expense : expenses) {
            totalExpenseAmount += expense.getAmount();
        }

        request.setAttribute("expenses", expenses);
        request.setAttribute("totalExpenseAmount", totalExpenseAmount);

        request.getRequestDispatcher("/views/expense/expense_list.jsp").forward(request, response);
    }
    
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String expenseDateValue = request.getParameter("expenseDate");
        String category = request.getParameter("category");
        String description = request.getParameter("description");
        String amountValue = request.getParameter("amount");
        String memo = request.getParameter("memo");

        if (description == null || description.trim().isEmpty()) {
            showFormError(request, response, "지출 내용을 입력해 주세요.");
            return;
        }

        List<String> categories = Arrays.asList("재료비", "임대료", "인건비", "공과금", "기타");

        if (!categories.contains(category)) {
            showFormError(request, response, "분류를 확인해 주세요.");
            return;
        }

        if (expenseDateValue == null || expenseDateValue.trim().isEmpty()) {
            showFormError(request, response, "지출일을 입력해 주세요.");
            return;
        }

        LocalDate expenseDate;

        try {
            expenseDate = LocalDate.parse(expenseDateValue.trim());
        } catch (DateTimeParseException e) {
            showFormError(request, response, "지출일을 올바르게 입력해 주세요.");
            return;
        }

        long amount;

        try {
            amount = Long.parseLong(amountValue);

            if (amount < 1) {
                throw new NumberFormatException();
            }
        } catch (NumberFormatException e) {
            showFormError(request, response, "금액은 1 이상의 정수로 입력해 주세요.");
            return;
        }

        memo = memo == null ? "" : memo.trim();

        HttpSession session = request.getSession();
        List<Expense> expenses = getExpenses(session);

        try {
            long total = amount;

            for (Expense expense : expenses) {
                total = Math.addExact(total, expense.getAmount());
            }
        } catch (ArithmeticException e) {
            showFormError(request, response, "누적 지출 금액이 처리 가능한 범위를 초과합니다.");
            return;
        }

        Expense expense = new Expense(expenseDate, category, description.trim(), amount, memo);

        expenses.add(expense);

        response.sendRedirect(request.getContextPath() + "/expense/list");
    }

    private void showFormError(HttpServletRequest request, HttpServletResponse response, String message) throws ServletException, IOException {

        request.setAttribute("errorMessage", message);

        request.getRequestDispatcher("/views/expense/expense_form.jsp") .forward(request, response);
    }
}