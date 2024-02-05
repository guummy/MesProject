package com.itwillbs.service;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;

import com.itwillbs.dao.MemberDAO;
import com.itwillbs.dao.MemberDAOImpl;
import com.itwillbs.domain.MemberDTO;

@Service
public class MemberServiceImpl implements MemberService{
	// 부모인터페이스 틀 상속
	
	// 멤버변수 부모 = 자식 객체생성
	// MemberDAO 부모 = MemberDAOImpl 자식 객체생성
	/* MemberDAO memberDAO = new MemberDAOImpl(); */
	
	// 멤버변수 데이터 은닉 => 객체생성
	// private MemberDAO memberDAO;
	
	// set메서드로 멤버변수 값 전달
	// @Inject
	// public void setMemberDAO(MemberDAO memberDAO) {
	// 	this.memberDAO = memberDAO;
	//}
	@Inject 
	private MemberDAO memberDAO;

	@Override
	public void insertMember(MemberDTO memberDTO) {
		System.out.println("MemberServiceImpl insertMember()");
		
		// MemberDAO memberDAO = new MemberDAOImpl(); 
		memberDAO.insertMember(memberDTO);
	}
	
	@Override
	public MemberDTO userCheck(MemberDTO memberDTO) {
		System.out.println("MemberServiceImpl userCheck()");
		
		// MemberDAO memberDAO = new MemberDAOImpl(); 
		
		return memberDAO.userCheck(memberDTO);
	}
	
}// class
