package com.kwang.commerce01.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.kwang.commerce01.model.dao.CartDAO;
import com.kwang.commerce01.model.dto.CartVO;

@Service
public class CartServiceImpl implements CartService {
	
	@Inject
	CartDAO cartDao;
	@Override
	public void cartAdd(CartVO vo) throws Exception {
		// TODO Auto-generated method stub
		cartDao.cartAdd(vo);
	}
	@Override
	public List<CartVO> list(String userId) throws Exception {
		// TODO Auto-generated method stub
		return cartDao.list(userId);
	}
	@Override
	public void cartDelete(String cartId) throws Exception {
		// TODO Auto-generated method stub
		cartDao.cartDelete(cartId);
	}
	@Override
	public int cartCount(String userId, String tno) throws Exception {
		// TODO Auto-generated method stub
		return cartDao.cartCount(userId, tno);
	}
	
	
	
}
