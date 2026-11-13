package com.bizmate.model;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.UUID;

public class Sale {
    private String saleId = UUID.randomUUID().toString();
    private LocalDateTime saleDate;
    private String productName;
    private int quantity;
    private long amount;
    private String orderNo;
    private String orderChannel;
    
    public Sale() {
    }
    
    public Sale(LocalDateTime saleDate, String productName, int quantity, long amount, String orderNo, String orderChannel) {
    	super();
    	this.saleDate = saleDate;
    	this.productName = productName;
    	this.quantity = quantity;
    	this.amount = amount;
    	this.orderNo = orderNo;
    	this.orderChannel = orderChannel;
}

	public String getSaleId() {
		return saleId;
	}

	public void setSaleId(String saleId) {
		this.saleId = saleId;
	}

	public LocalDateTime getSaleDate() {
		return saleDate;
	}

	public void setSaleDate(LocalDateTime saleDate) {
		this.saleDate = saleDate;
	}

	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	public long getAmount() {
		return amount;
	}

	public void setAmount(long amount) {
		this.amount = amount;
	}

	public String getOrderNo() {
		return orderNo;
	}

	public void setOrderNo(String orderNo) {
		this.orderNo = orderNo;
	}

	public String getOrderChannel() {
		return orderChannel;
	}

	public void setOrderChannel(String orderChannel) {
		this.orderChannel = orderChannel;
	}
    
	
	//판매 일시를 화면에 표시할 문자열로 변환
	public String getSaleDateText() {
	    if (saleDate == null) {
	        return "";
	    }

	    return saleDate.format(
	            DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm"));
	}
    
}
