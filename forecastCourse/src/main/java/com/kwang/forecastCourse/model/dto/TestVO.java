package com.kwang.forecastCourse.model.dto;

import java.sql.Date;

public class TestVO {
	private String geoNum;
	private String geoName;
	private String geoWriter;
	private Date geoRegDate;
	private Object geoJson;
	
	
	public String getGeoNum() {
		return geoNum;
	}
	public void setGeoNum(String geoNum) {
		this.geoNum = geoNum;
	}
	public String getGeoName() {
		return geoName;
	}
	public void setGeoName(String geoName) {
		this.geoName = geoName;
	}
	public String getGeoWriter() {
		return geoWriter;
	}
	public void setGeoWriter(String geoWriter) {
		this.geoWriter = geoWriter;
	}
	public Date getGeoRegDate() {
		return geoRegDate;
	}
	public void setGeoRegDate(Date geoRegDate) {
		this.geoRegDate = geoRegDate;
	}
	public Object getGeoJson() {
		return geoJson;
	}
	public void setGeoJson(Object geoJson) {
		this.geoJson = geoJson;
	}
	
	@Override
	public String toString() {
		return "TestVO [geoNum=" + geoNum + ", geoName=" + geoName + ", geoWriter=" + geoWriter + ", geoRegDate="
				+ geoRegDate + ", geoJson=" + geoJson + "]";
	}
	
	
}
