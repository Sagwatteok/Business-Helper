package com.bizmate.util;

import java.time.LocalDate;
import java.time.format.DateTimeParseException;
import java.util.Set;

import com.bizmate.model.Expense;
import com.bizmate.model.ExpenseCsvDraft;

public class ExpenseCsvConverter {

    private static final Set<String> CATEGORIES = Set.of("재료비", "임대료", "인건비", "공과금", "기타");

    public static Expense createExpense(ExpenseCsvDraft draft, int rowIndex, String expenseDateValue, String category, String description, String amountValue, String memo) {

        if (rowIndex < 0 || rowIndex >= draft.getUploadData().getRowCount()) {
            throw new IllegalArgumentException("파일에 없는 행입니다.");
        }

        expenseDateValue = requireText(expenseDateValue, "지출일을 입력해 주세요.");
        category = requireText(category, "분류를 선택해 주세요.");
        description = requireText(description, "지출 내용을 입력해 주세요.");
        amountValue = requireText(amountValue, "금액을 입력해 주세요.");

        if (!CATEGORIES.contains(category)) {
            throw new IllegalArgumentException("분류를 확인해 주세요.");
        }

        LocalDate expenseDate;

        try {
            expenseDate = LocalDate.parse(expenseDateValue);
        } catch (DateTimeParseException e) {
            throw new IllegalArgumentException("지출일을 올바르게 입력해 주세요.");
        }

        long amount;

        try {
            amount = Long.parseLong(amountValue);
        } catch (NumberFormatException e) {
            throw new IllegalArgumentException("금액은 처리 가능한 범위의 정수로 입력해 주세요.");
        }

        if (amount < 1) {
            throw new IllegalArgumentException("금액은 1 이상이어야 합니다.");
        }

        memo = memo == null ? "" : memo.trim();

        return new Expense(expenseDate, category, description, amount, memo);
    }

    private static String requireText(String value, String message) {
        if (value == null || value.trim().isEmpty()) {
            throw new IllegalArgumentException(message);
        }

        return value.trim();
    }
}