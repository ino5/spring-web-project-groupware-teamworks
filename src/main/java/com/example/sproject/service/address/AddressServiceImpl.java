package com.example.sproject.service.address;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.sproject.dao.address.AddressDao;
import com.example.sproject.model.address.AddressGroup;
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
	public List<AddressGroup> listAddressGroup(String m_id) {
		List<AddressGroup> addressGroupList = addDao.listAddressGroup(m_id);
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
	public int simpleAdd(Member member) {
		int simpleAdd = addDao.simpleAdd(member);
		return 0;
	}
}
