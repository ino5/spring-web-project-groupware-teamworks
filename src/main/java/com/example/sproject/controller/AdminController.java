package com.example.sproject.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.example.sproject.model.login.Member;
import com.example.sproject.service.login.LoginService;

@Controller
@RequestMapping("admin")
public class AdminController {
	
	@Autowired
	private LoginService loginService;

	@GetMapping("admin")
	public String join() {
		return "admin/admin";
	}
	
	@PostMapping("admin")
	public String joinPost(Member member) {
		System.out.println("Method joinPost in Class LoginController");
		loginService.join(member);
		System.out.println("after loginService.join(member)");
		return "redirect:/login/login";
	}
	
	@RequestMapping("admin")
	public String index(Model model) {
		return "admin/admin";
	}
	@RequestMapping("")
	public String index2(Model model) {
		return "admin/main";
	}
	
}
