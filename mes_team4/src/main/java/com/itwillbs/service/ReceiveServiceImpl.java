package com.itwillbs.service;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.itwillbs.dao.ReceiveDAO;
import com.itwillbs.domain.PageDTO;
import com.itwillbs.domain.PerformDTO;
import com.itwillbs.domain.PurchaseDTO;
import com.itwillbs.domain.ReceiveDTO;
import com.itwillbs.domain.StockDTO;

@Service
public class ReceiveServiceImpl implements ReceiveService{

	@Inject
	private ReceiveDAO receiveDAO;
	
	@Override
	public void insertReceive(ReceiveDTO receiveDTO) {
		System.out.println("insertReceive()");
		
		LocalDate now = LocalDate.now();
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyMMdd");
		String today = now.format(formatter);
			
		if(receiveDAO.getRECNum(today)==null) {
			//출고품목 없음
			receiveDTO.setRec_schedule_cd("REC"+today+"01");
		}else{
			//출고품목 => max(num)+1
		    int num = receiveDAO.getRECNum(today) + 1;
		    String new_num = String.format("%02d", num);
		    String str = "REC" + today + new_num;
			
			receiveDTO.setRec_schedule_cd(str);
		}
		receiveDAO.insertReceive(receiveDTO);
	}
	
	@Override
	public List<ReceiveDTO> getReceiveList(PageDTO pageDTO) {
		
		int startRow=(pageDTO.getCurrentPage()-1)*pageDTO.getPageSize()+1;
		int endRow = startRow+pageDTO.getPageSize()-1;
			
			pageDTO.setStartRow(startRow);
			pageDTO.setEndRow(endRow);
			
			return receiveDAO.getReciveList(pageDTO);
	}

	@Override
	public ReceiveDTO getPch_cd(String pch) {
		
			return receiveDAO.getPch_cd(pch);
	}
	
	@Override
	public int getReceiveCount(PageDTO pageDTO) {
		return receiveDAO.getReceiveCount(pageDTO);
	}

	@Override
	public ReceiveDTO getReceive(String rec_schedule_cd) {
		System.out.println("ReceiveServiceImpl getReceive()");
		
		return receiveDAO.getReceive(rec_schedule_cd);
	}

	@Override
	public void updateReceive(ReceiveDTO receiveDTO) {
		System.out.println("updateReceive()");
		
		receiveDAO.updateReceive(receiveDTO);
	}

	@Override
	public void deleteReceive(String rec_schedule_cd) {
		System.out.println("ReceiveServiceImpl deleteReceive()");
		
		receiveDAO.deleteReceive(rec_schedule_cd);
	}

	@Override
	public void updateStockcount(StockDTO stockDTO) {
		System.out.println("ReceiveServiceImpl updateStockcount()");
		
		receiveDAO.updateStockcount(stockDTO);
	}

	@Override
	public int getStock_count(String product_cd_name) {
		System.out.println("ReceiveServiceImpl getStock_count()");
		
		return receiveDAO.getStock_count(product_cd_name);
	}

	@Override
	public ReceiveDTO getbfRec_count(ReceiveDTO receiveDTO) {
		System.out.println("ReceiveServiceImpl getbfRec_count()");
		
		return receiveDAO.getbfRec_count(receiveDTO);
	}

	@Override
	public String getProduct_cd_name2(String rec_schedule_cd) {
		System.out.println("ReceiveServiceImpl getProduct_cd_name2()");
		
		return receiveDAO.getProduct_cd_name2(rec_schedule_cd);
	}

	@Override
	public String getPchor_cd(String rec_schedule_cd) {
		System.out.println("ReceiveServiceImpl getPchor_cd()");
		
		return receiveDAO.getPchor_cd(rec_schedule_cd);
	}

	@Override
	public int getSumRelCount(String pchor_cd) {
		System.out.println("ReceiveServiceImpl getSumRelCount()");
		
		return receiveDAO.getSumRelCount(pchor_cd);
	}

	@Override
	public int getRel_count(String pchor_cd) {
		System.out.println("ReceiveServiceImpl getRel_count()");
		
		return receiveDAO.getRel_count(pchor_cd);
	}

	@Override
	public int getpurcheck(String purchase_cd) {
		System.out.println("ReceiveServiceImpl getpurcheck()");
		
		return receiveDAO.getpurcheck(purchase_cd);
	}

	@Override
	public int getperformcheck(String order_cd) {
		System.out.println("ReceiveServiceImpl getperformcheck()");
		
		return receiveDAO.getperformcheck(order_cd);
	}

	@Override
	public String dvcheck(String product_cd_name) {
		System.out.println("ReceiveServiceImpl dvcheck()");
		
		return receiveDAO.dvcheck(product_cd_name);
	}

	@Override
	public PerformDTO getPerform_date(String inst) {
		System.out.println("ReceiveServiceImpl getPerform_date()");
		
		return receiveDAO.getPerform_date(inst);
	}

	@Override
	public String getInst(String pchor_cd) {
		System.out.println("ReceiveServiceImpl getInst()");
		
		return receiveDAO.getInst(pchor_cd);
	}

	@Override
	public PurchaseDTO getPurchase_date(String pchor_cd) {
		System.out.println("ReceiveServiceImpl getPurchase_date()");
		
		return receiveDAO.getPurchase_date(pchor_cd);
	}


}