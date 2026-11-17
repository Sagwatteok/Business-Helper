package com.bizmate.model;

public class ProductSalesSummary {
    private String productName;
    private long totalQuantity;
    private long totalAmount;

    public ProductSalesSummary() {
    }

    public ProductSalesSummary(String productName, long totalQuantity, long totalAmount) {
        this.productName = productName;
        this.totalQuantity = totalQuantity;
        this.totalAmount = totalAmount;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public long getTotalQuantity() {
        return totalQuantity;
    }

    public void setTotalQuantity(long totalQuantity) {
        this.totalQuantity = totalQuantity;
    }

    public long getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(long totalAmount) {
        this.totalAmount = totalAmount;
    }
}