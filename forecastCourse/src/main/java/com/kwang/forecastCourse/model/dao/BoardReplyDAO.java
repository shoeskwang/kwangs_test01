package com.kwang.forecastCourse.model.dao;

import java.util.List;

import com.kwang.forecastCourse.model.dto.BoardReplyVO;

public interface BoardReplyDAO {
		public List<BoardReplyVO> list(Integer bno, int start, int end);
		
		public void create(BoardReplyVO vo);
		
		public void update(BoardReplyVO vo);
		
		public void delete(Integer rno);
		
		public int count(int bno);
}
