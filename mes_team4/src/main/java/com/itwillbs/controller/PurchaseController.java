package com.itwillbs.controller;

import java.sql.Date;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
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
import com.itwillbs.domain.PurchaseDTO;
import com.itwillbs.domain.SystemDTO;
import com.itwillbs.service.ConsumptionService;
import com.itwillbs.service.PurchaseService;
import com.itwillbs.service.SystemService;
import com.mysql.cj.xdevapi.JsonArray;


@Controller
public class PurchaseController {
	
	@Inject 
	private PurchaseService purchaseService;
	
	@Inject
	private SystemService systemService;
	
	@RequestMapping(value = "/purchase/list", method = RequestMethod.GET)
	public String list(HttpServletRequest request, PageDTO pageDTO, Model model, HttpSession session) {
		System.out.println("PurchaseController list()");
		// 처리작업
		
		Object emp_no = session.getAttribute("emp_no");
		if(emp_no == null) {
			return "system/msg2";
		} else {
			// 검색어 처리작업
			if (pageDTO.getSearch() != null && pageDTO.getSearch().equals("")) {
				pageDTO.setSearch(null);
			}
			if (pageDTO.getSearch_com() != null && pageDTO.getSearch_com().equals("")) {
				pageDTO.setSearch_com(null);
			}
			if (pageDTO.getStart_date() != null && pageDTO.getStart_date().equals("")) {
				pageDTO.setStart_date(null);
			}
			if (pageDTO.getEnd_date() != null && pageDTO.getEnd_date().equals("")) {
				pageDTO.setEnd_date(null);
			}
			if (pageDTO.getStart_due_date() != null && pageDTO.getStart_due_date().equals("")) {
				pageDTO.setStart_due_date(null);
			}
			if (pageDTO.getEnd_due_date() != null && pageDTO.getEnd_due_date().equals("")) {
				pageDTO.setEnd_due_date(null);
			}
			
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
			
			// 사원정보 
			SystemDTO systemDTO = systemService.memberinfo((int)emp_no);
			
			// 서버단 처리 결과 전달
			model.addAttribute("purchaseMapList", purchaseMapList); 
			model.addAttribute("pageDTO", pageDTO);
			model.addAttribute("systemDTO2", systemDTO);
			
			return "purchase/List";
		}
	}
	
	@RequestMapping(value = "/purchase/prlist", method = RequestMethod.GET)
	public String prlist(HttpServletRequest request, PageDTO pageDTO, Model model) {
		System.out.println("PurchaseController prlist()");
		// 처리작업

		// 검색어 설정
		// String search= request.getParameter("search");
		// pageDTO.setSearch(search);		
		
		// 품목구분 설정
		String product_dv = request.getParameter("product_dv");
		pageDTO.setProduct_dv(product_dv);
		
		// 한 화면에 보여줄 글의 개수
		int pageSize = 10;
		
		// 현재페이지 번호 설정
		String pageNum= request.getParameter("pageNum");
		if(pageNum == null) {
			pageNum = "1";
		} 
		int CurrentPage = Integer.parseInt(pageNum);
		
		pageDTO.setPageSize(pageSize);
		pageDTO.setPageNum(pageNum);
		pageDTO.setCurrentPage(CurrentPage);
		
		List<Map<String, Object>> prList = purchaseService.getPrList(pageDTO);
		
		// 페이징 처리
		int count = purchaseService.getPrCount(pageDTO);
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
		model.addAttribute("prList", prList); 
		model.addAttribute("pageDTO", pageDTO);
		
		return "purchase/PrList";
	}
	
	@RequestMapping(value = "/purchase/bslist", method = RequestMethod.GET)
	public String bslist(HttpServletRequest request, PageDTO pageDTO, Model model) {
		System.out.println("PurchaseController bslist()");
		// 처리작업

		// 검색어 설정
		// String search= request.getParameter("search");
		// pageDTO.setSearch(search);		
		
		// 한 화면에 보여줄 글의 개수
		int pageSize = 10;
		
		// 현재페이지 번호 설정
		String pageNum= request.getParameter("pageNum");
		if(pageNum == null) {
			pageNum = "1";
		} 
		int CurrentPage = Integer.parseInt(pageNum);
		
		pageDTO.setPageSize(pageSize);
		pageDTO.setPageNum(pageNum);
		pageDTO.setCurrentPage(CurrentPage);
		
		List<Map<String, Object>> bsList = purchaseService.getBsList(pageDTO);
		
		// 페이징 처리
		int count = purchaseService.getBsCount(pageDTO);
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
		model.addAttribute("bsList", bsList); 
		model.addAttribute("pageDTO", pageDTO);
		
		return "purchase/BsList";
	}
	
	@RequestMapping(value = "/purchase/emlist", method = RequestMethod.GET)
	public String emlist(HttpServletRequest request, PageDTO pageDTO, Model model) {
		System.out.println("PurchaseController emlist()");
		// 처리작업

		// 검색어 설정
		// String search= request.getParameter("search");
		// pageDTO.setSearch(search);		
		
		// 한 화면에 보여줄 글의 개수
		int pageSize = 10;
		
		// 현재페이지 번호 설정
		String pageNum= request.getParameter("pageNum");
		if(pageNum == null) {
			pageNum = "1";
		} 
		int CurrentPage = Integer.parseInt(pageNum);
		
		pageDTO.setPageSize(pageSize);
		pageDTO.setPageNum(pageNum);
		pageDTO.setCurrentPage(CurrentPage);
		
		List<Map<String, Object>> emList = purchaseService.getEmList(pageDTO);
		System.out.println(emList.get(0));
		
		// 페이징 처리
		int count = purchaseService.getEmCount(pageDTO);
		int pageBlock = 5;
		int startPage = (CurrentPage-1)/pageBlock*pageBlock+1;
		int endPage = startPage+pageBlock-1;
		int pageCount = count/pageSize+(count%pageSize==0?0:1);
		if(endPage > pageCount){
		 	endPage = pageCount;
		}
		System.out.println("startPage"+startPage);
		System.out.println("endPage"+endPage);
		
		pageDTO.setCount(count);
		pageDTO.setPageBlock(pageBlock);
		pageDTO.setStartPage(startPage);
		pageDTO.setEndPage(endPage);
		pageDTO.setPageCount(pageCount);
		
		// 서버단 처리 결과 전달
		model.addAttribute("emList", emList); 
		model.addAttribute("pageDTO", pageDTO);
		
		return "purchase/EmList";
	}
	
	@RequestMapping(value = "/purchase/insert", method = RequestMethod.GET)
	public String insert(Model model) {
		System.out.println("PurchaseController insert()");
		// 처리작업
		
		return "purchase/Insert";
	}
	
	@RequestMapping(value = "/purchase/insertPro", method = RequestMethod.POST)
	public String insertPro(PurchaseDTO purchaseDTO) {
		System.out.println("PurchaseController insertPro()");
		// 처리작업
		
		// 발주코드 자동생성(PCHyyMMdd01) 및 저장 
		// 기존 발주코드
		String first_purchase_cd = "기존발주코드";
		String first_number_st = "기존스트링넘버";
		int first_number = 0;
		
		if (purchaseService.getPurchase_cd() != null) { // -> 이 줄만 수정해서 사용하세요.
			first_purchase_cd = purchaseService.getPurchase_cd(); // -> 이 줄만 수정해서 사용하세요.
			first_number_st = first_purchase_cd.substring(9);
		}	
		
		// 새로운 발주코드
		String new_purchase_cd = "새발주코드";
		String new_number_st = "새스트링넘버";
		int new_number = 0;
		
		// 메뉴코드 설정
		String menu_code = "PCH"; // -> 이 줄만 수정해서 사용하세요.
		
		// 오늘날짜 설정
		LocalDate now = LocalDate.now();
	    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyMMdd");
	    String today = now.format(formatter);
	    
	    // 인덱스 설정
	    if ( !(first_purchase_cd.equals("기존발주코드")) && first_purchase_cd.contains(today)) {
	    	// 패턴&매치 정규식 이용 => 스트링넘버 앞 0 삭제(조건 : String length 2자 이상)
	    	Pattern pattern = Pattern.compile("^0*([1-9][0-9]*)|0+$");
			Matcher matcher = pattern.matcher(first_number_st);
			
			if (matcher.find()) { 
			    first_number = Integer.parseInt(matcher.group(1)); 
			} else {
			    System.out.println("No match found.");
			}
			
			// String 정규식 이용 => new_purchase_cd 생성
			new_number = first_number+1;
			new_number_st = String.valueOf(new_number).format("%02d", new_number);
			new_purchase_cd = menu_code + today + new_number_st;
			
	    } else {
	    	new_purchase_cd = menu_code + today + "01";
	    }
		
	    purchaseDTO.setPurchase_cd(new_purchase_cd); // -> 이 줄만 수정해서 사용하세요.
	    
		// 발주상태 저장
		purchaseDTO.setPurchase_com("미완료");
		
		// String -> date 변환
		Date purchase_date = Date.valueOf(purchaseDTO.getPurchase_date_st());
	    Date purchase_due = Date.valueOf(purchaseDTO.getPurchase_due_st());
		purchaseDTO.setPurchase_date(purchase_date);
		purchaseDTO.setPurchase_due(purchase_due);
	    
		purchaseService.insertPurchase(purchaseDTO);
		
		return "purchase/Close";
	}
	
	@RequestMapping(value = "/purchase/update", method = RequestMethod.GET)
	public String update(HttpServletRequest request, Model model) {
		System.out.println("PurchaseController update()");
		// 처리작업
		
		String purchase_cd = request.getParameter("purchase_cd");
		
		PurchaseDTO purchaseDTO = purchaseService.getPurchaseDTO(purchase_cd);
		
		model.addAttribute("purchaseDTO", purchaseDTO);
		
		return "purchase/Update";
	}
	
	@RequestMapping(value = "/purchase/updatePro", method = RequestMethod.POST)
	public String updatePro(PurchaseDTO purchaseDTO) {
		System.out.println("PurchaseController updatePro()");
		// 처리작업
		
		// String -> date 변환
		Date purchase_date = Date.valueOf(purchaseDTO.getPurchase_date_st());
	    Date purchase_due = Date.valueOf(purchaseDTO.getPurchase_due_st());
		purchaseDTO.setPurchase_date(purchase_date);
		purchaseDTO.setPurchase_due(purchase_due);
		
		purchaseService.updatePurchase(purchaseDTO);
		
		return "purchase/Close";
	}
	
	@ResponseBody
	@RequestMapping(value = "/purchase/delete", method = RequestMethod.POST)
	public String delete(HttpServletRequest request, PurchaseDTO purchaseDTO) {
		System.out.println("PurchaseController delete()");
		// 처리작업
		String response = "delete";
		
		// 발주코드 저장
		String[] checkedValue = request.getParameterValues("checkedValue");
		int length = checkedValue.length;
		
		// 진행상황 체크
		List<String> purchase_com_arr = new ArrayList<String>(length);
		for(int i = 0; i < length; i++) {
			purchaseDTO = purchaseService.getPurchaseDTO(checkedValue[i]); 
			purchase_com_arr.add(purchaseDTO.getPurchase_com());
		}
		
		// 진행상황에 따른 삭제처리
		if (purchase_com_arr.contains("완료")) {
			response = "notDelete";
		} else {
			purchaseService.deletePurchase(checkedValue);
		}
		
		return response;
	}
	
	@RequestMapping(value = "/purchase/listB", method = RequestMethod.GET)
	public String listB(HttpServletRequest request, PageDTO pageDTO, Model model) {
		System.out.println("PurchaseController listB()");

		String cd = request.getParameter("cd");
		
		pageDTO.setCd(cd);
		
		// 검색어 처리작업
		if (pageDTO.getSearch() != null && pageDTO.getSearch().equals("")) {
			pageDTO.setSearch(null);
		}
		if (pageDTO.getSearch_com() != null && pageDTO.getSearch_com().equals("")) {
			pageDTO.setSearch_com(null);
		}
		if (pageDTO.getStart_date() != null && pageDTO.getStart_date().equals("")) {
			pageDTO.setStart_date(null);
		}
		if (pageDTO.getEnd_date() != null && pageDTO.getEnd_date().equals("")) {
			pageDTO.setEnd_date(null);
		}
		if (pageDTO.getStart_due_date() != null && pageDTO.getStart_due_date().equals("")) {
			pageDTO.setStart_due_date(null);
		}
		if (pageDTO.getEnd_due_date() != null && pageDTO.getEnd_due_date().equals("")) {
			pageDTO.setEnd_due_date(null);
		}
		
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
		
		List<Map<String, Object>> PurchaseListB = purchaseService.getPurchaseListB(pageDTO);
		
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
		model.addAttribute("PurchaseListB", PurchaseListB); 
		model.addAttribute("pageDTO", pageDTO);
		
		return "purchase/ListB";
	}

}// class
