package com.example.sproject.model.login;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Collection;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import lombok.Data;

@Data
@SuppressWarnings("serial")
public class Member implements UserDetails{
	public static final String usernameParameter = "m_id";
	public static final String passwordParameter = "m_password";
	
	private String m_id;
	private String m_password;
	private String m_name;
	private int m_empnum;
	private String m_birth;
	private String m_exnum;
	private String m_phone;
	private String m_email;
	private String dpt_code;
	private String pt_code;
	private Timestamp m_lastdate;
	private int m_status;
	
//	position
	private String pt_name;
//	department
	private String dpt_name;
//  address
	private int adg_num;
	// 조회용
	private String search;   private String keyword;
	private String pageNum;  
	private int start; 		 private int end;
	
	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		ArrayList<SimpleGrantedAuthority> grants = new ArrayList<SimpleGrantedAuthority>();
		grants.add(new SimpleGrantedAuthority("ROLE_MEMBER"));
		return grants;
	}
	@Override
	public String getPassword() {
		return m_password;
	}
	@Override
	public String getUsername() {
		// TODO Auto-generated method stub
		return m_id;
	}
	@Override
	public boolean isAccountNonExpired() {
		// TODO Auto-generated method stub
		return true;
	}
	@Override
	public boolean isAccountNonLocked() {
		// TODO Auto-generated method stub
		return true;
	}
	@Override
	public boolean isCredentialsNonExpired() {
		// TODO Auto-generated method stub
		return true;
	}
	@Override
	public boolean isEnabled() {
		// TODO Auto-generated method stub
		return true;
	}
}
