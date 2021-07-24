package com.example.sproject.controller;

import java.security.Principal;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.example.sproject.model.drive.DriveFile;

@Controller
@RequestMapping("drive")
public class DriveController {
	@RequestMapping("")
	public String index(Model model) {
		return "drive/main";
	}
	
	//업로드폼 페이지
	@RequestMapping("uploadForm")
	public String uploadForm(Model model) {
		return "drive/uploadForm";
	}
	
	//파일 업로드하기
	@PostMapping("upload")
	public String upladPost(Principal principal, DriveFile driveFile, Model model) {
		principal.getName();
		return "redirect:/drive";
	}
	
	//admin 권한 테스트 페이지
	@RequestMapping("admin")
	public String admin(Model model) {
		return "drive/admin";
	}
}
