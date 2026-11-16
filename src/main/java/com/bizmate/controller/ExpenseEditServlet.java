package com.bizmate.controller;

import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeParseException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.bizmate.model.Expense;

//수정 JSP에 지출 목록과 합계 전달
@WebServlet("/expense/edit")
public class ExpenseEditServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    @SuppressWarnings("unchecked")
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        List<Expense> expenses = (List<Expense>) session.getAttribute("expenses");

        if (expenses == null) {
            response.sendRedirect(request.getContextPath() + "/expense/list");
            return;
        }

        long totalExpenseAmount = 0;

        for (Expense expense : expenses) {
            totalExpenseAmount += expense.getAmount();
        }

        request.setAttribute("expenses", expenses);
        request.setAttribute("totalExpenseAmount", totalExpenseAmount);

        request.getRequestDispatcher("/views/expense/expense_edit.jsp").forward(request, response);
    }
    
    //세션 목록에서 전달받은 ID와 같은 지출 찾기
    private Expense findExpense(List<Expense> expenses, String expenseId) {
        for (Expense expense : expenses) {
            if (expense.getExpenseId().equals(expenseId)) {
                return expense;
            }
        }

        return null;
    }
    
    @Override
    @SuppressWarnings("unchecked")
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("expenses") == null) {
            response.sendRedirect(request.getContextPath() + "/expense/list");
            return;
        }

        List<Expense> expenses = (List<Expense>) session.getAttribute("expenses");

        String[] expenseIds = getValues(request, "expenseId");
        String[] expenseDates = getValues(request, "expenseDate");
        String[] categories = getValues(request, "category");
        String[] descriptions = getValues(request, "description");
        String[] amounts = getValues(request, "amount");
        String[] deletedExpenseIds = getValues(request, "deletedExpenseId");

        int count = expenseIds.length;

        if (expenseDates.length != count || categories.length != count
                || descriptions.length != count || amounts.length != count) {

            showEditError(request, response, "전송된 지출 정보의 개수가 맞지 않습니다.");
            return;
        }

        List<Expense> targets = new ArrayList<>();
        List<Expense> deleteTargets = new ArrayList<>();
        Set<String> checkedIds = new HashSet<>();

        for (int i = 0; i < count; i++) {
            if (!checkedIds.add(expenseIds[i])) {
                showEditError(request, response, "같은 지출이 중복 전송되었습니다.");
                return;
            }

            Expense target = findExpense(expenses, expenseIds[i]);

            if (target == null) {
                showEditError(request, response, "목록에 없는 지출입니다. 수정 화면을 다시 열어 주세요.");
                return;
            }

            String errorMessage = validateExpense(
                    expenseDates[i], categories[i], descriptions[i], amounts[i]);

            if (errorMessage != null) {
                showEditError(request, response, (i + 1) + "번째 지출: " + errorMessage);
                return;
            }

            targets.add(target);
        }

        //합계 검사 전에 삭제 대상 검사
        for (String expenseId : deletedExpenseIds) {
            if (!checkedIds.add(expenseId)) {
                showEditError(request, response, "수정 또는 삭제 대상 지출 ID가 중복되었습니다.");
                return;
            }

            Expense target = findExpense(expenses, expenseId);

            if (target == null) {
                showEditError(request, response, "삭제할 지출이 없습니다. 수정 화면을 다시 열어 주세요.");
                return;
            }

            deleteTargets.add(target);
        }
        
        try {
            long total = 0;

            for (Expense expense : expenses) {
                if (!checkedIds.contains(expense.getExpenseId())) {
                    total = Math.addExact(total, expense.getAmount());
                }
            }

            for (String amount : amounts) {
                total = Math.addExact(total, Long.parseLong(amount));
            }
        } catch (ArithmeticException e) {
            showEditError(request, response,
                    "누적 지출 금액이 처리 가능한 범위를 초과합니다.");
            return;
        }

        for (int i = 0; i < count; i++) {
            Expense target = targets.get(i);

            target.setExpenseDate(LocalDate.parse(expenseDates[i].trim()));
            target.setCategory(categories[i]);
            target.setDescription(descriptions[i].trim());
            target.setAmount(Long.parseLong(amounts[i]));
        }
        
        expenses.removeAll(deleteTargets);
        response.sendRedirect(request.getContextPath() + "/expense/list");
    }

    private String validateExpense(String expenseDateValue, String category, String description, String amountValue) {

        if (description == null || description.trim().isEmpty()) {
            return "지출 내용을 입력해 주세요.";
        }

        List<String> categories = Arrays.asList("재료비", "임대료", "인건비", "공과금", "기타");

        if (!categories.contains(category)) {
            return "분류를 확인해 주세요.";
        }

        if (expenseDateValue == null || expenseDateValue.trim().isEmpty()) {
            return "지출일을 입력해 주세요.";
        }

        try {
            LocalDate.parse(expenseDateValue.trim());
        } catch (DateTimeParseException e) {
            return "지출일을 올바르게 입력해 주세요.";
        }

        try {
            long amount = Long.parseLong(amountValue);

            if (amount < 1) {
                return "금액은 1 이상의 정수로 입력해 주세요.";
            }
        } catch (NumberFormatException e) {
            return "금액은 1 이상의 정수로 입력해 주세요.";
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
