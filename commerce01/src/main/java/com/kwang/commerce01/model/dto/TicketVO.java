package com.kwang.commerce01.model.dto;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

public class TicketVO {
	private String tno;
	private String title;
	private String summary;
	
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date sdate;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date edate;
	
	private String location;
	private String tclass;
	private String genre;
	private String rtime;
	
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date rdate;
	
	private String state;
	private String theme;
	private String content;
	private String poster;
	private int tcount;
	private int tprice;
	
	public String getTno() {
		return tno;
	}
	public void setTno(String tno) {
		this.tno = tno;
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
	
	public String getLocation() {
		return location;
	}
	public void setLocation(String location) {
		this.location = location;
	}
	public String getTclass() {
		return tclass;
	}
	public void setTclass(String tclass) {
		this.tclass = tclass;
	}
	public String getGenre() {
		return genre;
	}
	public void setGenre(String genre) {
		this.genre = genre;
	}
	public String getRtime() {
		return rtime;
	}
	public void setRtime(String rtime) {
		this.rtime = rtime;
	}
	
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public String getTheme() {
		return theme;
	}
	public void setTheme(String theme) {
		this.theme = theme;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getPoster() {
		return poster;
	}
	public void setPoster(String poster) {
		this.poster = poster;
	}
	public int getTcount() {
		return tcount;
	}
	public void setTcount(int tcount) {
		this.tcount = tcount;
	}
	public int getTprice() {
		return tprice;
	}
	public void setTprice(int tprice) {
		this.tprice = tprice;
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
	public Date getRdate() {
		return rdate;
	}
	public void setRdate(Date rdate) {
		this.rdate = rdate;
	}
	
	@Override
	public String toString() {
		return "TicketVO [tno=" + tno + ", title=" + title + ", summary=" + summary + ", sdate=" + sdate + ", edate="
				+ edate + ", location=" + location + ", tclass=" + tclass + ", genre=" + genre + ", rtime=" + rtime
				+ ", rdate=" + rdate + ", state=" + state + ", theme=" + theme + ", content=" + content + ", poster="
				+ poster + ", tcount=" + tcount + ", tprice=" + tprice + "]";
	}
	
	
	
	
	
}
