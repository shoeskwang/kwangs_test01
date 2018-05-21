package com.kwang.commerce01.service;

import java.util.List;

import javax.servlet.http.HttpSession;

import com.kwang.commerce01.model.dto.ReplyVO;


public interface ReplyService {
	// ´ñ±Û ¸ñ·Ï
    public List<ReplyVO> list(Integer bno,  int start, int end, HttpSession session);
    // ´ñ±Û ÀÔ·Â
    public void create(ReplyVO vo);
    // ´ñ±Û ¼öÁ¤
    public void update(ReplyVO vo);
    // ´ñ±Û »èÁ¦
    public void delete(Integer rno);
    
    // ´ñ±Û °¹¼ö
    public int count(int bno);

}
