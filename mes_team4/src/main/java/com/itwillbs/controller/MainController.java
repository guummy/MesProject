package com.itwillbs.controller;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.itwillbs.dao.MemberDAO;
import com.itwillbs.domain.MemberDTO;
import com.itwillbs.service.MemberService;
import com.itwillbs.service.MemberServiceImpl;

@Controller
public class MainController {
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		
		// 가상주소 변경하며 페이지이동
		return "redirect:/home";
	}
	
	@RequestMapping(value = "/home", method = RequestMethod.GET)
	public String main() {
		
		// 가상주소 유지
		return "main/Home";
	}
	
}//class
