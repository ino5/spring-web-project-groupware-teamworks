package com.example.sproject.controller;

import java.security.Principal;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpMethod;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.session.SessionRegistry;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.example.sproject.model.login.Member;
import com.example.sproject.service.login.LoginService;

@Controller
@RequestMapping(value="login")
public class LoginController {
	
	@Autowired
	private LoginService loginService;
	
	@RequestMapping(value = "login", method = {RequestMethod.GET, RequestMethod.POST})
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
//		String m_id = principal.getName();
//		System.out.println("m_id: " + m_id);
//		model.addAttribute("m_id", m_id);
		return "redirect:/main";
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
	
	@RequestMapping("api/getSessionMembers")
	@ResponseBody
	public List<Member> getSessionMembers() {
		return loginService.getSessionMembers();
	}
	
	@RequestMapping("simpleMyProfile")
	public String simpleMyProfile(@AuthenticationPrincipal Member principal, Model model) {
		System.out.println(principal);
		model.addAttribute("principal", principal);
		return "login/simpleMyProfile";
	}
	
	@RequestMapping(value = "simpleMyProfile/save", method = {RequestMethod.GET, RequestMethod.POST})
	public String simpleMyProfileSave(MultipartFile multipartFile, @AuthenticationPrincipal Member principal) {
		loginService.updateMemberPhoto(principal.getM_id(), multipartFile);
		return "redirect:/login/simpleMyProfile";
	}
	
}
