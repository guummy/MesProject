package com.itwillbs.service;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.itwillbs.dao.ProductDAO;
import com.itwillbs.domain.PageDTO;
import com.itwillbs.domain.ProductDTO;
import com.itwillbs.domain.StockDTO;

@Service
public class ProductServiceImpl implements ProductService{

	@Inject
	private ProductDAO productDAO;
	
	@Override
	public void insertProduct(ProductDTO productDTO) {
		System.out.println("ProductServiceImpl insertProduct()");
		
//		만약 완제품이면 PP넘 찾고, 원자재이면 MM넘 찾음 
		if(productDTO.getProduct_dv().equals("완제품")) {
			System.out.println(productDTO.getProduct_dv());
			
			if(productDAO.getPPNum()==null) {
				//수주거래처 없음
				productDTO.setProduct_cd("PP101");
			}else{
				//수주 거래처 있음 => max(num)+1
				System.out.println("pnum 출력 : "+productDAO.getPPNum());
				int num = productDAO.getPPNum()+1;
				String str = "PP" + num;
				productDTO.setProduct_cd(str);
			}
		} else if(productDTO.getProduct_dv().equals("원자재")) {
			if(productDAO.getMMNum() == null) {
				productDTO.setProduct_cd("MM101");
			}else{
				int num = productDAO.getMMNum()+1;
				String str = "MM" + num;
				productDTO.setProduct_cd(str);
			}
		}
		productDAO.insertProduct(productDTO);
	}
	
//	@Override
//	public List<ProductDTO> getProductList(PageDTO pageDTO) {
//		int startRow=(pageDTO.getCurrentPage()-1)*pageDTO.getPageSize()+1;
//		int endRow= startRow+pageDTO.getPageSize()-1;
//		
//		pageDTO.setStartRow(startRow);
//		pageDTO.setEndRow(endRow);
//		
//		return productDAO.getProductList(pageDTO);
//	}
	
	@Override
	public int getProductCount(PageDTO pageDTO) {

		return productDAO.getProductCount(pageDTO);
	}
	
	@Override
	public void deleteProduct(String product_cd_name) {
		System.out.println("ProductServiceImpl deleteProduct()");
		
		productDAO.deleteProduct(product_cd_name);
	}
	
	@Override
	public ProductDTO getProduct(String product_cd_name) {
		System.out.println("ProductServiceImpl getProduct()");
		
		return productDAO.getProduct(product_cd_name);
	}
	
	@Override
	public void updateProduct(ProductDTO productDTO) {
		System.out.println("ProductServiceImpl updateProduct()");
		
		productDAO.updateProduct(productDTO);
	}
	
	@Override
	public List<Map<String, Object>> getProductList(PageDTO pageDTO) {
		System.out.println("ProductServiceImpl getProductList()");
		// 시작하는 행번호 구하기
		int startRow=(pageDTO.getCurrentPage()-1)*pageDTO.getPageSize()+1;
		int endRow= startRow+pageDTO.getPageSize()-1;
		
		pageDTO.setStartRow(startRow);
		pageDTO.setEndRow(endRow);
		
		return productDAO.getProductList(pageDTO);
	}
	
	@Override
	public List<Map<String, Object>> getInstMap() {
		System.out.println("ProductServiceImpl getInstMap()");
		
		return productDAO.getInstMap();
	}

	@Override
	public int getProductCount2() {
		return productDAO.getProductCount2();
	}

	@Override
	public String getProduct_cd() {
		return productDAO.getProduct_cd();
	}

	@Override
	public List<ProductDTO> getProductList() {
		System.out.println("ProductServiceImpl getProductList()");

		return productDAO.getProductList();
	}

	@Override
	public String getStock_cd() {
		System.out.println("ProductServiceImpl getStock_cd()");
		
		return productDAO.getStock_cd();
	}

	@Override
	public void insertStock(StockDTO stockDTO) {
		System.out.println("ProductServiceImpl insertStock()");
		
		productDAO.insertStock(stockDTO);
	}

	@Override
	public int getprodcheck(String product_cd_name) {
		System.out.println("ProductServiceImpl getprodcheck()");
		
		return productDAO.getprodcheck(product_cd_name);
	}



}
