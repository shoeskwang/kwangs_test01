package com.kwang.commerce01.service;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;

import com.kwang.commerce01.model.dao.MemberDAO;
import com.kwang.commerce01.model.dto.MemberVO;

@Service
public class MemberServiceImpl implements MemberService {
	
	@Inject
	MemberDAO memberDao;
	
	@Override
	public boolean loginCheck(MemberVO vo, HttpSession session) {
		boolean result = memberDao.loginCheck(vo);
		if(result){
			MemberVO vo2 = viewMember(vo);
			
			session.setAttribute("userId", vo2.getUserId());
			session.setAttribute("userName", vo2.getUserName());
		}
		return result;
	}

	@Override
	public MemberVO viewMember(MemberVO vo) {
		// TODO Auto-generated method stub
		return memberDao.viewMember(vo);
	}

	@Override
	public void logout(HttpSession session) {
		// TODO Auto-generated method stub
		// 세션 변수 개별 삭제
        // session.removeAttribute("userId");

		// 세션 정보 초기화
		session.invalidate();
	}

	@Override
	public int idCheck(String userId) {
		// TODO Auto-generated method stub
		return memberDao.idCheck(userId);
	}

	@Override
	public void insert(MemberVO vo) {
		// TODO Auto-generated method stub
		memberDao.insert(vo);
	}
	
	
}
