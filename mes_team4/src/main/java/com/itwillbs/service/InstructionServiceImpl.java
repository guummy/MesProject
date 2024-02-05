package com.itwillbs.service;


import java.sql.Date;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.itwillbs.dao.InstructionDAO;
import com.itwillbs.domain.ConsumptionDTO;
import com.itwillbs.domain.InstructionDTO;
import com.itwillbs.domain.LineDTO;
import com.itwillbs.domain.OrderDTO;
import com.itwillbs.domain.PageDTO;

@Service
public class InstructionServiceImpl implements InstructionService{
	@Inject
	private InstructionDAO instructionDAO;

	@Override
	public List<Map<String, Object>> getorderlist(PageDTO pageDTO) {
		System.out.println("InstructionServiceImpl getorderlist()");
		
		int startRow=(pageDTO.getCurrentPage()-1)*pageDTO.getPageSize();
		int endRow = startRow + pageDTO.getPageSize()-1;
		
		pageDTO.setStartRow(startRow);  
		pageDTO.setEndRow(endRow);
		
		return instructionDAO.getorderlist(pageDTO);
	}

	@Override
	public int getordercount(PageDTO pageDTO) {
		System.out.println("InstructionServiceImpl getordercount()");
		
		return instructionDAO.getordercount(pageDTO);
	}

	@Override
	public OrderDTO orderinfo(String order_cd) {
		System.out.println("InstructionServiceImpl orderinfo()");
		
		return instructionDAO.orderinfo(order_cd);
	}

	@Override
	public List<InstructionDTO> instructionlist(PageDTO pageDTO) {
		System.out.println("InstructionServiceImpl instructionlist()");

		return instructionDAO.instructionlist(pageDTO);
	}

	@Override
	public int getinstructioncount(PageDTO pageDTO) {
		System.out.println("InstructionServiceImpl getinstructioncount()");
		
		return instructionDAO.getinstructioncount(pageDTO);
	}

	@Override
	public void instinsertpro(InstructionDTO instructionDTO) {
		System.out.println("InstructionServiceImpl instinsertpro()");
		
		instructionDAO.instinsertpro(instructionDTO);
		
	}

	@Override
	public InstructionDTO instructioninfo(String instruction_code) {
		System.out.println("InstructionServiceImpl instructioninfo()");
		
		return instructionDAO.instructioninfo(instruction_code);
	}

	@Override
	public List<Map<String, Object>> conslist(String order_cd) {
		System.out.println("InstructionServiceImpl instructioninfo()");
		
		return instructionDAO.conslist(order_cd);
	}

	@Override
	public List<Map<String, Object>> getInstMap() {
		System.out.println("InstructionServiceImpl getInstMap()");
		
		return instructionDAO.getInstMap();
	}

	@Override
	public Map<String, Object> getInst(String instruction_code) {
		System.out.println("InstructionServiceImpl getInst()");
		
		return instructionDAO.getInst(instruction_code);
	}

	@Override
	public void instupdatepro(InstructionDTO instructionDTO) {
		System.out.println("InstructionServiceImpl instupdatepro()");
		
		instructionDAO.instupdatepro(instructionDTO);
		
	}

	@Override
	public int getordercheck(String order_cd) {
		System.out.println("InstructionServiceImpl getordercheck()");
		
		return instructionDAO.getordercheck(order_cd);
	}

	@Override
	public List<Map<String, Object>> getOrderListMap(PageDTO pageDTO) {
		System.out.println("InstructionServiceImpl getOrderListMap()");
		

		int startRow=(pageDTO.getCurrentPage()-1)*pageDTO.getPageSize()+1;
		int endRow = startRow + pageDTO.getPageSize()-1;
		
		pageDTO.setStartRow(startRow);  
		pageDTO.setEndRow(endRow);
		
		return instructionDAO.getOrderListMap(pageDTO);
	}

	@Override
	public void instdelete(String instruction_code) {
		System.out.println("InstructionServiceImpl instdelete()");
		
		instructionDAO.instdelete(instruction_code);
		
	}

	@Override
	public void updateCon2(String cd) {
		System.out.println("InstructionServiceImpl updateCon2 생산중으로");

		instructionDAO.updateCon2(cd);
	}

	@Override
	public List<Map<String, Object>> getConsListMap(String instruction_code) {
		System.out.println("InstructionServiceImpl getConsListMap()");
		
		return instructionDAO.getConsListMap(instruction_code);
	}

	@Override
	public void updateCon3(String cd) {
		System.out.println("InstructionServiceImpl updateCon3 생산완료로");
		instructionDAO.updateCon3(cd);
	}

	@Override
	public String getInstDate(String instruction_code) {
		System.out.println("InstructionServiceImpl getInstDate()");
		
		return instructionDAO.getInstDate(instruction_code);
	}

	@Override
	public int getInstCount(String instruction_code) {
		System.out.println("InstructionServiceImpl getInstCount()");
		
		return instructionDAO.getInstCount(instruction_code);
	}

	@Override
	public String getInstCdname(String instruction_code) {
		System.out.println("InstructionServiceImpl getInstCdname()");
		
		return instructionDAO.getInstCdname(instruction_code);
	}

	@Override
	public String getInstPch(String product_cd_name) {
		System.out.println("InstructionServiceImpl getInstPch()");
		
		return instructionDAO.getInstPch(product_cd_name);
	}

	@Override
	public String getWh_cd(String product_cd_name) {
		System.out.println("InstructionServiceImpl getWh_cd()");
		
		return instructionDAO.getWh_cd(product_cd_name);
	}

	@Override
	public List<String> getcountcons(String cdname) {
		System.out.println("InstructionServiceImpl getcountcons()");
		
		return instructionDAO.getcountcons(cdname);
	}

	@Override
	public String getRel_schedule_cd() {
		System.out.println("InstructionServiceImpl getRel_schedule_cd()");
		
		return instructionDAO.getRel_schedule_cd();
	}

	@Override
	public ConsumptionDTO getConsumption(ConsumptionDTO consumptionDTO) {
		System.out.println("InstructionServiceImpl getConsumption()");
		
		return instructionDAO.getConsumption(consumptionDTO);
	}

	@Override
	public List<Map<String, Object>> getStockCheck(String order_cd) {
		System.out.println("InstructionServiceImpl getStockCheck()");

		return instructionDAO.getStockCheck(order_cd);
	}

	@Override
	public Map<String, Object> getInstInfoMap(String instruction_code) {
		System.out.println("InstructionServiceImpl getInstInfoMap()");

		return instructionDAO.getInstInfoMap(instruction_code);
	}

	@Override
	public List<LineDTO> getLine_cd() {
		System.out.println("InstructionServiceImpl getLine_cd()");
	
		return instructionDAO.getLine_cd();
	}

	@Override
	public void setlineState(String line_cd) {
		System.out.println("InstructionServiceImpl setlineState()");
		
		instructionDAO.setlineState(line_cd);
	}

	@Override
	public String getLine_cdInst(String instruction_code) {
		System.out.println("InstructionServiceImpl getLine_cdInst()");
		
		return instructionDAO.getLine_cdInst(instruction_code);
	}
	
	@Override
	public void setlineState2(String line_cd) {
		System.out.println("InstructionServiceImpl setlineState2()");
		
		instructionDAO.setlineState2(line_cd);
	}
	
	


	
}	

