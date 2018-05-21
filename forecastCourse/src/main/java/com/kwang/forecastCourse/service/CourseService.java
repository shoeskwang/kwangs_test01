package com.kwang.forecastCourse.service;

import java.util.List;

import javax.servlet.http.HttpSession;

import com.kwang.forecastCourse.model.dto.GeoVO;

public interface CourseService {
	public GeoVO view(int gno) throws Exception;
	public void insert(GeoVO vo) throws Exception;
	public List<GeoVO> listAll(int start, int end, String searchOption, String keyword) throws Exception;
	
    public void update(GeoVO vo) throws Exception;
    public void delete(int gno) throws Exception;
    
    public void increaseViewcnt(int gno, HttpSession session) throws Exception;
    public int countArticle() throws Exception;
}
