package com.kwang.commerce01.service;

import java.util.List;

import com.kwang.commerce01.model.dto.SeatVO;

public interface SeatService {
	public SeatVO list(String tno) throws Exception;
	public void update(SeatVO vo) throws Exception;
}
