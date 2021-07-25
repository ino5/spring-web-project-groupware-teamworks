package com.example.sproject.controller;

import java.security.Principal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.sproject.model.common.CommonGroup;
import com.example.sproject.model.drive.DriveFile;
import com.example.sproject.service.common.CommonService;

@Controller
@RequestMapping("drive")
public class DriveController {
	@Autowired
	private CommonService commonService;
	
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
	
	//common_group 테스트 페이지
	@RequestMapping(value = "test/cg", method = {RequestMethod.GET, RequestMethod.POST})
	@ResponseBody
	public List<CommonGroup> cg(Model model) {
		String tb_code = "p";
		return commonService.listCommonGroup(tb_code);
	}
	
	@RequestMapping(value = "test/cg/insert", method = {RequestMethod.GET, RequestMethod.POST})
	@ResponseBody
	public List<CommonGroup> cgInsert(CommonGroup commonGroup, Model model) {
		String tb_code = "p";
		commonService.addCommonGroup(commonGroup);
		return commonService.listCommonGroup(tb_code);
	}

}
