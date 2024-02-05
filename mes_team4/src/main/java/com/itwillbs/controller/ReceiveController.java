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

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itwillbs.domain.ConsumptionDTO;
import com.itwillbs.domain.OrderDTO;
import com.itwillbs.domain.PageDTO;
import com.itwillbs.domain.PerformDTO;
import com.itwillbs.domain.ProductDTO;
import com.itwillbs.domain.PurchaseDTO;
import com.itwillbs.domain.ReceiveDTO;
import com.itwillbs.domain.ReleaseDTO;
import com.itwillbs.domain.StockDTO;
import com.itwillbs.domain.SystemDTO;
import com.itwillbs.domain.WHDTO;
import com.itwillbs.service.OrderService;
import com.itwillbs.service.PerformService;
import com.itwillbs.service.PurchaseService;
import com.itwillbs.service.ReceiveService;
import com.itwillbs.service.SystemService;
import com.itwillbs.service.WHService;

@Controller
public class ReceiveController {
	
	@Inject
	private ReceiveService receiveService;
	@Inject
	private WHService whService;
	@Inject 
	private PurchaseService purchaseService;
	@Inject
	private OrderService orderService;
	@Inject
	private PerformService performService;
	@Inject
	private SystemService systemService;

	
	@RequestMapping(value = "/receive/recpage", method = RequestMethod.GET)
	public String recpage(HttpServletRequest request, Model model,HttpSession session) {
		Object emp_no = session.getAttribute("emp_no");
        if(emp_no == null) {
           return "system/msg2";
        } else {

    	String search=request.getParameter("search");
		// 검색어 옵션
		String select=request.getParameter("select");
		String pageNum=request.getParameter("pageNum");
		// 한 화면에 보여질 글의 개수 설정
		int pageSize=5;
		// 현재 페이지번호 가져오기
		if(pageNum==null) {
			// pageNum없으면 1페이지로 설정
			pageNum="1";
		}		
		// 페이지번호를 '정수형'으로 변경
		int currentPage=Integer.parseInt(pageNum);
		PageDTO pageDTO=new PageDTO();
		pageDTO.setPageSize(pageSize);
		pageDTO.setPageNum(pageNum);
		pageDTO.setCurrentPage(currentPage);
//		// 검색어
		pageDTO.setSearch(search);
		pageDTO.setSelect(select);
		
		List<ReceiveDTO> receiveList=receiveService.getReceiveList(pageDTO);
//		List<Map<String, Object>> receiveList
//	     =receiveService.getReceiveList(pageDTO);
//		
		// 페이징 처리
		int count =receiveService.getReceiveCount(pageDTO);
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
		model.addAttribute("receiveList", receiveList);
		model.addAttribute("pageDTO",pageDTO);
	
		   SystemDTO systemDTO = systemService.memberinfo((int)emp_no);
	         model.addAttribute("systemDTO2", systemDTO);

		return "receive/ReceivePage";
        }
	}
	
	@RequestMapping(value = "/receive/recinsert", method = RequestMethod.GET)
	public String recinsert(Model model) {
		System.out.println("ReceiveController insert()");
		
//		List<Map<String, Object>> instMap
//			=receiveService.getInstMap();
//		// model에 담아서 이동
//		model.addAttribute("instMap", instMap);
		
		return "receive/ReceiveInsert";
	}
	
	@RequestMapping(value = "/receive/recinsertPro", method = RequestMethod.POST)
	public String recinsertPro(ReceiveDTO receiveDTO, StockDTO stockDTO, PurchaseDTO purchaseDTO) {
		System.out.println("ReceiveController insertPro()");
		
//		// 발주코드 자동생성(PCHyyMMdd01) 및 저장 
//		// 기존 발주코드
//		String first_purchase_cd = "기존발주코드";
//		String first_number_st = "기존스트링넘버";
//		int first_number = 0;
//		
//		if (purchaseService.getPurchase_cd() != null) { // -> 이 줄만 수정해서 사용하세요.
//			first_purchase_cd = purchaseService.getPurchase_cd(); // -> 이 줄만 수정해서 사용하세요.
//			first_number_st = first_purchase_cd.substring(9);
//		}	
//		
//		// 새로운 발주코드
//		String new_purchase_cd = "새발주코드";
//		String new_number_st = "새스트링넘버";
//		int new_number = 0;
//		
//		// 메뉴코드 설정
//		String menu_code = "PCH"; // -> 이 줄만 수정해서 사용하세요.
//		
//		// 오늘날짜 설정
//		LocalDate now = LocalDate.now();
//	    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyMMdd");
//	    String today = now.format(formatter);
//	    
//	    // 인덱스 설정
//	    if ( !(first_purchase_cd.equals("기존발주코드")) && first_purchase_cd.contains(today)) {
//	    	// 패턴&매치 정규식 이용 => 스트링넘버 앞 0 삭제(조건 : String length 2자 이상)
//	    	Pattern pattern = Pattern.compile("^0*([1-9][0-9]*)|0+$");
//			Matcher matcher = pattern.matcher(first_number_st);
//			
//			if (matcher.find()) { 
//			    first_number = Integer.parseInt(matcher.group(1)); 
//			} else {
//			    System.out.println("No match found.");
//			}
//			
//			// String 정규식 이용 => new_purchase_cd 생성
//			new_number = first_number+1;
//			new_number_st = String.valueOf(new_number).format("%02d", new_number);
//			new_purchase_cd = menu_code + today + new_number_st;
//			
//	    } else {
//	    	new_purchase_cd = menu_code + today + "01";
//	    }
//		
//	    purchaseDTO.setPurchase_cd(new_purchase_cd); // -> 이 줄만 수정해서 사용하세요.
//	    
//		// 발주상태 저장
//		purchaseDTO.setPurchase_com("미완료");
//		
//		// String -> date 변환
//		Date purchase_date = Date.valueOf(purchaseDTO.getPurchase_date_st());
//	    Date purchase_due = Date.valueOf(purchaseDTO.getPurchase_due_st());
//		purchaseDTO.setPurchase_date(purchase_date);
//		purchaseDTO.setPurchase_due(purchase_due);
		
		// 입고 수량에 따라 재고현황에 적용할 재소수량 stockDTO에 저장
		String product_cd_name =  receiveDTO.getProduct_cd_name();
		int Stock_count=receiveService.getStock_count(product_cd_name);
		stockDTO.setStock_count(Stock_count+receiveDTO.getRec_count());
		stockDTO.setProduct_cd_name(product_cd_name);
		// 재고현황에 재고수량 적용 메서드 호출
		receiveService.updateStockcount(stockDTO);
		
		// 입고등록 메서드 호출
		receiveService.insertReceive(receiveDTO);
		
		// 발주관리 미완료 -> 완료 변경
		if (receiveDTO.getPchor_cd().contains("PCH")) {
			purchaseDTO = purchaseService.getPurchaseDTO(receiveDTO.getPchor_cd());
			purchaseDTO.setPurchase_com("완료");
			purchaseService.updatePurchase(purchaseDTO);
		}
		
		return "redirect:/receive/recpage";
	}
	
	@RequestMapping(value = "/receive/warehouse", method = RequestMethod.GET)
	public String whpage(HttpServletRequest request, Model model) {
				
				// 한 화면에 보여줄 글 개수 설정
				int pageSize=10;
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
				
		return "receive/warehouse";
	}
	
	@RequestMapping(value = "/receive/purchase", method = RequestMethod.GET)
	public String list(HttpServletRequest request, PageDTO pageDTO, Model model) {
				
		// 한 화면에 보여줄 글의 개수
		int pageSize = 5;
		
		// 현재페이지 번호 설정
		String pageNum= request.getParameter("pageNum");
		if(pageNum == null) {
			pageNum = "1";
		} 
		int CurrentPage = Integer.parseInt(pageNum);
		
		pageDTO.setPageSize(pageSize);
		pageDTO.setPageNum(pageNum);
		pageDTO.setCurrentPage(CurrentPage);
		
		List<Map<String, Object>> purchaseMapList = purchaseService.getPurchaseMapList(pageDTO);
		
		int count = purchaseService.getPurchaseCount(pageDTO);
		
		// 페이징 처리
		int pageBlock = 5;
		int startPage = (CurrentPage-1)/pageBlock*pageBlock+1;
		int endPage = startPage+pageBlock-1;
		int pageCount = count/pageSize+(count%pageSize==0?0:1);
		if(endPage > pageCount){
		 	endPage = pageCount;
		}
		
		pageDTO.setCount(count);
		pageDTO.setPageBlock(pageBlock);
		pageDTO.setStartPage(startPage);
		pageDTO.setEndPage(endPage);
		pageDTO.setPageCount(pageCount);
		
		// 서버단 처리 결과 전달
		model.addAttribute("purchaseMapList", purchaseMapList); 
		model.addAttribute("pageDTO", pageDTO);
		
		return "receive/purchase";
	}
	
	@ResponseBody
	@RequestMapping(value = "/receive/purcheck", method = RequestMethod.GET)
	public String purcheck(HttpServletRequest request, Model model) {
		// request 파라미터 
		String purchase_cd=request.getParameter("pur");
		String result=null;
		// 메서드 호출
		int purcheck
	     =receiveService.getpurcheck(purchase_cd);
		// if문으로 result에 저장 할 값 설정
		if(purcheck==0) {
			result="0";
		}else {
			result="1";
		}			
		// result 값 리턴
		return result;
	}
	
	@RequestMapping(value = "/receive/perform", method = RequestMethod.GET)
	public String perform(HttpServletRequest request, Model model) {
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
		
		//메서드 호출
		List<Map<String, Object>> PerformMap
		     =performService.getPerformMap3(pageDTO);
		
		//페이징 처리
		int count = performService.getPerformCount3(pageDTO);
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
		
		// 주소변경 없이 이동
		// /WEB-INF/views/receive/Perform.jsp
		return "receive/perform";
	}
	
	@ResponseBody
	@RequestMapping(value = "/receive/performcheck", method = RequestMethod.GET)
	public String performcheck(HttpServletRequest request, Model model) {
		// request 파라미터 
		String order_cd=request.getParameter("perform");
		String result=null;
		// 메서드 호출
		int performcheck
	     =receiveService.getperformcheck(order_cd);
		// if문으로 result에 저장 할 값 설정
		if(performcheck==0) {
			result="0";
		}else {
			result="1";
		}			
		// result 값 리턴
		return result;
	}
	
	@ResponseBody
	@RequestMapping(value = "/receive/dvcheck", method = RequestMethod.GET, produces = "application/text; charset=utf8")
	public String instcheck(HttpServletRequest request, Model model) {
		// request 파라미터 
		String product_cd_name=request.getParameter("product_cd_name");
		String result=null;
		
		// 메서드 호출
		String dvcheck
	     =receiveService.dvcheck(product_cd_name);
		// result에 저장
		result=dvcheck;
		// result 값 리턴
		return result;
	}
	
	@RequestMapping(value = "/receive/recupdate", method = RequestMethod.GET)
	public String recupdate(HttpServletRequest request, Model model) {
		System.out.println("ReceiveController recupdate()");
		String rec_schedule_cd =request.getParameter("rec_schedule_cd");
		String pchor_cd =request.getParameter("pchor_cd");
		
		
		ReceiveDTO receiveDTO=receiveService.getReceive(rec_schedule_cd );
		String inst=receiveService.getInst(pchor_cd);
		PerformDTO performDTO=receiveService.getPerform_date(inst);
		PurchaseDTO purchaseDTO=receiveService.getPurchase_date(pchor_cd);
		model.addAttribute("performDTO", performDTO);
		model.addAttribute("purchaseDTO", purchaseDTO);
		model.addAttribute("receiveDTO", receiveDTO);
		// 주소변경 없이 이동
		return "receive/ReceiveUpdate";
	}
	
	@RequestMapping(value = "/receive/recupdatePro", method = RequestMethod.POST)
	public String recupdatePro(ReceiveDTO receiveDTO, StockDTO stockDTO) {
		
		// 입고수량 수정에 따라 재고현황에 적용할 재소수량 stockDTO에 저장
		String rec_schedule_cd = receiveDTO.getRec_schedule_cd();
		String product_cd_name =  receiveDTO.getProduct_cd_name();
		int Stock_count=receiveService.getStock_count(product_cd_name);
		int reccount=receiveDTO.getRec_count();		
		receiveDTO.setRec_schedule_cd(rec_schedule_cd);
		receiveDTO.setProduct_cd_name(product_cd_name);			
		ReceiveDTO recDTO=receiveService.getbfRec_count(receiveDTO);
		int bfreccount=recDTO.getRec_count();		
		stockDTO.setStock_count((Stock_count-bfreccount)+reccount);		
		stockDTO.setProduct_cd_name(product_cd_name);
		// 재고현황에 재고수량 적용 메서드 호출
		receiveService.updateStockcount(stockDTO);
		
		receiveService.updateReceive(receiveDTO);
		// 주소변경 하면서 이동
		return "redirect:/receive/recpage";
	}
	
	@RequestMapping(value = "/receive/recdelete", method = RequestMethod.GET)
	public String recdelete(HttpServletRequest request, StockDTO stockDTO, PurchaseDTO purchaseDTO, ReceiveDTO receiveDTO) {
		System.out.println("ReceiveController recdelete()");
		
		String[] ajaxMsg = request.getParameterValues("valueArr");
		int size = ajaxMsg.length;
		
		// 발주관리 완료 -> 미완료 변경
		String[] pch = new String[size];
		for(int i=0; i<size; i++) {
			System.out.println("ajaxMsg[i] "+ajaxMsg[i]);
			receiveDTO = receiveService.getPch_cd(ajaxMsg[i]);
			System.out.println("Pch_cd "+receiveDTO);
			pch[i] = receiveDTO.getPchor_cd();
			if (pch[i].contains("PCH")) {
				purchaseDTO = purchaseService.getPurchaseDTO(pch[i]);
				purchaseDTO.setPurchase_com("미완료");
				purchaseService.updatePurchase(purchaseDTO);
			}
		}
		
		for(int i=0; i<size; i++) {
			// 삭제시 재고현황에 적용할 재소수량 stockDTO에 저장
				String rec_schedule_cd=ajaxMsg[i];
				String product_cd_name =receiveService.getProduct_cd_name2(rec_schedule_cd);
				String pchor_cd=receiveService.getPchor_cd(rec_schedule_cd);
				if(receiveService.getRel_count(pchor_cd)>0) {
					
					int sumrelcount=receiveService.getSumRelCount(pchor_cd);
					
					
					receiveDTO.setRec_schedule_cd(rec_schedule_cd);
					receiveDTO.setProduct_cd_name(product_cd_name);			
					ReceiveDTO recDTO=receiveService.getbfRec_count(receiveDTO);
					int bfreccount=recDTO.getRec_count();						
					int Stock_count=receiveService.getStock_count(product_cd_name);
					stockDTO.setStock_count((Stock_count-bfreccount)+sumrelcount);						
					stockDTO.setProduct_cd_name(product_cd_name);
				}else {
					receiveDTO.setRec_schedule_cd(rec_schedule_cd);
					receiveDTO.setProduct_cd_name(product_cd_name);			
					ReceiveDTO recDTO=receiveService.getbfRec_count(receiveDTO);
					int bfreccount=recDTO.getRec_count();	
					int Stock_count=receiveService.getStock_count(product_cd_name);
					stockDTO.setStock_count(Stock_count-bfreccount);
					stockDTO.setProduct_cd_name(product_cd_name);
				}
			// 재고현황에 재고수량 적용 메서드 호출
			receiveService.updateStockcount(stockDTO);
		}
		
		for(int i=0; i<size; i++) {
			System.out.println("check");
			receiveService.deleteReceive(ajaxMsg[i]);
		}
		
		return "redirect:/receive/recpage";
	}
}