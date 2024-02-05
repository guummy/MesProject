package com.itwillbs.dao;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.itwillbs.domain.PageDTO;
import com.itwillbs.domain.ReceiveDTO;
import com.itwillbs.domain.ReleaseDTO;

@Repository
public class ReleaseDAOImpl implements ReleaseDAO {
	
	@Inject
	private SqlSession sqlSession;
	
	private static final String namespace="com.itwillbs.mappers.releaseMapper";
	
	@Override
	public int getRelCount(PageDTO pageDTO) {
		System.out.println("ReleaseDAOImpl getRelCount()");
		return sqlSession.selectOne(namespace+".getRelCount", pageDTO);
	}

	@Override
	public void insertrel(ReleaseDTO releaseDTO) {
		System.out.println("ReleaseDAOImpl insertrel()");
		
		sqlSession.insert(namespace+".insertrel", releaseDTO);
	}

	@Override
	public Integer getLNum() {
		System.out.println("ReleaseDAOImpl getLNum()");
		
		return sqlSession.selectOne(namespace+".getLNum");
	}

	@Override
	public List<Map<String, Object>> getInstMap() {
		System.out.println("ReleaseDAOImpl getInstMap()");
		
		return sqlSession.selectList(namespace+".getInstMap");
	}

	@Override
	public List<Map<String, Object>> getRelList(PageDTO pageDTO) {
		System.out.println("ReleaseDAOImpl getRelList()");
		
		pageDTO.setStartRow(pageDTO.getStartRow()-1);
		
		return sqlSession.selectList(namespace+".getRelList", pageDTO);
	}


	@Override
	public ReleaseDTO getrel(String rel_schedule_cd) {
		System.out.println("ReleaseDAOImpl updaterel()");
		
		return sqlSession.selectOne(namespace+".getrel",rel_schedule_cd);
	}

	@Override
	public void updaterel(ReleaseDTO releaseDTO) {
		System.out.println("ReleaseDAOImpl updaterel()");
		
		sqlSession.update(namespace+".updaterel", releaseDTO);
	}

	@Override
	public void deleterel(String rel_schedule_cd) {
		System.out.println("ReleaseDAOImpl deleterel()");
		
		sqlSession.delete(namespace+".deleterel",rel_schedule_cd);
		
	}

	@Override
	public String getRel_cd() {
		System.out.println("ReleaseDAOImpl getRel_cd()");
		
		return sqlSession.selectOne(namespace+".getRel_cd");
	}

	@Override
	public Map<String, Object> getrec(ReleaseDTO releaseDTO) {
		System.out.println("ReleaseDAOImpl getrec()");
		
		return sqlSession.selectOne(namespace+".getrec", releaseDTO);
	}

	@Override
	public void finishrel(String rel_schedule_cd) {
		System.out.println("ReleaseDAOImpl finishrel()");
		
		sqlSession.delete(namespace+".finishrel",rel_schedule_cd);
		
	}

	@Override
	public int getbfRel_count(ReleaseDTO releaseDTO) {
		System.out.println("ReleaseDAOImpl getbfRel_count()");
		
		return sqlSession.selectOne(namespace+".getbfRel_count", releaseDTO);
	}

	@Override
	public String getProduct_cd_name2(String rel_schedule_cd) {
		System.out.println("ReleaseDAOImpl getProduct_cd_name2()");
		
		return sqlSession.selectOne(namespace+".getProduct_cd_name2", rel_schedule_cd);
	}

	@Override
	public void insertrel2(ReleaseDTO releaseDTO) {
		System.out.println("ReleaseDAOImpl insertrel2()");
		
		sqlSession.insert(namespace+".insertrel2", releaseDTO);		
	}

	@Override
	public List<Map<String, Object>> getReceiveSList(PageDTO pageDTO) {
		System.out.println("ReleaseDAOImpl getReceiveSList()");
		
		pageDTO.setStartRow(pageDTO.getStartRow()-1);
		return sqlSession.selectList(namespace+".getReceiveSList", pageDTO);
	}





	

	

	}


