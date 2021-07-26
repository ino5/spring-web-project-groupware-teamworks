package com.example.sproject.dao.address;

import java.util.List;

import com.example.sproject.model.address.AddressGroup;
import com.example.sproject.model.login.Member;

public interface addressDao {

	int tot();

	List<Member> listMember(Member member);

	List<AddressGroup> listAddressGroup(String m_id);

	List<Member> listPersonalGroup(Member member);

	int totPersonal(int adg_num);

}
