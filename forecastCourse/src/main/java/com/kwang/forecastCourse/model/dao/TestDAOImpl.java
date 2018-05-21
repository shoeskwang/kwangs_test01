package com.kwang.forecastCourse.model.dao;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.kwang.forecastCourse.model.dto.GeoVO;
import com.kwang.forecastCourse.model.dto.TestVO;

@Repository // 현재 클래스를 DAO bean으로 등록한다.
public class TestDAOImpl implements TestDAO {
	
	@Inject
	SqlSession SqlSession;
	
	@Override
	public GeoVO read(int gno) throws Exception {
		// TODO Auto-generated method stub
		return SqlSession.selectOne("test.read", gno);
	}

	@Override
	public void create(GeoVO vo) throws Exception {
		// TODO Auto-generated method stub
		SqlSession.insert("test.insert", vo);
	}

}
