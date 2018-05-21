package com.kwang.commerce01.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.kwang.commerce01.model.dto.OrderVO;

@Repository
public class OrderDAOImpl implements OrderDAO {
	
	@Inject
	SqlSession SqlSession;
	
	@Override
	public void orderAdd(OrderVO vo) throws Exception {
		// TODO Auto-generated method stub
		System.out.println("OrderDAO add()");
		SqlSession.insert("order.orderAdd", vo);
	}

	@Override
	public List<OrderVO> list(String userId) throws Exception {
		// TODO Auto-generated method stub
		return SqlSession.selectList("order.list", userId);
	}
	
	
	@Override
	public List<OrderVO> listAll() throws Exception {
		// TODO Auto-generated method stub
		return SqlSession.selectList("order.listAll", null);
	}
	
	
	
	@Override
	public void orderUpdate(String orderId, String orderState) throws Exception {
		// TODO Auto-generated method stub
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("orderId", orderId);
		map.put("orderState", orderState);
		
		SqlSession.update("order.orderUpdate", map);
	}

	@Override
	public void orderDelete(String orderId) throws Exception {
		// TODO Auto-generated method stub

	}

	@Override
	public int orderCount(String userId, String tno) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}

}
