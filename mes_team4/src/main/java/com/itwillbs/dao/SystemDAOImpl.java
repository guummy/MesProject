package com.itwillbs.dao;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.itwillbs.domain.PageDTO;
import com.itwillbs.domain.SystemDTO;

@Repository
public class SystemDAOImpl implements SystemDAO {
	@Inject
	private SqlSession sqlSession;
	private static final String namespace="com.itwillbs.mappers.systemMapper";

	@Override
	public void memberinsertpro(SystemDTO systemDTO) {
		System.out.println("SystemDAOImpl memberinsertpro()");
		
		sqlSession.insert(namespace + ".memberinsertpro", systemDTO);
	}
	@Override
	public Integer getMaxEmp_no() {
		System.out.println("SystemDAOImpl getMaxEmp_no()");
		
		return sqlSession.selectOne(namespace +".getMaxEmp_no");
	}
	@Override
	public List<SystemDTO> getsystemlist(PageDTO pageDTO) {
		System.out.println("SystemDAOImpl getsystemlist()");
//		limit #{startRow}, #{pageSize} 인데 startRow에서 1부터 10까지 하려면 0부터 시작해야 1~10이라고 인식함(처음 수는 인식하지 않음)
//		그렇게 때문에 StartRow-1을 해줌
		pageDTO.setStartRow(pageDTO.getStartRow()-1);
		
		return sqlSession.selectList(namespace + ".getsystemlist", pageDTO);
	}
	@Override
	public int getsystemcount(PageDTO pageDTO) {
		System.out.println("SystemDAOImpl getsystemcount()");
		
		return sqlSession.selectOne(namespace + ".getsystemcount", pageDTO);
	}
	@Override
	public SystemDTO memberinfo(int emp_no) {
		System.out.println("SystemDAOImpl memberinfo()");
		
		return sqlSession.selectOne(namespace + ".memberinfo", emp_no);
	}
	@Override
	public void memberupdatepro(SystemDTO systemDTO) {
		System.out.println("SystemDAOImpl memberupdatepro()");
		
		sqlSession.update(namespace + ".memberupdatepro", systemDTO);
	}
	@Override
	public void memberdelete(int emp_no) {
		System.out.println("SystemDAOImpl memberdelete()");
		
		sqlSession.delete(namespace + ".memberdelete", emp_no);
		
	}
	@Override
	public SystemDTO userCheck(SystemDTO systemDTO) {
		System.out.println("SystemDAOImpl userCheck()");
		
		return sqlSession.selectOne(namespace+".userCheck", systemDTO);
	}
	@Override
	public void mypagePro(SystemDTO systemDTO) {
		System.out.println("SystemDAOImpl mypagePro()");
		System.out.println(systemDTO.getEmp_no());
		System.out.println(systemDTO.getEmp_pass());
		
		sqlSession.update(namespace + ".mypagePro", systemDTO);
	}
	@Override
	public List<SystemDTO> getMemberList() {
		System.out.println("SystemDAOImpl getmemberList()");
		return sqlSession.selectList(namespace+".getMemberforor");
	}



	
	
	
}
