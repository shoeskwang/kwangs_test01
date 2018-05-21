package com.kwang.commerce01.model.dao;

import java.util.List;

import com.kwang.commerce01.model.dto.ReplyVO;


public interface ReplyDAO {
	public List<ReplyVO> list(Integer bno, int start, int end);
	
	public void create(ReplyVO vo);
	
	public void update(ReplyVO vo);
	
	public void delete(Integer rno);
	
	public int count(int bno);
}
