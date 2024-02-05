package com.itwillbs.service;

import java.util.List;

import com.itwillbs.domain.BusinessDTO;
import com.itwillbs.domain.PageDTO;

public interface BusinessService {

	public void insertBusiness(BusinessDTO businessDTO);
	
	public int getBusinessCount(PageDTO pageDTO);
	
	public  List<BusinessDTO> getBusinessList(PageDTO pageDTO);

	public List<BusinessDTO> getBusinessList();
	
	public void deleteBusiness(String cd);

	public BusinessDTO getBusiness(String cd);

	public void updateBusiness(BusinessDTO businessDTO);

	public List<BusinessDTO> getBusinessList2();
	
}
