package com.itwillbs.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;


import com.itwillbs.dao.SystemDAO;
import com.itwillbs.domain.PageDTO;
import com.itwillbs.domain.SystemDTO;

@Service
public class SystemServiceImpl implements SystemService{
	@Inject
	private SystemDAO systemDAO;

	@Override
	public void memberinsertpro(SystemDTO systemDTO) {
		System.out.println("SystemServiceImpl memberinsertpro()");
		if(systemDAO.getMaxEmp_no() == null) {
			//게시판 글 없음 = num =1
			systemDTO.setEmp_no(100000);
		}else {
			//게시판 글 있음 MaxNum()+1
			systemDTO.setEmp_no(systemDAO.getMaxEmp_no()+1);
		}
		
		systemDAO.memberinsertpro(systemDTO);
	}

	@Override
	public List<SystemDTO> getsystemlist(PageDTO pageDTO) {
		System.out.println("SystemServiceImpl getSystemList()");
		// 계산작업, 시작하는 행번호 구하기
		
		int startRow = (pageDTO.getCurrentPage()-1)*pageDTO.getPageSize()+1 ;
		int endRow = startRow + pageDTO.getPageSize() - 1;
		
		pageDTO.setStartRow(startRow);
		pageDTO.setEndRow(endRow);
		
		return systemDAO.getsystemlist(pageDTO);
	}

	@Override
	public int getsystemcount(PageDTO pageDTO) {
		System.out.println("SystemServiceImpl getsystemcount()");
		
		return systemDAO.getsystemcount(pageDTO);
	}

	@Override
	public SystemDTO memberinfo(int emp_no) {
		System.out.println("SystemServiceImpl memberinfo()");
		
		return systemDAO.memberinfo(emp_no);
	}

	@Override
	public void memberupdatepro(SystemDTO systemDTO) {
		System.out.println("SystemServiceImpl memberupdatepro()");
		
		systemDAO.memberupdatepro(systemDTO);
	}

	@Override
	public void memberdelete(int emp_no) {
		System.out.println("SystemServiceImpl memberdelete()");
		
		systemDAO.memberdelete(emp_no);
		
	}

	@Override
	public SystemDTO userCheck(SystemDTO systemDTO) {
		System.out.println("SystemServiceImpl userCheck()");
		
		return systemDAO.userCheck(systemDTO);
	}

	@Override
	public void mypagePro(SystemDTO systemDTO) {
		System.out.println("systemserviceImpl mypagePro");
	
		systemDAO.mypagePro(systemDTO);
	}

	@Override
	public List<SystemDTO> getMemberList() {
		System.out.println("systemserviceImpl getmemberlist()");

		return systemDAO.getMemberList();
	}


	
	
	
}
