package com.example.sproject.dao.address;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.sproject.model.address.Address_Group;
import com.example.sproject.model.address.Department;
import com.example.sproject.model.address.Position;
import com.example.sproject.model.login.Member;

@Repository
public class AddressDaoImpl implements AddressDao {

	@Autowired
	private SqlSession session;
	
	@Override
	public int tot() {
		System.out.println("addressDaoImpl tot Start ..." );
		int tot = session.selectOne("memberCntOfAddress");
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
		int tot = session.selectOne("personalCntOfAddress", adg_num);
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

	@Override
	public void groupDelete(Address_Group addressGroup) {
		System.out.println("addressDaoImpl groupDelete Start ..." );
		session.delete("addressDelOfAddress", addressGroup);
		session.delete("groupDelOfAddress", addressGroup);
	}

	@Override
	public void groupNameUpdate(Address_Group addressGroup) {
		System.out.println("addressDaoImpl groupNameUpdate Start ..." );
		session.update("groupNameUpdateOfAddress", addressGroup);
	}

	@Override
	public List<Department> listDeptGroup() {
		System.out.println("addressDaoImpl listDeptGroup Start ..." );
		List<Department> listDeptGroup = session.selectList("listDeptGroupOfAddress");
		return listDeptGroup;
	}

	@Override
	public int totDept(String dpt_code) {
		System.out.println("addressDaoImpl totDept Start ..." );
		int tot = session.selectOne("deptCntOfAddress", dpt_code);
		return tot;
	}

	@Override
	public List<Member> listDeptGroup(Member member) {
		System.out.println("addressDaoImpl listDeptGroup Start ...");
		List<Member> listDeptGroup = null;
		try {
			listDeptGroup = session.selectList("DeptGroupListOfAddress", member);
		} catch (Exception e) {
			System.out.println("addressDaoImpl listDeptGroup Exception->"+e.getMessage());
		}
		return listDeptGroup;
	}

	@Override
	public List<Member> addressSearchListDept(Member member) {
		List<Member> addressSearchListDept = null;
		System.out.println("addressDaoImpl addressSearchListDept Start ..." );
		try {
			addressSearchListDept = session.selectList("searchListDeptOfAddress", member);
			System.out.println("after session.selectList");
		} catch (Exception e) {
			System.out.println("addressDaoImpl addressSearchListDept Exception->"+e.getMessage());
		}
		return addressSearchListDept;
	}

	@Override
	public List<Member> addressSearchListPersonal(Member member) {
		List<Member> addressSearchListPersonal = null;
		System.out.println("addressDaoImpl addressSearchListPersonal Start ..." );
		try {
			addressSearchListPersonal = session.selectList("searchListPersonalOfAddress", member);
			System.out.println("after session.selectList");
		} catch (Exception e) {
			System.out.println("addressDaoImpl addressSearchListPersonal Exception->"+e.getMessage());
		}
		return addressSearchListPersonal;
	}

	@Override
	public void memberDelete(ArrayList<String> deleteArray, int adg_num) {
		System.out.println("addressDaoImpl memberDelete Start ..." );
		for(int i = 0; i < deleteArray.size(); i++) {
			String m_id = deleteArray.get(i);
			Map<String,Object> map = new HashMap<String,Object>();
			map.put("m_id", m_id);
			map.put("adg_num", adg_num);
			session.delete("memberDeleteOfAddress", map);
		}
	}

	@Override
	public void addressGroup(List<String> groupList, int adg_num) {
		System.out.println("addressDaoImpl memberDelete Start ..." );
		for(int i = 0; i < groupList.size(); i++) {
			String m_id = groupList.get(i);
			Map<String,Object> map = new HashMap<String,Object>();
			map.put("m_id", m_id);
			map.put("adg_num", adg_num);
			session.insert("memberGroupOfAddress", map);
		}
	}

	@Override
	public List<Position> listPtGroup() {
		System.out.println("addressDaoImpl memberDelete Start ..." );
		List<Position> listPtGroup = session.selectList("listPtGroupOfAddress");
		return listPtGroup;
	}

	@Override
	public void addressAdd(Member member) {
		System.out.println("addressDaoImpl addressAdd Start ..." );
		session.insert("addressAddOfAddress", member);
	}
}
