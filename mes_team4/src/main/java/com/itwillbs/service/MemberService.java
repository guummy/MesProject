package com.itwillbs.service;

import com.itwillbs.dao.MemberDAO;
import com.itwillbs.domain.MemberDTO;

public interface MemberService {
	// 클래스 만들기 위한 부모 인터페이스 틀
	// 추상메서드 틀 정의
	public void insertMember(MemberDTO memberDTO);
	
	public MemberDTO userCheck(MemberDTO memberDTO);
}
