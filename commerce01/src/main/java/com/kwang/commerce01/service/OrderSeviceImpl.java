package com.kwang.commerce01.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.kwang.commerce01.model.dao.OrderDAO;
import com.kwang.commerce01.model.dto.OrderVO;

@Service
public class OrderSeviceImpl implements OrderService {
	@Inject
	OrderDAO orderDao;
	
	@Override
	public void orderAdd(OrderVO vo) throws Exception {
		// TODO Auto-generated method stub
		System.out.println("orderService orderAdd()");
		orderDao.orderAdd(vo);
	}

	@Override
	public List<OrderVO> list(String userId) throws Exception {
		// TODO Auto-generated method stub
		return orderDao.list(userId);
	}

	
	@Override
	public List<OrderVO> listAll() throws Exception {
		// TODO Auto-generated method stub
		return orderDao.listAll();
	}
	
	
	@Override
	public void orderUpdate(String orderId, String orderState) throws Exception {
		// TODO Auto-generated method stub
		orderDao.orderUpdate(orderId, orderState);
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
