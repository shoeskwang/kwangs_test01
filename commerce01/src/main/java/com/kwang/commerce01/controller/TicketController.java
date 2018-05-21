package com.kwang.commerce01.controller;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.kwang.commerce01.model.dto.SeatVO;
import com.kwang.commerce01.model.dto.TicketVO;
import com.kwang.commerce01.service.SeatService;
import com.kwang.commerce01.service.TicketService;

@Controller
@RequestMapping("/ticket/*")
public class TicketController {
	@Inject
	TicketService ticketService;
	
	@Inject
	SeatService seatService;
	
	//put this in your Controller 
	//(if you have a superclass for your controllers 
	//and want to use the same date format throughout the app, put it there)
	@InitBinder
	private void dateBinder(WebDataBinder binder) {
	            //The date format to parse or output your dates
	    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
	            //Create a new CustomDateEditor
	    CustomDateEditor editor = new CustomDateEditor(dateFormat, true);
	            //Register it as custom editor for the Date type
	    binder.registerCustomEditor(Date.class, editor);
	}
	
	@RequestMapping("list.do")
	public ModelAndView list(@RequestParam(defaultValue="2") String sortOption) throws Exception{
		
		List<TicketVO> list = ticketService.listAll(sortOption);
		
		/*mav.addObject("list", list); // 데이터를 저장
		mav.addObject("count", count);
		mav.addObject("searchOption", searchOption);
		mav.addObject("keyword", keyword);*/
		
		
		// 데이터를 맵에 저장
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list); // list
		
		// ModelAndView - 모델과 뷰
		ModelAndView mav = new ModelAndView();
		mav.addObject("map", map); // 맵에 저장된 데이터를 mav에 저장
		
		mav.setViewName("ticket/list"); // 뷰를 list.jsp로 설정
		return mav; // list.jsp로 List가 전달된다.
	}
	
	@RequestMapping(value="insertcont.do", method=RequestMethod.POST)
	public String insertTicket(@ModelAttribute TicketVO vo) throws Exception{
		System.out.println("TicketController insert vo = " + vo.toString());
		
		// date 타입 변경 필요함..
		Date sdate = vo.getSdate();
		
		String convertSdate = new SimpleDateFormat("yyyy-MM-dd").format(sdate);
		
		System.out.println("convertdate  = " + convertSdate);
		
		//TODO
		// String 형태로는 변환은 하였으나 원하는 형태의 Date 형태로 변환하지 못하였음..
		
//		Date stringDate1 = (Date) new SimpleDateFormat("yyyy-MM-dd").parse(convertSdate);
//		
//		System.out.println("stringDate1 = " + stringDate1);
		
//		vo.setSdate(stringDate1);
		ticketService.create(vo);
		
		return "redirect:list.do"; // list.jsp로 List가 전달된다.
	}
	
	 @RequestMapping("insert.do")
    public String insert() throws Exception{
	 	System.out.println("insert.do");
    	return "ticket/insert";
    }
	
	 @RequestMapping("seats.do")
	    public ModelAndView seats(@RequestParam(defaultValue="001") String tno ,
	    						@RequestParam(defaultValue="none") String title , 
	    						@RequestParam(defaultValue="0") String userId , 
	    						@RequestParam(defaultValue="0") int amount , 
	    						@RequestParam(defaultValue="0") String whatday , 
	    						@RequestParam(defaultValue="0") String selectday 
	    		) throws Exception{
		 	System.out.println("seats.do");
		 	
		 	String no = tno.replaceAll("t", "");
		 	SeatVO seatVO = seatService.list(no);
		 	int day = Integer.parseInt(whatday)+1;
		 	String seat;
		 	
		 	switch (day) {
			case 1:
				seat = seatVO.getDay1();
				break;
			case 2:
				seat = seatVO.getDay2();
				break;
			case 3:
				seat = seatVO.getDay3();
				break;
			case 4:
				seat = seatVO.getDay4();
				break;
			case 5:
				seat = seatVO.getDay5();
				break;
			case 6:
				seat = seatVO.getDay6();
				break;
			case 7:
				seat = seatVO.getDay7();
				break;
			case 8:
				seat = seatVO.getDay8();
				break;
			case 9:
				seat = seatVO.getDay9();
				break;
			case 10:
				seat = seatVO.getDay10();
				break;
			default:
				seat = seatVO.getDay1();
				break;
			}
		 	
		 	System.out.println("seat = " +seat);
		 	if(seat == null){
		 		seat = "00000000000000000000000000000000000000000000000000";
		 	}
		 	System.out.println("seat = " +seat);
		 	// 데이터를 맵에 저장
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("tno", tno); // list
			map.put("title", title);
			map.put("userId", userId);
			map.put("amount", amount);
			map.put("whatday", whatday);
			map.put("selectday", selectday);
			map.put("seat", seat);
			
			
			// ModelAndView - 모델과 뷰
			ModelAndView mav = new ModelAndView();
			mav.addObject("map", map); // 맵에 저장된 데이터를 mav에 저장
			mav.addObject("seat", seat);
//			mav.addObject("dto", ticketService.view(tno));
			mav.setViewName("ticket/seats"); // 뷰를 list.jsp로 설정
			return mav; // list.jsp로 List가 전달된다.
	    }
	 
	@RequestMapping("view.do")
    public ModelAndView view(@RequestParam(defaultValue="t001") String tno) throws Exception{
		
		Date sdate = ticketService.view(tno).getSdate();
		String convertSdate = new SimpleDateFormat("yyyy-MM-dd").format(sdate);
		
		System.out.println("convertdate  = " + convertSdate);
		
		// 데이터를 맵에 저장
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("tno", tno); // list
		map.put("convertSdate", convertSdate);
		
		
		// ModelAndView - 모델과 뷰
		ModelAndView mav = new ModelAndView();
		mav.addObject("map", map); // 맵에 저장된 데이터를 mav에 저장
		mav.addObject("dto", ticketService.view(tno));
		
		mav.setViewName("ticket/view"); // 뷰를 list.jsp로 설정
		return mav; // list.jsp로 List가 전달된다.
    }
	
	@RequestMapping("theme.do")
	public ModelAndView themeList(@RequestParam(defaultValue="2") String sortOption ,
									@RequestParam(defaultValue="0") String theme , 
									@RequestParam(defaultValue="0") String genre ,
									@RequestParam(defaultValue="0") String location,
									HttpSession session) throws Exception{
	
		List<TicketVO> list = ticketService.listAll(sortOption);
		
		session.setAttribute("sortOption", sortOption);
		
		System.out.println("     sortOption = " + sortOption);
		System.out.println("     theme = " + theme);
		System.out.println("     genre = " + genre);
		System.out.println("     location = " + location);
		
		/*mav.addObject("list", list); // 데이터를 저장
		mav.addObject("count", count);
		mav.addObject("searchOption", searchOption);
		mav.addObject("keyword", keyword);*/
		
		
		// 데이터를 맵에 저장
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list); // list
		
		// ModelAndView - 모델과 뷰
		ModelAndView mav = new ModelAndView();
		mav.addObject("map", map); // 맵에 저장된 데이터를 mav에 저장
		
		mav.setViewName("ticket/themelist"); // 뷰를 list.jsp로 설정
		return mav; // list.jsp로 List가 전달된다.
	}
	
	@RequestMapping("themeajax.do")
	public void themeListajax(@RequestParam(defaultValue="2") String sortOption ,
									@RequestParam(defaultValue="0") String theme , 
									@RequestParam(defaultValue="0") String genre ,
									@RequestParam(defaultValue="0") String location,
									HttpServletResponse response,
									HttpSession session ) throws Exception{
		String ajaxJson;
		List<TicketVO> list = ticketService.listTheme(sortOption, theme, genre, location);
		
		
		session.setAttribute("sortOption", sortOption);
		
		System.out.println("     sortOption = " + sortOption);
		System.out.println("     theme = " + theme);
		System.out.println("     genre = " + genre);
		System.out.println("     location = " + location);
		
		System.out.println("ajax.do!!");
		System.out.println("list = " + list);
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd").create();
		if(list != null){
			ajaxJson = gson.toJson(list);
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
	
	@RequestMapping("buyTicket.do")
	public ModelAndView buyTicket(@RequestParam(defaultValue="default") String tno ,
									@RequestParam(defaultValue="default") String userId ,
									@RequestParam(defaultValue="") String temp , 
									HttpSession session) throws Exception{
		
		
//		String selectSeatStr = temp;
//		System.out.println(selectSeatStr);
		// 데이터를 맵에 저장
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("tno", tno); 
		map.put("userId", userId);
		
		// ModelAndView - 모델과 뷰
		ModelAndView mav = new ModelAndView();
		mav.addObject("map", map); // 맵에 저장된 데이터를 mav에 저장
		mav.addObject("dto", ticketService.view(tno));
		
		
		mav.setViewName("ticket/buyTicket"); // 뷰를 list.jsp로 설정
		return mav; // list.jsp로 List가 전달된다.
	}
	 
}
