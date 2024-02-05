package com.itwillbs.dao;

import java.sql.Timestamp;

import javax.inject.Inject;
import javax.sql.DataSource;

import org.apache.ibatis.session.SqlSession;
//import org.springframework.jdbc.core.simple.SimpleJdbcTemplate;
import org.springframework.stereotype.Repository;

import com.itwillbs.domain.MemberDTO;

@Repository
public class MemberDAOImpl implements MemberDAO{
	
	//마이바티스 디비연결 
	//@inject => root-context.xml 파일에 객체생성된 "sqlSession" 찾아서 자동으로 가져옴
	@Inject
	private SqlSession sqlSession;
	
	// 디비연결 객체생성
	// 은닉 멤버변수
	// private DataSource dataSource;
	// private SimpleJdbcTemplate template;

	//@Inject
	//public void setDataSource(DataSource dataSource) {
		//this.dataSource = dataSource;
		//template=new SimpleJdbcTemplate(dataSource);
	//}
	
	// String sql="insert into members(id,pass,name,date) values(?,?,?,?)";
	static String namespace="com.itwillbs.mappers.memberMapper";
	
	@Override
	public void insertMember(MemberDTO memberDTO) {
		// 디비작업 
		System.out.println("MemberDAOImpl insertMember()");
		memberDTO.setDate(new Timestamp(System.currentTimeMillis()));
		// template.update(sql, memberDTO.getId(), memberDTO.getPass(),memberDTO.getName(), memberDTO.getDate());
		// myBatise memberMapper.xml의 sql 구문 호출하여 사용
		// .insert(sql구문이름, ?표에입력될 값)
		sqlSession.insert(namespace+".insertMember", memberDTO);
	}

	@Override
	public MemberDTO userCheck(MemberDTO memberDTO) {
		System.out.println("MemberDAOImpl userCheck()");
		
		//return 값이 하나일 때 selectOne 사용
		return sqlSession.selectOne(namespace+".userCheck", memberDTO);
	}
	
}// class
