package com.kwang.commerce01.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.kwang.commerce01.model.dto.ReplyVO;


@Repository
public class ReplyDAOImpl implements ReplyDAO {
	
	@Inject
	SqlSession sqlSession;

	@Override
	public List<ReplyVO> list(Integer bno, int start, int end) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("bno", bno);
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
	public void delete(Integer rno) {
		// TODO Auto-generated method stub
		sqlSession.delete("reply.deleteReply", rno);
	}

	@Override
	public int count(int bno) {
		return sqlSession.selectOne("reply.countReply", bno);
	}
	
	

}
