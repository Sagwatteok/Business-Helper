package com.bizmate.util;

import java.time.LocalDateTime;
import java.time.format.DateTimeParseException;
import java.util.List;

import com.bizmate.model.Sale;
import com.bizmate.model.SalesCsvDraft;

public class SalesCsvConverter {

    public static Sale createSale(
            SalesCsvDraft draft,
            int rowIndex,
            String saleDateValue,
            String productName,
            String quantityValue,
            String amountValue) {

        if (rowIndex < 0 || rowIndex >= draft.getUploadData().getRowCount()) {
            throw new IllegalArgumentException("파일에 없는 행입니다.");
        }

        productName = requireText(productName, "상품명을 입력해 주세요.");
        saleDateValue = requireText(saleDateValue, "판매일시를 입력해 주세요.");
        quantityValue = requireText(quantityValue, "수량을 입력해 주세요.");
        amountValue = requireText(amountValue, "금액을 입력해 주세요.");

        LocalDateTime saleDate;

        try {
            saleDate = LocalDateTime.parse(saleDateValue);
        } catch (DateTimeParseException e) {
            throw new IllegalArgumentException("판매일시를 올바르게 입력해 주세요.");
        }

        int quantity;
        long amount;

        try {
            quantity = Integer.parseInt(quantityValue);
            amount = Long.parseLong(amountValue);
        } catch (NumberFormatException e) {
            throw new IllegalArgumentException("수량과 금액은 처리 가능한 범위의 정수로 입력해 주세요.");
        }

        if (quantity < 1 || amount < 1) {
            throw new IllegalArgumentException("수량과 금액은 1 이상이어야 합니다.");
        }

        if ("unitPrice".equals(draft.getAmountBasis())) {
            try {
                amount = Math.multiplyExact(amount, quantity);
            } catch (ArithmeticException e) {
                throw new IllegalArgumentException("단가와 수량의 곱이 처리 가능한 범위를 초과합니다.");
            }
        } else if (!"lineTotal".equals(draft.getAmountBasis())) {
            throw new IllegalArgumentException("금액 기준을 확인해 주세요.");
        }

        List<String> originalRow = draft.getUploadData().getRows().get(rowIndex);

        String orderNo = readOptional(originalRow, draft.getMapping().get("orderNoColumn"));

        String orderChannel = readOptional(originalRow, draft.getMapping().get("orderChannelColumn"));

        return new Sale(saleDate, productName, quantity, amount, orderNo, orderChannel);
    }

    private static String requireText(String value, String message) {
        if (value == null || value.trim().isEmpty()) {
            throw new IllegalArgumentException(message);
        }

        return value.trim();
    }

    private static String readOptional(List<String> row, int column) {
        if (column == -1) {
            return "";
        }

        return row.get(column).trim();
    }
}