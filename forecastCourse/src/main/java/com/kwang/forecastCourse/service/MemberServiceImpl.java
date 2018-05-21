package com.kwang.forecastCourse.service;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;

import com.kwang.forecastCourse.model.dao.MemberDAO;
import com.kwang.forecastCourse.model.dto.MemberVO;

@Service
public class MemberServiceImpl implements MemberService {
	@Inject
	MemberDAO memberDao;

	@Override
	public boolean loginCheck(MemberVO vo, HttpSession session) {
		boolean result = memberDao.loginCheck(vo);
		if(result){
			MemberVO vo2 = viewMember(vo);
			
			session.setAttribute("userId", vo2.getId());
			session.setAttribute("userName", vo2.getName());
		}
		return result;
	}

	@Override
	public MemberVO viewMember(MemberVO vo) {
		return memberDao.viewMember(vo);
	}

	@Override
	public void logout(HttpSession session) {
		// 세션 정보 초기화
		session.invalidate();
	}

	@Override
	public int idCheck(String userId) {
		return memberDao.idCheck(userId);
	}

	@Override
	public void insert(MemberVO vo) {
		memberDao.insert(vo);
	}
	
	
}
