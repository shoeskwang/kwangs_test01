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

import com.kwang.forecastCourse.model.dto.ReplyVO;
import com.kwang.forecastCourse.service.ReplyPager;
import com.kwang.forecastCourse.service.ReplyService;

@Controller
@RequestMapping("/reply/*")
public class ReplyController {
	@Inject
	ReplyService replyService;
	
	@RequestMapping("insert.do")
	@ResponseBody
	public HashMap<String, String> insert(@ModelAttribute ReplyVO vo, HttpSession session){
		String userId = (String) session.getAttribute("userId");
		vo.setReplyer(userId);
		replyService.create(vo);
		
		System.out.println("reply insert Success!!");
		
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("code", "1");
		map.put("msg", "등록하였습니다.");
		
		return map;
	}
	
	@RequestMapping("delete.do")
	@ResponseBody
	public HashMap<String, String> delete(@ModelAttribute ReplyVO vo, HttpSession session){
		//String userId = (String) session.getAttribute("userId");
		System.out.println("ReplyController delete() grno = " + vo.getGrno());
		//vo.setReplyer(userId);
		replyService.delete(vo.getGrno());
		
		System.out.println("reply delete Success!!");
		
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("code", "1");
		map.put("msg", "삭제하였습니다.");
		
		return map;
	}
	
	@RequestMapping("list.do")
	public ModelAndView list(@RequestParam int gno,
							@RequestParam(defaultValue="1") int curPage,
							ModelAndView mav,
							HttpSession session){
		
		//System.out.println("              ReplyController list() bno : " + bno);
		
		// ** 페이징처리
		int count = replyService.count(gno);
		
		if(count<1){
			return mav;
		}
		
		ReplyPager replyPager = new ReplyPager(count,curPage);
		int start = replyPager.getPageBegin();
		int end = replyPager.getPageEnd();
		List<ReplyVO> list = replyService.list(gno, start, end);
		
		
		
		mav.addObject("list", list);
		mav.addObject("replyPager", replyPager);
		mav.addObject("count", count);
		mav.setViewName("course/replyList");
		return mav;
	}
}
