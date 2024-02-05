package com.itwillbs.dao;

import java.util.List;
import java.util.Map;

import com.itwillbs.domain.PageDTO;
import com.itwillbs.domain.PerformDTO;

public interface PerformDAO {
	
//	public List<PerformDTO> getPerformList(PageDTO pageDTO);
	
	public int getPerformCount(PageDTO pageDTO);
	
	public void insertPerform(PerformDTO performDTO);
	
//	public PerformDTO getPerform(String perform_cd);
	
	public void updatePerform(PerformDTO performDTO);
	
	public void deletePerform(String perform_cd);
	

	public int getPerformCount2();

	public String getPerform_cd();

	public int getinstcheck(String instruction_code);
	
	//map
	public List<Map<String, Object>> getInstMap();

	public List<Map<String, Object>> getPerformMap(PageDTO pageDTO);
	
	public Map<String, Object> getPerform(String perform_cd);

	public Map<String, Object> getcallcdMap(String ic);
	
	public int getinstructioncount2(PageDTO pageDTO);

	public List<Map<String, Object>> getPerformMap3(PageDTO pageDTO);

	public int getPerformCount3(PageDTO pageDTO);

}
