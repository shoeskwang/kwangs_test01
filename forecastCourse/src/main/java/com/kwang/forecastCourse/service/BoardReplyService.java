package com.kwang.forecastCourse.service;

import java.util.List;

import javax.servlet.http.HttpSession;

import com.kwang.forecastCourse.model.dto.BoardReplyVO;

public interface BoardReplyService {
	// 댓글 목록
    public List<BoardReplyVO> list(Integer bno,  int start, int end, HttpSession session);
    // 댓글 입력
    public void create(BoardReplyVO vo);
    // 댓글 수정
    public void update(BoardReplyVO vo);
    // 댓글 삭제
    public void delete(Integer rno);
    
    // 댓글 갯수
    public int count(int bno);
}
