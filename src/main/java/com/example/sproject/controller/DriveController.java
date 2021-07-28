package com.example.sproject.controller;

import java.io.File;
import java.io.IOException;
import java.net.URLEncoder;
import java.security.Principal;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.example.sproject.configuration.WebMvcConfig;
import com.example.sproject.model.common.CommonGroup;
import com.example.sproject.model.drive.DriveFile;
import com.example.sproject.model.globals.Tb_code;
import com.example.sproject.service.common.CommonService;
import com.example.sproject.service.drive.DriveService;

@Controller
@RequestMapping("drive")
public class DriveController {
	private static final Logger logger = LoggerFactory.getLogger(DriveController.class);
	@Autowired
	private DriveService driveService;
	@Autowired
	private CommonService commonService;
	
	
	
	@RequestMapping("")
	public String index(Model model) {
		return "drive/main";
	}
	
	//업로드폼 페이지
	@RequestMapping("uploadForm")
	public String uploadForm(Model model, Principal principal) {
		System.out.println("uploadForm method in DriveController Starts");
		System.out.println("principal.getName: " + principal.getName());
		return "drive/uploadForm";
	}
	
	//파일 업로드하기
	@PostMapping("upload")	
	public String upload(MultipartFile file1, Model model, Principal principal) throws Exception {
		System.out.println("upload method in DriveController Starts");
		System.out.println("principal.getName: " + principal.getName());
//		String uploadPath = request.getSession().getServletContext().getRealPath("/upload/");
		String uploadPath = WebMvcConfig.RESOURCE_PATH + "/drive";
		System.out.println("uploadForm POST Start");
		System.out.println("getName: " + file1.getName());
		logger.info("originalName: " + file1.getOriginalFilename());
//		logger.info("title: " + title);
	    logger.info("size: " + file1.getSize());
	    logger.info("contentType: " + file1.getContentType());
	    logger.info("uploadPath: " + uploadPath);
	    String dv_id = driveService.uploadFile(file1.getOriginalFilename(), file1.getBytes(), uploadPath);
	    logger.info("savedName: " + dv_id);
	    model.addAttribute("savedName", dv_id);
	    
	    //DB에 파일 정보 저장
	    System.out.println("db file save");
	    System.out.println(principal.getName());
	    System.out.println(file1.getOriginalFilename());
	    DriveFile driveFile = new DriveFile(dv_id, principal.getName(), file1.getOriginalFilename(), null, 0);
	    driveService.insertDriveFile(driveFile);
	    return "redirect:/drive";
	  }
	
	
	//파일 다운로드 테스트
	//해야할 것 : drive테이블 연동, 세션id체크
	@RequestMapping("download/{dv_id:.+}")
    public String fileDownLoad(@PathVariable("dv_id") String dv_id, HttpServletRequest request, HttpServletResponse response) throws IOException {
        String filenameReal = "abc.pdf";
        if (filenameReal == null || filenameReal.equals("")) {
            return null;
        }
        response.setHeader("Content-Disposition", "attachment; fileName=\"" + URLEncoder.encode(filenameReal,"UTF-8") + "\";");
        response.setHeader("Content-Transfer-Encoding", "binary");
        
        byte[] fileByte = FileUtils.readFileToByteArray(new File(WebMvcConfig.RESOURCE_PATH + "/drive/"+dv_id));
        response.getOutputStream().write(fileByte);
        response.getOutputStream().flush();
        response.getOutputStream().close();
        
        return null;
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
	
	@RequestMapping(value = "test/cg2", method = {RequestMethod.GET, RequestMethod.POST})
	@ResponseBody
	public List<CommonGroup> cg2(Model model) {
		String tb_code = Tb_code.POST;
		return commonService.listCommonGroup(tb_code, 2, 2);
	}
	
	@RequestMapping(value = "test/cg/insert", method = {RequestMethod.GET, RequestMethod.POST})
	@ResponseBody
	public List<CommonGroup> cgInsert(CommonGroup commonGroup, Model model, int parent_cg_num) {
		String tb_code = Tb_code.POST;
		commonService.addCommonGroup(tb_code, commonGroup, parent_cg_num);
		return commonService.listCommonGroup(tb_code);
	}
	
	

}
