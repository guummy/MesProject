package com.itwillbs.service;

import java.util.List;
import java.util.Map;

import com.itwillbs.domain.LineDTO;
import com.itwillbs.domain.PageDTO;

public interface InfoService {

	public List<LineDTO> getLineList(PageDTO pageDTO);
	
	public int getLineCount(PageDTO pageDTO);
	
	public void insertLine(LineDTO lineDTO);
	
	public LineDTO getLine(String line_cd);
	
	public void updateLine(LineDTO lineDTO);
	
	public void deleteLine(String line_cd);

	public int getlinecdcheck(String line_cd);
}
