package com.kwang.forecastCourse.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.kwang.forecastCourse.model.dto.ReplyVO;

@Repository
public class ReplyDAOImpl implements ReplyDAO {
	
	@Inject
	SqlSession sqlSession;
	
	@Override
	public List<ReplyVO> list(int gno, int start, int end) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("gno", gno);
		map.put("start", start);
		map.put("end", end);
		return sqlSession.selectList("reply.listReply", map);
	}

	@Override
	public void create(ReplyVO vo) {
		// TODO Auto-generated method stub
		sqlSession.insert("reply.insertReply", vo);
	}

	@Override
	public void update(ReplyVO vo) {
		// TODO Auto-generated method stub

	}

	@Override
	public void delete(int grno) {
		// TODO Auto-generated method stub
		sqlSession.delete("reply.deleteReply", grno);
	}

	@Override
	public int count(int gno) {
		return sqlSession.selectOne("reply.countReply", gno);
	}

}
