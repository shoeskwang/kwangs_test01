package com.kwang.forecastCourse.service;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;

import com.kwang.forecastCourse.model.dao.BoardReplyDAO;
import com.kwang.forecastCourse.model.dto.BoardReplyVO;

@Service
public class BoardReplyServiceImpl implements BoardReplyService {
	@Inject
	BoardReplyDAO boardReplyDao;
	@Override
	public List<BoardReplyVO> list(Integer bno, int start, int end, HttpSession session) {
		return boardReplyDao.list(bno,start,end);
	}

	@Override
	public void create(BoardReplyVO vo) {
		// TODO Auto-generated method stub
		boardReplyDao.create(vo);
	}

	@Override
	public void update(BoardReplyVO vo) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void delete(Integer rno) {
		boardReplyDao.delete(rno);
	}

	@Override
	public int count(int bno) {
		return boardReplyDao.count(bno);
	}

}
