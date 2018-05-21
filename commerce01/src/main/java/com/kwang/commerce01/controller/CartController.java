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
import com.kwang.commerce01.model.dto.CartVO;
import com.kwang.commerce01.model.dto.OrderVO;
import com.kwang.commerce01.model.dto.TicketVO;
import com.kwang.commerce01.service.CartService;
import com.kwang.commerce01.service.OrderService;

@Controller
@RequestMapping("/cart/*")
public class CartController {
	
	@Inject
	CartService cartService;
	
	@Inject
	OrderService orderSevrice;
	
	@RequestMapping("cartAdd.do")
	public void cartAddajax(@RequestParam(defaultValue="0") String tno,
							@RequestParam(defaultValue="") String userId,
									HttpServletResponse response,
									HttpSession session ) throws Exception{
		String ajaxJson;
		//List<TicketVO> list = ticketService.listTheme(sortOption);
		System.out.println("cartAddajax");
		System.out.println("tno = " + tno);
		System.out.println("userId = " + userId);
		
		int cartCount = cartService.cartCount(userId, tno);
		System.out.println("cartCount = " + cartCount);
		if(cartCount>0){
			ajaxJson = "{\"result\":\"fail\"}";
		}else{
			CartVO vo = new CartVO();
			vo.setTno(tno);
			vo.setUserId(userId);
			vo.setAmount(1);
			
			//insert
			cartService.cartAdd(vo);
			
			ajaxJson = "{\"result\":\"success\"}";
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
	
	@RequestMapping("cartList.do")
	public ModelAndView cartList(HttpServletResponse response,
									HttpSession session) throws Exception{
		 // 레코드 갯수
        //int count = CartService.countArticle(searchOption, keyword);
        
        String userId = (String) session.getAttribute("userId");
        List<CartVO> list = cartService.list(userId); //찜목록
        
        List<OrderVO> orderList = orderSevrice.list(userId);
        
        // 데이터를 맵에 저장
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("list", list); // list
        map.put("orderList", orderList);
        //map.put("count", count); // 레코드의 갯수
        
        // ModelAndView - 모델과 뷰
        ModelAndView mav = new ModelAndView();
        mav.addObject("map", map); // 맵에 저장된 데이터를 mav에 저장

        mav.setViewName("cart/list"); // 뷰를 list.jsp로 설정
        return mav; // list.jsp로 List가 전달된다.
	}
	
	@RequestMapping("cartDelete.do")
	public String cartDelete(@RequestParam(defaultValue="0") String cartId,
														HttpSession session) throws Exception{
		cartService.cartDelete(cartId);
        return "redirect:cartList.do";
    }

}
