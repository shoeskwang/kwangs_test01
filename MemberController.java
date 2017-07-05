package com.exam.ajaxtest01.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.exam.ajaxtest01.model.dto.MemberVO;
import com.exam.ajaxtest01.service.MemberService;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

@Controller
@RequestMapping("/member/*")
public class MemberController {
	@Inject
	MemberService memberService;
	
	@RequestMapping("list.do")
	public ModelAndView list() throws Exception{
		
		// TEST!!
		
		List<MemberVO> list = memberService.listAll();
		
		// �����͸� �ʿ� ����
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("list", list); // list
        
        // ModelAndView - �𵨰� ��
        ModelAndView mav = new ModelAndView();
        mav.addObject("map", map); // �ʿ� ����� �����͸� mav�� ����

        mav.setViewName("member/list"); // �並 list.jsp�� ����
        return mav; // list.jsp�� List�� ���޵ȴ�.
	}
	
	@RequestMapping("ajax.do")
	public void ajaxView(HttpServletResponse response) throws Exception {
		String ajaxJson;
		
		List<MemberVO> member = memberService.listAll();
		
		System.out.println("ajax.do!!");
		System.out.println("memeber = " + member);
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd").create();
		if(member != null){
			ajaxJson = gson.toJson(member);
		}else{
			ajaxJson = "null";
		}
		
//		if(member != null){
//			ajaxJson = "{\"userId\":\""+member.getUserId()
//	            +"\",\"userName\":\""+member.getUserName()
//	            +"\",\"userRegdate\":\""+member.getUserRegdate()
//	            +"\",\"userEmail\":\""+member.getUserEmail()+"\"}";
//		}else{
//			ajaxJson="null";
//		}
		
		try {
	        response.getWriter().print(ajaxJson);
	    } catch (IOException e) {
	        e.printStackTrace();
	    }   
		
		
	}
}
