package com.kwang.forecastCourse.service;

import com.kwang.forecastCourse.model.dto.GeoVO;
import com.kwang.forecastCourse.model.dto.TestVO;

public interface TestService {
	public GeoVO read(int gno) throws Exception;
	public void create(GeoVO vo) throws Exception;
}
