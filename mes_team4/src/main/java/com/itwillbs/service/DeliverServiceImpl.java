package com.itwillbs.service;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.itwillbs.dao.DeliverDAO;
import com.itwillbs.domain.DeliverDTO;
import com.itwillbs.domain.PageDTO;
import com.itwillbs.domain.ReleaseDTO;

@Service
public class DeliverServiceImpl implements DeliverService{
	
	//객체생성 부모 인터페이스 -> 자동으로 자식 클래스 객체생성
	@Inject
	private DeliverDAO deliverDAO;

	
	@Override
	public List<DeliverDTO> getDeliverList(PageDTO pageDTO) {
		System.out.println("DeliverServiceImpl getDeliverList()");
		//startRow endRow 구하기
		// 시작하는 행번호 구하기
		int startRow =(pageDTO.getCurrentPage()-1)*pageDTO.getPageSize()+1;
		int endRow = startRow+pageDTO.getPageSize()-1;
		
		pageDTO.setStartRow(startRow);
		pageDTO.setEndPage(endRow);
		
		return deliverDAO.getDeliverList(pageDTO);
	}
	
	
	
	@Override
	public void insertDeliver(DeliverDTO deliverDTO) {
		System.out.println("DeliverServiceImpl insertDeliver()");
		
		//메소드 호출
	 deliverDAO.insertDeliver(deliverDTO);
	}




	@Override
	public DeliverDTO getDeliver(DeliverDTO deliverDTO) {
		System.out.println("DeliverServiceImpl getDeliver()");
		
		return deliverDAO.getDeliver(deliverDTO);
	}


	@Override
	public void updateDeliver(DeliverDTO deliverDTO) {
		System.out.println("DeliverServiceImpl updateDeliver()");
		
		deliverDAO.updateDeliver(deliverDTO);
	}



	@Override
	public int getDeliverCount(PageDTO pageDTO) {
		System.out.println("DeliverServiceImpl getDeliverCount()");
		return deliverDAO.getDeliverCount(pageDTO);
	}



	@Override
	public void deleteDeliver(String checkValue) {
		System.out.println("DeliverServiceImpl deleteDeliver()");
		
		deliverDAO.deleteDeliver(checkValue);
		
	}



	@Override
	public List<Map<String, Object>> getInstMap() {
		System.out.println("DeliverServiceImpl getInstMap()");

		
		return deliverDAO.getInstMap();
	}



	@Override
	public List<Map<String, Object>> getInstMap2() {
		System.out.println("DeliverServiceImpl getInstMap2()");
		
		return deliverDAO.getInstMap2();
	}



	@Override
	public List<Map<String, Object>> getInstMap3() {
		System.out.println("DeliverServiceImpl getInstMap3()");
		return deliverDAO.getInstMap3();
	}



	@Override
	public String getDeliver_cd() {
		System.out.println("DeliverServiceImpl getDeliver_cd()");

		return deliverDAO.getDeliver_cd();
	}



	@Override
	public List<Map<String, Object>> getRelList2(PageDTO pageDTO) {
		System.out.println("DeliverServiceImpl getRelList2()");
		// 시작하는 행번호 구하기
		int startRow=(pageDTO.getCurrentPage()-1)*pageDTO.getPageSize()+1;
		int endRow= startRow+pageDTO.getPageSize()-1;
				
		pageDTO.setStartRow(startRow);
		pageDTO.setEndRow(endRow);
		
		return deliverDAO.getRelList2(pageDTO);
	}

	@Override
	public int getRelCount(PageDTO pageDTO) {
		System.out.println("DeliverServiceImpl getRelCount()");
		
		return deliverDAO.getRelCount(pageDTO);
	}



	@Override
	public int getinstcheck(String order_cd) {
		System.out.println("DeliverServiceImpl getinstcheck()");
		return deliverDAO.getinstcheck(order_cd);
	}



	@Override
	public ReleaseDTO getreldat(String order_cd) {
		System.out.println("DeliverServiceImpl getreldat()");
		

		return deliverDAO.getreldat(order_cd);
	}


	
	
	

	

}
