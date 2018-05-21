package com.kwang.forecastCourse.model.dao;

import com.kwang.forecastCourse.model.dto.GeoVO;
import com.kwang.forecastCourse.model.dto.TestVO;

public interface TestDAO {
	 public GeoVO read(int gno) throws Exception;
	 public void create(GeoVO vo) throws Exception;
}
