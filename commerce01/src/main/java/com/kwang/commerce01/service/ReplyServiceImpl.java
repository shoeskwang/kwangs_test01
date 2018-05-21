package com.kwang.commerce01.service;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;

import com.kwang.commerce01.model.dao.ReplyDAO;
import com.kwang.commerce01.model.dto.ReplyVO;


@Service
public class ReplyServiceImpl implements ReplyService {
	
	@Inject
	ReplyDAO replyDao;
	
	@Override
	public List<ReplyVO> list(Integer bno,  int start, int end, HttpSession session) {
		// TODO Auto-generated method stub
		List<ReplyVO> items = replyDao.list(bno,start,end);
		
		//세션에서 현재 사용자 id값 저장
		String userId = (String) session.getAttribute("userId");
		for(ReplyVO vo : items){
			//댓글 목록 중 비밀 댓글이 있을 경우
			if("y".equals(vo.getSecretReply()) ){
				if(userId==null){
					vo.setReplytext("비밀 댓글입니다.");
				}else{
					String writer = vo.getWriter();
					String replyer = vo.getReplyer();
					// 로그인한 사용자가 게시글 작성자도 아니고 댓글 작성자도 아닐경우 비밀댓글로 처리
					if(!(userId.equals(writer) || userId.equals(replyer))){
						vo.setReplytext("비밀 댓글입니다.");
					}
				}
			}
		}
		return items;
	}


	@Override
	public void create(ReplyVO vo) {
		// TODO Auto-generated method stub
		replyDao.create(vo);
	}

	@Override
	public void update(ReplyVO vo) {
		// TODO Auto-generated method stub

	}

	@Override
	public void delete(Integer rno) {
		// TODO Auto-generated method stub
		replyDao.delete(rno);
	}

	@Override
	public int count(int bno) {
		// TODO Auto-generated method stub
		return replyDao.count(bno);
	}
}
