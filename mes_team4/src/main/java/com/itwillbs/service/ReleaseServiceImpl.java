package com.itwillbs.service;

import java.security.KeyStore.Entry.Attribute;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.itwillbs.dao.ReleaseDAO;
import com.itwillbs.domain.PageDTO;
import com.itwillbs.domain.ReceiveDTO;
import com.itwillbs.domain.ReleaseDTO;
import com.itwillbs.domain.WHDTO;

@Service
public class ReleaseServiceImpl implements ReleaseService{
	
	@Inject
	private ReleaseDAO releaseDAO;
	
	@Override
	public void insertrel(ReleaseDTO releaseDTO) {
		System.out.println("ReleaseServiceImpl insertrel()");
		
		Date now = new Date();
	    SimpleDateFormat dateFormat = new SimpleDateFormat("yyMMddHHmmss");
	    String result = dateFormat.format(now);
	    System.out.println(result);
	    releaseDTO.setRel_schedule_cd("L" + result);
	    releaseDTO.setReleased("미출고");
		
		
		releaseDAO.insertrel(releaseDTO);
	}
	
	
	@Override
	public int getRelCount(PageDTO pageDTO) {
		System.out.println("ReleaseServiceImpl getRelList()");
		
		return releaseDAO.getRelCount(pageDTO);
	}

	@Override
	public List<Map<String, Object>> getRelList(PageDTO pageDTO) {
		System.out.println("ReleaseServiceImpl getRelList()");
		// 시작하는 행번호 구하기
		int startRow=(pageDTO.getCurrentPage()-1)*pageDTO.getPageSize()+1;
		int endRow= startRow+pageDTO.getPageSize()-1;
		
		pageDTO.setStartRow(startRow);
		pageDTO.setEndRow(endRow);
		
		return releaseDAO.getRelList(pageDTO);
	}




	@Override
	public ReleaseDTO getrel(String rel_schedule_cd) {
		System.out.println("ReleaseServiceImpl getrel()");
		
		return releaseDAO.getrel(rel_schedule_cd);
	}


	@Override
	public void updaterel(ReleaseDTO releaseDTO) {
		System.out.println("ReleaseServiceImpl updaterel()");
		
		 Date now = new Date();
		    if (now.after(releaseDTO.getRel_date())) {
		      releaseDTO.setReleased("출고완료");
		    } else {
		      releaseDTO.setReleased("미출고");
		    } 
		    
		releaseDAO.updaterel(releaseDTO);
	}


	@Override
	public void deleterel(String rel_schedule_cd) {
		System.out.println("ReleaseServiceImpl deleterel()");
		
		releaseDAO.deleterel(rel_schedule_cd);
		
	}


	@Override
	public String getRel_cd() {
		System.out.println("ReleaseServiceImpl getRel_cd()");
		
		return releaseDAO.getRel_cd();
	}


	@Override
	public Map<String, Object> getrec(ReleaseDTO releaseDTO) {
		System.out.println("ReleaseServiceImpl getrec()");
		return releaseDAO.getrec(releaseDTO);
	}


	@Override
	public void finishrel(String rel_schedule_cd) {
		System.out.println("ReleaseServiceImpl finishrel()");
		
		releaseDAO.finishrel(rel_schedule_cd);
		
	}


	@Override
	public int getbfRel_count(ReleaseDTO releaseDTO) {
		System.out.println("ReleaseServiceImpl getbfRel_count()");
		
		return releaseDAO.getbfRel_count(releaseDTO);
	}


	@Override
	public String getProduct_cd_name2(String rel_schedule_cd) {
		System.out.println("ReleaseServiceImpl getProduct_cd_name2()");
		
		return releaseDAO.getProduct_cd_name2(rel_schedule_cd);
	}


	@Override
	public void insertrel2(ReleaseDTO releaseDTO) {
		System.out.println("ReleaseServiceImpl insertrel2()");

		LocalDate now = LocalDate.now();
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyMMdd");
		String today = now.format(formatter);
			
		if(releaseDAO.getLNum()==null) {
			//출고품목 없음
			releaseDTO.setRel_schedule_cd("L"+today+"100");
		}else{
			//출고품목 => max(num)+1
			System.out.println("LNum 출력 : "+releaseDAO.getLNum());
			int num = releaseDAO.getLNum()+1;
			String str = "L"+num;
			
			releaseDTO.setRel_schedule_cd(str);
		}
		
		
		releaseDAO.insertrel2(releaseDTO);		
	}


	@Override
	public List<Map<String, Object>> getReceiveSList(PageDTO pageDTO) {
		System.out.println("ReleaseServiceImpl getReceiveSList()");
		
		int startRow=(pageDTO.getCurrentPage()-1)*pageDTO.getPageSize()+1;
		int endRow = startRow+pageDTO.getPageSize()-1;
			
		pageDTO.setStartRow(startRow);
		pageDTO.setEndRow(endRow);
			
		return releaseDAO.getReceiveSList(pageDTO);
	}


}
