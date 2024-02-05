package com.itwillbs.controller;



import java.sql.Date;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.xml.crypto.dsig.keyinfo.PGPData;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itwillbs.domain.DeliverDTO;
import com.itwillbs.domain.InstructionDTO;
import com.itwillbs.domain.OrderDTO;
import com.itwillbs.domain.PageDTO;
import com.itwillbs.domain.ReceiveDTO;
import com.itwillbs.domain.ReleaseDTO;
import com.itwillbs.domain.SystemDTO;
import com.itwillbs.service.DeliverService;
import com.itwillbs.service.OrderService;
import com.itwillbs.service.ReceiveService;
import com.itwillbs.service.ReleaseService;
import com.itwillbs.service.SystemService;





	
@Controller
public class DeliverController {
	
		@Inject
		private DeliverService deliverService;
		
		
		@Inject
		private OrderService orderService;
		
		@Inject
		private ReleaseService relService;
		
		@Inject
		private SystemService systemService;

		
		

//		//가상주소???!!!???? 영업관리=> 출하등록 화면에서 " 출하등록 및 리스트가 되어야하는곳..."
//		@RequestMapping(value = "/deliver/deliver", method = RequestMethod.GET)
//		public String list(Model model) {
//			// 처리작업
//			
//			List<DeliverDTO> DeliverList=deliverService.getDeliverList();
//			
//			model.addAttribute("DeliverList", DeliverList);
//			
//			
//			// 가상주소에서 주소변경 없이 이동
//			return "deliver/Deliver";
//		}
	
			
		@RequestMapping(value = "/deliver/list", method = RequestMethod.GET)
		public String list(HttpServletRequest request, Model model, HttpSession session) {
			System.out.println("리스트"+"/deliver/list");

			//검색어 가져오기
			String search=request.getParameter("search");
			String select=request.getParameter("select");
			
			//비로그인시
			Object emp_no = session.getAttribute("emp_no");
	         if(emp_no == null) {
	            return "system/msg2";
	         } else {

			
				// 한 화면에 보여줄 글 개수 설정
				int pageSize = 5;
			
			//현 페이지 번호가져오기
			String pageNum=request.getParameter("pageNum");
			if(pageNum==null) {
				//pageNum없으면 1페이지 설정
				pageNum="1";
			}
			//페이지 번호를 => 정수형 변경
			int currentPage=Integer.parseInt(pageNum);
			
			PageDTO pageDTO = new PageDTO();
			pageDTO.setPageSize(pageSize);
			pageDTO.setPageNum(pageNum);
			pageDTO.setCurrentPage(currentPage);
			//검색어
			pageDTO.setSearch(search);
			pageDTO.setSelect(select);
			List<DeliverDTO>deliverList=deliverService.getDeliverList(pageDTO);
			
			//페이징처리
			//검색어
			int count = deliverService.getDeliverCount(pageDTO);
			int pageBlock=5;
			int startPage=(currentPage-1)/pageBlock*pageBlock+1;
			int endPage=startPage+pageBlock-1;
			int pageCount=count/pageSize+(count%pageSize == 0?0:1);
			if(endPage > pageCount) {
				endPage = pageCount;
			
			}
			
			pageDTO.setCount(count);
			pageDTO.setPageBlock(pageBlock);
			pageDTO.setStartPage(startPage);
			pageDTO.setEndPage(endPage);
			pageDTO.setPageCount(pageCount);
			
			System.out.println(startPage);
			
			
			model.addAttribute("deliverList", deliverList);
			model.addAttribute("pageDTO",pageDTO);
//			System.out.println(deliverList.get(0).getDeliver_cd());
			
			//사원정보
			SystemDTO systemDTO = systemService.memberinfo((int)emp_no);
	         model.addAttribute("systemDTO2", systemDTO);

			
			// 주소변경없이 이동
			return "deliver/Deliver";
		}
		}


	/*		GET 방식은 클라이언트의 데이터를 URL 뒤 붙여 쿼리 스트링을 통해 전송, 전송하는 데이터 길이는 제한적
  		POST 방식은 데이터를 URL에 붙여 전송하지 않고 HTTP 몸체에 전송하며, 길이에 제한 없이 전송합니다. */	
//	가상주소 http://localhost:8080/mesteam4/deliver/Deliverinsert
	//자동으로 가상주소 뽑아오나? /deliver/Deliverinsert
	//가상주소???!!!????여기는 영업관리=>출하등록 이동후  "추가" 버튼 누르면 팝업창이 생성되어서 값을 등록할수 있게 되어야함.
	@RequestMapping(value = "/deliver/insert", method = RequestMethod.GET)
	public String insert(Model model) {
		
		
		// 거래처코드 갖고오기 메소드 호출
		List<Map<String,Object >> instMap = deliverService.getInstMap();
		//model담아서 이동
		model.addAttribute("instMap", instMap);
		
		
		// 수주코드 갖고오기 메소드호출
		List<Map<String,Object >> instMap2 = deliverService.getInstMap2();
		model.addAttribute("instMap2", instMap2);
		
		
		// 수주코드 갖고오기 메소드호출
		List<Map<String,Object >> instMap3= deliverService.getInstMap3();
		model.addAttribute("instMap3", instMap3);

		
//		//담당자 갖고오기
//		List<SystemDTO> systemList = deliverService.getMemberList();
//		model.addAttribute("systemList",systemList);
		
		
		
		
		//주소변경 없이 이동
		// /WEB-INF/views/deliver/Deliverinsert.jsp
		return "deliver/Deliverinsert";
		
	}//insert
	
	
	
	
	
//	가상주소 http://localhost:8080/mesteam4/deliver/insertPro
	//가상주소???!!!????
	//이동하는게 이상한데? 내가원하는것은 팝업창에서 입력하면 원래의 취합받은 리스트가 저장되는곳 그곳으로 이동이 되어야 하는데? 왜 이렇지?
		@RequestMapping(value = "/deliver/insertPro", method = RequestMethod.POST)
		public String insertPro(DeliverDTO deliverDTO) {
			System.out.println("DeliverController insertPro()" );
			
			
			// 실적코드 자동생성(PCHyyMMdd01) 및 저장 
						// 기존 실적코드
						String first_deliver_cd = "기존실적코드";
						String first_number_st = "기존스트링넘버";
						int first_number = 0;
						
						if (deliverService.getDeliver_cd() != null) {
							first_deliver_cd = deliverService.getDeliver_cd();
							first_number_st = first_deliver_cd.substring(9);
						}	
						
						// 새로운 실적코드
						String new_deliver_cd = "실적코드";
						String new_number_st = "스트링넘버";
						int new_number = 0;
						
						// 메뉴코드 설정
						String menu_code = "DEL";
						
						// 오늘날짜 설정
						LocalDate now = LocalDate.now();
					    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyMMdd");
					    String today = now.format(formatter);
					    
					    // 인덱스 설정
					    if ( !(first_deliver_cd.equals("기존실적코드")) && first_deliver_cd.contains(today)) {
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
							new_deliver_cd = menu_code + today + new_number_st;
							
					    } else {
					    	new_deliver_cd = menu_code + today + "01";
					    }
					    deliverDTO.setDeliver_cd(new_deliver_cd);
			
			
			
			//글쓰기 작업 메소드 호출 = 출하 값 입력 작업 메소드 호출
			deliverService.insertDeliver(deliverDTO);
			
			// 주소변경 하면서 이동.
			return "redirect:/deliver/list";
		}//insertPro()
	
	
	
		
		
/*		GET 방식은 클라이언트의 데이터를 URL 뒤 붙여 쿼리 스트링을 통해 전송, 전송하는 데이터 길이는 제한적
	  	POST 방식은 데이터를 URL에 붙여 전송하지 않고 HTTP 몸체에 전송하며, 길이에 제한 없이 전송합니다.
*/			
		@RequestMapping(value = "/deliver/update", method = RequestMethod.GET)
		public String update(HttpServletRequest request, Model model) {
			System.out.println("업데이트"+"/deliver/update");
			String deliver_cd =  request.getParameter("deliver_cd");
			String order_cd =  request.getParameter("order_cd");
			System.out.println("order_cd="+order_cd);
			ReleaseDTO releaseDTO = deliverService.getreldat(order_cd);	
			System.out.println("출고일="+releaseDTO);
			DeliverDTO deliverDTO= new DeliverDTO();
			deliverDTO.setDeliver_cd(deliver_cd);
			System.out.println(deliverDTO.getDeliver_cd());
			deliverDTO=deliverService.getDeliver(deliverDTO);
		
			model.addAttribute("deliverDTO", deliverDTO);
			model.addAttribute("releaseDTO", releaseDTO);
					
			
			
			// 거래처코드 갖고오기 메소드 호출
			List<Map<String,Object >> instMap = deliverService.getInstMap();
			//model담아서 이동
			model.addAttribute("instMap", instMap);
			
			
			// 수주코드 갖고오기 메소드호출
			List<Map<String,Object >> instMap2 = deliverService.getInstMap2();
			model.addAttribute("instMap2", instMap2);
			
			
			// 품목코드 갖고오기 메소드호출
			List<Map<String,Object >> instMap3= deliverService.getInstMap3();
			model.addAttribute("instMap3", instMap3);
			
			
			
			
			// 가상주소에서 주소변경 없이 이동
			return "deliver/Deliverupdate";
		}
		
		
		
		
		/*		GET 방식은 클라이언트의 데이터를 URL 뒤 붙여 쿼리 스트링을 통해 전송, 전송하는 데이터 길이는 제한적
	  	POST 방식은 데이터를 URL에 붙여 전송하지 않고 HTTP 몸체에 전송하며, 길이에 제한 없이 전송합니다.
*/			
		@RequestMapping(value = "/deliver/updatePro", method = RequestMethod.POST)
		public String updatePro(DeliverDTO deliverDTO) {
			System.out.println("updatepro부분"+"/deliver/updatePro");
			System.out.println(deliverDTO.getDeliver_cd());
			System.out.println(deliverDTO.getBusiness_cd());
			System.out.println(deliverDTO.getOrder_cd());
			System.out.println(deliverDTO.getProduct_cd_name());
			System.out.println(deliverDTO.getDeliver_date());
			System.out.println(deliverDTO.getDeliver_count());
			System.out.println(deliverDTO.getEmp_no());
		
			deliverService.updateDeliver(deliverDTO);
			// 주소변경하면서 이동
			return "redirect:/deliver/list";
		}
		
		
		
		@RequestMapping(value = "/deliver/deliverdelete", method = RequestMethod.GET)
		public String deliverdelete(HttpServletRequest request) {
		//	System.out.println("DeliverController delete()");
			String chbox[]=request.getParameterValues("rowcheck");
			String deliver_cd = null;
			if(chbox!=null) {
				for(int i=0; i<chbox.length; i++) {
					deliver_cd=chbox[i];
					System.out.println(deliver_cd);
					deliverService.deleteDeliver(deliver_cd);
				}
			}
			
			
			// 주소줄 변경하면서 이동
			return "redirect:/deliver/list";
		}	
		
		
		
		@RequestMapping(value = "/deliver/deliverinstlist", method = RequestMethod.GET)
		public String DeliverInstList(HttpServletRequest request, Model model) {
			System.out.println("/deliver/deliverinstlist");
			
//			한 화면에 보여줄 글의 개수 설정
			int pageSize =5;
//			현재 페이지 번호 가져오기
			String pageNum = request.getParameter("pageNum");
			if(pageNum == null) {
//				pageNum이 없으면 1페이지로 설정
				pageNum = "1";
			} 
			int currentPage = Integer.parseInt(pageNum);
			
			PageDTO pageDTO = new PageDTO();
			pageDTO.setPageSize(pageSize);
			pageDTO.setPageNum(pageNum);
			pageDTO.setCurrentPage(currentPage);
			
			List<OrderDTO> orderList = orderService.getOrderList2(pageDTO);		
			
//			페이징처리
			int count = orderService.getOrderCount2();
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
			
			
			
			model.addAttribute("orderList", orderList);
			model.addAttribute("pageDTO", pageDTO);
			
			// 주소변경 없이 이동
			// /WEB-INF/views/perform/InstList.jsp
			return "deliver/DeliverInstList";
		}

		
		@RequestMapping(value = "/deliver/deliverinstlist2", method = RequestMethod.GET)
		public String instList(HttpServletRequest request, Model model) {

			// 한 화면에 보여줄 글 개수 설정
			int pageSize=5;
			// 현페이지 번호 가져오기
			String pageNum=request.getParameter("pageNum");
			if(pageNum==null) {
//				pageNum 없으면 1페이지 설정
				pageNum="1";
			}
//			 페이지번호를 => 정수형 변경
			int currentPage=Integer.parseInt(pageNum);
			
			PageDTO pageDTO=new PageDTO();
			pageDTO.setPageSize(pageSize);
			pageDTO.setPageNum(pageNum);
			pageDTO.setCurrentPage(currentPage);
			
			List<Map<String, Object>> relList=deliverService.getRelList2(pageDTO);
			
			//페이징 처리
			int count = deliverService.getRelCount(pageDTO);
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
			
			model.addAttribute("relList", relList);
			model.addAttribute("pageDTO", pageDTO);
			
			return "deliver/DeliverInstList2";
		}
		
		@ResponseBody
		@RequestMapping(value = "/deliver/ordercheck", method = RequestMethod.GET)
		public String ordercheck(HttpServletRequest request, Model model) {
			// request 파라미터 
			String order_cd=request.getParameter("inst");
			String result=null;
			
			// 메서드 호출
			int ordercheck
		     =deliverService.getinstcheck(order_cd);
				
			// if문으로 result에 저장 할 값 설정
			if(ordercheck==0) {
				result="0";
			}else {
				result="1";
			}			
					
			// result 값 리턴
			return result;
		}
		
		@ResponseBody
		@RequestMapping(value = "/deliver/reldate", method = RequestMethod.GET)
		public Date reldate(HttpServletRequest request, Model model) {
			// request 파라미터 
			String order_cd=request.getParameter("order_cd");
			Date result=null;
			// 메서드 호출
			ReleaseDTO releaseDTO
		     =deliverService.getreldat(order_cd);
			result=releaseDTO.getRel_date();
			// result 값 리턴
			return result;
		}
		
	
}// DeliverController
