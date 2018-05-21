package com.kwang.commerce01.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.kwang.commerce01.model.dto.CartVO;

@Repository // 현재 클래스를 DAO bean으로 등록한다.
public class CartDAOImpl implements CartDAO {
	@Inject
	SqlSession SqlSession;
	
	@Override
	public void cartAdd(CartVO vo) throws Exception {
		// TODO Auto-generated method stub
		SqlSession.insert("cart.cartAdd", vo);
	}

	@Override
	public List<CartVO> list(String userId) throws Exception {
		// TODO Auto-generated method stub
		return SqlSession.selectList("cart.list", userId);
	}

	@Override
	public void cartDelete(String cartId) throws Exception {
		// TODO Auto-generated method stub
		SqlSession.delete("cart.cartDelete", cartId);
	}

	@Override
	public int cartCount(String userId, String tno) throws Exception {
		// TODO Auto-generated method stub
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("userId", userId);
		map.put("tno", tno);
		return SqlSession.selectOne("countCart", map);
	}
	
	

}
