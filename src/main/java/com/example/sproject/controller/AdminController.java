package com.example.sproject.controller;

import java.security.Principal;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.sproject.model.login.Member;
import com.example.sproject.service.admin.AdminService;
import com.example.sproject.service.admin.Paging;
import com.example.sproject.service.login.LoginService;

@Controller
@RequestMapping("admin")
public class AdminController {
	
	@Autowired
	private LoginService loginService;
	
	@Autowired
	private AdminService adminservice;
	//리스트 띄어주기
	@GetMapping("admin")
	public String list(Principal principal, Model model, Member member, String currentPage){
		System.out.println("AdminController Start list...");
		int total = adminservice.total();
		//입력받은 currentpage가 null일 때 1로 바꿔주기
				if(currentPage == null || "".equals(currentPage)) {
					currentPage = "1";
				}
		Paging pg = new Paging(total, currentPage);
		member.setStart(pg.getStart());
		member.setEnd(pg.getEnd());
		List<Member> listMember = adminservice.listMember(member);
		model.addAttribute("total", total); 
		model.addAttribute("listMember",listMember); 
		model.addAttribute("pg",pg);
  	return "admin/admin";
	}
	
	@PostMapping("admin")
	public String joinPost(Member member) {
		System.out.println("Method joinPost in Class LoginController");
		loginService.join(member);
		System.out.println("after loginService.join(member)");
		return "redirect:/login/login";
	}
	//직위 변경하기
	  @RequestMapping(value="adminGroup", method= {RequestMethod.GET, RequestMethod.POST})
	   @ResponseBody
	   public void adminGroup(@RequestParam(value="checkArray[]", required=false) List<String> groupList, Model model, String pt_code, Member member) {
//	        Ajax를 통해 Array로 받은 "deleteList"를 하나씩 빼내어 ArrayList에 넣음 
		  System.out.println("adminGroup Controller Start");
	       ArrayList<String> GroupArray = new ArrayList<String>();
	       for(int i=0;i<groupList.size();i++){
	          GroupArray.add(groupList.get(i));
	       }
	       adminservice.adminGroup(groupList, pt_code);
	   }
	  
	  //비밀번호 변경하기 
	  @RequestMapping(value="adminPassWordChangeGroup", method= {RequestMethod.GET, RequestMethod.POST})
	   @ResponseBody  
	  public void adminPassWordChangeGroup(@RequestParam(value="checkArray[]", required=false) List<String> groupList, Model model,Member member) {
		  System.out.println("adminPassWordChangeGroup Controller Start");
	       ArrayList<String> GroupArray = new ArrayList<String>();
	       for(int i=0;i<groupList.size();i++){
	          GroupArray.add(groupList.get(i));
	       }
	       adminservice.adminPassWordChangeGroup(groupList,member);
	   }
	  
	// 삭제
	   @RequestMapping(value="admindDeleteGroup", method= {RequestMethod.GET, RequestMethod.POST})
	   @ResponseBody
	   public void admindDeleteGroup(@RequestParam(value="checkArray[]", required=false) List<String> groupList, Model model) {
		   System.out.println("확인");
	       ArrayList<String> GroupArray = new ArrayList<String>();
	       for(int i=0;i<groupList.size();i++){
	          GroupArray.add(groupList.get(i));
	       }
	       adminservice.admindDeleteGroup(groupList);
	   }
	@RequestMapping("")
	public String index2(Model model) {
		return "admin/main";
	}

	// 아이디 중복검사
	@ResponseBody
	@PostMapping(value = "/checkID")
	public int checkID(Member member, Model model, String m_id) throws Exception {
		int result = adminservice.checkID(m_id);
		return result;
	}
	
	@ResponseBody
	@PostMapping(value = "/memberAllList")
	public List<Member> memberAllList(Model model) throws Exception {
		System.out.println("!!!");
		System.out.println(adminservice.memberAllList());
		
		return adminservice.memberAllList();
	}
	
	
}
