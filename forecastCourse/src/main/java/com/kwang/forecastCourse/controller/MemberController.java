package com.kwang.forecastCourse.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.kwang.forecastCourse.model.dto.BoardVO;
import com.kwang.forecastCourse.model.dto.GeoVO;
import com.kwang.forecastCourse.model.dto.MemberVO;
import com.kwang.forecastCourse.service.BoardService;
import com.kwang.forecastCourse.service.CourseService;
import com.kwang.forecastCourse.service.MemberService;

@Controller
@RequestMapping("/member/*")
public class MemberController {
	@Inject
	MemberService memberService;
	
	@Inject
	BoardService boardService;
	@Inject
	CourseService courseService;
	
	// 로깅을 위한 변수
    private static final Logger logger = LoggerFactory.getLogger(MemberController.class);
    
    @RequestMapping("login.do")
    public String login(){
    	return "member/login";
    }
    
    @RequestMapping("join.do")
    public String join(){
    	return "member/join";
    }
    
    @RequestMapping("insert.do")
    public String insert(@ModelAttribute MemberVO vo){
    	
    	System.out.println("insert.do vo = " + vo);
    	memberService.insert(vo);
    	
    	return "member/login";
    	
    }
    
    @RequestMapping("idCheck.do")
    public void idCheckajax(@RequestParam(defaultValue="") String id,
    											HttpServletResponse response) throws Exception{
    	
    	String ajaxJson;
		int count = memberService.idCheck(id);
		
		System.out.println("ID Check count = " + count);
		if(count>0){
			ajaxJson = "{\"result\":\""+"1"+"\"}";
		}else{
			// result 0 이 성공
			ajaxJson= "{\"result\":\""+"0"+"\"}";
		}
		
		try {
	        response.getWriter().print(ajaxJson);
	    } catch (IOException e) {
	        e.printStackTrace();
	    }  
    	
    }
    
    @RequestMapping("loginCheck.do")
    public String loginCheck(@ModelAttribute MemberVO vo, HttpSession session){
    	boolean result = memberService.loginCheck(vo, session);
    	if(result == true){
    		return "redirect:../main/index.do";
    	} else{ //로그인 실패
    		return "redirect:loginFail.do";
    	}
    	//return mav;
    }
    
    @RequestMapping("loginFail.do")
    public ModelAndView loginFail(){
    	ModelAndView mav = new ModelAndView();
    	
		mav.setViewName("member/login");
		mav.addObject("msg", "failure");
		
		return mav;
    }
    
    @RequestMapping("logout.do")
    public ModelAndView logout(HttpSession session){
    	memberService.logout(session);
    	ModelAndView mav = new ModelAndView();
    	mav.setViewName("member/login");
    	mav.addObject("msg", "logout");
    	return mav;
    }
    
    @RequestMapping("mypage.do")
    public ModelAndView mypage(HttpSession session) throws Exception{
    	String userId = (String) session.getAttribute("userId");
    	
    	List<GeoVO> glist = courseService.listAll(1, 20,"writer", userId);
    	List<BoardVO> blist = boardService.listAll(1,20,"writer", userId);
        
        // 데이터를 맵에 저장
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("glist", glist); // list
        map.put("blist", blist); // list
        
    	ModelAndView mav = new ModelAndView();
    	mav.addObject("map", map);
    	mav.setViewName("member/mypage");
    	return mav;
    }
}
