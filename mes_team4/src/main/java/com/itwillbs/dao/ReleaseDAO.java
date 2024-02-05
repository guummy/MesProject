package com.itwillbs.dao;

import java.util.List;
import java.util.Map;

import com.itwillbs.domain.PageDTO;
import com.itwillbs.domain.ReceiveDTO;
import com.itwillbs.domain.ReleaseDTO;

public interface ReleaseDAO {
	
	public int getRelCount(PageDTO pageDTO);
	
	public void insertrel(ReleaseDTO releaseDTO);
	
	public Integer getLNum();

	public List<Map<String, Object>> getInstMap();
	
	public List<Map<String, Object>> getRelList(PageDTO pageDTO);

	public ReleaseDTO getrel(String rel_schedule_cd);

	public void updaterel(ReleaseDTO releaseDTO);

	public void deleterel(String rel_schedule_cd);

	public String getRel_cd();

	public Map<String, Object> getrec(ReleaseDTO releaseDTO);

	public void finishrel(String rel_schedule_cd);

	public String getProduct_cd_name2(String rel_schedule_cd);

	public void insertrel2(ReleaseDTO releaseDTO);

	public int getbfRel_count(ReleaseDTO releaseDTO);

	public List<Map<String, Object>> getReceiveSList(PageDTO pageDTO);






}
