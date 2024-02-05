package com.itwillbs.dao;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.itwillbs.domain.MemberDTO;
import com.itwillbs.domain.PageDTO;
import com.itwillbs.domain.WHDTO;

@Repository
public class WHDAOImpl implements WHDAO{
	
	@Inject
	private SqlSession sqlSession;
	
	private static final String namespace="com.itwillbs.mappers.whMapper";
	
	@Override
	public void insertwh(WHDTO whdto) {
		System.out.println("WHDAOImpl insertwh()");
		
		sqlSession.insert(namespace+".insertwh", whdto);
		
	}

	@Override
	public Integer getMaxNum() {
		System.out.println("WHDAOImpl getMaxNum()");
		return sqlSession.selectOne(namespace+".getMaxNum");
	}


	@Override
	public List<WHDTO> getWhList(PageDTO pageDTO) {
		System.out.println("WHDAOImpl getWhList()");
		// limit #{startRow -1} , #{pageSize} 
		//        1-1, 10 => 1~10
		pageDTO.setStartRow(pageDTO.getStartRow()-1);
		
		return sqlSession.selectList(namespace+".getWhList", pageDTO);
	}

	@Override
	public int getWhCount(PageDTO pageDTO) {
		System.out.println("WHDAOImpl getWhCount()");
		
		return sqlSession.selectOne(namespace+".getWhCount",pageDTO);
	}
	


	@Override
	public Integer getMNum() {
		System.out.println("WHDAOImpl getMNum()");
		
		return sqlSession.selectOne(namespace+".getMNum");
	}

	@Override
	public Integer getPNum() {
		System.out.println("WHDAOImpl getPNum()");
		
		return sqlSession.selectOne(namespace+".getPNum");
	}

	@Override
	public void deletewh(String wh_cd) {
		System.out.println("WHDAOImpl deletewh()");
		
		sqlSession.delete(namespace+".deletewh", wh_cd);
		
	}

	@Override
	public WHDTO getwh(String wh_cd) {
		System.out.println("WHDAOImpl getwh()");
		
		return sqlSession.selectOne(namespace+".getwh",wh_cd);
	}

	@Override
	public void updatewh(WHDTO whDTO) {
		System.out.println("WHDAOImpl updatewh()");
		
		sqlSession.update(namespace+".updatewh", whDTO);
	}

	@Override
	public int getwhcheck(String wh_name) {
		System.out.println("WHDAOImpl getwhcheck()");
		
		return sqlSession.selectOne(namespace+".getwhcheck",wh_name);
	}

	







	



	
}
