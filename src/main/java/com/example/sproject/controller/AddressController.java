package com.example.sproject.controller;

import java.security.Principal;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.sproject.model.address.AddressGroup;
import com.example.sproject.model.login.Member;
import com.example.sproject.service.address.AddressService;
import com.example.sproject.service.address.Paging;

@Controller
@RequestMapping("address")
public class AddressController {
	
	@Autowired
	private AddressService adds;
	
	@RequestMapping("")
	public String index(Principal principal, Member member, String currentPage, Model model) {
		System.out.println("AddressController Start index..." );
		String m_id = principal.getName();
		int total = adds.total();
		Paging pg = new Paging(total, currentPage);
		member.setStart(pg.getStart());   // 시작시 1
		member.setEnd(pg.getEnd());       // 시작시 10 
		List<Member> listMember = adds.listMember(member);
		List<AddressGroup> listAddressGroup = adds.listAddressGroup(m_id);
		model.addAttribute("total", total); 
		model.addAttribute("listMember",listMember); 
		model.addAttribute("listAddressGroup",listAddressGroup); 
		model.addAttribute("pg",pg);
		return "address/address"; 
	}
	
	@RequestMapping(value="personal")
	public String personalGroup(Principal principal, int adg_num, Member member, String currentPage, Model model) {
		System.out.println("AddressController Start personalGroup..." );
		String m_id = principal.getName();
		int total = adds.totalPersonal(adg_num);
		Paging pg = new Paging(total, currentPage);
		member.setStart(pg.getStart());   // 시작시 1
		member.setEnd(pg.getEnd());       // 시작시 10 
		List<Member> listPersonalGroup = adds.listPersonalGroup(member);
		List<AddressGroup> listAddressGroup = adds.listAddressGroup(m_id);
		model.addAttribute("total", total); 
		model.addAttribute("listPersonalGroup",listPersonalGroup); 
		model.addAttribute("listAddressGroup",listAddressGroup); 
		model.addAttribute("pg",pg);
		return "address/addressPersonal"; 
	}
//	@RequestMapping(value = "search.do", produces = "application/json")
//	@ResponseBody
//	public ResponseEntity<HashMap<String, Object>> testListDo(Member member, Model model) throws Exception {
//
//		HashMap<String, Object> result = new HashMap<>();
//		// 검색
//		member.pageInfo(listCnt);
//		// 페이징
//		result.put("pagination", search);
//		// 게시글 화면 출력
//		result.put("list", testServiceImpl.selectTest(search));
//
//		return ResponseEntity.ok(result);
	
}
