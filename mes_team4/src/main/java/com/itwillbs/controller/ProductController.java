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

import com.itwillbs.domain.BusinessDTO;
import com.itwillbs.domain.PageDTO;
import com.itwillbs.domain.ProductDTO;
import com.itwillbs.domain.StockDTO;
import com.itwillbs.domain.SystemDTO;
import com.itwillbs.service.BusinessService;
import com.itwillbs.service.ConsumptionService;
import com.itwillbs.service.ProductService;
import com.itwillbs.service.SystemService;

@Controller
public class ProductController {
	
	@Inject
	private BusinessService businessService;
	@Inject
	private ProductService productService;
	@Inject
	private SystemService systemService;
	@Inject
	private ConsumptionService consumptionService;
	
	@RequestMapping(value = "/product/prodpage", method = RequestMethod.GET)
	public String prodpage(HttpServletRequest request, Model model, HttpSession session) {
		Object emp_no = session.getAttribute("emp_no");
        if(emp_no == null) {
           return "system/msg2";
        } else {

		// 검색어 가져오기
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
		// 검색어
		pageDTO.setSearch(search);
		pageDTO.setSelect(select);
		
//		List<ProductDTO> productList=productService.getProductList(pageDTO);
		List<Map<String, Object>> productList
	     =productService.getProductList(pageDTO);
		
		// 페이징 처리
		int count =productService.getProductCount(pageDTO);
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
		System.out.println(productList.get(0));
		model.addAttribute("productList", productList);
		model.addAttribute("pageDTO",pageDTO);
		
		   SystemDTO systemDTO = systemService.memberinfo((int)emp_no);
	         model.addAttribute("systemDTO2", systemDTO);

		
		return "product/ProductPage";
	}
	}
	
	@RequestMapping(value = "/product/prodinsert", method = RequestMethod.GET)
	public String prodinsert(Model model) {
		List<BusinessDTO> businessList = businessService.getBusinessList2();
		List<Map<String, Object>> instMap
			=productService.getInstMap();
		// model에 담아서 이동
		model.addAttribute("instMap", instMap);
		model.addAttribute("businessList",businessList);
		return "product/ProductInsert";
	}
	
	@RequestMapping(value = "/product/prodinsertPro", method = RequestMethod.POST)
	public String prodinsertPro(HttpServletRequest request, ProductDTO productDTO, StockDTO stockDTO) {
		System.out.println("ProductController prodinsertPro()");

		
		// 재고코드 자동생성(PCHyyMMdd01) 및 저장 
		// 기존 재고코드
		String first_stock_cd = "기존재고코드";
		String first_number_st = "기존스트링넘버";
		int first_number = 0;
		
		if (productService.getStock_cd() != null) {
			first_stock_cd = productService.getStock_cd();
			first_number_st = first_stock_cd.substring(9);
		}	
		
		// 새로운 재고코드
		String new_stock_cd = "재고코드";
		String new_number_st = "스트링넘버";
		int new_number = 0;
		
		// 메뉴코드 설정
		String menu_code = "SN";
		
		// 오늘날짜 설정
		LocalDate now = LocalDate.now();
	    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyMMdd");
	    String today = now.format(formatter);
	    
	    // 인덱스 설정
	    if ( !(first_stock_cd.equals("기존재고코드")) && first_stock_cd.contains(today)) {
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
			new_stock_cd = menu_code + today + new_number_st;
			
	    } else {
	    	new_stock_cd = menu_code + today + "01";
	    }
	    stockDTO.setStock_cd(new_stock_cd);		
		stockDTO.setProduct_cd_name(productDTO.getProduct_cd_name());				
		
		// 등록 메서드 호출 (product + stock)
		productService.insertProduct(productDTO);
		productService.insertStock(stockDTO);
//		주소줄 변경하면서 이동
		return "redirect:/product/prodpage";
	}
	
	@RequestMapping(value = "/product/proddelete", method = RequestMethod.GET)
	public String proddelete(HttpServletRequest request) {
		System.out.println("ReceiveController recdelete()");
		
		String[] ajaxMsg = request.getParameterValues("valueArr");
		int size = ajaxMsg.length;
		for(int i=0; i<size; i++) {
			productService.deleteProduct(ajaxMsg[i]);
		}
		// 주소변경 하면서 이동
		return "redirect:/product/prodpage";
	}
	
	@RequestMapping(value = "/product/produpdate", method = RequestMethod.GET)
	public String produpdate(HttpServletRequest request, Model model) {
		String product_cd_name=request.getParameter("product_cd_name");
//		System.out.println("세션 product_cd_name :" + product_cd_name);
		ProductDTO productDTO=productService.getProduct(product_cd_name);
		
		model.addAttribute("productDTO", productDTO);
		// 주소변경 없이 이동
		return "product/ProductUpdate";
	}
	
	@RequestMapping(value = "/product/produpdatePro", method = RequestMethod.POST)
	public String produpdatePro(ProductDTO productDTO) {
		
		productService.updateProduct(productDTO);
		
		// 소요량 품목명 변경
		String product_dv = productDTO.getProduct_dv();
		
		String column_cd = "";
		String column_name = "";
		String product_cd_name = productDTO.getProduct_cd_name();
		String product_name = productDTO.getProduct_name();
		System.out.println("CD이름 "+product_cd_name);
		System.out.println("이름 "+product_name);
		
		if(product_dv.equals("완제품")) {
			column_cd = "cproduct_cd_name";
			column_name = "cproduct_name";
		} else {
			column_cd = "rproduct_cd_name";
			column_name = "rproduct_name";
		}
		
		consumptionService.updateConsmptName(column_cd, column_name, product_cd_name, product_name);
		
		// 주소변경 하면서 이동
		return "redirect:/product/prodpage";
	}
	
	@ResponseBody
	@RequestMapping(value = "/product/prodcheck", method = RequestMethod.GET)
	public String prodcheck(HttpServletRequest request, Model model) {
		// request 파라미터 
		String product_cd_name=request.getParameter("prod");
		String result=null;
		// 메서드 호출
		int prodcheck=productService.getprodcheck(product_cd_name);
		// if문으로 result에 저장 할 값 설정
		if(prodcheck==0) {
			result="0";
		}else {
			result="1";
		}			
		// result 값 리턴
		System.out.println(result);
		return result;
	}
	
}
