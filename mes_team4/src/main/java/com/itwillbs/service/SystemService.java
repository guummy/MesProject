package com.itwillbs.service;

import java.util.List;

import com.itwillbs.domain.PageDTO;
import com.itwillbs.domain.ProductDTO;
import com.itwillbs.domain.SystemDTO;

public interface SystemService {

	public void memberinsertpro(SystemDTO systemDTO);
	
	public List<SystemDTO> getsystemlist(PageDTO pageDTO);
	
	public int getsystemcount(PageDTO pageDTO);
	
	public SystemDTO memberinfo(int emp_no);
	
	public void memberupdatepro(SystemDTO systemDTO);

	public void memberdelete(int emp_no);

	public SystemDTO userCheck(SystemDTO systemDTO);

	public void mypagePro(SystemDTO systemDTO);
	
	public List<SystemDTO> getMemberList();

	

}
