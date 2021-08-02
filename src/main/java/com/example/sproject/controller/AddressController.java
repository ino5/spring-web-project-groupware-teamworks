	package com.example.sproject.controller;

import java.security.Principal;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.sproject.model.address.Address_Group;
import com.example.sproject.model.address.Department;
import com.example.sproject.model.address.Position;
import com.example.sproject.model.login.Member;
import com.example.sproject.service.address.AddressService;
import com.example.sproject.service.address.Paging;

@Controller
@RequestMapping("address")
public class AddressController {
	
	@Autowired
	private AddressService adds;
	
	@RequestMapping("")
	public String index(Principal principal, Member member, Department department, String currentPage, Model model) {
		System.out.println("AddressController Start index..." );
		String m_id = principal.getName();
		int total = adds.total();
		Paging pg = new Paging(total, currentPage);
		member.setStart(pg.getStart());   // 시작시 1
		member.setEnd(pg.getEnd());       // 시작시 10 
		List<Member> listMember = adds.listMember(member);
		List<Address_Group> listAddressGroup = adds.listAddressGroup(m_id);
		List<Department> listDeptGroup = adds.listDeptGroup();
		List<Position> listPtGroup = adds.listPtGroup();
		model.addAttribute("total", total); 
		model.addAttribute("listMember",listMember); 
		model.addAttribute("listAddressGroup",listAddressGroup); 
		model.addAttribute("listDeptGroup",listDeptGroup); 
		model.addAttribute("listPtGroup",listPtGroup); 
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
		List<Department> listDeptGroup = adds.listDeptGroup();
		model.addAttribute("total", total); 
		model.addAttribute("listPersonalGroup",listPersonalGroup); 
		model.addAttribute("listAddressGroup",listAddressGroup); 
		model.addAttribute("listDeptGroup",listDeptGroup); 
		model.addAttribute("adg_num",adg_num);
		model.addAttribute("pg",pg);
		return "address/addressPersonal"; 
	}

	@RequestMapping(value="addressSearchList")
	@ResponseBody
	public List<Member> addressSearchList(Member member) {
		System.out.println("AddressController Start addressSearchList..." );
		List<Member> listSearch = adds.listSearch(member);
		return listSearch;
	}
	
	@RequestMapping(value="addressSearchListDept")
	@ResponseBody
	public List<Member> addressSearchListDept(Member member){
		System.out.println("AddressController Start addressSearchListDept..." );
		List<Member> addressSearchListDept = adds.addressSearchListDept(member);
		return addressSearchListDept;
	}
	
	@RequestMapping(value="addressSearchListPersonal")
	@ResponseBody
	public List<Member> addressSearchListPersonal(Member member){
		System.out.println("AddressController Start addressSearchListPersonal..." );
		List<Member> addressSearchListPersonal = adds.addressSearchListPersonal(member);
		return addressSearchListPersonal;
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
	
	@RequestMapping(value="dept")
	public String deptGroup(Principal principal, String dpt_code, Member member, String currentPage, Model model) {
		System.out.println("AddressController Start personalGroup..." );
		String m_id = principal.getName();
		int total = adds.totalDept(dpt_code);
		Paging pg = new Paging(total, currentPage);
		member.setStart(pg.getStart());   // 시작시 1
		member.setEnd(pg.getEnd());       // 시작시 10 
		List<Member> listDeptGroupMember = adds.listDeptGroup(member);
		List<Department> listDeptGroup = adds.listDeptGroup();
		List<Address_Group> listAddressGroup = adds.listAddressGroup(m_id);
		model.addAttribute("total", total); 
		model.addAttribute("listDeptGroupMember",listDeptGroupMember); 
		model.addAttribute("listDeptGroup",listDeptGroup); 
		model.addAttribute("listAddressGroup",listAddressGroup); 
		model.addAttribute("pg",pg);
		model.addAttribute("dpt_code", dpt_code);
		return "address/addressDept"; 
	}
	
	@RequestMapping(value="addressDelete", method= {RequestMethod.GET, RequestMethod.POST})
	@ResponseBody
	public void memberDelete(@RequestParam(value="checkArray[]") List<String> deleteList, Model model, int adg_num) {
//	     Ajax를 통해 Array로 받은 "deleteList"를 하나씩 빼내어 ArrayList에 넣음 
	    ArrayList<String> deleteArray = new ArrayList<String>();
	    for(int i=0;i<deleteList.size();i++){
	        deleteArray.add(deleteList.get(i));
	    }
	    adds.memberDelete(deleteArray, adg_num);
	}
	
	@RequestMapping(value="addressInsert")
	public String addressInsert(Principal principal, Member member, Model model) {
		System.out.println("AddressController Start addressInsert..." );
		String m_id = principal.getName();
		List<Address_Group> listAddressGroup = adds.listAddressGroup(m_id);
		List<Department> listDeptGroup = adds.listDeptGroup();
		model.addAttribute("listAddressGroup",listAddressGroup); 
		model.addAttribute("listDeptGroup",listDeptGroup); 
		return "address/addressInsert";
	}
	
	@RequestMapping(value="addressGroup", method= {RequestMethod.GET, RequestMethod.POST})
	@ResponseBody
	public void addressGroup(@RequestParam(value="checkArray[]") List<String> groupList, Model model, int adg_num) {
		System.out.println("AddressController Start addressGroup..." );
//	     Ajax를 통해 Array로 받은 "deleteList"를 하나씩 빼내어 ArrayList에 넣음 
	    ArrayList<String> GroupArray = new ArrayList<String>();
	    for(int i=0;i<groupList.size();i++){
	    	GroupArray.add(groupList.get(i));
	    }
	    adds.addressGroup(groupList, adg_num);
	}
	
	@RequestMapping(value="addressAdd", method = RequestMethod.POST)
	public String addressAdd(Member member) {
		System.out.println("AddressController Start addressAdd..." );
		UUID uid = UUID.randomUUID();
		member.setM_id(uid.toString());
		adds.addressAdd(member);
		return "redirect:/address";
	}
}
