package com.kwang.forecastCourse.service;

import javax.servlet.http.HttpSession;

import com.kwang.forecastCourse.model.dto.MemberVO;

public interface MemberService {
	public boolean loginCheck(MemberVO vo, HttpSession session);
	
	public MemberVO viewMember(MemberVO vo);
	
	public void logout(HttpSession session);
	
	public int idCheck(String userId);
	
	public void insert(MemberVO vo);
}
