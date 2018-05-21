package com.kwang.commerce01.model.dao;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.kwang.commerce01.model.dto.MemberVO;

@Repository
public class MemberDAOImpl implements MemberDAO {
	
	@Inject
	SqlSession sqlSession;
	
	@Override
	public boolean loginCheck(MemberVO vo) {
		// TODO Auto-generated method stub
		String name = sqlSession.selectOne("member.loginCheck", vo);
		return (name == null)? false : true;
	}

	@Override
	public MemberVO viewMember(MemberVO vo) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("member.viewMember", vo);
	}

	@Override
	public void logout(HttpSession session) {
		// TODO Auto-generated method stub

	}

	@Override
	public int idCheck(String userId) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("member.idCheck", userId);
	}

	@Override
	public void insert(MemberVO vo) {
		// TODO Auto-generated method stub
		sqlSession.insert("member.insert", vo);
	}
	
	
	
}
