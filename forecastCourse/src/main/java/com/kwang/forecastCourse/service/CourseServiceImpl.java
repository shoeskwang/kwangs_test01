package com.kwang.forecastCourse.service;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;

import com.kwang.forecastCourse.model.dao.CourseDAO;
import com.kwang.forecastCourse.model.dto.GeoVO;

@Service
public class CourseServiceImpl implements CourseService {
	@Inject
	CourseDAO CourseDao;
	@Override
	public GeoVO view(int gno) throws Exception {
		// TODO Auto-generated method stub
		return CourseDao.view(gno);
	}

	@Override
	public void insert(GeoVO vo) throws Exception {
		// TODO Auto-generated method stub
		CourseDao.insert(vo);
	}

	@Override
	public List<GeoVO> listAll(int start, int end, String searchOption, String keyword) throws Exception {
		// TODO Auto-generated method stub
		return CourseDao.listAll(start, end, searchOption, keyword);
	}

	@Override
	public void update(GeoVO vo) throws Exception {
		// TODO Auto-generated method stub
		CourseDao.update(vo);
	}

	@Override
	public void delete(int gno) throws Exception {
		// TODO Auto-generated method stub
		CourseDao.delete(gno);
	}

	@Override
	public void increaseViewcnt(int gno, HttpSession session) throws Exception {
		// TODO Auto-generated method stub
		long update_time = 0;
		
		System.out.println("session.getAttribute(update time +bno ) :: "+session.getAttribute("update_time_"+gno));
        // 세션에 저장된 조회시간 검색
        // 최초로 조회할 경우 세션에 저장된 값이 없기 때문에 if문은 실행X
        if(session.getAttribute("update_time_"+gno) != null){
                                // 세션에서 읽어오기
            update_time = Long.parseLong(session.getAttribute("update_time_"+gno).toString());
        }
        // 시스템의 현재시간을 current_time에 저장
        long current_time = System.currentTimeMillis();
        
        System.out.println("current_time - update_time :: " + (current_time - update_time));
        // 일정시간이 경과 후 조회수 증가 처리 24*60*60*1000(24시간)
        // 시스템현재시간 - 열람시간 > 일정시간(조회수 증가가 가능하도록 지정한 시간)
        if(current_time - update_time > 5*1000){
        	CourseDao.increaseViewcnt(gno);
            // 세션에 시간을 저장 : "update_time_"+bno는 다른변수와 중복되지 않게 명명한 것
            session.setAttribute("update_time_"+gno, current_time);
            
        }
	}

	@Override
	public int countArticle() throws Exception {
		return CourseDao.countArticle();
	}

}
