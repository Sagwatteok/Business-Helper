package com.bizmate.model;

import java.util.UUID;

public class Product {
    private String productName;
    private String category;
    private long salePrice;
    private long estimatedCost;
    private String saleStatus;
    private final String productId;

    public Product() {
        this(null, null, 0, 0, null);
    }

    public Product(String productName, String category, long salePrice, long estimatedCost, String saleStatus) {
        this(UUID.randomUUID().toString(), productName, category, salePrice, estimatedCost, saleStatus);
    }

    public Product(String productId, String productName, String category, long salePrice, long estimatedCost, String saleStatus) {
        this.productId = productId;
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
	
    public String getProductId() {
        return productId;
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
