package com.kwang.commerce01.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.kwang.commerce01.model.dao.TicketDAO;
import com.kwang.commerce01.model.dto.TicketVO;

@Service
public class TicketServiceImpl implements TicketService {
	
	@Inject
	TicketDAO ticketDao;
	
	@Override
	public List<TicketVO> listAll(String sortOption) throws Exception {
		// TODO Auto-generated method stub
		System.out.println("TicektService listAll()!!");
		return ticketDao.listAll(sortOption);
	}
	
	
	
	@Override
	public List<TicketVO> listTheme(String sortOption, String theme, String genre , String location) throws Exception {
		// TODO Auto-generated method stub
		System.out.println("TicektService listAll()!!");
		return ticketDao.listTheme(sortOption, theme, genre, location);
	}



	@Override
	public void create(TicketVO vo) throws Exception {
		// TODO Auto-generated method stub
		System.out.println("service VO = " + vo.toString());
		
		//ticketDao.create(vo);
	}

	@Override
	public TicketVO view(String tno) throws Exception {
		// TODO Auto-generated method stub
		return ticketDao.view(tno);
	}
	

}
