package com.itwillbs.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.itwillbs.dao.BusinessDAO;
import com.itwillbs.domain.BusinessDTO;
import com.itwillbs.domain.PageDTO;


@Service
public class BusinessServiceImpl implements BusinessService{

	


	@Inject
	private BusinessDAO businessDAO;
	
	@Override
	public void insertBusiness(BusinessDTO businessDTO) {
		System.out.println("BusinessServiceImpl insertbusiness()");
		
//		만약 수주이면 O넘 찾고, 발주이면 P넘 찾음 
		if(businessDTO.getBusiness_dv().equals("수주")) {
			System.out.println(businessDTO.getBusiness_dv());
			
			if(businessDAO.getONum()==null) {
				//수주거래처 없음
				businessDTO.setBusiness_cd("O100");
			}else{
				//수주 거래처 있음 => max(num)+1
				System.out.println("onum 출력 : "+businessDAO.getONum());
				int num = businessDAO.getONum()+1;
				String str = "O" + num;
				businessDTO.setBusiness_cd(str);
			}
		} else if(businessDTO.getBusiness_dv().equals("발주")) {
			if(businessDAO.getPNum() == null) {
				businessDTO.setBusiness_cd("P100");
			}else{
				int num = businessDAO.getPNum()+1;
				String str = "P" + num;
				businessDTO.setBusiness_cd(str);
			}
		}
		businessDAO.insertBusiness(businessDTO);
	}

	@Override
	public int getBusinessCount(PageDTO pageDTO) {
		System.out.println("BusinessServiceImpl getBusinessCount()");
		
		return businessDAO.getBusinessCount(pageDTO);
	}

	@Override
	public List<BusinessDTO> getBusinessList(PageDTO pageDTO) {
		System.out.println("BusinessServiceImpl getBusinessList()");
		//시작하는 행번호 구하기
		int startRow=(pageDTO.getCurrentPage()-1)*pageDTO.getPageSize()+1;
		int endRow = startRow+pageDTO.getPageSize()-1;
			
			pageDTO.setStartRow(startRow);
			pageDTO.setEndRow(endRow);
		
		return businessDAO.getBusinessList(pageDTO);
	}
	
	@Override
	public List<BusinessDTO> getBusinessList() {
		System.out.println("BusinessServiceImpl getBusinessList()");
		return businessDAO.getBusinessList();
	}

	@Override
	public void deleteBusiness(String cd) {
		System.out.println("BusinessServiceImpl deleteBusiness()");
		System.out.println("delete code값 : " +cd);
		businessDAO.deleteBusiness(cd);		
	}

	@Override
	public BusinessDTO getBusiness(String cd) {
		System.out.println("BusinessServiceImpl getBusiness()");

		return businessDAO.getBusiness(cd);
	}

	@Override
	public void updateBusiness(BusinessDTO businessDTO) {
		System.out.println("BusinessServiceImpl updateBusiness()");
		
		businessDAO.updateBusiness(businessDTO);
	}

	@Override
	public List<BusinessDTO> getBusinessList2() {
		System.out.println("BusinessServiceImpl getBusinessList2()");
		return businessDAO.getBusinessList2();
	}

	
	


}
