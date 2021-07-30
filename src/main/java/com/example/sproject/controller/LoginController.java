package com.example.sproject.controller;

import java.security.Principal;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.sproject.model.login.Member;
import com.example.sproject.service.login.LoginService;

@Controller
@RequestMapping(value="login")
public class LoginController {
	
	@Autowired
	private LoginService loginService;
	
	@GetMapping("login")
	public String login() {
		return "login/login";
	}
	
	@GetMapping("join")
	public String join() {
		return "login/join";
	}
	
	@PostMapping("join")
	public String joinPost(Member member) {
		System.out.println("Method joinPost in Class LoginController");
		loginService.join(member);
		System.out.println("after loginService.join(member)");
		return "redirect:/login/login";
	}
	
	@GetMapping("")
	public String memberInfo(Principal principal, Model model) {
		System.out.println("--Method memberInfo in Class LoginController");
		if (null == principal) {
			return "login/login";
		}
		String m_id = principal.getName();
		System.out.println("m_id: " + m_id);
		model.addAttribute("m_id", m_id);
		return "main/sampleMain";
	}
	
	@GetMapping("denied")
	public String denied(Model model) {
		System.out.println("Method denied in Class LoginController");
		return "login/denied";
	}
	
	@GetMapping("passwordCheck")
	public String passwordCheck(Model model) {
		return "login/passwordCheck";
	}
	
	@PostMapping("passwordCheckResult")
	public String passwordCheckPost(Member member, Principal principal, Model model) {
		member.setM_id(principal.getName());
		System.out.println("password: " + member.getM_password());
		int result = loginService.passwordCheck(member);
		model.addAttribute("result", result);
		return "login/passwordCheckResult";
	}
	
	@RequestMapping("memberInfo")
	public String memberInfo(@AuthenticationPrincipal Member member, Model model) {
		model.addAttribute("member", member);
//		System.out.println(member.getM_id());
		return "login/memberInfo";
	}
}
