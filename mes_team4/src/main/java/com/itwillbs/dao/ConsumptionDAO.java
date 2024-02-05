package com.itwillbs.dao;

import java.util.List;
import java.util.Map;

import com.itwillbs.domain.ConsumptionDTO;
import com.itwillbs.domain.PageDTO;

public interface ConsumptionDAO {
	
	public List<Map<String, Object>> getPrList(PageDTO pageDTO);
	
	public int getPrCount(PageDTO pageDTO);
	
	public void insertConsmpt(ConsumptionDTO[] consmptArray);
	
	public List<ConsumptionDTO> checkCprCdName(String cproduct_cd_name);
	
	public List<ConsumptionDTO> getCprConsmptList(PageDTO pageDTO);
	
	public int getCprConsmptCount(PageDTO pageDTO);
	
	public List<ConsumptionDTO> getRprConsmptList(String[] cprCdName);
	
	public List<Integer> getRowcolsTd(String[] cprCdName);
	
	public void deleteConsmpt(String[] checkedValue);
	
	public void updateConsmpt(ConsumptionDTO[] consmptArray);
	
	public void updateConsmptName(String column_cd, String column_name, String product_cd_name, String product_name);
	
}// class
