package com.example.sproject.service.address;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.sproject.dao.address.AddressDao;
import com.example.sproject.model.address.Address_Group;
import com.example.sproject.model.address.Department;
import com.example.sproject.model.login.Member;

@Service
public class AddressServiceImpl implements AddressService {
	
	@Autowired
	private AddressDao addDao;
	
	@Override
	public int total() {
		int totCnt = addDao.tot();
		return totCnt;
	}

	@Override
	public List<Member> listMember(Member member) {
		List<Member> memberList = null;
		memberList = addDao.listMember(member);
		return memberList;
	}

	@Override
	public List<Address_Group> listAddressGroup(String m_id) {
		List<Address_Group> addressGroupList = addDao.listAddressGroup(m_id);
		return addressGroupList;
	}

	@Override
	public List<Member> listPersonalGroup(Member member) {
		List<Member> listPersonalGroup = addDao.listPersonalGroup(member);
		return listPersonalGroup;
	}

	@Override
	public int totalPersonal(int adg_num) {
		int totCnt = addDao.totPersonal(adg_num);
		return totCnt;
	}

	@Override
	public List<Member> listSearch(Member member) {
		List<Member> memberList = addDao.searchList(member);
		return memberList;
	}

	@Override
	public int searchTotal(Member member) {
		int searchTotal = addDao.searchTotal(member);
		return searchTotal;
	}

	@Override
	public void simpleAdd(Member member) {
		addDao.simpleAdd(member);
	}

	@Override
	public void groupAdd(Address_Group addressGroup) {
		addDao.groupAdd(addressGroup);
	}

	@Override
	public void groupDelete(Address_Group addressGroup) {
		addDao.groupDelete(addressGroup);
	}

	@Override
	public void groupNameUpdate(Address_Group addressGroup) {
		addDao.groupNameUpdate(addressGroup);
	}

	@Override
	public List<Department> listDeptGroup() {
		List<Department> listDeptGroup = addDao.listDeptGroup();
		return listDeptGroup;
	}

	@Override
	public int totalDept(String dpt_code) {
		int totCnt = addDao.totDept(dpt_code);
		return totCnt;
	}

	@Override
	public List<Member> listDeptGroup(Member member) {
		List<Member> listDeptGroup = addDao.listDeptGroup(member);
		return listDeptGroup;
	}

	@Override
	public List<Member> addressSearchListDept(Member member) {
		List<Member> addressSearchListDept = addDao.addressSearchListDept(member);
		return addressSearchListDept;
	}

	@Override
	public List<Member> addressSearchListPersonal(Member member) {
		List<Member> addressSearchListPersonal = addDao.addressSearchListPersonal(member);
		return addressSearchListPersonal;
	}

	@Override
	public void memberDelete(ArrayList<String> deleteArray, int adg_num) {
		addDao.memberDelete(deleteArray, adg_num);
	}
}
