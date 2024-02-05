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

import com.itwillbs.domain.InstructionDTO;
import com.itwillbs.domain.PageDTO;
import com.itwillbs.domain.ReceiveDTO;
import com.itwillbs.domain.ReleaseDTO;
import com.itwillbs.domain.StockDTO;
import com.itwillbs.domain.SystemDTO;
import com.itwillbs.service.ReceiveService;
import com.itwillbs.service.ReleaseService;
import com.itwillbs.service.SystemService;

@Controller
public class ReleaseController {
	
	@Inject
	private ReleaseService relService; 
	@Inject
	private ReceiveService receiveService;
	@Inject
	private SystemService systemService;
	
	@RequestMapping(value = "/rel/relpage", method = RequestMethod.GET)
	public String relpage(HttpServletRequest request, Model model,HttpSession session) {
		System.out.println("ReleaseController relinsert()");
		
		Object emp_no = session.getAttribute("emp_no");
        if(emp_no == null) {
           return "system/msg2";
        } else {
		
		//검색어 가져오기
		String search=request.getParameter("search");
		// 검색옵션
		String select = request.getParameter("select");
		
		
		// 한 화면에 보여줄 글 개수 설정
		int pageSize=5;
		// 현페이지 번호 가져오기
		String pageNum=request.getParameter("pageNum");
		if(pageNum==null) {
//			pageNum 없으면 1페이지 설정
			pageNum="1";
		}
//		 페이지번호를 => 정수형 변경
		int currentPage=Integer.parseInt(pageNum);
		
		PageDTO pageDTO=new PageDTO();
		pageDTO.setPageSize(pageSize);
		pageDTO.setPageNum(pageNum);
		pageDTO.setCurrentPage(currentPage);
		//검색어
		pageDTO.setSearch(search);
		pageDTO.setSelect(select);
		List<Map<String, Object>> relList=relService.getRelList(pageDTO);
		
		//페이징 처리
		int count = relService.getRelCount(pageDTO);
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
		SystemDTO systemDTO = systemService.memberinfo((int)emp_no);
        model.addAttribute("systemDTO2", systemDTO);
		
		return "release/RelPage";
        }
	}
	
	@RequestMapping(value = "/rel/relinsert", method = RequestMethod.GET)
	public String relinsert(Model model) {
		System.out.println("ReleaseController relinsert()");
		
		return "release/RelInsert";
	}
	
	@RequestMapping(value = "/rel/relinsertPro", method = RequestMethod.POST)
	public String relinsertPro(ReleaseDTO releaseDTO, StockDTO stockDTO, ReceiveDTO receiveDTO) {
		System.out.println("ReleaseController relinsertPro()");
		

		// 출고 수량에 따라 재고현황에 적용할 재소수량 stockDTO에 저장
		String product_cd_name =  releaseDTO.getProduct_cd_name();
		int Stock_count=receiveService.getStock_count(product_cd_name);
		stockDTO.setStock_count(Stock_count-releaseDTO.getRel_count());
		stockDTO.setProduct_cd_name(product_cd_name);
		// 재고현황에 재고수량 적용 메서드 호출
		receiveService.updateStockcount(stockDTO);
		
		// 출고수량 등록 -> 등록한 만큼 입고수량 줄어듬 ,,, 
//		receiveDTO.setRec_count(receiveDTO.getRec_count()-releaseDTO.getRel_count());
//		System.out.println("rec:"+receiveDTO.getRec_count()+", rel:"+releaseDTO.getRel_count());
		
		// 출고등록 메서드 호출
		relService.insertrel(releaseDTO);
		
		return "redirect:/rel/relpage";
	}

	@RequestMapping(value = "/rel/relupdate", method = RequestMethod.GET)
	public String relupdate(HttpServletRequest request, Model model, ReleaseDTO releaseDTO) {
		System.out.println("ReleaseController relupdate()");
		
		String rel_schedule_cd=request.getParameter("rel_schedule_cd");
		String product_cd_name=request.getParameter("product_cd_name");
		releaseDTO.setRel_schedule_cd(rel_schedule_cd);
		releaseDTO.setProduct_cd_name(product_cd_name);
		
		
		Map<String, Object> rec=relService.getrec(releaseDTO);
		
		
		model.addAttribute("rec", rec);
		
		return "release/RelUpdate";
	}
	
	@RequestMapping(value = "/rel/relupdatePro", method = RequestMethod.POST)
	public String relupdatePro(ReleaseDTO releaseDTO, StockDTO stockDTO) {
		System.out.println("ReleaseController relupdatePro()");
		
		
		// 출고수량 수정에 따라 재고현황에 적용할 재소수량 stockDTO에 저장
		String product_cd_name =  releaseDTO.getProduct_cd_name();
		int Stock_count=receiveService.getStock_count(product_cd_name);
		
		releaseDTO.setRel_schedule_cd(releaseDTO.getRel_schedule_cd());
		releaseDTO.setProduct_cd_name(product_cd_name);			
		int bfrel=relService.getbfRel_count(releaseDTO);
		stockDTO.setStock_count((Stock_count+bfrel)-releaseDTO.getRel_count());
		stockDTO.setProduct_cd_name(product_cd_name);
		// 재고현황에 재고수량 적용 메서드 호출
		receiveService.updateStockcount(stockDTO);
		
		relService.updaterel(releaseDTO);
		
		return "redirect:/rel/relpage";
	}
	
	@RequestMapping(value = "/rel/reldelete", method = RequestMethod.POST)
	public String deleterel(HttpServletRequest request, StockDTO stockDTO, ReleaseDTO releaseDTO) {
		System.out.println("ReleaseController deleterel()");
		
		String[] ajaxMsg = request.getParameterValues("valueArr");
		int size = ajaxMsg.length;		
		
		for(int i=0; i<size; i++) {
		// 삭제시 재고현황에 적용할 재소수량 stockDTO에 저장
			String rel_schedule_cd=ajaxMsg[i];
			String product_cd_name =relService.getProduct_cd_name2(rel_schedule_cd);
			releaseDTO.setRel_schedule_cd(rel_schedule_cd);
			releaseDTO.setProduct_cd_name(product_cd_name);
			System.out.println("1");
			int bfrel=relService.getbfRel_count(releaseDTO);
			System.out.println("2");
			int Stock_count=receiveService.getStock_count(product_cd_name);
			stockDTO.setStock_count(Stock_count+bfrel);
			stockDTO.setProduct_cd_name(product_cd_name);
		// 재고현황에 재고수량 적용 메서드 호출
		receiveService.updateStockcount(stockDTO);
		}		
		
		for(int i=0; i<size; i++) {
			relService.deleterel(ajaxMsg[i]);
		}
		
		return "redirect:/rel/relpage";
	}
	
	
	@RequestMapping(value = "/rel/reclist", method = RequestMethod.GET)
	public String instList(HttpServletRequest request, Model model) {
		
//		한 화면에 보여줄 글의 개수 설정
		int pageSize =5;
//		현재 페이지 번호 가져오기
		String pageNum = request.getParameter("pageNum");
		if(pageNum == null) {
//			pageNum이 없으면 1페이지로 설정
			pageNum = "1";
		} 
		int currentPage = Integer.parseInt(pageNum);
		
		PageDTO pageDTO = new PageDTO();
		pageDTO.setPageSize(pageSize);
		pageDTO.setPageNum(pageNum);
		pageDTO.setCurrentPage(currentPage);
		
		List<Map<String, Object>> receiveList=relService.getReceiveSList(pageDTO);
		
//		페이징처리
		int count = receiveService.getReceiveCount(pageDTO);
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
		
		
		
		model.addAttribute("receiveList", receiveList);
		model.addAttribute("pageDTO", pageDTO);
		
		return "release/RecList";
	}
	 @RequestMapping(value = {"/rel/rel"}, method = {RequestMethod.GET})
	  public String rel(HttpServletRequest request, Model model, ReleaseDTO releaseDTO) {
	    System.out.println("ReleaseController rel()");
	    
	    String rel_schedule_cd = request.getParameter("rel_schedule_cd");
	    String product_cd_name = request.getParameter("product_cd_name");
	    
	    releaseDTO.setRel_schedule_cd(rel_schedule_cd);
	    releaseDTO.setProduct_cd_name(product_cd_name);
	    
	    Map<String, Object> rec = relService.getrec(releaseDTO);
	    model.addAttribute("rec", rec);
	    
	    return "release/Rel";
	  }
	}
