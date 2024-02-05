package com.itwillbs.controller;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.itwillbs.domain.PageDTO;
import com.itwillbs.domain.SystemDTO;
import com.itwillbs.service.SystemService;

@Controller
public class SystemController {
	@Inject
	private SystemService systemService;
	
	@RequestMapping(value = "/system/membermain", method = RequestMethod.GET)
	public String membermain(HttpServletRequest request, Model model, HttpSession session) {
			System.out.println("SystemController membermain()");

			Object emp_no = session.getAttribute("emp_no");
			if(emp_no == null) {
				return "system/msg2";
			} else {
				String search =request.getParameter("search");
//				한 화면에 보여줄 글의 개수 설정
				int pageSize =5;
//				현재 페이지 번호 가져오기
				String pageNum = request.getParameter("pageNum");
				if(pageNum == null) {
//					pageNum이 없으면 1페이지로 설정
					pageNum = "1";
				} 
				int currentPage = Integer.parseInt(pageNum);
				
				PageDTO pageDTO = new PageDTO();
				pageDTO.setPageSize(pageSize);
				pageDTO.setPageNum(pageNum);
				pageDTO.setCurrentPage(currentPage);
				pageDTO.setSearch(search);
				
				List<SystemDTO> systemList=systemService.getsystemlist(pageDTO);
				
//				페이징처리
				int count = systemService.getsystemcount(pageDTO);
				int pageBlock = 10;
				int startPage = (currentPage-1)/pageBlock * pageBlock + 1;  
				int endPage = startPage + pageBlock - 1;
				int pageCount = count/pageSize + (count%pageSize==0?0:1);
				if (endPage > pageCount){
					endPage = pageCount;
					}
				
				pageDTO.setCount(count);
				pageDTO.setPageBlock(pageBlock);
				pageDTO.setStartPage(startPage);
				pageDTO.setEndPage(endPage);
				pageDTO.setPageCount(pageCount);
				
				model.addAttribute("systemList", systemList);
				model.addAttribute("pageDTO", pageDTO);
				SystemDTO systemDTO = systemService.memberinfo((int)emp_no);
				model.addAttribute("systemDTO2", systemDTO);
				System.out.println(systemDTO.getEmp_no());
				return "system/MemberMain";
			}

	}
	
	@RequestMapping(value = "/system/memberinsert", method = RequestMethod.GET)
	public String memberinsert() {
		// 처리작업
		
		// 가상주소에서 주소변경 없이 이동
		return "system/MemberInsert";
	}
	
	@RequestMapping(value = "/system/memberinsertpro", method = RequestMethod.POST)
	public String memberinsertpro(SystemDTO systemDTO) {
		// web.xml 에서 한글설정을 한번만 하면 모든 곳에서 한글처리
		System.out.println("SystemController memberinsertpro()");

		// MemberService memberService = new MemberServiceImpl();
		systemService.memberinsertpro(systemDTO);

		// 가상주소에서 주소변경 하면서 이동
		return "redirect:/system/membermain";
	}
	
	@RequestMapping(value = "/system/memberupdate", method = RequestMethod.GET)
	public String memberupdate(HttpServletRequest request, Model model) {
		// web.xml 에서 한글설정을 한번만 하면 모든 곳에서 한글처리
		System.out.println("SystemController memberupdate()");
		int emp_no = Integer.parseInt(request.getParameter("emp_no"));
		SystemDTO systemDTO = systemService.memberinfo(emp_no);
		model.addAttribute("systemDTO", systemDTO);

		return "system/MemberUpdate";
	}

	@RequestMapping(value = "/system/memberupdatepro", method = RequestMethod.POST)
	public String memberupdatepro(SystemDTO systemDTO,HttpServletRequest request) {
		System.out.println("SystemController memberupdatepro()");
		// 디비 수정 처리 => 처리 => 디비 자바 메서드 호출
			systemService.memberupdatepro(systemDTO);
			// 주소 변경되면서 로그인 페이지로 이동 
			// response.sendRedirect("/member/main");
			return "redirect:/system/membermain";	
	}

	@RequestMapping(value = "/system/memberdelete", method = RequestMethod.GET)
	public String memberdelete(HttpServletRequest request) {
		// web.xml 에서 한글설정을 한번만 하면 모든 곳에서 한글처리
		System.out.println("SystemController memberupdate()");
		int emp_no = Integer.parseInt(request.getParameter("emp_no"));
			systemService.memberdelete(emp_no);

		 return "redirect:/system/membermain";
	}

	@RequestMapping(value = "/system/memberlogin", method = RequestMethod.GET)
	public String memberlogin() {
		// 처리작업
		
		// 가상주소에서 주소변경 없이 이동
		return "system/MemberLogin";
	}
	

	@RequestMapping(value = "/system/memberloginpro", method = RequestMethod.POST)
	public String loginPro(SystemDTO systemDTO, HttpSession session) {
		System.out.println("MemberController loginPro()");
				
		// 리턴할형 MemberDTO userCheck(MemberDTO memberDTO) 메서드 정의
		// 메서드 호출
		 SystemDTO systemDTO2=systemService.userCheck(systemDTO);
		
		if(systemDTO2!=null) {
			
			session.setAttribute("emp_no", systemDTO.getEmp_no());
			System.out.println("출력해바!!!!!!!!"+session.getAttribute("emp_no"));
			return "redirect:/home";
		}else {
			//아이디 비밀번호 틀림  뒤로이동  member/msg
			return "system/msg";
		}
	}
	
	@RequestMapping(value = "/system/memberlogout", method = RequestMethod.GET)
	public String logout(HttpSession session) {
		//세션초기화
		session.invalidate();
		
//		주소줄 변경하면서 이동
		return "redirect:/home";
	}
	
	@RequestMapping(value = "/system/mypageform", method = RequestMethod.GET)
	public String businessupdate(HttpSession session, Model model) {
		System.out.println("SystemController mypageForm()");
		//비로그인 상태일 시
		int emp_no = (Integer)session.getAttribute("emp_no");
		
		System.out.println(emp_no);
		SystemDTO systemDTO = systemService.memberinfo(emp_no);
		
		model.addAttribute("systemDTO",systemDTO);
		
		
		// 가상주소 유지
		return "mypage/mypage";
		
	}
	
	@RequestMapping(value = "/system/mypagepro", method = RequestMethod.POST)
	public String updatePro(SystemDTO systemDTO, HttpSession session) {
		System.out.println("systemController mypagePro()");
		int emp_no = (Integer)session.getAttribute("emp_no");
		systemDTO.setEmp_no(emp_no);
		systemService.mypagePro(systemDTO);

		return "mypage/msg";
	}
	
	
}
