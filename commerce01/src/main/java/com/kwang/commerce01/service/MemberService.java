package com.kwang.commerce01.service;

import javax.servlet.http.HttpSession;

import com.kwang.commerce01.model.dto.MemberVO;


public interface MemberService {
public boolean loginCheck(MemberVO vo, HttpSession session);
	
	public MemberVO viewMember(MemberVO vo);
	
	public void logout(HttpSession session);
	
	public int idCheck(String userId);
	
	public void insert(MemberVO vo);
}
