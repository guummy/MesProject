package com.itwillbs.controller;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itwillbs.domain.MemberDTO;
import com.itwillbs.domain.PageDTO;
import com.itwillbs.domain.SystemDTO;
import com.itwillbs.domain.WHDTO;
import com.itwillbs.service.SystemService;
import com.itwillbs.service.WHService;

@Controller
public class WHController {
	
	@Inject
	private WHService whService; 
	
	@Inject
	private SystemService systemService;
	
	@RequestMapping(value = "/wh/whpage", method = RequestMethod.GET)
	public String whpage(HttpServletRequest request, Model model,HttpSession session) {
		
		Object emp_no = session.getAttribute("emp_no");
        if(emp_no == null) {
           return "system/msg2";
        } else {

		
		//검색어 가져오기
		String search=request.getParameter("search");
		// 검색어 옵션
		String select = request.getParameter("select");
		String pageNum=request.getParameter("pageNum");
		
				// 한 화면에 보여줄 글 개수 설정
				int pageSize=5;
				// 현페이지 번호 가져오기
				if(pageNum==null) {
					//pageNum 없으면 1페이지 설정
					pageNum="1";
				}
				// 페이지번호를 => 정수형 변경
				int currentPage=Integer.parseInt(pageNum);
				
				PageDTO pageDTO=new PageDTO();
				pageDTO.setPageSize(pageSize);
				pageDTO.setPageNum(pageNum);
				pageDTO.setCurrentPage(currentPage);
				//검색어
				pageDTO.setSearch(search);
				pageDTO.setSelect(select);
				
				List<WHDTO> whList=whService.getWhList(pageDTO);
				
				//페이징 처리
				int count = whService.getWhCount(pageDTO);
				int pageBlock=10;
				int startPage=(currentPage-1)/pageBlock*pageBlock+1;
				int endPage=startPage+pageBlock-1;
				int pageCount=count/pageSize+(count%pageSize==0?0:1);
				if(endPage > pageCount){
					endPage = pageCount;
				}
				
				pageDTO.setCount(count);
				pageDTO.setPageBlock(pageBlock);
				pageDTO.setStartPage(startPage);
				pageDTO.setEndPage(endPage);
				pageDTO.setPageCount(pageCount);
				
				model.addAttribute("whList", whList);
				model.addAttribute("pageDTO", pageDTO);
				
				 SystemDTO systemDTO = systemService.memberinfo((int)emp_no);
		         model.addAttribute("systemDTO2", systemDTO);

				
		return "warehouse/WhPage";
        }
	}
	
	@RequestMapping(value = "/wh/whinsert", method = RequestMethod.GET)
	public String whinsert() {
		System.out.println("WHController whinsert()");
		
		return "warehouse/WhInsert";
	}
	
	@RequestMapping(value = "/wh/whinsertPro", method = RequestMethod.POST)
	public String whinsertPro(WHDTO whdto) {
		System.out.println("WHController whinsertPro()");
		
		whService.insertwh(whdto);
		
		return "redirect:/wh/whpage";
	}
	
	@RequestMapping(value = "/wh/whupdate", method = RequestMethod.GET)
	public String whupdate(HttpServletRequest request, Model model) {
		System.out.println("WHController whupdate()");
		String wh_cd=request.getParameter("wh_cd");
		WHDTO whDTO=whService.getwh(wh_cd);
		
		model.addAttribute("whDTO", whDTO);
		
		return "warehouse/WhUpdate";
	}
	
	@RequestMapping(value = "/wh/whupdatePro", method = RequestMethod.POST)
	public String whupdatePro(WHDTO whDTO) {
		System.out.println("WHController whupdatePro()");
		
		whService.updatewh(whDTO);
		
		return "redirect:/wh/whpage";
	}
	
	@RequestMapping(value = "/wh/whdelete", method = RequestMethod.GET)
	public String whdelete(HttpServletRequest request) {
		System.out.println("WHController whdelete()");
		String[] ajaxMsg = request.getParameterValues("valueArr");
		int size = ajaxMsg.length;
		for(int i=0; i<size; i++) {
			whService.deletewh(ajaxMsg[i]);
		}
		
		return "redirect:/wh/whpage";
	}
	
	@ResponseBody
	@RequestMapping(value = "/wh/whcheck", method = RequestMethod.GET)
	public String whcheck(HttpServletRequest request, Model model) {
		// request 파라미터 
		String wh_name=request.getParameter("wh");
		String result=null;
		
		// 메서드 호출
		int whcheck=whService.getwhcheck(wh_name);
			
		// if문으로 result에 저장 할 값 설정
		if(whcheck==0) {
			result="0";
		}else {
			result="1";
		}			
				
		// result 값 리턴
		return result;
	}
	
}
