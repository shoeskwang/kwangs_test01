package com.kwang.commerce01.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.kwang.commerce01.model.dao.SeatDAO;
import com.kwang.commerce01.model.dto.SeatVO;

@Service
public class SeatServiceImpl implements SeatService {
	
	@Inject
	SeatDAO seatDao;
	@Override
	public SeatVO list(String tno) throws Exception {
		// TODO Auto-generated method stub
		return seatDao.list(tno);
	}
	@Override
	public void update(SeatVO vo) throws Exception {
		// TODO Auto-generated method stub
		seatDao.update(vo);
	}
	

}
