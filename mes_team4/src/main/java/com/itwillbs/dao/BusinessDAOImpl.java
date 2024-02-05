package com.itwillbs.dao;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.itwillbs.domain.BusinessDTO;
import com.itwillbs.domain.PageDTO;

@Repository
public class BusinessDAOImpl implements BusinessDAO{
	
	@Inject
	private SqlSession sqlSession;
	private static final String namespace="com.itwillbs.mappers.BusinessMapper";

	@Override
	public void insertBusiness(BusinessDTO businessDTO) {
		System.out.println("businessDAOImpl insertBusiness()");
		
		sqlSession.insert(namespace+".insertBusiness", businessDTO);
	}
	
	@Override
	public Integer getONum() {
		System.out.println("BusinessDAOImpl getONum()");
		
		return sqlSession.selectOne(namespace+".getONum");
	}
	
	@Override
	public Integer getPNum() {
		System.out.println("BusinessDAOImpl getPNum()");
		
		return sqlSession.selectOne(namespace+".getPNum");
	}

	@Override
	public int getBusinessCount(PageDTO pageDTO) {
		System.out.println("businessDAOImpl getcount()");
		
		return sqlSession.selectOne(namespace+".getBusinessCount",pageDTO);
	}

	@Override
	public List<BusinessDTO> getBusinessList(PageDTO pageDTO) {
		System.out.println("BusinessDAOImpl getBusinessList()");
		
		pageDTO.setStartRow(pageDTO.getStartRow()-1);
		
		return sqlSession.selectList(namespace+".getBusinessList",pageDTO);
	}

	@Override
	public void deleteBusiness(String cd) {
		System.out.println("businessDAOImpl deleteBusiness()");
		
		sqlSession.delete(namespace+".deleteBusiness",cd);
	}

	@Override
	public BusinessDTO getBusiness(String cd) {
		System.out.println("BusinessDAOImpl getBusiness()");
		
		return sqlSession.selectOne(namespace+".getBusiness", cd);
	}

	@Override
	public void updateBusiness(BusinessDTO businessDTO) {
		System.out.println("BusinessDAOImpl updateBusiness()");
		System.out.println("업뎃중!!"+businessDTO.getBusiness_name());
		System.out.println("code : "+businessDTO.getBusiness_cd());
		sqlSession.update(namespace+".updateBusiness", businessDTO);		
	}

	@Override
	public List<BusinessDTO> getBusinessList() {
		System.out.println("BusinessDAOImpl getBusinessList()");
		return sqlSession.selectList(namespace+".getBusiListforor");
	}

	@Override
	public Integer getCon(String cd) {
		System.out.println("BusinessDAOImpl getCon()");
		System.out.println("cd이름 : "+cd);
		return sqlSession.selectOne(namespace+".getCon",cd);
	}

	@Override
	public List<BusinessDTO> getBusinessList2() {
		System.out.println("BusinessDAOImpl getBusinessList2()");
		return sqlSession.selectList(namespace+".getBusinessList2");
	}

}
