package com.itwillbs.service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.itwillbs.dao.WHDAO;
import com.itwillbs.domain.PageDTO;
import com.itwillbs.domain.WHDTO;


@Service
public class WHServiceImpl implements WHService{
	
	@Inject
	private WHDAO whDAO;
	
	@Override
	public void insertwh(WHDTO whDTO) {
		System.out.println("WHServiceImpl insertwh()");
		
		Date now = new Date();
		SimpleDateFormat dateFormat = new SimpleDateFormat ( "HHmmss");                                
		String result = dateFormat.format(now);
		
		if(whDTO.getWh_dv().equals("원자재")) {
			whDTO.setWh_cd("M"+result);
		}else {
			whDTO.setWh_cd("P"+result);
		}
		
		whDAO.insertwh(whDTO);
		
	}

	@Override
	public List<WHDTO> getWhList(PageDTO pageDTO) {
		System.out.println("WHServiceImpl getWhList()");
		//시작하는 행번호 구하기
		int startRow=(pageDTO.getCurrentPage()-1)*pageDTO.getPageSize()+1;
		int endRow = startRow+pageDTO.getPageSize()-1;
			
			pageDTO.setStartRow(startRow);
			pageDTO.setEndRow(endRow);
			
			return whDAO.getWhList(pageDTO);
	}

	@Override
	public int getWhCount(PageDTO pageDTO) {
		System.out.println("WHServiceImpl getWhCount()");
		
		return whDAO.getWhCount(pageDTO);
	}

	


	@Override
	public void deletewh(String wh_cd) {
		System.out.println("WHServiceImpl deletewh()");
		
		whDAO.deletewh(wh_cd);
	}

	@Override
	public WHDTO getwh(String wh_cd) {
		System.out.println("WHServiceImpl getwh()");
		
		return whDAO.getwh(wh_cd);
	}

	@Override
	public void updatewh(WHDTO whDTO) {
		System.out.println("WHServiceImpl updatewh()");
		
		whDAO.updatewh(whDTO);
	}

	@Override
	public int getwhcheck(String wh_name) {
		System.out.println("WHServiceImpl updatewh()");
		
		return whDAO.getwhcheck(wh_name);
	}


	

	



}
