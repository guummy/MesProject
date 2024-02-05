package com.itwillbs.controller;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itwillbs.domain.InstructionDTO;
import com.itwillbs.domain.PageDTO;
import com.itwillbs.domain.PerformDTO;
import com.itwillbs.domain.SystemDTO;
import com.itwillbs.service.InstructionService;
import com.itwillbs.service.PerformService;
import com.itwillbs.service.SystemService;

@Controller
public class PerformController {
	
	//멤버변수 부모 인터페이스 정의 => 자동으로 자식 클래스 객체생성
		// 스프링 객체생성 방식 => 의존관계주입(DI : Dependency Injection)
		@Inject
		private PerformService performService;
		@Inject
		private InstructionService instructionService;
		@Inject
		private SystemService systemService;
			
		@RequestMapping(value = "/perform/perform", method = RequestMethod.GET)
		public String perform(HttpServletRequest request, Model model, HttpSession session) {
			System.out.println("PerformController perform()");
			
			//비로그인 상태일 시
			Object emp_no = session.getAttribute("emp_no");
			if(emp_no == null) {
				return "system/msg2";
			} else {
			//검색어 가져오기
			String search=request.getParameter("search");
			String select=request.getParameter("select");
			
			// 한 화면에 보여줄 글 개수 설정
			int pageSize=5;
			// 현페이지 번호 가져오기
			String pageNum=request.getParameter("pageNum");
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
			
//			List<PerformDTO> PerformList=performService.getPerformList(pageDTO);
						
			//메서드 호출
			List<Map<String, Object>> PerformMap
			     =performService.getPerformMap(pageDTO);
			
			//페이징 처리
			int count = performService.getPerformCount(pageDTO);
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
			
			
			//model 담아서 이동
			model.addAttribute("PerformMap", PerformMap);
			model.addAttribute("pageDTO", pageDTO);	
			
			//사원정보 관련
			SystemDTO systemDTO = systemService.memberinfo((int)emp_no);
			model.addAttribute("systemDTO2", systemDTO);
			
			// 주소변경 없이 이동
			// /WEB-INF/views/perform/Perform.jsp
			return "perform/Perform";
			}
		}
		
		@RequestMapping(value = "/perform/performinsert", method = RequestMethod.GET)
		public String performInsert(HttpServletRequest request, Model model) {
			
			//메서드 호출
			List<Map<String, Object>> instMap
			     =performService.getInstMap();
			//model 담아서 이동
			model.addAttribute("instMap", instMap);
			
//			String instruction_code=request.getParameter("instruction_code");
//			String product_cd=request.getParameter("product_cd");
//			String line_cd=request.getParameter("line_cd");
			
//			model.addAttribute("instruction_code", instruction_code);
//			model.addAttribute("product_cd", product_cd);
//			model.addAttribute("line_cd", line_cd);
			
			// 주소변경 없이 이동
			// /WEB-INF/views/perform/PerformInsert.jsp
			return "perform/PerformInsert";
		}
		
		@RequestMapping(value = "/perform/performinsertpro", method = RequestMethod.POST)
		public String performInsertPro(HttpServletRequest request, PerformDTO performDTO) {
			System.out.println("PerformController performInsertPro()");
//			if(performService.getPerformCount2()==0) {
//				performDTO.setPerform_cd("MPF00001");
//			}else {
//				String maxpc=performService.getPerform_cd();
//				maxpc=maxpc.substring(3);
//				int tpc=Integer.parseInt(maxpc);
//				tpc=tpc+1;
//				maxpc=String.valueOf(tpc);
//				if(maxpc.length()==1) {
//				maxpc="0000".concat(maxpc);
//				maxpc="MPF".concat(maxpc);
//				}else if(maxpc.length()==2) {
//					maxpc="000".concat(maxpc);
//					maxpc="MPF".concat(maxpc);
//				}else if(maxpc.length()==3) {
//					maxpc="00".concat(maxpc);
//					maxpc="MPF".concat(maxpc);
//				}else if(maxpc.length()==4) {
//					maxpc="0".concat(maxpc);
//					maxpc="MPF".concat(maxpc);
//				}else if(maxpc.length()==5) {
//					maxpc="MPF".concat(maxpc);
//				}
//				performDTO.setPerform_cd(maxpc);
//			}
			
			// 실적코드 자동생성(PCHyyMMdd01) 및 저장 
			// 기존 실적코드
			String first_perform_cd = "기존실적코드";
			String first_number_st = "기존스트링넘버";
			int first_number = 0;
			
			if (performService.getPerform_cd() != null) {
				first_perform_cd = performService.getPerform_cd();
				first_number_st = first_perform_cd.substring(9);
			}	
			
			// 새로운 실적코드
			String new_perform_cd = "실적코드";
			String new_number_st = "스트링넘버";
			int new_number = 0;
			
			// 메뉴코드 설정
			String menu_code = "MPF";
			
			// 오늘날짜 설정
			LocalDate now = LocalDate.now();
		    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyMMdd");
		    String today = now.format(formatter);
		    
		    // 인덱스 설정
		    if ( !(first_perform_cd.equals("기존실적코드")) && first_perform_cd.contains(today)) {
		    	// 패턴&매치 정규식 이용 => 스트링넘버 앞 0 삭제(조건 : String length 2자 이상)
		    	Pattern pattern = Pattern.compile("^0*([1-9][0-9]*)|0+$");
				Matcher matcher = pattern.matcher(first_number_st);
				
				if (matcher.find()) { 
				    first_number = Integer.parseInt(matcher.group(1)); 
				} else {
				    System.out.println("No match found.");
				}
				
				// String 정규식 이용 => new_perform_cd 생성
				new_number = first_number+1;
				new_number_st = String.valueOf(new_number).format("%02d", new_number);
				new_perform_cd = menu_code + today + new_number_st;
				
		    } else {
		    	new_perform_cd = menu_code + today + "01";
		    }
		    performDTO.setPerform_cd(new_perform_cd);
			
			//글쓰기 작업 메서드 호출
			performService.insertPerform(performDTO);
			
			// 주소변경 하면서 이동
			return "redirect:/perform/perform";
		}
		
		@RequestMapping(value = "/perform/performupdate", method = RequestMethod.GET)
		public String performUpdate(HttpServletRequest request, Model model) {
			String perform_cd=request.getParameter("perform_cd");
//			PerformDTO performDTO=performService.getPerform(perform_cd);
			
			//메서드 호출
			List<Map<String, Object>> instMap
			     =performService.getInstMap();
			//model 담아서 이동
			model.addAttribute("instMap", instMap);
			
			//메서드 호출
			Map<String, Object> perform
			     =performService.getPerform(perform_cd);
			
			//model 담아서 이동
			model.addAttribute("perform", perform);
//			model.addAttribute("PerformDTO", performDTO);
//			System.out.println(perform.get("line_cd"));
			
			// 주소변경 없이 이동
			// /WEB-INF/views/perform/PerformUpdate.jsp
			return "perform/PerformUpdate";
		}
		
		@RequestMapping(value = "/perform/performupdatepro", method = RequestMethod.POST)
		public String performUpdatePro(PerformDTO performDTO) {
			
			//글 수정 메서드 호출
			performService.updatePerform(performDTO);
			
			// 주소변경 하면서 이동
			return "redirect:/perform/perform";
		}
		
		@RequestMapping(value = "/perform/performdelete", method = RequestMethod.GET)
		public String performDelete(HttpServletRequest request) {
			//체크 된 값들 가져와서 삭제
			String chbox[]=request.getParameterValues("rowcheck");
			String perform_cd = null;
			if(chbox!=null){
				  for(int i=0;i<chbox.length;i++){
					perform_cd=chbox[i];
					performService.deletePerform(perform_cd);
				  }
		       }			
			
			// 주소변경 하면서 이동
			return "redirect:/perform/perform";
		}
		
			@ResponseBody
			@RequestMapping(value = "/perform/callcd", method = RequestMethod.GET)
			public String callcd(HttpServletRequest request, Model model) {
				// request 파라미터 
				String ic=request.getParameter("ic");
				
				// 메서드 호출
				Map<String, Object> callcdMap
				     =performService.getcallcdMap(ic);
				
				// 보낼 값 result에 저장
				String result=(String) callcdMap.get("line_cd");
				
				// result 값 리턴
				return result;
			}
			
			@ResponseBody
			@RequestMapping(value = "/perform/callcd2", method = RequestMethod.GET)
			public String callcd2(HttpServletRequest request, Model model) {
				// request 파라미터 
				String ic=request.getParameter("ic");
				
				// 메서드 호출
				Map<String, Object> callcdMap
				     =performService.getcallcdMap(ic);
				
				// 보낼 값 result에 저장
				String result=(String) callcdMap.get("product_cd_name");
								
				// result 값 리턴
				return result;
			}
			
			@RequestMapping(value = "/perform/instlist", method = RequestMethod.GET)
			public String instList(HttpServletRequest request, Model model) {
//				한 화면에 보여줄 글의 개수 설정
				int pageSize =5;
//				현재 페이지 번호 가져오기
				String pageNum = request.getParameter("pageNum");
				if(pageNum == null) {
//					pageNum이 없으면 1페이지로 설정
					pageNum = "1";
				} 
				// 페이지번호를 => 정수형 변경
				int currentPage = Integer.parseInt(pageNum);
				
				PageDTO pageDTO = new PageDTO();
				pageDTO.setPageSize(pageSize);
				pageDTO.setPageNum(pageNum);
				pageDTO.setCurrentPage(currentPage);
				
				// 메서드 호출
				List<InstructionDTO> instructionList=instructionService.instructionlist(pageDTO);
				
//				페이징처리
				int count = instructionService.getinstructioncount(pageDTO);
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
				
//				String bfinstruction_code=request.getParameter("instruction_code");
				//model 담아서 이동
				model.addAttribute("instructionList", instructionList);
				model.addAttribute("pageDTO", pageDTO);
//				model.addAttribute("bfinstruction_code", bfinstruction_code);
				
				// 주소변경 없이 이동\\\
				// /WEB-INF/views/perform/InstList.jsp
				return "perform/InstList";
			}
			
			@ResponseBody
			@RequestMapping(value = "/perform/instcheck", method = RequestMethod.GET)
			public String instcheck(HttpServletRequest request, Model model) {
				// request 파라미터 
				String instruction_code=request.getParameter("inst");
				String result=null;
				
				// 메서드 호출
				int instcheck
			     =performService.getinstcheck(instruction_code);
					
				// if문으로 result에 저장 할 값 설정
				if(instcheck==0) {
					result="0";
				}else {
					result="1";
				}			
						
				// result 값 리턴
				return result;
			}
			
			@ResponseBody
			@RequestMapping(value = "/perform/fpdp", method = RequestMethod.GET)
			public int fpdp(HttpServletRequest request, Model model) {
				// request 파라미터 
				int fp=Integer.parseInt(request.getParameter("fp"));
				int qt=Integer.parseInt(request.getParameter("qt"));
				int result=qt-fp;			
				
										
				// result 값 리턴
				return result;
			}
			
			@ResponseBody
			@RequestMapping(value = "/perform/dpfp", method = RequestMethod.GET)
			public int dpfp(HttpServletRequest request, Model model) {
				// request 파라미터 
				int dp=Integer.parseInt(request.getParameter("dp"));
				int qt=Integer.parseInt(request.getParameter("qt"));
				int result=qt-dp;			
				
										
				// result 값 리턴
				return result;
			}

			
}
