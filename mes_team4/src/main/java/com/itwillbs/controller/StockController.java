package com.itwillbs.controller;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.itwillbs.domain.PageDTO;
import com.itwillbs.domain.StockDTO;
import com.itwillbs.domain.SystemDTO;
import com.itwillbs.service.StockService;
import com.itwillbs.service.SystemService;

@Controller
public class StockController {

	//멤버변수 부모 인터페이스 정의 => 자동으로 자식 클래스 객체생성
	// 스프링 객체생성 방식 => 의존관계주입(DI : Dependency Injection)
	@Inject
	private StockService stockService;
	@Inject
	private SystemService systemService;
	
	@RequestMapping(value = "/stock/stock", method = RequestMethod.GET)
	public String stock(HttpServletRequest request, Model model, HttpSession session) {
		System.out.println("StockController stock()");
		
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
		
//		List<StockDTO> StockList=stockService.getStockList(pageDTO);
					
		//페이징 처리
		int count = stockService.getStockCount(pageDTO);
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
		
		//메서드 호출
		List<Map<String, Object>> StockMap
		     =stockService.getStockMap(pageDTO);
		//model 담아서 이동
		model.addAttribute("StockMap", StockMap);
		
//		model.addAttribute("StockList", StockList);
		model.addAttribute("pageDTO", pageDTO);
		
		//사원정보 관련
		SystemDTO systemDTO = systemService.memberinfo((int)emp_no);
		model.addAttribute("systemDTO2", systemDTO);
		
		// 주소변경 없이 이동
		// /WEB-INF/views/stock/Stock.jsp
		return "stock/Stock";
		}
	}
	
	@RequestMapping(value = "/stock/stockinsert", method = RequestMethod.GET)
	public String stockInsert(Model model) {
			
		//메서드 호출
		List<Map<String, Object>> whMap
		     =stockService.getwhMap();
		//model 담아서 이동
		model.addAttribute("whMap", whMap);
		
		//메서드 호출
		List<Map<String, Object>> recMap
		     =stockService.getrecMap();
		//model 담아서 이동
		model.addAttribute("recMap", recMap);
		
		//메서드 호출
		List<Map<String, Object>> prodMap
		     =stockService.getprodMap();
		//model 담아서 이동
		model.addAttribute("prodMap", prodMap);
		
		// 주소변경 없이 이동
		// /WEB-INF/views/stock/StockInsert.jsp
		return "stock/StockInsert";
	}
	
	@RequestMapping(value = "/stock/stockinsertpro", method = RequestMethod.POST)
	public String stockInsertPro(HttpServletRequest request, StockDTO stockDTO) {
		System.out.println("StockController stockInsertPro()");
//		
//		if(stockService.getStockCount2()==0) {
//			stockDTO.setStock_cd("STC001");
//		}else {
//			String maxpc=stockService.getStock_cd();
//			System.out.println(maxpc);
//			maxpc=maxpc.substring(3);
//			int tpc=Integer.parseInt(maxpc);
//			tpc=tpc+1;
//			maxpc=String.valueOf(tpc);
//			if(maxpc.length()==1) {
//			maxpc="00".concat(maxpc);
//			maxpc="STC".concat(maxpc);
//			}else if(maxpc.length()==2) {
//				maxpc="0".concat(maxpc);
//				maxpc="STC".concat(maxpc);
//			}else if(maxpc.length()==3) {
//				maxpc="STC".concat(maxpc);
//			}
//			stockDTO.setStock_cd(maxpc);
//			System.out.println(maxpc);
//		}
//		
		
		//글쓰기 작업 메서드 호출
		stockService.insertStock(stockDTO);
		
		// 주소변경 하면서 이동
		return "redirect:/stock/stock";
	}
	
	@RequestMapping(value = "/stock/stockupdate", method = RequestMethod.GET)
	public String stockupdate(HttpServletRequest request, Model model) {
		String stock_cd=request.getParameter("stock_cd");
		StockDTO stockDTO=stockService.getStock(stock_cd);
		
//		//메서드 호출
//		List<Map<String, Object>> whMap
//		     =stockService.getwhMap();
//		//model 담아서 이동
//		model.addAttribute("whMap", whMap);
//		
//		//메서드 호출
//		List<Map<String, Object>> recMap
//		     =stockService.getrecMap();
//		//model 담아서 이동
//		model.addAttribute("recMap", recMap);
//		
//		//메서드 호출
//		List<Map<String, Object>> prodMap
//		     =stockService.getprodMap();
//		//model 담아서 이동
//		model.addAttribute("prodMap", prodMap);	
		
		model.addAttribute("StockDTO", stockDTO);
		
		
		
		// 주소변경 없이 이동
		// /WEB-INF/views/stock/StockUpdate.jsp
		return "stock/StockUpdate";
	}
	
	@RequestMapping(value = "/stock/stockupdatepro", method = RequestMethod.POST)
	public String stockUpdatePro(StockDTO stockDTO) {
		
		stockService.updateStock(stockDTO);
		
		// 주소변경 하면서 이동
		return "redirect:/stock/stock";
	}
	
	@RequestMapping(value = "/stock/stockdelete", method = RequestMethod.GET)
	public String stockDelete(HttpServletRequest request) {
		String chbox[]=request.getParameterValues("rowcheck");
		String stock_cd = null;
		if(chbox!=null){
			  for(int i=0;i<chbox.length;i++){		   
				stock_cd=chbox[i];
				stockService.deleteStock(stock_cd);
			  }
	       }			
		
		// 주소변경 하면서 이동
		return "redirect:/stock/stock";
	}
}
