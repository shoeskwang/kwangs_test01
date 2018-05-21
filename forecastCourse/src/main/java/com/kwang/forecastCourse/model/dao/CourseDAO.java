package com.kwang.forecastCourse.model.dao;

import java.util.List;

import com.kwang.forecastCourse.model.dto.GeoVO;

public interface CourseDAO {
	public GeoVO view(int gno) throws Exception;
	 public void insert(GeoVO vo) throws Exception;
	 public List<GeoVO> listAll(int start, int end, String searchOption, String keyword) throws Exception;
	 
	 public void update(GeoVO vo) throws Exception;
     public void delete(int gno) throws Exception;
    
     public void increaseViewcnt(int gno) throws Exception;
     public int countArticle() throws Exception;
}
