package com.kwang.forecastCourse.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.kwang.forecastCourse.model.dto.BoardVO;
import com.kwang.forecastCourse.model.dto.GeoVO;
import com.kwang.forecastCourse.service.BoardPager;
import com.kwang.forecastCourse.service.CourseService;
import com.kwang.forecastCourse.service.HttpRequestService;
import com.kwang.forecastCourse.service.MainService;

@Controller
@RequestMapping("/course/*")
public class CourseController {
	@Inject
	HttpRequestService httpRequestService;
	@Inject
	CourseService courseService;
	@Inject
	MainService mainService;
	
	@RequestMapping("view.do")
    public ModelAndView viewCourse(@RequestParam(defaultValue="1") int gno, HttpSession session) throws Exception{
		
		//GeoVO vo = courseService.view(gno);
		// 조회수 증가 처리
		courseService.increaseViewcnt(gno, session);
        
		Map<String, Object> map = new HashMap<String, Object>();
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("dto",courseService.view(gno));
		mav.setViewName("course/view");
		return mav;
	}
	
	@RequestMapping(value="insert.do", method=RequestMethod.POST)
    public String insert(@ModelAttribute GeoVO vo, HttpSession session) throws Exception{
		System.out.println("CourseController insert()");
		String userId = (String) session.getAttribute("userId");
		vo.setWriter(userId);
		
		courseService.insert(vo);
		
		return "redirect:list.do";
	}
	
	@RequestMapping(value="write.do", method=RequestMethod.GET)
    public String write(){
        return "course/insert"; // insert.jsp로 이동
    }
	
	@RequestMapping("list.do")
    public ModelAndView listAll(@RequestParam(defaultValue="1") int curPage) throws Exception{
		// 레코드 갯수
        int count = courseService.countArticle();
        
        // 페이지 나누기 관련 처리
        BoardPager boardPager = new BoardPager(count,curPage);
        int start = boardPager.getPageBegin();
        int end = boardPager.getPageEnd();
        
		List<GeoVO> list = courseService.listAll(start, end , null, null);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list); // list
		map.put("count", count); // 레코드의 갯수
        map.put("boardPager", boardPager);
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("map", map);
		mav.addObject("forecastMap", mainService.getForecastInfo());
    	mav.addObject("dustMap", mainService.getDustInfo());
		mav.setViewName("course/list");
		return mav;
	}
	
	// 04. 게시글 수정
    // 폼에서 입력한 내용들은 @ModelAttribute BoardVO vo로 전달됨
    @RequestMapping(value="update.do", method=RequestMethod.POST)
    public String update(@ModelAttribute GeoVO vo) throws Exception{
    	System.out.println("update VO :: " + vo.toString());
    	
    	courseService.update(vo);
        return "redirect:list.do";
    }

    // 05. 게시글 삭제
    @RequestMapping("delete.do")
    public String delete(@RequestParam int gno) throws Exception{
    	courseService.delete(gno);
        return "redirect:list.do";
    }
}
