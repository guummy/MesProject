package com.itwillbs.dao;

import java.util.List;
import java.util.Map;

import com.itwillbs.domain.PageDTO;
import com.itwillbs.domain.StockDTO;

public interface StockDAO {

//	public List<StockDTO> getStockList(PageDTO pageDTO);
	
	public int getStockCount(PageDTO pageDTO);
	
	public void insertStock(StockDTO stockDTO);
	
	public StockDTO getStock(String stock_cd);
	
	public void updateStock(StockDTO stockDTO);
	
	public void deleteStock(String stock_cd);

	public List<Map<String, Object>> getStockMap(PageDTO pageDTO);

	public List<Map<String, Object>> getwhMap();

	public List<Map<String, Object>> getrecMap();

	public List<Map<String, Object>> getprodMap();

	public int getStockCount2();

	public String getStock_cd();
}
