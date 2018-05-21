package com.kwang.forecastCourse.model.dto;

import java.util.Date;

public class GeoVO {
	private int gno;
	private String title;
	private String writer;
	private int distance;
	private Date regdate;
	private Object gjson;
	private int viewcnt;
	
	private int recnt; 				// 코ㅡ의 댓글의 수
	
	public int getGno() {
		return gno;
	}
	public void setGno(int gno) {
		this.gno = gno;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public int getDistance() {
		return distance;
	}
	public void setDistance(int distance) {
		this.distance = distance;
	}
	public Date getRegdate() {
		return regdate;
	}
	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}
	public Object getGjson() {
		return gjson;
	}
	public void setGjson(Object gjson) {
		this.gjson = gjson;
	}
	
	public int getViewcnt() {
		return viewcnt;
	}
	public void setViewcnt(int viewcnt) {
		this.viewcnt = viewcnt;
	}
	public int getRecnt() {
		return recnt;
	}
	public void setRecnt(int recnt) {
		this.recnt = recnt;
	}
	
	@Override
	public String toString() {
		return "GeoVO [gno=" + gno + ", title=" + title + ", writer=" + writer + ", distance=" + distance + ", regdate="
				+ regdate + ", gjson=" + gjson + ", viewcnt=" + viewcnt + ", recnt=" + recnt + "]";
	}
	
}
