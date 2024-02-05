package com.itwillbs.service;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.itwillbs.dao.StockDAO;
import com.itwillbs.domain.StockDTO;
import com.itwillbs.domain.PageDTO;

@Service
public class StockServiceImpl implements StockService{

	// 객체생성 부모 인터페이스 => 자동으로 자식 클래스 객체생성
		@Inject
		private StockDAO stockDAO;
		
//		@Override
//		public List<StockDTO> getStockList(PageDTO pageDTO) {
//			System.out.println("stockServiceImpl getStockList()");
//			//시작하는 행번호 구하기
//			int startRow=(pageDTO.getCurrentPage()-1)*pageDTO.getPageSize()+1;
//			int endRow = startRow+pageDTO.getPageSize()-1;
//			
//			pageDTO.setStartRow(startRow);
//			pageDTO.setEndRow(endRow);
//			
//			return stockDAO.getStockList(pageDTO);
//		}		

		@Override
		public int getStockCount(PageDTO pageDTO) {
			System.out.println("stockServiceImpl getStockCount()");
			
			return stockDAO.getStockCount(pageDTO);
		}

		@Override
		public void insertStock(StockDTO stockDTO) {
			System.out.println("stockServiceImpl insertStock()");
			
			stockDAO.insertStock(stockDTO);			
		}

		@Override
		public StockDTO getStock(String stock_cd) {
			System.out.println("stockServiceImpl getStock()");
			
			return stockDAO.getStock(stock_cd);
		}

		@Override
		public void updateStock(StockDTO stockDTO) {
			System.out.println("stockServiceImpl updateStock()");
			
			stockDAO.updateStock(stockDTO);
		}

		@Override
		public void deleteStock(String stock_cd) {
			System.out.println("stockServiceImpl deleteStock()");
			
			stockDAO.deleteStock(stock_cd);
		}

		@Override
		public List<Map<String, Object>> getStockMap(PageDTO pageDTO) {
			System.out.println("stockServiceImpl getStockMap()");
			//시작하는 행번호 구하기
			int startRow=(pageDTO.getCurrentPage()-1)*pageDTO.getPageSize()+1;
			int endRow = startRow+pageDTO.getPageSize()-1;
			
			pageDTO.setStartRow(startRow);
			pageDTO.setEndRow(endRow);
			
			return stockDAO.getStockMap(pageDTO);
		}

		@Override
		public List<Map<String, Object>> getwhMap() {
			System.out.println("stockServiceImpl getwhMap()");
			
			return stockDAO.getwhMap();
		}

		@Override
		public List<Map<String, Object>> getrecMap() {
			System.out.println("stockServiceImpl getrecMap()");
			
			return stockDAO.getrecMap();
		}

		@Override
		public List<Map<String, Object>> getprodMap() {
			System.out.println("stockServiceImpl getprodMap()");
			
			return stockDAO.getprodMap();
		}

		@Override
		public int getStockCount2() {
			System.out.println("stockServiceImpl getStockCount2()");
			
			return stockDAO.getStockCount2();
		}

		@Override
		public String getStock_cd() {
			System.out.println("stockServiceImpl getStock_cd()");
			
			return stockDAO.getStock_cd();
		}

}
