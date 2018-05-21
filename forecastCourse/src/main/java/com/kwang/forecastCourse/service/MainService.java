package com.kwang.forecastCourse.service;

import java.util.Map;

public interface MainService {
	public Map<String, Object> getForecastInfo()throws Exception;
	public Map<String, Object> getDustInfo()throws Exception;
}
