package com.itwillbs.dao;

import com.itwillbs.domain.MemberDTO;

public interface MemberDAO {
	// 추상메서드 틀
	
	public void insertMember(MemberDTO memberDTO);
	
	public MemberDTO userCheck(MemberDTO memberDTO);
	
}// class
