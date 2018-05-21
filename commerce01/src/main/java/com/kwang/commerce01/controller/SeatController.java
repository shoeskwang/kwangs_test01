package com.kwang.commerce01.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.kwang.commerce01.model.dto.SeatVO;
import com.kwang.commerce01.service.SeatService;

@Controller
@RequestMapping("/seat/*")
public class SeatController {
	
	@Inject
	SeatService seatService;

	
	@RequestMapping("seatList.do")
	public ModelAndView seatList(@RequestParam(defaultValue="") String tno,
								HttpServletResponse response,
									HttpSession session) throws Exception{
		 // 레코드 갯수
        //int count = CartService.countArticle(searchOption, keyword);
        
        SeatVO list = seatService.list(tno); //찜목록
        
        // 데이터를 맵에 저장
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("list", list); // list
        //map.put("count", count); // 레코드의 갯수
        
        // ModelAndView - 모델과 뷰
        ModelAndView mav = new ModelAndView();
        mav.addObject("map", map); // 맵에 저장된 데이터를 mav에 저장

        mav.setViewName("seat/list"); // 뷰를 list.jsp로 설정
        return mav; // list.jsp로 List가 전달된다.
	}
	

}
