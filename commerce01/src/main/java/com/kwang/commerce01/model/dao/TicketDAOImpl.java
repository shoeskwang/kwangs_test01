package com.kwang.commerce01.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.kwang.commerce01.model.dto.TicketVO;

@Repository // 현재 클래스를 DAO bean으로 등록한다.
public class TicketDAOImpl implements TicketDAO {
	@Inject
	SqlSession SqlSession;
	
	@Override
	public List<TicketVO> listAll(String sortOption) throws Exception {
		// TODO Auto-generated method stub
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("sortOption", sortOption);
		System.out.println("TicektDAO listAll()!! sortOption = "+ sortOption);
		return SqlSession.selectList("ticket.listAll",map);
	}
	
	

	@Override
	public List<TicketVO> listTheme(String sortOption, String theme, String genre, String location) throws Exception {
		// TODO Auto-generated method stub
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("sortOption", sortOption);
		map.put("theme", theme);
		map.put("genre", genre);
		map.put("location", location);
		System.out.println("TicektDAO listTheme()!! sortOption = "+ sortOption);
		System.out.println("TicektDAO listTheme()!! theme = "+ theme);
		System.out.println("TicektDAO listTheme()!! genre = "+ genre);
		System.out.println("TicektDAO listTheme()!! location = "+ location);
		return SqlSession.selectList("ticket.listTheme",map);
	}



	@Override
	public void create(TicketVO vo) throws Exception {
		// TODO Auto-generated method stub
		SqlSession.insert("ticket.insert", vo);
	}

	@Override
	public TicketVO view(String tno) throws Exception {
		// TODO Auto-generated method stub
		return SqlSession.selectOne("ticket.view", tno);
	}
	
	
}
