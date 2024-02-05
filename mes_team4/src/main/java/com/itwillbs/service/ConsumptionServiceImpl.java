package com.itwillbs.service;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.itwillbs.dao.ConsumptionDAO;
import com.itwillbs.domain.ConsumptionDTO;
import com.itwillbs.domain.PageDTO;

@Service
public class ConsumptionServiceImpl implements ConsumptionService{
	
	@Inject 
	private ConsumptionDAO consumptionDAO;
	
	@Override
	public List<Map<String, Object>> getPrList(PageDTO pageDTO) {
		System.out.println("ConsumptionServiceImpl getPrList()");
		
		int startRow=(pageDTO.getCurrentPage()-1)*pageDTO.getPageSize();
		int endRow = startRow + pageDTO.getPageSize()-1;
		
		pageDTO.setStartRow(startRow);  
		pageDTO.setEndRow(endRow);
		
		return consumptionDAO.getPrList(pageDTO);
	}
	
	@Override
	public int getPrCount(PageDTO pageDTO) {
		System.out.println("ConsumptionServiceImpl getPrCount()");
		
		return consumptionDAO.getPrCount(pageDTO);
	}
	
	@Override
	public void insertConsmpt(ConsumptionDTO[] consmptArray) {
		System.out.println("ConsumptionServiceImpl insertConsmpt()");
		
		consumptionDAO.insertConsmpt(consmptArray);
	}
	
	@Override
	public List<ConsumptionDTO> checkCprCdName(String cproduct_cd_name) {
		System.out.println("ConsumptionServiceImpl checkCprCdName()");
		
		return consumptionDAO.checkCprCdName(cproduct_cd_name);
	}
	
	@Override
	public List<ConsumptionDTO> getCprConsmptList(PageDTO pageDTO) {
		System.out.println("ConsumptionServiceImpl getCprConsmptList()");
		
		int startRow=(pageDTO.getCurrentPage()-1)*pageDTO.getPageSize();
		int endRow = startRow + pageDTO.getPageSize()-1;
		
		pageDTO.setStartRow(startRow);
		pageDTO.setEndRow(endRow);
		
		return consumptionDAO.getCprConsmptList(pageDTO);
	}
	
	@Override
	public int getCprConsmptCount(PageDTO pageDTO) {
		System.out.println("ConsumptionServiceImpl getCprConsmptCount()");
		
		return consumptionDAO.getCprConsmptCount(pageDTO);
	}
	
	@Override
	public List<ConsumptionDTO> getRprConsmptList(String[] cprCdName) {
		System.out.println("ConsumptionServiceImpl getRprConsmptList()");
		
		return consumptionDAO.getRprConsmptList(cprCdName);
	}
	
	@Override
	public List<Integer> getRowcolsTd(String[] cprCdName) {
		System.out.println("ConsumptionServiceImpl getRowcolsTd()");
		
		return consumptionDAO.getRowcolsTd(cprCdName);
	}
	
	@Override
	public void deleteConsmpt(String[] checkedValue) {
		System.out.println("ConsumptionServiceImpl deleteConsmpt()");
		
		consumptionDAO.deleteConsmpt(checkedValue);
	}
	
	@Override
	public void updateConsmpt(ConsumptionDTO[] consmptArray) {
		System.out.println("ConsumptionServiceImpl updateConsmpt()");
		
		consumptionDAO.updateConsmpt(consmptArray);
	}
	
	@Override
	public void updateConsmptName(String column_cd, String column_name, String product_cd_name, String product_name) {
		System.out.println("ConsumptionServiceImpl updateConsmptName()");
		
		consumptionDAO.updateConsmptName(column_cd, column_name, product_cd_name, product_name);
	}
	
}// class
