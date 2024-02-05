package com.itwillbs.service;

import java.util.List;
import java.util.Map;

import com.itwillbs.domain.PageDTO;
import com.itwillbs.domain.StockDTO;

public interface StockService {
	
//public List<StockDTO> getStockList(PageDTO pageDTO);
	
	public int getStockCount(PageDTO pageDTO);
	
	public int getStockCount2();
	
	public void insertStock(StockDTO stockDTO);
	
	public StockDTO getStock(String stock_cd);
	
	public void updateStock(StockDTO stockDTO);
	
	public void deleteStock(String stock_cd);

	public List<Map<String, Object>> getStockMap(PageDTO pageDTO);

	public List<Map<String, Object>> getwhMap();

	public List<Map<String, Object>> getrecMap();

	public List<Map<String, Object>> getprodMap();

	public String getStock_cd();
}
