package com.kwang.forecastCourse.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.kwang.forecastCourse.model.dao.TestDAO;
import com.kwang.forecastCourse.model.dto.GeoVO;
import com.kwang.forecastCourse.model.dto.TestVO;

@Service
public class TestServiceImpl implements TestService {
	
	@Inject
	TestDAO TestDao;
	
	@Override
	public GeoVO read(int gno) throws Exception {
		// TODO Auto-generated method stub
		return TestDao.read(gno);
	}

	@Override
	public void create(GeoVO vo) throws Exception {
		// TODO Auto-generated method stub
		
		System.out.println("Service create vo : " + vo.toString());
		TestDao.create(vo);
	}

}
