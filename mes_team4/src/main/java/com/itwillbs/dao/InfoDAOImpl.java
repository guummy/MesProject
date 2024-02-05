package com.itwillbs.dao;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.itwillbs.domain.LineDTO;
import com.itwillbs.domain.PageDTO;

@Repository
public class InfoDAOImpl implements InfoDAO {

	//마이바티스 자동 객체생성
		@Inject
		private SqlSession sqlSession;
		
		// sql구문 전체 이름 정의
		private static final String namespace="com.itwillbs.mappers.InfoMapper";

		@Override
		public List<LineDTO> getLineList(PageDTO pageDTO) {
			System.out.println("InfoDAOImpl getLineList()");
			// limit #{startRow -1} , #{pageSize} 
			//        1-1, 10 => 1~10
			pageDTO.setStartRow(pageDTO.getStartRow()-1);
			
			return sqlSession.selectList(namespace+".getLineList", pageDTO);
		}		

		@Override
		public int getLineCount(PageDTO pageDTO) {
			System.out.println("InfoDAOImpl getLineCount()");
			
			return sqlSession.selectOne(namespace+".getLineCount", pageDTO);
		}

		@Override
		public void insertLine(LineDTO lineDTO) {
			System.out.println("InfoDAOImpl insertLine()");
			
			sqlSession.insert(namespace+".insertLine", lineDTO);			
		}

		@Override
		public LineDTO getLine(String line_cd) {
			System.out.println("InfoDAOImpl getLine()");
			
			return sqlSession.selectOne(namespace+".getLine", line_cd);
		}

		@Override
		public void updateLine(LineDTO lineDTO) {
			System.out.println("InfoDAOImpl updateLine()");
			
			sqlSession.update(namespace+".updateLine", lineDTO);
		}

		@Override
		public void deleteLine(String line_cd) {
			System.out.println("InfoDAOImpl deleteLine()");
			
			sqlSession.delete(namespace+".deleteLine", line_cd);
		}

		@Override
		public int getlinecdcheck(String line_cd) {
			System.out.println("InfoDAOImpl getlinecdcheck()");
			
			return sqlSession.selectOne(namespace+".getlinecdcheck", line_cd);
		}

}
