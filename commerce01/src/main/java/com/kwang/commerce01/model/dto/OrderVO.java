package com.kwang.commerce01.model.dto;

import java.util.Date;

public class OrderVO {
	private int orderId;
	private String userId;
	private String tno;
	private int amount;
	private String orderState;
	private String title;
	private String summary;
	private Date sdate;
	private Date edate;
	private String location;
	private String poster;
	private int tprice;
	
	public int getOrderId() {
		return orderId;
	}
	public void setOrderId(int orderId) {
		this.orderId = orderId;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getTno() {
		return tno;
	}
	public void setTno(String tno) {
		this.tno = tno;
	}
	public int getAmount() {
		return amount;
	}
	public void setAmount(int amount) {
		this.amount = amount;
	}
	public String getOrderState() {
		return orderState;
	}
	public void setOrderState(String orderState) {
		this.orderState = orderState;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getSummary() {
		return summary;
	}
	public void setSummary(String summary) {
		this.summary = summary;
	}
	public Date getSdate() {
		return sdate;
	}
	public void setSdate(Date sdate) {
		this.sdate = sdate;
	}
	public Date getEdate() {
		return edate;
	}
	public void setEdate(Date edate) {
		this.edate = edate;
	}
	public String getLocation() {
		return location;
	}
	public void setLocation(String location) {
		this.location = location;
	}
	public String getPoster() {
		return poster;
	}
	public void setPoster(String poster) {
		this.poster = poster;
	}
	public int getTprice() {
		return tprice;
	}
	public void setTprice(int tprice) {
		this.tprice = tprice;
	}
	
	@Override
	public String toString() {
		return "OrderVO [orderId=" + orderId + ", userId=" + userId + ", tno=" + tno + ", amount=" + amount
				+ ", orderState=" + orderState + ", title=" + title + ", summary=" + summary + ", sdate=" + sdate
				+ ", edate=" + edate + ", location=" + location + ", poster=" + poster + ", tprice=" + tprice + "]";
	}
	
	
}
