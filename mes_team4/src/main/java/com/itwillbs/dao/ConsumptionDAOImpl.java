package com.itwillbs.dao;

import java.util.Arrays;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.itwillbs.domain.ConsumptionDTO;
import com.itwillbs.domain.PageDTO;

@Repository
public class ConsumptionDAOImpl implements ConsumptionDAO{
	
	@Inject
	private SqlSession sqlSession;
	
	static String namespace="com.itwillbs.mappers.ConsumptionMapper";
	
	@Override
	public List<Map<String, Object>> getPrList(PageDTO pageDTO) {
		System.out.println("ConsumptionDAOImpl getPrList()");
		
		if (pageDTO.getProduct_dv().equals("cp")) {
			return sqlSession.selectList(namespace+".getCpList", pageDTO);
		} 
		else if (pageDTO.getProduct_dv().equals("rp")) {
			return sqlSession.selectList(namespace+".getRpList", pageDTO);
		} 
		else {
			return null;
		}
	} 
	
	@Override
	public int getPrCount(PageDTO pageDTO) {
		System.out.println("ConsumptionDAOImpl getPrCount()");
		
		if (pageDTO.getProduct_dv().equals("cp")) {
			return sqlSession.selectOne(namespace+".getCpCount", pageDTO);
		} 
		else if (pageDTO.getProduct_dv().equals("rp")) {
			return sqlSession.selectOne(namespace+".getRpCount", pageDTO);
		} 
		else {
			return 0;
		}
	} 
	
	@Override
	public void insertConsmpt(ConsumptionDTO[] consmptArray) {
		System.out.println("ConsumptionDAOImpl insertConsmpt()");
		
		Map<String, Object> map = new HashMap<>();
		map.put("consmptArray", consmptArray);
		
		sqlSession.insert(namespace + ".insertConsmpt", map);
		
		//sqlSession.insert(namespace+".insertConsmpt", Map.of("consmptArray" ,consmptArray));
	}
	
	@Override
	public List<ConsumptionDTO> checkCprCdName(String cproduct_cd_name) {
		System.out.println("ConsumptionDAOImpl checkCprCdName()");
		
		return sqlSession.selectList(namespace+".checkCprCdName", cproduct_cd_name);
	}
	
	@Override
	public List<ConsumptionDTO> getCprConsmptList(PageDTO pageDTO) {
		System.out.println("ConsumptionDAOImpl getCprConsmptList()");
		
		return sqlSession.selectList(namespace+".getCprConsmptList", pageDTO);
	}
	
	@Override
	public int getCprConsmptCount(PageDTO pageDTO) {
		System.out.println("ConsumptionDAOImpl getCprConsmptCount()");
		
		return sqlSession.selectOne(namespace+".getCprConsmptCount", pageDTO);
	}
	
	@Override
	public List<ConsumptionDTO> getRprConsmptList(String[] cprCdName) {
		System.out.println("ConsumptionDAOImpl getRprConsmptList()");
		
		List<String> cprCdNameList = Arrays.asList(cprCdName);
		
		Map<String, Object> map = new HashMap<>();
		map.put("cprCdNameList", cprCdNameList);
		
		return sqlSession.selectList(namespace + ".getRprConsmptList", map);
		
		//return sqlSession.selectList(namespace+".getRprConsmptList", Map.of("cprCdNameList", cprCdNameList));
	}
	
	@Override
	public List<Integer> getRowcolsTd(String[] cprCdName) {
		System.out.println("ConsumptionDAOImpl getRowcolsTd()");
		
		List<String> cprCdNameList = Arrays.asList(cprCdName);
		
		Map<String, Object> map = new HashMap<>();
		map.put("cprCdNameList", cprCdNameList);
		
		return sqlSession.selectList(namespace + ".getRowcolsTd", map);

		//return sqlSession.selectList(namespace+".getRowcolsTd", Map.of("cprCdNameList", cprCdNameList));
	}
	
	@Override
	public void deleteConsmpt(String[] checkedValue) {
		System.out.println("ConsumptionDAOImpl deleteConsmpt()");
		
		Map<String, Object> map = new HashMap<>();
		map.put("checkedValue", checkedValue);
		
		sqlSession.delete(namespace + ".deleteConsmpt", map);
		
		//sqlSession.delete(namespace+".deleteConsmpt", Map.of("checkedValue" ,checkedValue));
	}
	
	@Override
	public void updateConsmpt(ConsumptionDTO[] consmptArray) {
		System.out.println("ConsumptionDAOImpl updateConsmpt()");
		
		Map<String, Object> map = new HashMap<>();
		map.put("consmptArray", consmptArray);
		
		sqlSession.insert(namespace + ".updateConsmpt", map);
	
		//sqlSession.insert(namespace+".updateConsmpt", Map.of("consmptArray" ,consmptArray));
	}
	
	@Override
	public void updateConsmptName(String column_cd, String column_name, String product_cd_name, String product_name) {
		System.out.println("ConsumptionDAOImpl updateConsmptName()");
	
		Map<String, String> nameMap = new HashMap<>();
	    nameMap.put("column_cd", column_cd);
	    nameMap.put("column_name", column_name);
	    nameMap.put("product_cd_name", product_cd_name);
	    nameMap.put("product_name", product_name);
		
		sqlSession.update(namespace+".updateConsmptName", nameMap);
	}
	
}// class
