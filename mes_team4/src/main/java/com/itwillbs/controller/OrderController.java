package com.itwillbs.controller;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itwillbs.dao.OrderDAO;
import com.itwillbs.domain.BusinessDTO;
import com.itwillbs.domain.OrderDTO;
import com.itwillbs.domain.PageDTO;
import com.itwillbs.domain.ProductDTO;
import com.itwillbs.domain.StockDTO;
import com.itwillbs.domain.SystemDTO;
import com.itwillbs.service.BusinessService;
import com.itwillbs.service.OrderService;
import com.itwillbs.service.ProductService;
import com.itwillbs.service.ReceiveService;
import com.itwillbs.service.SystemService;

@Controller
public class OrderController {

	@Inject
	private BusinessService businessService;
	
	@Inject
	private OrderService orderService;
	
	@Inject
	private OrderDAO orderDAO;
	
	@Inject
	private ProductService productService;
	
	@Inject
	private SystemService systemService;
	
	@Inject
	private ReceiveService receiveService;
	
	@RequestMapping(value = "/order/ordermain", method = RequestMethod.GET)
	public String ordermain(HttpServletRequest request, Model model,HttpSession session) {
				
		//비로그인 상태일 시
		Object emp_no = session.getAttribute("emp_no");
		if(emp_no == null) {
			return "system/msg2";
		} else {
		
		// 한 화면에 보여줄 글 개수 설정
		int pageSize=5;
		
		// 현페이지 번호 가져오기
		String pageNum=request.getParameter("pageNum");
		if(pageNum==null) {
			pageNum="1";
		}
		// 페이지번호를 => 정수형 변경
		int currentPage=Integer.parseInt(pageNum);
		
		PageDTO pageDTO=new PageDTO();
		pageDTO.setPageSize(pageSize);
		pageDTO.setPageNum(pageNum);
		pageDTO.setCurrentPage(currentPage);
		
		//생산 전,완료 개수 구하기
		pageDTO.setPcount(orderService.getPCount());
		pageDTO.setFcount(orderService.getFCount());
		pageDTO.setIcount(orderService.getICount());
		pageDTO.setWcount(orderService.getWCount());
		
		// 검색어 가져오기
		String search = request.getParameter("search");
		// 검색어를 pageDTO에 담아줌 
		pageDTO.setSearch(search);
		
		List<OrderDTO> orderList = orderService.getOrderList(pageDTO);
		
		//페이징 처리
		int count = orderService.getOrderCount();
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

		model.addAttribute("orderList", orderList);
		model.addAttribute("pageDTO", pageDTO);
		
		//사원정보 관련
		SystemDTO systemDTO = systemService.memberinfo((int)emp_no);
		model.addAttribute("systemDTO2", systemDTO);
		
		// 가상주소 유지
		return "order/OrderMain";
		}
	}
	
	@RequestMapping(value = "/order/ordermainB", method = RequestMethod.GET)
	public String ordermainB(HttpServletRequest request, Model model,HttpSession session) {
		//비로그인 상태일 시
		Object emp_no = session.getAttribute("emp_no");
		if(emp_no == null) {
			return "system/msg2";
		} else {	
		
		// 한 화면에 보여줄 글 개수 설정
		int pageSize=5;
		
		// 현페이지 번호 가져오기
		String pageNum=request.getParameter("pageNum");
		if(pageNum==null) {
			pageNum="1";
		}
		// 페이지번호를 => 정수형 변경
		int currentPage=Integer.parseInt(pageNum);
		
		PageDTO pageDTO=new PageDTO();
		pageDTO.setPageSize(pageSize);
		pageDTO.setPageNum(pageNum);
		pageDTO.setCurrentPage(currentPage);
		
		String search = request.getParameter("cd");
		System.out.println("search값이다!!!!"+search);
		// 검색어를 pageDTO에 담아줌 
		pageDTO.setSearch(search);
		
		//생산 전,완료 개수 구하기
		pageDTO.setPcount(orderService.getPCount(pageDTO));
		pageDTO.setFcount(orderService.getFCount(pageDTO));
		pageDTO.setIcount(orderService.getICount(pageDTO));
		pageDTO.setWcount(orderService.getWCount(pageDTO));
		
		List<OrderDTO> orderList = orderService.getOrderList(pageDTO);
		
		//페이징 처리
		int count = orderService.getOrderCount();
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
		
		model.addAttribute("orderList", orderList);
		model.addAttribute("pageDTO", pageDTO);
		
		//사원정보 관련
				SystemDTO systemDTO = systemService.memberinfo((int)emp_no);
				model.addAttribute("systemDTO2", systemDTO);
		
		// 가상주소 유지
		return "order/OrderMainB";
		}
	}
	
	@RequestMapping(value = "/order/orderinsert", method = RequestMethod.GET)
	public String businessinsert(Model model) {
			
		List<BusinessDTO> businessList = businessService.getBusinessList();
		List<ProductDTO> productList = productService.getProductList();
		List<SystemDTO> systemList = systemService.getMemberList();
		
		model.addAttribute("businessList",businessList);
		model.addAttribute("productList",productList);
		model.addAttribute("systemList",systemList);
		
		// 가상주소 유지
		return "order/OrderInsert";
	}
	
	@RequestMapping(value = "/order/orderinsertpro", method = RequestMethod.POST)
	public String insertPro(OrderDTO orderDTO) {
		System.out.println("OrderController insertPro()");
		
		orderService.insertOrder(orderDTO);
		
		return "redirect:/order/ordermain";		
	}
	
	@ResponseBody
	@RequestMapping(value = "/order/delete")
	public String delete(HttpServletRequest request) {
		System.out.println("OrderController delete()");
		
		String[] ajaxMsg = request.getParameterValues("valueArr");
		String jdata = "0";
		int size = ajaxMsg.length;
		for(int i=0; i<size; i++) {
			
			System.out.println("수주지우기 getCon값 : "+orderDAO.getCon(ajaxMsg[i]));
			if(orderDAO.getCon(ajaxMsg[i])==0) {
				orderService.deleteOrder(ajaxMsg[i]);
				jdata = "1";
			}
			
		}
		System.out.println("jdata값!!!!!!!!!!" + jdata);
		return jdata;
	}
	
	@RequestMapping(value = "/order/orderupdate", method = RequestMethod.GET)
	public String businessupdate(HttpServletRequest request, Model model) {
		System.out.println("orderController UpdateForm()");
		
		String cd = request.getParameter("cd");
		System.out.println("cd 값 : "+cd);

		OrderDTO orderDTO = orderService.getOrder(cd);
		List<BusinessDTO> businessList = businessService.getBusinessList();
		List<ProductDTO> productList = productService.getProductList();
		List<SystemDTO> systemList = systemService.getMemberList();
		

		model.addAttribute("productList",productList);
		model.addAttribute("systemList",systemList);
		model.addAttribute("businessList",businessList);
		model.addAttribute("orderDTO",orderDTO);
		
		// 가상주소 유지
		return "order/OrderUpdate";
	}
	
	@RequestMapping(value = "/order/orderupdatepro", method = RequestMethod.POST)
	public String updatePro(OrderDTO orderDTO, HttpServletRequest request) {
		System.out.println("OrderController orderupdatePro()");
		
		String cd = request.getParameter("cd");
		orderDTO.setOrder_cd(cd);
		System.out.println("order cd값 : "+ orderDTO.getOrder_cd());
		
//		// 수정시 재고현황에 적용할 재소수량 stockDTO에 저장
//		String product_cd_name =orderService.getProduct_cd_name(cd);
//		int bforcount=orderService.getbfOr_count(cd);
//		int Stock_count=receiveService.getStock_count(product_cd_name);
//		stockDTO.setStock_count((Stock_count-bforcount)+orderDTO.getOrder_count());
//		stockDTO.setProduct_cd_name(product_cd_name);
//		// 재고현황에 재고수량 적용 메서드 호출
//		receiveService.updateStockcount(stockDTO);		

		int jdata = orderDAO.getCon(cd);
		if(jdata == 0) {
			orderService.updateOrder(orderDTO);
			return "redirect:/order/ordermain";
		}else {
			
			return "order/msg";
		}
		
		
		

		
	}
	
	
}