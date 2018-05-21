package com.kwang.commerce01.model.dao;

import java.util.List;

import com.kwang.commerce01.model.dto.CartVO;

public interface CartDAO {
	public void cartAdd(CartVO vo) throws Exception;
	public List<CartVO> list(String userId) throws Exception;
	public void cartDelete(String cartId) throws Exception;
	public int cartCount(String userId, String tno) throws Exception;
}
