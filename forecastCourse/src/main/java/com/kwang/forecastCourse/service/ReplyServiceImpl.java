package com.kwang.forecastCourse.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.kwang.forecastCourse.model.dao.ReplyDAO;
import com.kwang.forecastCourse.model.dto.ReplyVO;

@Service
public class ReplyServiceImpl implements ReplyService {
	@Inject
	ReplyDAO  ReplyDao;
	@Override
	public List<ReplyVO> list(int gno, int start, int end) {
		// TODO Auto-generated method stub
		return ReplyDao.list(gno, start, end);
	}

	@Override
	public void create(ReplyVO vo) {
		// TODO Auto-generated method stub
		ReplyDao.create(vo);
	}

	@Override
	public void update(ReplyVO vo) {
		// TODO Auto-generated method stub

	}

	@Override
	public void delete(int grno) {
		// TODO Auto-generated method stub
		ReplyDao.delete(grno);
	}

	@Override
	public int count(int gno) {
		// TODO Auto-generated method stub
		return ReplyDao.count(gno);
	}

}
