	package com.example.sproject.controller;

import java.security.Principal;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.sproject.model.address.Address_Group;
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
		List<Address_Group> listAddressGroup = adds.listAddressGroup(m_id);
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
		List<Address_Group> listAddressGroup = adds.listAddressGroup(m_id);
		model.addAttribute("total", total); 
		model.addAttribute("listPersonalGroup",listPersonalGroup); 
		model.addAttribute("listAddressGroup",listAddressGroup); 
		model.addAttribute("pg",pg);
		return "address/addressPersonal"; 
	}

	@RequestMapping(value="addressSearchList")
	@ResponseBody
	public List<Member> addressSearchList(Member member, String currentPage) {
		System.out.println("AddressController Start addressSearchList..." );
		int total = adds.searchTotal(member);
		Paging pg = new Paging(total, currentPage);
		member.setStart(pg.getStart());   // 시작시 1
		member.setEnd(pg.getEnd());       // 시작시 10 
		List<Member> listSearch = adds.listSearch(member);
		return listSearch;
	}
	
	@RequestMapping(value="simpleAdd")
	public String simpleAdd(Member member) {
		System.out.println("AddressController Start simpleAdd..." );
		UUID uid = UUID.randomUUID();
		member.setM_id(uid.toString());
		adds.simpleAdd(member);
		return "redirect:/address";
	}
	
	@RequestMapping(value="groupAdd")
	public String groupAdd(Principal principal, Address_Group addressGroup) {
		System.out.println("AddressController Start groupAdd..." );
		String m_id = principal.getName();
		addressGroup.setM_id(m_id);
		adds.groupAdd(addressGroup);
		return "redirect:/address";
	}
	
	@RequestMapping(value="groupDelete")
	public String groupDelete(Principal principal, Address_Group addressGroup) {
		System.out.println("AddressController Start groupDelete..." );
		String m_id = principal.getName();
		addressGroup.setM_id(m_id);
		adds.groupDelete(addressGroup);
		return "redirect:/address";
	}
	
	@RequestMapping(value="groupNameUpdate")
	public String groupNameUpdate(Principal principal, Address_Group addressGroup) {
		System.out.println("AddressController Start groupNameUpdate..." );
		String m_id = principal.getName();
		addressGroup.setM_id(m_id);
		adds.groupNameUpdate(addressGroup);
		return "redirect:/address";
	}
}
