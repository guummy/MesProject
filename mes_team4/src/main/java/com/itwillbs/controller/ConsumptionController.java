package com.itwillbs.controller;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itwillbs.domain.ConsumptionDTO;
import com.itwillbs.domain.PageDTO;
import com.itwillbs.domain.SystemDTO;
import com.itwillbs.service.ConsumptionService;
import com.itwillbs.service.SystemService;
import com.mysql.cj.xdevapi.JsonArray;


@Controller
public class ConsumptionController {
	
	@Inject 
	private ConsumptionService consumptionService;
	
	@Inject
	private SystemService systemService;
	
	@RequestMapping(value = "/consmpt/list", method = RequestMethod.GET)
	public String list(HttpServletRequest request, PageDTO pageDTO, Model model, HttpSession session) {
		System.out.println("ConsumptionController list()");
		// 처리작업
		
		Object emp_no = session.getAttribute("emp_no");
		if(emp_no == null) {
			return "system/msg2";
		} else {
			// 검색어 설정
			String search= request.getParameter("search");
			pageDTO.setSearch(search);		
			
			// 품목구분 설정
			String product_dv = request.getParameter("product_dv");
			pageDTO.setProduct_dv(product_dv);
			
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
			
			List<ConsumptionDTO> cprConsmptList = consumptionService.getCprConsmptList(pageDTO);
			int count = consumptionService.getCprConsmptCount(pageDTO);
			
			// 완제품 페이징 처리에 따른 원자재 저장
			List<ConsumptionDTO> rprConsmptList = null;
			List<List<ConsumptionDTO>> rprList = null;
			
			if(count != 0) {
				String[] cprCdName = new String[cprConsmptList.size()];
				for(int i = 0; i < cprConsmptList.size(); i++) {
					cprCdName[i] = cprConsmptList.get(i).getCproduct_cd_name();
				}
				
				rprConsmptList = consumptionService.getRprConsmptList(cprCdName);
				
				// 테이블 병합처리 변수 저장
				List<Integer> rowcolsTd = consumptionService.getRowcolsTd(cprCdName);
				pageDTO.setRowcolsTd(rowcolsTd);
				int length = rowcolsTd.size();
				
				// List<Integer> showTd = new ArrayList<Integer>(rowcolsTd.size());
				// showTd.add(0);
				// if (rowcolsTd.size() > 0) {
				// 	for(int i = 0; i < rowcolsTd.size()-1; i++) {
				// 		int x = rowcolsTd.get(i);
				// 		int y = showTd.get(i) + x;
				// 		showTd.add(y);
				// 	}
				// }
				// pageDTO.setShowTd(showTd);
				
				// 2차원 리스트 저장
				int startNum = 0;
				int endNum = rowcolsTd.get(0);
				System.out.println("check "+endNum);
				
				rprList = new ArrayList<List<ConsumptionDTO>>(length);
				for(int i = 0; i < length; i++) {				
					rprList.add(rprConsmptList.subList(startNum, endNum));
					startNum += rowcolsTd.get(i);	
					if(i < length-1) {
						endNum += rowcolsTd.get(i+1);
					}
				}
			}
			System.out.println("check");
			
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
			model.addAttribute("rprConsmptList", rprConsmptList); 
			model.addAttribute("rprList",rprList);
			model.addAttribute("pageDTO", pageDTO);
			model.addAttribute("systemDTO2", systemDTO);
			
			return "consumption/List";
		}
	}
	
	@RequestMapping(value = "/consmpt/insert", method = RequestMethod.GET)
	public String insert(Model model) {
		System.out.println("ConsumptionController insert()");
		// 처리작업
		
		// 임시 unit 저장
		List<String> unit = new ArrayList<String>();
		unit.add("kg");
		unit.add("EA");
		
		model.addAttribute("unit", unit);
		
		return "consumption/Insert";
	}
	
	@RequestMapping(value = "/consmpt/update", method = RequestMethod.GET)
	public String update(HttpServletRequest request, Model model) {
		System.out.println("ConsumptionController update()");
		// 처리작업
		
		// 임시 unit 저장
		List<String> unit = new ArrayList<String>();
		unit.add("kg");
		unit.add("EA");
		
		String cproduct_cd_name = request.getParameter("cproduct_cd_name");
		
		List<ConsumptionDTO> consmptList = consumptionService.checkCprCdName(cproduct_cd_name);
		
		model.addAttribute("consmptList", consmptList);
		model.addAttribute("unit", unit);
		
		return "consumption/Update";
	}
	
	@RequestMapping(value = "/consmpt/insertPro", method = RequestMethod.POST)
	public String insertPro(ConsumptionDTO consumptionDTO) {
		System.out.println("ConsumptionController insertPro()");
		// 처리작업
		
		// 배열 길이 지정
		int length = consumptionDTO.getRproduct_cd_name_arr().length;
		
		// consmptArray에 한줄씩 저장
		ConsumptionDTO[] consmptArray = new ConsumptionDTO[length];
		for (int i = 0; i < length; i++) {
			ConsumptionDTO consumptionDTO2 = new ConsumptionDTO();
			consumptionDTO2.setCproduct_cd_name(consumptionDTO.getCproduct_cd_name());
			consumptionDTO2.setCproduct_name(consumptionDTO.getCproduct_name());
			consumptionDTO2.setRproduct_cd_name(consumptionDTO.getRproduct_cd_name_arr()[i]);
			consumptionDTO2.setRproduct_name(consumptionDTO.getRproduct_name_arr()[i]);
			consumptionDTO2.setConsumption(consumptionDTO.getConsumption_arr()[i]);
			consumptionDTO2.setConsumption_unit(consumptionDTO.getConsumption_unit_arr()[i]);
			consmptArray[i] = consumptionDTO2;
		}
		
		consumptionService.insertConsmpt(consmptArray);
		return "consumption/Close";
	}
	
	@RequestMapping(value = "/consmpt/updatePro", method = RequestMethod.POST)
	public String updatePro(ConsumptionDTO consumptionDTO, HttpServletRequest request) {
		System.out.println("ConsumptionController updatePro()");
		// 처리작업
		
		// consmptArray의 cproduct_cd_name 저장
		String[] cproduct_cd_name = new String[1];
		cproduct_cd_name[0] = consumptionDTO.getCproduct_cd_name();
		
		// String -> timestamp 변환
		String insert_date_st = request.getParameter("insert_date_st").substring(0, 19);
		Timestamp insert_date = Timestamp.valueOf(insert_date_st);
		
		consumptionService.deleteConsmpt(cproduct_cd_name);
		
		// 배열 길이 지정
		int length = consumptionDTO.getRproduct_cd_name_arr().length;
				
		// consmptArray에 한줄씩 저장
		ConsumptionDTO[] consmptArray = new ConsumptionDTO[length];
		for (int i = 0; i < length; i++) {
			ConsumptionDTO consumptionDTO2 = new ConsumptionDTO();
			consumptionDTO2.setCproduct_cd_name(consumptionDTO.getCproduct_cd_name());
			consumptionDTO2.setCproduct_name(consumptionDTO.getCproduct_name());
			consumptionDTO2.setRproduct_cd_name(consumptionDTO.getRproduct_cd_name_arr()[i]);
			consumptionDTO2.setRproduct_name(consumptionDTO.getRproduct_name_arr()[i]);
			consumptionDTO2.setConsumption(consumptionDTO.getConsumption_arr()[i]);
			consumptionDTO2.setConsumption_unit(consumptionDTO.getConsumption_unit_arr()[i]);
			consumptionDTO2.setInsert_date(insert_date);
			consmptArray[i] = consumptionDTO2;
		}
		
		consumptionService.updateConsmpt(consmptArray);
		
		return "consumption/Close";
	}
	
	@RequestMapping(value = "/consmpt/prlist", method = RequestMethod.GET)
	public String prlist(HttpServletRequest request, PageDTO pageDTO, Model model) {
		System.out.println("ConsumptionController prlist()");
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
		
		List<Map<String, Object>> prList = consumptionService.getPrList(pageDTO);
		
		// 페이징 처리
		int count = consumptionService.getPrCount(pageDTO);
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
		model.addAttribute("prList", prList); 
		model.addAttribute("pageDTO", pageDTO);
		
		return "consumption/PrList";
	}
	
	@ResponseBody
	@RequestMapping(value = "/consmpt/cprcheck", method = RequestMethod.GET)
	public String cprcheck(HttpServletRequest request) {
		System.out.println("ConsumptionController cprcheck()");
		// 처리작업
		String cproduct_cd_name = request.getParameter("cproduct_cd_name");
		String result = "insert";
		
		List<ConsumptionDTO> consmptList = consumptionService.checkCprCdName(cproduct_cd_name);
		
		if(!(consmptList.isEmpty())) {
			result = "notInsert";
		} 
		
		return result;
	}
	
	@ResponseBody
	@RequestMapping(value = "/consmpt/delete", method = RequestMethod.POST)
	public String delete(HttpServletRequest request) {
		System.out.println("ConsumptionController delete()");
		// 처리작업
		String response = "delete";
		
		String[] checkedValue = request.getParameterValues("checkedValue");
		if(checkedValue == null) {
			response = "false";
		}
		
		consumptionService.deleteConsmpt(checkedValue);
		
		return response;
	}
	
}// class
