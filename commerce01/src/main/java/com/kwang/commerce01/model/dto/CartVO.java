package com.kwang.commerce01.model.dto;

import java.util.Date;

public class CartVO {
	
	private int cartId;
	private String userId;
	private String tno;
	private int amount;
	private String title;
	private String summary;
	private Date sdate;
	private Date edate;
	private String location;
	private String genre;
	private String theme;
	private String poster;
	private int tprice;
	
	
	public int getCartId() {
		return cartId;
	}
	public void setCartId(int cartId) {
		this.cartId = cartId;
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
	public String getGenre() {
		return genre;
	}
	public void setGenre(String genre) {
		this.genre = genre;
	}
	public String getTheme() {
		return theme;
	}
	public void setTheme(String theme) {
		this.theme = theme;
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
		return "CartVO [cartId=" + cartId + ", userId=" + userId + ", tno=" + tno + ", amount=" + amount + ", title="
				+ title + ", summary=" + summary + ", sdate=" + sdate + ", edate=" + edate + ", location=" + location
				+ ", genre=" + genre + ", theme=" + theme + ", poster=" + poster + ", tprice=" + tprice + "]";
	}
	
}
