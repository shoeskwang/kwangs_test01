package com.kwang.forecastCourse.model.dao;

import javax.servlet.http.HttpSession;

import com.kwang.forecastCourse.model.dto.MemberVO;

public interface MemberDAO {
	public boolean loginCheck(MemberVO vo);
	
	public MemberVO viewMember(MemberVO vo);
	
	public void logout(HttpSession session);
	
	public int idCheck(String userId);
	
	public void insert(MemberVO vo);
}
