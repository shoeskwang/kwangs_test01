package com.kwang.commerce01.model.dao;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.kwang.commerce01.model.dto.SeatVO;

@Repository
public class SeatDAOImpl implements SeatDAO {
	
	@Inject
	SqlSession SqlSession;
	
	@Override
	public SeatVO list(String tno) throws Exception {
		// TODO Auto-generated method stub
		return SqlSession.selectOne("seat.list", tno);
	}
	
	@Override
	public void update(SeatVO vo) throws Exception{
		SqlSession.update("seat.update", vo);
	};
}
