package com.itwillbs.dao;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.itwillbs.domain.StockDTO;
import com.itwillbs.domain.PageDTO;

@Repository
public class StockDAOImpl implements StockDAO {

	//마이바티스 자동 객체생성
	@Inject
	private SqlSession sqlSession;
		
	// sql구문 전체 이름 정의
	private static final String namespace="com.itwillbs.mappers.StockMapper";

//	@Override
//	public List<StockDTO> getStockList(PageDTO pageDTO) {
//		System.out.println("InfoDAOImpl getStockList()");
//		// limit #{startRow -1} , #{pageSize} 
//		//        1-1, 10 => 1~10
//		pageDTO.setStartRow(pageDTO.getStartRow()-1);
//		
//		return sqlSession.selectList(namespace+".getStockList", pageDTO);
//	}		

	@Override
	public int getStockCount(PageDTO pageDTO) {
		System.out.println("InfoDAOImpl getStockCount()");
		
		return sqlSession.selectOne(namespace+".getStockCount", pageDTO);
	}

	@Override
	public void insertStock(StockDTO stockDTO) {
		System.out.println("InfoDAOImpl insertStock()");
		
		sqlSession.insert(namespace+".insertStock", stockDTO);			
	}

	@Override
	public StockDTO getStock(String stock_cd) {
		System.out.println("InfoDAOImpl getStock()");
		
		return sqlSession.selectOne(namespace+".getStock", stock_cd);
	}

	@Override
	public void updateStock(StockDTO stockDTO) {
		System.out.println("InfoDAOImpl updateStock()");
		
		sqlSession.update(namespace+".updateStock", stockDTO);
	}

	@Override
	public void deleteStock(String stock_cd) {
		System.out.println("InfoDAOImpl deleteStock()");
		
		sqlSession.delete(namespace+".deleteStock", stock_cd);
	}

	@Override
	public List<Map<String, Object>> getStockMap(PageDTO pageDTO) {
		System.out.println("InfoDAOImpl getStockMap()");
		// limit #{startRow -1} , #{pageSize} 
		//        1-1, 10 => 1~10
		pageDTO.setStartRow(pageDTO.getStartRow()-1);
		
		return sqlSession.selectList(namespace+".getStockMap", pageDTO);
	}

	@Override
	public List<Map<String, Object>> getwhMap() {
		System.out.println("InfoDAOImpl getwhMap()");
		
		return sqlSession.selectList(namespace+".getwhMap");
	}

	@Override
	public List<Map<String, Object>> getrecMap() {
		System.out.println("InfoDAOImpl getrecMap()");
		
		return sqlSession.selectList(namespace+".getrecMap");
	}

	@Override
	public List<Map<String, Object>> getprodMap() {
		System.out.println("InfoDAOImpl getprodMap()");
		
		return sqlSession.selectList(namespace+".getprodMap");
	}

	@Override
	public int getStockCount2() {
		System.out.println("InfoDAOImpl getStockCount2()");
		
		return sqlSession.selectOne(namespace+".getStockCount2");
	}

	@Override
	public String getStock_cd() {
		System.out.println("InfoDAOImpl getStock_cd()");
		
		return sqlSession.selectOne(namespace+".getStock_cd");
	}
}
