package com.bizmate.model;

import java.time.LocalDate;
import java.util.UUID;

public class Expense {
    private String expenseId = UUID.randomUUID().toString();
    private LocalDate expenseDate;
    private String category;
    private String description;
    private long amount;
    private String memo;

    public Expense() {
    }

    public Expense(LocalDate expenseDate, String category,
                   String description, long amount, String memo) {
        this.expenseDate = expenseDate;
        this.category = category;
        this.description = description;
        this.amount = amount;
        this.memo = memo;
    }

    public String getExpenseId() {
        return expenseId;
    }

    public LocalDate getExpenseDate() {
        return expenseDate;
    }

    public void setExpenseDate(LocalDate expenseDate) {
        this.expenseDate = expenseDate;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public long getAmount() {
        return amount;
    }

    public void setAmount(long amount) {
        this.amount = amount;
    }

    public String getMemo() {
        return memo;
    }

    public void setMemo(String memo) {
        this.memo = memo;
    }
}