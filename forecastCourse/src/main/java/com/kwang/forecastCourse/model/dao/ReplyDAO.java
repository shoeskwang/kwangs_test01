package com.kwang.forecastCourse.model.dao;

import java.util.List;

import com.kwang.forecastCourse.model.dto.ReplyVO;

public interface ReplyDAO {
	public List<ReplyVO> list(int gno, int start, int end);
	public void create(ReplyVO vo);
	public void update(ReplyVO vo);
	public void delete(int grno);
	
	public int count(int gno);
}
