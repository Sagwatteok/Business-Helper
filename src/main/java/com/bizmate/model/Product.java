package com.bizmate.model;

public class Product {
    private String productName;
    private String category;
    private long salePrice;
    private long estimatedCost;
    private String saleStatus;

    public Product() {
    }

	public Product(String productName, String category, long salePrice, long estimatedCost, String saleStatus) {
		super();
		this.productName = productName;
		this.category = category;
		this.salePrice = salePrice;
		this.estimatedCost = estimatedCost;
		this.saleStatus = saleStatus;
	}

	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public long getSalePrice() {
		return salePrice;
	}

	public void setSalePrice(long salePrice) {
		this.salePrice = salePrice;
	}

	public long getEstimatedCost() {
		return estimatedCost;
	}

	public void setEstimatedCost(long estimatedCost) {
		this.estimatedCost = estimatedCost;
	}

	public String getSaleStatus() {
		return saleStatus;
	}

	public void setSaleStatus(String saleStatus) {
		this.saleStatus = saleStatus;
	}

	public long getEstimatedMargin() {
		return salePrice - estimatedCost;
	}
}
