package com.itwillbs.dao;

import java.util.List;

import com.itwillbs.domain.PageDTO;
import com.itwillbs.domain.WHDTO;

public interface WHDAO {
	
	public void insertwh(WHDTO whdto);
	
	public Integer getMaxNum();
	
	public Integer getMNum();
	
	public Integer getPNum();
	
	public List<WHDTO> getWhList(PageDTO pageDTO);
	
	public int getWhCount(PageDTO pageDTO);
	
	public void deletewh(String wh_cd);

	public WHDTO getwh(String wh_cd);

	public void updatewh(WHDTO whDTO);

	public int getwhcheck(String wh_name);




}
