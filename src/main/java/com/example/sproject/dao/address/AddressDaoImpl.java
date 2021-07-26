package com.example.sproject.dao.address;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.sproject.model.address.Address_Group;
import com.example.sproject.model.login.Member;

@Repository
public class AddressDaoImpl implements AddressDao {

	@Autowired
	private SqlSession session;
	
	@Override
	public int tot() {
		System.out.println("addressDaoImpl tot Start ..." );
		int tot = session.selectOne("memberCnt");
		return tot;
	}

	@Override
	public List<Member> listMember(Member member) {
		List<Member> memberList = null;
		System.out.println("addressDaoImpl listMember Start ..." );
		try {
		memberList = session.selectList("memberListOfAddress", member);
		} catch (Exception e) {
			System.out.println("addressDaoImpl listMember Exception->"+e.getMessage());
		}
		return memberList;
	}

	@Override
	public List<Address_Group> listAddressGroup(String m_id) {
		System.out.println("addressDaoImpl listAddressGroup Start ..." );
		System.out.println("m_id >>>>"+ m_id);
		List<Address_Group> addressGroupList = session.selectList("addressGroupListOfAddress", m_id);
		return addressGroupList;
	}
	
	@Override
	public int totPersonal(int adg_num) {
		System.out.println("addressDaoImpl totPersonal Start ..." );
		int tot = session.selectOne("personalCnt", adg_num);
		return tot;
	}

	@Override
	public List<Member> listPersonalGroup(Member member) {
		System.out.println("addressDaoImpl listPersonalGroup Start ...");
		List<Member> groupMemberList = null;
		try {
			groupMemberList = session.selectList("personalGroupListOfAddress", member);
		} catch (Exception e) {
			System.out.println("addressDaoImpl listPersonalGroup Exception->"+e.getMessage());
		}
		return groupMemberList;
	}

	@Override
	public List<Member> searchList(Member member) {
		List<Member> memberList = null;
		System.out.println("addressDaoImpl searchList Start ..." );
		try {
			memberList = session.selectList("searchListOfAddress", member);
			System.out.println("after session.selectList");
		} catch (Exception e) {
			System.out.println("addressDaoImpl searchList Exception->"+e.getMessage());
		}
		return memberList;
	}

	@Override
	public int searchTotal(Member member) {
		System.out.println("addressDaoImpl searchTotal Start ..." );
		int searchTotal = session.selectOne("searchTotalOfAddress", member);
		return searchTotal;
	}

	@Override
	public void simpleAdd(Member member) {
		System.out.println("addressDaoImpl simpleAdd Start ..." );
		session.insert("simpleAddOfAddess", member);
	}

	@Override
	public void groupAdd(Address_Group addressGroup) {
		System.out.println("addressDaoImpl groupAdd Start ..." );
		session.insert("groupAddOfAddress", addressGroup);
	}

}
