package com.itwillbs.dao;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.itwillbs.domain.DeliverDTO;
import com.itwillbs.domain.PageDTO;
import com.itwillbs.domain.ReleaseDTO;



@Repository
public class DeliverDAOImpl implements DeliverDAO  {

	//마이바티스 자동 객체 생성
	@Inject
	private SqlSession sqlSession;
	
	//sql구문 이름 정의
	private static final String namespace="com.itwillbs.mappers.deliverMapper";

	
	@Override
	public List<DeliverDTO> getDeliverList(PageDTO pageDTO) {
		System.out.println("DeliverDAOImpl getDeliverList()");
		// startRow -1
		
		pageDTO.setStartRow(pageDTO.getStartRow()-1);		
		
		return sqlSession.selectList(namespace+".getDeliverList",pageDTO);
	}
	
	@Override
	public void insertDeliver(DeliverDTO deliverDTO) {
		System.out.println("DeliverDAOImpl insertDeliver()");
		
		sqlSession.insert(namespace+".insertDeliver", deliverDTO);
	}

	@Override
	public DeliverDTO getDeliver(DeliverDTO deliverDTO) {
		System.out.println("DeliverDAOImpl getDeliver()");
		
		return sqlSession.selectOne(namespace+".getDeliver", deliverDTO);
	}

	
	@Override
	public void updateDeliver(DeliverDTO deliverDTO) {
		System.out.println("DeliverDAOImpl updateDeliver()");
		System.out.println(deliverDTO.getDeliver_cd());
	//	System.out.println(deliverDTO.getDeliver_cd());
		
		sqlSession.update(namespace+".updateDeliver", deliverDTO);
		
		
	}

	@Override
	public int getDeliverCount(PageDTO pageDTO) {
		System.out.println("DeliverDAOImpl getDeliverCount()");
		
		return sqlSession.selectOne(namespace+".getDeliverCount", pageDTO);
	}

	@Override
	public void deleteDeliver(String deliver_cd) {
		System.out.println("DeliverDAOImpl deleteDeliver()");
		
		sqlSession.delete(namespace+".deleteDeliver", deliver_cd);
		
	}

	@Override
	public List<Map<String, Object>> getInstMap() {
		System.out.println("DeliverDAOImpl getInstMap()");
		
		
		return sqlSession.selectList(namespace+".getInstMap");
	}

	@Override
	public List<Map<String, Object>> getInstMap2() {
		System.out.println("DeliverDAOImpl getInstMap2()");
		
		
		return sqlSession.selectList(namespace+".getInstMap2");
	}

	@Override
	public List<Map<String, Object>> getInstMap3() {
		System.out.println("DeliverDAOImpl getInstMap2()");
		
		return sqlSession.selectList(namespace+".getInstMap3");
	}

	@Override
	public String getDeliver_cd() {
		System.out.println("DeliverDAOImpl getDeliver_cd()");

		return sqlSession.selectOne(namespace+".getDeliver_cd");
	}

	@Override
	public List<Map<String, Object>> getRelList2(PageDTO pageDTO) {
		System.out.println("DeliverDAOImpl getRelList2()");
		
		pageDTO.setStartRow(pageDTO.getStartRow()-1);
		
		return sqlSession.selectList(namespace+".getRelList2", pageDTO);
	}

	@Override
	public int getRelCount(PageDTO pageDTO) {
		System.out.println("DeliverDAOImpl getRelCount()");
		
		return sqlSession.selectOne(namespace+".getRelCount", pageDTO);
	}

	@Override
	public int getinstcheck(String order_cd) {
		System.out.println("DeliverDAOImpl getinstcheck()");
		return sqlSession.selectOne(namespace+".getinstcheck", order_cd);
	}

	@Override
	public ReleaseDTO getreldat(String order_cd) {
		System.out.println("DeliverDAOImpl getreldat()");
		return sqlSession.selectOne(namespace+".getreldat", order_cd);
	}

	
	
	

}
