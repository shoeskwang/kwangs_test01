package com.kwang.forecastCourse.model.dao;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.kwang.forecastCourse.model.dto.MemberVO;

@Repository
public class MemberDAOImpl implements MemberDAO {
	@Inject
	SqlSession sqlSession;
	@Override
	public boolean loginCheck(MemberVO vo) {
		String name = sqlSession.selectOne("member.loginCheck", vo);
		return (name == null)? false : true;
	}

	@Override
	public MemberVO viewMember(MemberVO vo) {
		return sqlSession.selectOne("member.viewMember", vo);
	}

	@Override
	public void logout(HttpSession session) {
		// TODO Auto-generated method stub

	}

	@Override
	public int idCheck(String userId) {
		return sqlSession.selectOne("member.idCheck", userId);
	}

	@Override
	public void insert(MemberVO vo) {
		sqlSession.insert("member.insert", vo);
	}

}
