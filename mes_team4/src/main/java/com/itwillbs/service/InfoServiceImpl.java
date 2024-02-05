package com.itwillbs.service;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.itwillbs.dao.InfoDAO;
import com.itwillbs.domain.LineDTO;
import com.itwillbs.domain.PageDTO;

@Service
public class InfoServiceImpl implements InfoService{

	// 객체생성 부모 인터페이스 => 자동으로 자식 클래스 객체생성
		@Inject
		private InfoDAO infoDAO;

		@Override
		public List<LineDTO> getLineList(PageDTO pageDTO) {
			System.out.println("InfoServiceImpl getLineList()");
			//시작하는 행번호 구하기
			int startRow=(pageDTO.getCurrentPage()-1)*pageDTO.getPageSize()+1;
			int endRow = startRow+pageDTO.getPageSize()-1;
			
			pageDTO.setStartRow(startRow);
			pageDTO.setEndRow(endRow);
			
			return infoDAO.getLineList(pageDTO);
		}		

		@Override
		public int getLineCount(PageDTO pageDTO) {
			System.out.println("InfoServiceImpl getLineCount()");
			
			return infoDAO.getLineCount(pageDTO);
		}

		@Override
		public void insertLine(LineDTO lineDTO) {
			System.out.println("InfoServiceImpl insertLine()");
			
			infoDAO.insertLine(lineDTO);			
		}

		@Override
		public LineDTO getLine(String line_cd) {
			System.out.println("InfoServiceImpl getLine()");
			
			return infoDAO.getLine(line_cd);
		}

		@Override
		public void updateLine(LineDTO lineDTO) {
			System.out.println("InfoServiceImpl updateLine()");
			
			infoDAO.updateLine(lineDTO);
		}

		@Override
		public void deleteLine(String line_cd) {
			System.out.println("InfoServiceImpl deleteLine()");
			
			infoDAO.deleteLine(line_cd);
		}

		@Override
		public int getlinecdcheck(String line_cd) {
			System.out.println("InfoServiceImpl getlinecdcheck()");
			
			return infoDAO.getlinecdcheck(line_cd);
		}

}
