package com.kwang.forecastCourse.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.kwang.forecastCourse.model.dto.BoardReplyVO;

@Repository
public class BoardReplyDAOImpl implements BoardReplyDAO {
	@Inject
	SqlSession sqlSession;
	
	@Override
	public List<BoardReplyVO> list(Integer bno, int start, int end) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("bno", bno);
		map.put("start", start);
		map.put("end", end);
		return sqlSession.selectList("boardReply.listReply", map);
	}

	@Override
	public void create(BoardReplyVO vo) {
		sqlSession.insert("boardReply.insertReply", vo);
	}

	@Override
	public void update(BoardReplyVO vo) {
		// TODO Auto-generated method stub

	}

	@Override
	public void delete(Integer rno) {
		sqlSession.delete("boardReply.deleteReply", rno);
	}

	@Override
	public int count(int bno) {
		return sqlSession.selectOne("boardReply.countReply", bno);
	}

}
