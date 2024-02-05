package com.itwillbs.service;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.itwillbs.dao.PerformDAO;
import com.itwillbs.domain.LineDTO;
import com.itwillbs.domain.PageDTO;
import com.itwillbs.domain.PerformDTO;

@Service
public class PerformServiceImpl implements PerformService{

	// 객체생성 부모 인터페이스 => 자동으로 자식 클래스 객체생성
			@Inject
			private PerformDAO performDAO;

//			@Override
//			public List<PerformDTO> getPerformList(PageDTO pageDTO) {
//				System.out.println("PerformServiceImpl getPerformList()");
//				//시작하는 행번호 구하기
//				int startRow=(pageDTO.getCurrentPage()-1)*pageDTO.getPageSize()+1;
//				int endRow = startRow+pageDTO.getPageSize()-1;
//				
//				pageDTO.setStartRow(startRow);
//				pageDTO.setEndRow(endRow);
//				
//				return performDAO.getPerformList(pageDTO);
//			}
			
			@Override
			public int getPerformCount(PageDTO pageDTO) {
				System.out.println("PerformServiceImpl getPerformCount()");
				
				return performDAO.getPerformCount(pageDTO);
			}

			@Override
			public void insertPerform(PerformDTO performDTO) {
				System.out.println("PerformServiceImpl insertPerform()");
				
				performDAO.insertPerform(performDTO);
			}

//			@Override
//			public PerformDTO getPerform(String perform_cd) {
//				System.out.println("PerformServiceImpl getPerform()");
//
//				return performDAO.getPerform(perform_cd);
//			}

			@Override
			public void updatePerform(PerformDTO performDTO) {
				System.out.println("PerformServiceImpl updatePerform()");
				
				performDAO.updatePerform(performDTO);
			}

			@Override
			public void deletePerform(String perform_cd) {
				System.out.println("PerformServiceImpl deletePerform()");
				
				performDAO.deletePerform(perform_cd);
			}

			@Override
			public List<Map<String, Object>> getInstMap() {
				System.out.println("PerformServiceImpl getInstMap()");
				
				return performDAO.getInstMap();
			}

			@Override
			public List<Map<String, Object>> getPerformMap(PageDTO pageDTO) {
				System.out.println("PerformServiceImpl getPerformMap()");
				//시작하는 행번호 구하기
				int startRow=(pageDTO.getCurrentPage()-1)*pageDTO.getPageSize()+1;
				int endRow = startRow+pageDTO.getPageSize()-1;
				
				pageDTO.setStartRow(startRow);
				pageDTO.setEndRow(endRow);				
				
				return performDAO.getPerformMap(pageDTO);
			}

			@Override
			public Map<String, Object> getPerform(String perform_cd) {
				System.out.println("PerformServiceImpl getPerform()");
				
				return performDAO.getPerform(perform_cd);
			}

			@Override
			public Map<String, Object> getcallcdMap(String ic) {
				System.out.println("PerformServiceImpl getcallcdMap()");
				
				return performDAO.getcallcdMap(ic);
			}

			@Override
			public int getPerformCount2() {
				System.out.println("PerformServiceImpl getPerformCount2()");
				
				return performDAO.getPerformCount2();
			}

			@Override
			public String getPerform_cd() {
				System.out.println("PerformServiceImpl getPerform_cd()");
				
				return performDAO.getPerform_cd();
			}

			@Override
			public int getinstcheck(String instruction_code) {
				System.out.println("PerformServiceImpl getinstcheck()");
				
				return performDAO.getinstcheck(instruction_code);
			}

			@Override
			public int getinstructioncount2(PageDTO pageDTO) {
				System.out.println("PerformServiceImpl getinstructioncount2()");
				
				return performDAO.getinstructioncount2(pageDTO);
			}

			@Override
			public List<Map<String, Object>> getPerformMap3(PageDTO pageDTO) {
				System.out.println("PerformServiceImpl getPerformMap3()");
				//시작하는 행번호 구하기
				int startRow=(pageDTO.getCurrentPage()-1)*pageDTO.getPageSize()+1;
				int endRow = startRow+pageDTO.getPageSize()-1;
				
				pageDTO.setStartRow(startRow);
				pageDTO.setEndRow(endRow);				
				
				return performDAO.getPerformMap3(pageDTO);
			}

			@Override
			public int getPerformCount3(PageDTO pageDTO) {
				System.out.println("PerformServiceImpl getPerformCount3()");
				
				return performDAO.getPerformCount3(pageDTO);
			}
									
}
