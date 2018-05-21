package com.kwang.commerce01.model.dao;

import java.util.List;

import com.kwang.commerce01.model.dto.TicketVO;


public interface TicketDAO {
	 public List<TicketVO> listAll(String sortOption) throws Exception;
	 public List<TicketVO> listTheme(String sortOption, String theme, String genre, String location) throws Exception;
	 public void create(TicketVO vo) throws Exception;
	 public TicketVO view(String tno) throws Exception;
}
