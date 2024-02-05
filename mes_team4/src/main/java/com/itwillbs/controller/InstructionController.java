
package com.itwillbs.controller;

import java.sql.Date;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.swing.text.DateFormatter;

import org.apache.commons.collections.bag.SynchronizedSortedBag;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.itwillbs.domain.ConsumptionDTO;
import com.itwillbs.domain.InstructionDTO;
import com.itwillbs.domain.LineDTO;
import com.itwillbs.domain.OrderDTO;
import com.itwillbs.domain.PageDTO;
import com.itwillbs.domain.ReleaseDTO;
import com.itwillbs.domain.StockDTO;
import com.itwillbs.domain.SystemDTO;
import com.itwillbs.service.InstructionService;
import com.itwillbs.service.OrderService;
import com.itwillbs.service.ReceiveService;
import com.itwillbs.service.ReleaseService;
import com.itwillbs.service.SystemService;
import com.mysql.cj.xdevapi.JsonArray;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
public class InstructionController {
	@Inject
	private InstructionService instructionService;
	
	@Inject
	private OrderService orderService;

	@Inject
	private ReleaseService relService;
	
	@Inject
	private ReceiveService receiveService;
	
	@Inject
	private SystemService systemService;

	
	@RequestMapping(value = "/inst/instmain", method = RequestMethod.GET)
	public String instmain(HttpServletRequest request, Model model,HttpSession session) {
			System.out.println("InstructionController instmain()");
			
			Object emp_no = session.getAttribute("emp_no");
	        if(emp_no == null) {
	            return "system/msg2";
	        } else {
	        	
			String search =request.getParameter("search");
			String select =request.getParameter("select");
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
			pageDTO.setSearch(search);
			pageDTO.setSelect(select);
			
			List<InstructionDTO> instructionList=instructionService.instructionlist(pageDTO);
			
//			페이징처리
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
			
			SystemDTO systemDTO = systemService.memberinfo((int)emp_no);
		    model.addAttribute("systemDTO2", systemDTO);

			model.addAttribute("instructionList", instructionList);
			model.addAttribute("pageDTO", pageDTO);
			
			return "inst/InstMain";
			}
	}
	
	@RequestMapping(value = "/inst/instinsert", method = RequestMethod.GET)
	public String instructioninsert(HttpServletRequest request, Model model) {
		// web.xml 에서 한글설정을 한번만 하면 모든 곳에서 한글처리
		List<Map<String, Object>> instMap
	     = instructionService.getInstMap();
		
		List<LineDTO> lineDTO=instructionService.getLine_cd();
		
		//model 담아서 이동
		model.addAttribute("lineDTO", lineDTO);
		model.addAttribute("instMap", instMap);
		return "inst/InstInsert";
	}
	
	@RequestMapping(value = "/inst/instinsert2", method = RequestMethod.GET)
	public String instructioninsert2(HttpServletRequest request, Model model, InstructionDTO instructionDTO) {
		//리퀘스트 받아오기
		String instruction_code = request.getParameter("instruction_code");
		String line_cd = request.getParameter("line_cd");
		String product_cd_name = request.getParameter("product_cd_name");
		String order_cd = request.getParameter("order_cd");
		//DTO에 저장
		instructionDTO.setInstruction_code(instruction_code);
		instructionDTO.setLine_cd(line_cd);
		instructionDTO.setProduct_cd_name(product_cd_name);
		instructionDTO.setOrder_cd(order_cd);
		
		//model 담아서 이동
		model.addAttribute("instructionDTO", instructionDTO);
		
		return "inst/InstInsert2";
	}
	
	@RequestMapping(value = "/inst/instinsertpro2", method = RequestMethod.POST)
	public String instinsertpro2(InstructionDTO instructionDTO) {
		// web.xml 에서 한글설정을 한번만 하면 모든 곳에서 한글처리
		System.out.println("InstructionController instinsertpro2()");
		String inst=instructionDTO.getInstruction_code();
		String inst2=instructionDTO.getInstruction_code();
		inst=inst.substring(11);
		inst2=inst2.substring(0,11);
		int tpc=Integer.parseInt(inst);
		tpc=tpc+10;
		inst=String.valueOf(tpc);
		inst=inst2.concat(inst);
		instructionDTO.setInstruction_code(inst);
		// MemberService memberService = new MemberServiceImpl();
		instructionService.instinsertpro(instructionDTO);
		orderService.updateCon(instructionDTO.getOrder_cd());
		
		// 가상주소에서 주소변경 하면서 이동
		return "redirect:/inst/instmain";
	}
	
	@RequestMapping(value = "/inst/instinsertpro", method = RequestMethod.POST)
	public String instinsertpro(InstructionDTO instructionDTO) {
		// web.xml 에서 한글설정을 한번만 하면 모든 곳에서 한글처리
		System.out.println("InstructionController instinsertpro()");
		instructionDTO.setInstruction_code("IS" + instructionDTO.getOrder_cd());
		
		System.out.println("instruction_code :" + instructionDTO.getInstruction_code());
		System.out.println("line_cd :" + instructionDTO.getLine_cd());
		System.out.println("product_cd_name :" + instructionDTO.getProduct_cd_name());
		System.out.println("order_cd :" + instructionDTO.getOrder_cd());
		System.out.println("instruction_date :" + instructionDTO.getInstruction_date());
		System.out.println("instruction_state :" + instructionDTO.getInstruction_state());
		System.out.println("instruction_qt :" + instructionDTO.getInstruction_qt());
		
		// MemberService memberService = new MemberServiceImpl();
		instructionService.instinsertpro(instructionDTO);
		orderService.updateCon(instructionDTO.getOrder_cd());
		
		// 가상주소에서 주소변경 하면서 이동
		return "redirect:/inst/instmain";
	}
	
	@RequestMapping(value = "/inst/instupdate", method = RequestMethod.GET)
	public String instupdate(HttpServletRequest request, Model model) {
		// web.xml 에서 한글설정을 한번만 하면 모든 곳에서 한글처리
		System.out.println("InstructionController instupdate()");
		String instruction_code = request.getParameter("instruction_code");
		System.out.println(instruction_code);
	
		Map<String, Object> instInfoMap
	     = instructionService.getInstInfoMap(instruction_code);

		model.addAttribute("instInfoMap", instInfoMap);		
		
		return "/inst/InstUpdate";
	}
	
	@RequestMapping(value = "/inst/instupdatepro", method = RequestMethod.POST)
	public String instructionupdatepro(InstructionDTO instructionDTO) {
		// web.xml 에서 한글설정을 한번만 하면 모든 곳에서 한글처리
		System.out.println("InstructionController instructionupdatepro()");

		instructionService.instupdatepro(instructionDTO);
		
		
		// 가상주소에서 주소변경 하면서 이동
		return "redirect:/inst/instmain";
	}

	@RequestMapping(value = "/inst/instdelete", method = RequestMethod.GET)
	public String instdelete(HttpServletRequest request) {
		// web.xml 에서 한글설정을 한번만 하면 모든 곳에서 한글처리
		System.out.println("InstructionController instdelete()");
		String chbox[]=request.getParameterValues("rowcheck");
		String instruction_code = null;
		if(chbox!=null){
			  for(int i=0;i<chbox.length;i++){
				  instruction_code=chbox[i];
				  instructionService.instdelete(instruction_code);
			  }
	       }			
		
		// 주소변경 하면서 이동
		return "redirect:/inst/instmain";
	}
	
	
	@RequestMapping(value = "/inst/orderlist", method = RequestMethod.GET)
	public String orderlist(HttpServletRequest request, Model model) {
		
//		한 화면에 보여줄 글의 개수 설정
		int pageSize =10;
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
		
		List<Map<String, Object>> orderListMap
	     =instructionService.getOrderListMap(pageDTO);
//		List<OrderDTO> orderList=orderService.getOrderList(pageDTO);
		
//		페이징처리
		int count = orderService.getOrderCount();
		int pageBlock = 5;
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
		

		model.addAttribute("orderListMap", orderListMap);
		model.addAttribute("pageDTO", pageDTO);
		
		// 주소변경 없이 이동
		// /WEB-INF/views/perform/InstList.jsp
		return "inst/OrderList";
	}
	
	@ResponseBody
	@RequestMapping(value = "/inst/ordercheck", method = RequestMethod.GET)
	public String ordercheck(HttpServletRequest request, Model model) {
		// request 파라미터 
		String order_cd=request.getParameter("order");
		String result=null;
		
		// 메서드 호출
		int ordercheck
	     =instructionService.getordercheck(order_cd);
			
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
	@RequestMapping(value = "/inst/changeIng")
	public String changeIng(HttpServletRequest request, ReleaseDTO releaseDTO, ConsumptionDTO consumptionDTO, StockDTO stockDTO) {
		System.out.println("InstructionController changIng()");
		
		String[] ajaxMsg = request.getParameterValues("valueArr");
		String jdata = "0";
		
		System.out.println("배열0번지출력"+ajaxMsg[0]);
		
		int size = ajaxMsg.length;
		for(int i=0; i<size; i++) {
				instructionService.updateCon2(ajaxMsg[i]);
//				orderService.updateCon(ajaxMsg[i]);
				jdata = "1";
			}
		
		for(int i=0; i<size; i++) {
			String instruction_code=ajaxMsg[i];
			String line_cd=instructionService.getLine_cdInst(instruction_code);
			instructionService.setlineState(line_cd);
		}
		
		
		for(int i=0; i<size; i++) {
			String instruction_code=ajaxMsg[i];
			int count=instructionService.getInstCount(instruction_code);
			String date=instructionService.getInstDate(instruction_code);
			LocalDate localDate1 = LocalDate.parse(date);//	       
	        Date date2 = java.sql.Date.valueOf(localDate1);
			String cproduct_cd_name=instructionService.getInstCdname(instruction_code);
			List<String> cons=instructionService.getcountcons(cproduct_cd_name);
			for(int i2=0; i2<cons.size(); i2++) {
				String rproduct_cd_name=cons.get(i2);
				consumptionDTO.setRproduct_cd_name(rproduct_cd_name);
				consumptionDTO.setCproduct_cd_name(cproduct_cd_name);
				ConsumptionDTO consumdDTO=instructionService.getConsumption(consumptionDTO);
				
				String wh_cd=instructionService.getWh_cd(rproduct_cd_name);
				releaseDTO.setWh_cd(wh_cd);
				String pch=instructionService.getInstPch(rproduct_cd_name);
			    releaseDTO.setRel_date(date2);
				releaseDTO.setRel_count(consumdDTO.getConsumption()*count);
				releaseDTO.setProduct_cd_name(rproduct_cd_name);
				releaseDTO.setPchor_cd(pch);
				// 출고등록 메서드 호출
				relService.insertrel2(releaseDTO);
				
				// 출고 수량에 따라 재고현황에 적용할 재소수량 stockDTO에 저장
//				String product_cd_name =  releaseDTO.getProduct_cd_name();
				int Stock_count=receiveService.getStock_count(rproduct_cd_name);
				stockDTO.setStock_count(Stock_count-releaseDTO.getRel_count());
				stockDTO.setProduct_cd_name(rproduct_cd_name);
				// 재고현황에 재고수량 적용 메서드 호출
				receiveService.updateStockcount(stockDTO);
			}	
			
		}		
		System.out.println("jdata값!!!!!!!!!!" + jdata);
		return jdata;
	}
	
	@ResponseBody
	@RequestMapping(value = "/inst/changeIng2", method = RequestMethod.POST)
	public String changeIng2(HttpServletRequest request, ReleaseDTO releaseDTO, ConsumptionDTO consumptionDTO, StockDTO stockDTO) {
		System.out.println("InstructionController changIng2()");
		
		String[] ajaxMsg = request.getParameterValues("valueArr");
		int size = ajaxMsg.length;
		String[] linecheck = new String[size];
		
		String jdata = "0";
		
		if (ajaxMsg.length > 1 ) {
			for(int i=0; i<size; i++) {
				String instruction_code = ajaxMsg[i];
				String line_cd = instructionService.getLine_cdInst(instruction_code);
				linecheck[i]=line_cd;	
			}
			
			List<String> linecheck2 = Arrays.asList(linecheck);
	        if(linecheck2.size() != linecheck2.stream().distinct().count()){
	        	System.out.println("원래 사이즈"+linecheck2.size());
	        	System.out.println("중복제거 사이즈"+linecheck2.stream().distinct().count());
	            System.out.println("중복된 요소가 있습니다!");
	            jdata = "1";
	        }
		}
				
		return jdata;
	}
	
	@ResponseBody
	@RequestMapping(value = "/inst/changefin")
	public String changefin(HttpServletRequest request) {
		System.out.println("InstructionController changeFin()");
		
		String[] ajaxMsg = request.getParameterValues("valueArr");
		String jdata = "0";
		
		System.out.println("배열0번지출력"+ajaxMsg[0]);
		int size = ajaxMsg.length;
		for(int i=0; i<size; i++) {
			String instruction_code=ajaxMsg[i];
			String line_cd=instructionService.getLine_cdInst(instruction_code);
			instructionService.setlineState2(line_cd);
		}
		
		for(int i=0; i<size; i++) {
				instructionService.updateCon3(ajaxMsg[i]);
//				orderService.updateCon(ajaxMsg[i]);
				jdata = "1";
			}
			
		
		System.out.println("jdata값!!!!!!!!!!" + jdata);
		return jdata;
	}

	@RequestMapping(value = "/inst/instcontent", method = RequestMethod.GET)
	public String instcontent(HttpServletRequest request, Model model, InstructionDTO instructionDTO) {
		// web.xml 에서 한글설정을 한번만 하면 모든 곳에서 한글처리
		String instruction_code = request.getParameter("instruction_code");
		List<Map<String, Object>> consListMap
	     = instructionService.getConsListMap(instruction_code);
		
		Map<String, Object> instInfoMap
	     = instructionService.getInstInfoMap(instruction_code);
	//model 담아서 이동
	model.addAttribute("consListMap", consListMap);
	model.addAttribute("instInfoMap", instInfoMap);
		return "/inst/InstContent";
	}
	
	@ResponseBody
	@RequestMapping(value = "/inst/stockCheck", method = RequestMethod.GET)
	public JSONArray stockCheck(HttpServletRequest request) {
		// request 파라미터 
		String order_cd = request.getParameter("order_cd");
		System.out.println(order_cd);
		String instruction_qt_st = request.getParameter("instruction_qt");
		int instruction_qt = Integer.parseInt(instruction_qt_st);
		System.out.println(instruction_qt);
		
		// 메서드 호출
		List<Map<String, Object>> stockCheckList = instructionService.getStockCheck(order_cd);
		
		// DB stock_count null -> 0 저장
		for (Map<String, Object> stockCheckMap : stockCheckList) {
		    Object stock_count = stockCheckMap.get("stock_count");
		    if(stock_count == null) {
		    	 stockCheckMap.put("stock_count", 0);
		    }
		}
		
		// 지시 수량에 따른 원자재 소요량 계산
		for (Map<String, Object> stockCheckMap : stockCheckList) {
		    Object consumption = stockCheckMap.get("consumption");
		    Integer consumption_int = (Integer)consumption;
		    consumption_int = consumption_int*instruction_qt;
		    stockCheckMap.put("consumption", consumption_int);
		}
		
		// List<MapString, Object>> -> JSONArray 변환
		 JSONArray jsonArr = new JSONArray();
		 for (Map<String, Object> map : stockCheckList) {
		        JSONObject json = new JSONObject();
		        for (Map.Entry<String, Object> entry : map.entrySet()) {
		            String key = entry.getKey();
		            Object value = entry.getValue();
		            json.put(key, value);
		        }
		        jsonArr.add(json);
		}
		System.out.println("변환입니다."+jsonArr);    	
		
		return jsonArr;
	}

}
