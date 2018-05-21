package com.kwang.commerce01.service;

import java.util.List;

import com.kwang.commerce01.model.dto.OrderVO;

public interface OrderService {
	public void orderAdd(OrderVO vo) throws Exception;
	public List<OrderVO> list(String userId) throws Exception;
	public List<OrderVO> listAll() throws Exception;
	public void orderUpdate(String orderId, String orderState) throws Exception;
	public void orderDelete(String orderId) throws Exception;
	public int orderCount(String userId, String tno) throws Exception;
}
