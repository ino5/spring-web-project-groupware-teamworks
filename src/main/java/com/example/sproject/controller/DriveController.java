package com.example.sproject.controller;

import java.io.File;
import java.security.Principal;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.example.sproject.model.common.CommonGroup;
import com.example.sproject.model.drive.DriveFile;
import com.example.sproject.model.globals.Tb_code;
import com.example.sproject.service.common.CommonService;

@Controller
@RequestMapping("drive")
public class DriveController {
	private static final Logger logger = LoggerFactory.getLogger(DriveController.class);
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
//	public String upladPost(Principal principal, DriveFile driveFile, Model model) {
//		principal.getName();
//		return "redirect:/drive";
//	}
	public String uploadForm( HttpServletRequest request, MultipartFile file1,Model model ) throws Exception {
		String uploadPath = request.getSession().getServletContext().getRealPath("/upload/");	
		System.out.println("uploadForm POST Start");
		logger.info("originalName: " + file1.getOriginalFilename());
//		logger.info("title: " + title);
	    logger.info("size: " + file1.getSize());
	    logger.info("contentType: " + file1.getContentType());
	    logger.info("uploadPath: " + uploadPath);
	    String savedName = uploadFile(file1.getOriginalFilename(), file1.getBytes(), uploadPath);
	    logger.info("savedName: " + savedName);
	    model.addAttribute("savedName", savedName);
	    return "redirect:/drive";
	  }
	//업로드파일 서비스 테스트
	private String uploadFile(String originalName, byte[] fileData , String uploadPath) throws Exception {
	     UUID uid = UUID.randomUUID();
	   // requestPath = requestPath + "/resources/image";
	    System.out.println("uploadPath->"+uploadPath);
	    // Directory 생성 
		File fileDirectory = new File(uploadPath);
		if (!fileDirectory.exists()) {
			fileDirectory.mkdirs();
			System.out.println("업로드용 폴더 생성 : " + uploadPath);
		}

	    String savedName = uid.toString() + "_" + originalName;
	    logger.info("savedName: " + savedName);
	    File target = new File(uploadPath, savedName);
//	    File target = new File(requestPath, savedName);
	    FileCopyUtils.copy(fileData, target);   // org.springframework.util.FileCopyUtils
	    
	    return savedName;
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
		String tb_code = Tb_code.POST;
		return commonService.listCommonGroup(tb_code);
	}
	
	@RequestMapping(value = "test/cg/insert", method = {RequestMethod.GET, RequestMethod.POST})
	@ResponseBody
	public List<CommonGroup> cgInsert(CommonGroup commonGroup, Model model, int parent_cg_num) {
		String tb_code = Tb_code.POST;
		commonService.addCommonGroup(tb_code, commonGroup, parent_cg_num);
		return commonService.listCommonGroup(tb_code);
	}

}
