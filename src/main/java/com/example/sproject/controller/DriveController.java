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
import com.example.sproject.model.drive.DriveFileInfo;
import com.example.sproject.model.globals.GlobalsOfCg_num;
import com.example.sproject.model.globals.GlobalsOfTb_code;
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
	public String main(Model model, Integer cg_num, Principal principal) {
		System.out.println("Method main in Class DriveController");
		
		//common_group 관련 처리
		if(cg_num == null) cg_num = GlobalsOfCg_num.DRIVE_ENTERPRISE;
		if (cg_num == GlobalsOfCg_num.DRIVE_ENTERPRISE) model.addAttribute("title", "전사 자료실");
		else if (cg_num == GlobalsOfCg_num.DRIVE_PERSONAL) model.addAttribute("title", "개인 자료실");
		
		//자료실 목록 가져오기
		List<DriveFileInfo> driveFileInfoListOfEnterprise = driveService.selectListDriveFileInfo(cg_num, principal.getName());
		
		//목록 콘솔에 출력
		for(DriveFileInfo driveFileInfo : driveFileInfoListOfEnterprise) System.out.println(driveFileInfo);
		
		model.addAttribute("driveFileInfoListOfEnterprise", driveFileInfoListOfEnterprise);
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
	public String upload(MultipartFile file1, int cg_num, Model model, Principal principal) throws Exception {
		System.out.println("upload method in DriveController Starts");
		String uploadPath = WebMvcConfig.RESOURCE_PATH + "/drive";
		
		//서버에 파일 업로드
	    String dv_id = driveService.uploadFile(file1.getOriginalFilename(), file1.getBytes(), uploadPath);
	    
	    //DB에 파일 정보 저장
	    System.out.println("db file save");
	    DriveFileInfo driveFile = new DriveFileInfo(dv_id, principal.getName(), file1.getOriginalFilename(), null, cg_num);
	    driveService.insertDriveFileInfo(driveFile);
	    return "redirect:/drive?cg_num=" + cg_num;
	  }
	
	
	//파일 다운로드
	@RequestMapping("download/{dv_id:.+}")
	@ResponseBody
    public String fileDownLoad(@PathVariable("dv_id") String dv_id, Principal principal, HttpServletRequest request, HttpServletResponse response) throws IOException {
        System.out.println("--Method fileDownLoad");
		//DB에서 해당 파일 정보 가져오기
		DriveFileInfo driveFileInfo = driveService.selectOneDriveFileInfo(dv_id);
		System.out.println("driveFileInfo: " + driveFileInfo);
		String m_id = driveFileInfo.getM_id();
		String dv_filename = driveFileInfo.getDv_filename();
		int cg_num = driveFileInfo.getCg_num();
		
		//세션 ID 통해서 다운로드 권한 여부 체크하기(개인 자료실에 대해서)
		if(cg_num == GlobalsOfCg_num.DRIVE_PERSONAL) {
			if(!m_id.equals(principal.getName())) {
				System.out.println("!m_id.equals(principal.getName()");
				return null;
			}
		}
		
        //서버에서 파일 가져오기 (서버에 저장된 파일명: dv_id)
        byte[] fileByte = FileUtils.readFileToByteArray(new File(WebMvcConfig.RESOURCE_PATH + "/drive/"+dv_id));
        
        //response 세팅
        response.setHeader("Content-Disposition", "attachment; fileName=\"" + URLEncoder.encode(dv_filename,"UTF-8").replaceAll("\\+", "%20") + "\";");
        response.setHeader("Content-Transfer-Encoding", "binary");
        response.getOutputStream().write(fileByte);
        response.getOutputStream().flush();
        response.getOutputStream().close();
        
        return null;
    }
	
	//파일 삭제
	//나중에 파일 삭제 권한 체크 만들기 
	@RequestMapping("delete/{dv_id:.+}")
	@ResponseBody	
    public int fileDelete(@PathVariable("dv_id") String dv_id, Principal principal) throws IOException {
        System.out.println("Start - Method 'fileDelete' in Class 'DriveController'");
        int result = 0;
        //삭제할 파일 경로 관련 변수 설정
        String filePath = WebMvcConfig.RESOURCE_PATH + "/drive";
        String fileNameWithPath = filePath + "/" + dv_id;
        System.out.println("fileNameWithPath: " + fileNameWithPath);
        
		//DB에서 해당 파일 정보 가져오기
		DriveFileInfo driveFileInfo = driveService.selectOneDriveFileInfo(dv_id);
		String m_id = driveFileInfo.getM_id();
		String dv_filename = driveFileInfo.getDv_filename();
		int cg_num = driveFileInfo.getCg_num();
		
		//서버에서 파일 삭제
        int resultOfDeleteFile = driveService.deleteFile(fileNameWithPath);
        //DB에서 파일 정보 삭제
        int resultOfDeleteFileInfo = driveService.deleteFileInfo(driveFileInfo);
        
        result = resultOfDeleteFile + 10 * resultOfDeleteFileInfo;
        System.out.println("resultCode: " + result);
        
        return result;
    }
		
	//admin 권한 테스트 페이지
	@RequestMapping("admin")
	public String admin(Model model) {
		return "drive/admin";
	}
}
