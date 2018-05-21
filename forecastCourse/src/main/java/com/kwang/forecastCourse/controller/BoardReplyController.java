package com.kwang.forecastCourse.controller;

import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.kwang.forecastCourse.model.dto.BoardReplyVO;
import com.kwang.forecastCourse.service.ReplyPager;
import com.kwang.forecastCourse.service.BoardReplyService;

@Controller
@RequestMapping("/boardreply/*")
public class BoardReplyController {
	@Inject
	BoardReplyService boardReplyService;
	
	@RequestMapping("insert.do")
	@ResponseBody
	public HashMap<String, String> insert(@ModelAttribute BoardReplyVO vo, HttpSession session){
		String userId = (String) session.getAttribute("userId");
		vo.setReplyer(userId);
		boardReplyService.create(vo);
		
		System.out.println("reply insert Success!!");
		
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("code", "1");
		map.put("msg", "등록하였습니다.");
		
		return map;
	}
	
	@RequestMapping("delete.do")
	@ResponseBody
	public HashMap<String, String> delete(@ModelAttribute BoardReplyVO vo, HttpSession session){
		//String userId = (String) session.getAttribute("userId");
		System.out.println("ReplyController delete() rno = " + vo.getRno());
		//vo.setReplyer(userId);
		boardReplyService.delete(vo.getRno());
		
		System.out.println("reply delete Success!!");
		
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("code", "1");
		map.put("msg", "삭제하였습니다.");
		
		return map;
	}
	
	@RequestMapping("list.do")
	public ModelAndView list(@RequestParam int bno,
							@RequestParam(defaultValue="1") int curPage,
							ModelAndView mav,
							HttpSession session){
		
		//System.out.println("              ReplyController list() bno : " + bno);
		
		// ** 페이징처리
		int count = boardReplyService.count(bno);
		
		if(count<1){
			return mav;
		}
		
		ReplyPager replyPager = new ReplyPager(count,curPage);
		int start = replyPager.getPageBegin();
		int end = replyPager.getPageEnd();
		List<BoardReplyVO> list = boardReplyService.list(bno, start, end, session);
		
		
		
		mav.setViewName("board/replyList");
		mav.addObject("list", list);
		mav.addObject("replyPager", replyPager);
		
		return mav;
	}
	
}
