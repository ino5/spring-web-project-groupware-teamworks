package com.example.sproject.service.login;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.example.sproject.dao.login.LoginDao;
import com.example.sproject.model.login.Member;

@Service
public class LoginServiceImpl implements LoginService {

	@Autowired
	private LoginDao loginDao;

	@Autowired
	private PasswordEncoder passwordEncoder;

	@Override
	public UserDetails loadUserByUsername(String m_id) throws UsernameNotFoundException {
		System.out.println("--Method loadUserByUsername");
		System.out.println("m_id: " + m_id);
		Member member = loginDao.getUserById(m_id);
		if (null == member) {
			throw new UsernameNotFoundException("Member Not Found");
		}
		return member;
	}

	@Override
	public int join(Member member) {
		System.out.println("--Method join in Class LoginServiceImpl");
		int result = 0;
		member.setM_password(passwordEncoder.encode(member.getM_password()));
		result = loginDao.insertMember(member);
		System.out.println("result: " + result);
		return result;
	}

	@Override
	public int passwordCheck(Member member) {
		System.out.println("--Method passwordCheck in Class LoginServiceImpl");
		int result = 0;
		System.out.println("id of Session: " + member.getM_id());
		Member memberOfDb = (Member) loadUserByUsername(member.getM_id());
		boolean isEqual = passwordEncoder.matches(member.getM_password(), memberOfDb.getM_password());
		result = (isEqual) ? 1 : 0;
		System.out.println("result: " + result);
		return result;
	}

}
