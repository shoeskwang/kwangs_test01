package com.kwang.commerce01.model.dao;

import com.kwang.commerce01.model.dto.SeatVO;

public interface SeatDAO {
	public SeatVO list(String tno) throws Exception;
	public void update(SeatVO vo) throws Exception;
}
