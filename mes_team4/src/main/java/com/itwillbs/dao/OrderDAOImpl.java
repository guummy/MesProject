package com.itwillbs.dao;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.itwillbs.domain.OrderDTO;
import com.itwillbs.domain.PageDTO;

@Repository
public class OrderDAOImpl implements OrderDAO{
	
	@Inject
	private SqlSession sqlSession;
	
	private static final String namespace="com.itwillbs.mappers.OrderMapper";
	
	@Override
	public Integer getMaxNum(String today) {
		System.out.println("OrderDAOImpl getMaxNum()");
		System.out.println(today);
		return sqlSession.selectOne(namespace+".getMaxNum",today);
	}

	@Override
	public void insertOrder(OrderDTO orderDTO) {
		System.out.println("OrderDAOImpl insertOrder()");
		
		sqlSession.insert(namespace+".insertOrder",orderDTO);		
	}

	@Override
	public List<OrderDTO> getOrderList(PageDTO pageDTO) {
		System.out.println("OrderDAOImpl getOrderList()");
		
		pageDTO.setStartRow(pageDTO.getStartRow()-1);
	
		return sqlSession.selectList(namespace+".getOrderList",pageDTO);
	}

	@Override
	public int getOrderCount() {
		System.out.println("OrderDAOImpl getOrderCount()");
				
		return sqlSession.selectOne(namespace+".getOrderCount");
	}

	@Override
	public void deteleOrder(String cd) {
		System.out.println("OrderDAOImpl deleteOrder()");
		
		sqlSession.delete(namespace+".deleteOrder",cd);		
	}

	@Override
	public OrderDTO getOrder(String cd) {
		System.out.println("OrderDAOImpl getOrder()");
		
		return sqlSession.selectOne(namespace+".getOrder",cd);
	}

	@Override
	public void updateOrder(OrderDTO orderDTO) {
		System.out.println("OrderDAOImpl updateOrder()");
		
		sqlSession.update(namespace+".updateOrder",orderDTO);
	}

	@Override
	public int getPCount() {
		System.out.println("OrderDAOImpl getPCount()");
		return sqlSession.selectOne(namespace+".getPCount");
	}

	@Override
	public int getFCount() {
		System.out.println("OrderDAOImpl getFCount()");
		return sqlSession.selectOne(namespace+".getFCount");
	}

	@Override
	public int getPCount(PageDTO pageDTO) {
		System.out.println("OrderDAOImpl search있는 p개수구함");
		
		return sqlSession.selectOne(namespace+".getPCount",pageDTO);
	}

	@Override
	public int getFCount(PageDTO pageDTO) {
		System.out.println("OrderDAOImpl search있는 f개수구함");
		
		return sqlSession.selectOne(namespace+".getFCount",pageDTO);
	}

	@Override
	public String getProduct_cd_name(String order_cd) {
		System.out.println("OrderDAOImpl getProduct_cd_name()");
		
		return sqlSession.selectOne(namespace+".getProduct_cd_name",order_cd);
	}

	@Override
	public int getSumRelCount(String order_cd) {
		System.out.println("OrderDAOImpl getSumRelCount()");
		
		return sqlSession.selectOne(namespace+".getSumRelCount",order_cd);
	}

	@Override
	public int getbfOr_count(String order_cd) {
		System.out.println("OrderDAOImpl getbfOr_count()");
		
		return sqlSession.selectOne(namespace+".getbfOr_count",order_cd);
	}

	@Override
	public Integer getCon(String cd) {
		System.out.println("OrderDAOImpl getCOn()");
		System.out.println("cd이름 : "+cd);
		
		return sqlSession.selectOne(namespace+".getCon",cd);
	}

	@Override
	public void updateCon(String cd) {
		System.out.println("OrderDAOImpl updateCon() 생산전->생산대기으로");
		
		sqlSession.update(namespace+".updateCon",cd);
	}

	@Override
	public int getICount() {
		System.out.println("OrderDAOImpl getICount()");
		return sqlSession.selectOne(namespace+".getICount");
	}

	@Override
	public int getWCount() {
		System.out.println("OrderDAOImpl getWCount()");
		return sqlSession.selectOne(namespace+".getWCount");
	}

	@Override
	public int getICount(PageDTO pageDTO) {
		System.out.println("OrderDAOImpl search있는 i개수구함");
		
		return sqlSession.selectOne(namespace+".getICount",pageDTO);
	}

	@Override
	public int getWCount(PageDTO pageDTO) {
		System.out.println("OrderDAOImpl search있는 w개수구함");
		
		return sqlSession.selectOne(namespace+".getWCount",pageDTO);
	}

	@Override
	public List<OrderDTO> getOrderList2(PageDTO pageDTO) {
		System.out.println("OrderDAOImpl getOrderList2()");
		
		pageDTO.setStartRow(pageDTO.getStartRow()-1);
	
		return sqlSession.selectList(namespace+".getOrderList2",pageDTO);
	}

	@Override
	public int getOrderCount2() {
		System.out.println("OrderDAOImpl getOrderCount2()");
		
		return sqlSession.selectOne(namespace+".getOrderCount2");
	}

	

}
