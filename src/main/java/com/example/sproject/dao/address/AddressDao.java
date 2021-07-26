package com.example.sproject.dao.address;

import java.util.List;

import com.example.sproject.model.address.AddressGroup;
import com.example.sproject.model.login.Member;

public interface AddressDao {

	int tot();

	List<Member> listMember(Member member);

	List<AddressGroup> listAddressGroup(String m_id);

	List<Member> listPersonalGroup(Member member);

	int totPersonal(int adg_num);

	List<Member> searchList(Member member);

	int searchTotal(Member member);

	int simpleAdd(Member member);

}
