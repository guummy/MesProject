package com.itwillbs.dao;

import java.sql.Date;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.itwillbs.domain.ConsumptionDTO;
import com.itwillbs.domain.InstructionDTO;
import com.itwillbs.domain.LineDTO;
import com.itwillbs.domain.OrderDTO;
import com.itwillbs.domain.PageDTO;

@Repository
public class InstructionDAOImpl implements InstructionDAO {
	@Inject
	private SqlSession sqlSession;
	
	static String namespace="com.itwillbs.mappers.instructionMapper";
	
	static String namespace2="com.itwillbs.mappers.OrderMapper";


	@Override
	public List<Map<String, Object>> getorderlist(PageDTO pageDTO) {
		System.out.println("InstructionDAOImpl getorderlist()");
		
		return sqlSession.selectList(namespace +".getorderlist", pageDTO);
	}

	@Override
	public int getordercount(PageDTO pageDTO) {
		System.out.println("InstructionDAOImpl getordercount()");
		
		return sqlSession.selectOne(namespace + ".getordercount", pageDTO);
	}

	@Override
	public OrderDTO orderinfo(String order_cd) {
		System.out.println("InstructionDAOImpl orderinfo()");
		
		return sqlSession.selectOne(namespace + ".orderinfo", order_cd);
	}

	@Override
	public List<InstructionDTO> instructionlist(PageDTO pageDTO) {
		System.out.println("InstructionDAOImpl instructionlist()");
		
		return sqlSession.selectList(namespace + ".instructionlist", pageDTO);
	}

	@Override
	public int getinstructioncount(PageDTO pageDTO) {
		System.out.println("InstructionDAOImpl getinstructioncount()");
		
		return sqlSession.selectOne(namespace + ".getinstructioncount", pageDTO);
	}

	@Override
	public void instinsertpro(InstructionDTO instructionDTO) {
		System.out.println("InstructionDAOImpl instinsertpro()");
		
		sqlSession.insert(namespace + ".instinsertpro", instructionDTO);
	}

	@Override
	public InstructionDTO instructioninfo(String instruction_code) {
		System.out.println("InstructionDAOImpl instructioninfo()");
		
		return sqlSession.selectOne(namespace + ".instructioninfo", instruction_code);
	}

	@Override
	public List<Map<String, Object>> conslist(String order_cd) {
		System.out.println("InstructionDAOImpl conslist()");
		
		return sqlSession.selectList(namespace +".conslist", order_cd);
	}

	@Override
	public List<Map<String, Object>> getInstMap() {
		System.out.println("InstructionDAOImpl getInstMap()");
		
		return sqlSession.selectList(namespace +".getInstMap");
	}

	@Override
	public Map<String, Object> getInst(String instruction_code) {
		System.out.println("InstructionDAOImpl getInst()");
		
		return sqlSession.selectOne(namespace +".getInst", instruction_code);
	}

	@Override
	public void instupdatepro(InstructionDTO instructionDTO) {
		System.out.println("InstructionDAOImpl instupdatepro()");
		
		sqlSession.update(namespace +".instupdatepro", instructionDTO);
		
	}

	@Override
	public int getordercheck(String order_cd) {
		System.out.println("InstructionDAOImpl getordercheck()");
		
		return sqlSession.selectOne(namespace +".getordercheck", order_cd);
	}

	@Override
	public List<Map<String, Object>> getOrderListMap(PageDTO pageDTO) {
		System.out.println("InstructionDAOImpl getOrderListMap()");
		
		// limit #{startRow -1} , #{pageSize} 
		//        1-1, 10 => 1~10
		pageDTO.setStartRow(pageDTO.getStartRow()-1);
		
		return sqlSession.selectList(namespace +".getOrderListMap", pageDTO);
	}

	@Override
	public void instdelete(String instruction_code) {
		System.out.println("InstructionDAOImpl instdelete()");
		
		sqlSession.delete(namespace +".instdelete", instruction_code);
	}

	@Override
	public void updateCon2(String cd) {
		System.out.println("InstructionDAOImpl updateCon2 생산중으로변경");
		
		sqlSession.update(namespace2+".updateCon2",cd);
		sqlSession.update(namespace+".updateCon2",cd);
	}

	@Override
	public List<Map<String, Object>> getConsListMap(String instruction_code) {
		System.out.println("InstructionDAOImpl getConsListMap()");
		
		return sqlSession.selectList(namespace +".getConsListMap", instruction_code);
	}

	@Override
	public void updateCon3(String cd) {
		System.out.println("InstructionDAOImpl updateCon3 생산완료로변경");
		sqlSession.update(namespace2+".updateCon3",cd);
		sqlSession.update(namespace+".updateCon3",cd);
	}

	@Override
	public String getInstDate(String instruction_code) {
		System.out.println("InstructionDAOImpl getInstDate()");
		
		return sqlSession.selectOne(namespace +".getInstDate", instruction_code);
	}

	@Override
	public int getInstCount(String instruction_code) {
		System.out.println("InstructionDAOImpl getInstDate()");
		
		return sqlSession.selectOne(namespace +".getInstCount", instruction_code);
	}

	@Override
	public String getInstCdname(String instruction_code) {
		System.out.println("InstructionDAOImpl getInstCdname()");
		
		return sqlSession.selectOne(namespace +".getInstCdname", instruction_code);
	}

	@Override
	public String getInstPch(String product_cd_name) {
		System.out.println("InstructionDAOImpl getInstPch()");
		
		return sqlSession.selectOne(namespace +".getInstPch", product_cd_name);
	}

	@Override
	public String getWh_cd(String product_cd_name) {
		System.out.println("InstructionDAOImpl getWh_cd()");
		
		return sqlSession.selectOne(namespace +".getWh_cd", product_cd_name);
	}

	@Override
	public List<String> getcountcons(String cdname) {
		System.out.println("InstructionDAOImpl getcountcons()");
		
		return sqlSession.selectList(namespace +".getcountcons", cdname);
	}

	@Override
	public String getRel_schedule_cd() {
		System.out.println("InstructionDAOImpl getRel_schedule_cd()");
		
		return sqlSession.selectOne(namespace +".getRel_schedule_cd");
	}

	@Override
	public ConsumptionDTO getConsumption(ConsumptionDTO consumptionDTO) {
		System.out.println("InstructionDAOImpl getConsumption()");
		
		return sqlSession.selectOne(namespace +".getConsumption", consumptionDTO);
	}
	
	@Override
	public List<Map<String, Object>> getStockCheck(String order_cd) {
		System.out.println("InstructionDAOImpl getStockCheck()");
		
		return sqlSession.selectList(namespace +".getStockCheck", order_cd);
	}

	@Override
	public Map<String, Object> getInstInfoMap(String instruction_code) {
		System.out.println("InstructionDAOImpl getInstInfoMap()");
		
		return sqlSession.selectOne(namespace +".getInstInfoMap", instruction_code);
	}

	@Override
	public List<LineDTO> getLine_cd() {
		System.out.println("InstructionDAOImpl getLine_cd()");
		
		return sqlSession.selectList(namespace +".getLine_cd");
	}

	@Override
	public void setlineState(String line_cd) {
		System.out.println("InstructionDAOImpl setlineState()");
		
		sqlSession.update(namespace +".setlineState", line_cd);
	}

	@Override
	public String getLine_cdInst(String instruction_code) {
		System.out.println("InstructionDAOImpl getLine_cdInst()");
		
		return sqlSession.selectOne(namespace +".getLine_cdInst", instruction_code);
	}
	
	@Override
	public void setlineState2(String line_cd) {
		System.out.println("InstructionDAOImpl setlineState2()");
		
		sqlSession.update(namespace +".setlineState2", line_cd);
	}
	
	
}
