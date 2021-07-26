package com.example.sproject.service.address;

import java.util.List;

import com.example.sproject.model.address.Address_Group;
import com.example.sproject.model.login.Member;

public interface AddressService {

	int total();

	List<Member> listMember(Member member);

	List<Address_Group> listAddressGroup(String m_id);

	List<Member> listPersonalGroup(Member member);

	int totalPersonal(int adg_num);

	List<Member> listSearch(Member member);

	int searchTotal(Member member);

	void simpleAdd(Member member);

	void groupAdd(Address_Group addressGroup);

}
