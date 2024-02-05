//package com.itwillbs.controller;
//
//import javax.inject.Inject;
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpSession;
//
//import org.springframework.stereotype.Controller;
//import org.springframework.web.bind.annotation.RequestMapping;
//import org.springframework.web.bind.annotation.RequestMethod;
//
//import com.itwillbs.dao.MemberDAO;
//import com.itwillbs.domain.MemberDTO;
//import com.itwillbs.service.MemberService;
//import com.itwillbs.service.MemberServiceImpl;
//
//@Controller
//public class MemberController {
//	// 주의 :파일이 틀려도 같은 @Controller 에 있는 가상주소 모두 다르게 부여
//	// 서블릿이 동작하기 전에 웹 애플리케이션 서버에서 request, response 서버 내장객체 생성 
//	// => 서버 기억장소 할당
//	// => request 기억장소 안에 서버 정보, 쿠키정보, 클라이언트 정보, 사용자가 입력한 정보 저장 
//	
//	// 멤버변수 부모 = 자식 객체생성
//	
//	// Spring 3버전 자동으로 객체 생성
//	// 1)멤버변수 부모 공통적인 틀 선언 => 데이터 은닉
//	// 2)스프링파일 root-context.xml 객체 생성
//	// 3)MemberConrtoller 파일에 멤버 변수 memberService 값 전달
//	
//	// 1)멤버변수 부모 공통적인 틀 선언 => 데이터 은닉
//	// private MemberService memberService;
//	
//	// 3)멤버변수 값 => 생성자 or set메서드 통해서 전달
//	// MemberController 생성자	
//	
//	//@Inject 
//	//public MemberController(MemberService memberService) {
//	//	this.memberService = memberService; 
//	//}
//	
//	// memberService set메서드
//	// @Inject
//	// public void setMemberService(MemberService memberService) {
//	// 	System.out.println("MemberService 객체생성");
//	// 	this.memberService = memberService;
//	// }
//	
//	// Spring 4버전 자동 객체 생성
//	// 1)멤버변수 부모 공통적인 틀 선언 => 데이터 은닉
//	// 2)부모를 상속받은 자시클래스 자동으로 찾아옴
//	@Inject 
//	private MemberService memberService;
//	
//	@RequestMapping(value = "/member/insert", method = RequestMethod.GET)
//	public String insert() {
//		// 처리작업
//		
//		// 가상주소에서 주소변경 없이 이동
//		return "member/insertForm";
//	}
//
//	@RequestMapping(value = "/member/insertPro", method = RequestMethod.POST)
//	public String insertPro(MemberDTO memberDTO) {
//		// web.xml 에서 한글설정을 한번만 하면 모든 곳에서 한글처리
//		System.out.println("MemberController insertPro()");
//		
//		// 패키지 com.itwillbs.domain의 MemberDTO에 수동으로 저장
//		// MemberDTO memberDTO = new MemberDTO();
//		// memberDTO.setId(request.getParameter("id"));
//		// memberDTO.setPass(request.getParameter("pass"));
//		// memberDTO.setName(request.getParameter("name"));
//		
//		// 패키지 com.itwillbs.domain의 MemberDTO에 자동으로 저장
//		// 스프링에서 insertForm.jsp의 id,pass,name input 태그의 입력된 값이 서버에 전달
//		// request 객체에 저장 => MemberDTO 객체 생성 => input 태그의 name명과 멤버변수의 변수명이 동일하면
//		// 자동으로 setId() 메서드 호출되어지고 setId(request.getParameter("id")) 자동으로 값 저장
//		System.out.println(memberDTO.getId());
//		System.out.println(memberDTO.getPass());
//		System.out.println(memberDTO.getName());
//		
//		// jsp MVC2
//		// MemberFrontController 주소매핑 호출
//		// => MemberInsertPro.java excute() 호출
//		// => MemberDAO insertMember() 
//		
//		// jsp SPRING MVC
//		// 자바파일 메서드 호출 회원가입 처리 => MemberService 처리 => MemberDAO처리
//		// 주소매핑 MemberController 
//		// => 처리 MemberService (인터페이스 MemberServiceTmpl) insertMember()
//		// => 디비 MemberDAO (인터페이스 MemberDAOTmpl) insertMmber()
//		
//		// MemberService memberService = new MemberServiceImpl();
//		memberService.insertMember(memberDTO);
//		
//		// 가상주소에서 주소변경 하면서 이동
//		return "redirect:/member/login";
//	}
//	
//	
//	@RequestMapping(value = "/member/login", method = RequestMethod.GET)
//	public String login() {
//		// 처리작업
//		
//		// 가상주소에서 주소변경 없이 이동
//		return "member/loginForm";
//	}
//	
//	@RequestMapping(value = "/member/loginPro", method = RequestMethod.POST)
//	public String loginPro(MemberDTO memberDTO, HttpSession session) {
//		System.out.println("MemberController loginPro()");
//		// DB작업
//		System.out.println(memberDTO.getId());
//		System.out.println(memberDTO.getPass());
//		
//		// jsp MVC2
//		// MemberLoginPro.java execute()
//		
//		// jsp SPRING MVC
//		// MemberService 부모 = MemberServiceImpl 자식 객체생성
//		// 리턴할형 MemberDTO userCheck(MemberDTO memberDTO) 메서드 정의
//		// MemberDTO memberDTO2 = userCheck(memberDTO) 메서드 호출
//		
//		// MemberService memberService = new MemberServiceImpl();
//		MemberDTO memberDTO2 = memberService.userCheck(memberDTO);
//		if(memberDTO2 != null) {
//			System.out.println("아이디 비밀번호 일치");
//			// session 객체는 매개변수로 받아옴
//			session.setAttribute("id", memberDTO.getId());
//			return "redirect:/member/main";
//		} else {
//			System.out.println("아이디 비밀번호 틀림");
//			// member/msg.jsp 만들어서 아이디 비밀번호 틀림 메세지 출력, 뒤로이동
//			//가상주소 변경없이 이동
//			return "member/msg";
//		}
//	}
//	
//	
//	@RequestMapping(value = "/member/main", method = RequestMethod.GET)
//	public String main() {
//		// 처리작업
//		
//		// 가상주소에서 주소변경 없이 이동
//		return "member/main";
//	}
//	
//	@RequestMapping(value = "/member/info", method = RequestMethod.GET)
//	public String info() {
//		// 처리작업
//		
//		// 가상주소에서 주소변경 없이 이동
//		return "member/info";
//	}
//	
//	@RequestMapping(value = "/member/update", method = RequestMethod.GET)
//	public String update() {
//		// 처리작업
//		
//		// 가상주소에서 주소변경 없이 이동
//		return "member/updateForm";
//	}
//	
//	@RequestMapping(value = "/member/updatePro", method = RequestMethod.POST)
//	public String updatePro(MemberDTO memberDTO) {
//		System.out.println("MemberController updatePro()");
//		// DB작업 
//		System.out.println(memberDTO.getId());
//		System.out.println(memberDTO.getPass());
//		System.out.println(memberDTO.getName());
//		
//		// 가상주소에서 주소변경 하면서 이동
//		return "redirect:/member/main";
//	}
//
//	@RequestMapping(value = "/member/delete", method = RequestMethod.GET)
//	public String delete() {
//		// 처리작업
//		
//		// 가상주소에서 주소변경 없이 이동
//		return "member/deleteForm";
//	}
//	
//	@RequestMapping(value = "/member/deletePro", method = RequestMethod.POST)
//	public String deletePro(MemberDTO memberDTO) {
//		System.out.println("MemberController deletePro()");
//		// DB작업 
//		System.out.println(memberDTO.getId());
//		System.out.println(memberDTO.getPass());
//		
//		// 가상주소에서 주소변경 하면서 이동
//		return "redirect:/member/main";
//	}
//
//	@RequestMapping(value = "/member/list", method = RequestMethod.GET)
//	public String list() {
//		System.out.println("MemberController list()");
//		// DB작업
//		
//		// 가상주소에서 주소변경 없이 이동 
//		return "member/list";
//	}
//	
//	@RequestMapping(value = "/member/logout", method = RequestMethod.GET)
//	public String logout() {
//		System.out.println("MemberController logout()");
//		// DB작업을 거치지 않고 세션초기화
//		
//		// 가상주소에서 주소변경 하면서 이동
//		return "redirect:/member/main";
//	}
//	
//}//class
