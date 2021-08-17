package com.example.sproject.service.login;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.session.SessionRegistry;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;

import com.example.sproject.configuration.WebMvcConfig;
import com.example.sproject.dao.login.LoginDao;
import com.example.sproject.model.login.Member;

@Service
public class LoginServiceImpl implements LoginService {

	@Autowired
	private LoginDao loginDao;

	@Autowired
	private PasswordEncoder passwordEncoder;
	
	@Autowired
	private SessionRegistry sessionRegistry;

	@Override
	public UserDetails loadUserByUsername(String m_id) throws UsernameNotFoundException {
		System.out.println("--Method loadUserByUsername");
		System.out.println("m_id: " + m_id);
		Member member = loginDao.getUserById(m_id);
		
		// 사용자 정보 없을 경우
		if (null == member) {
			throw new UsernameNotFoundException("Member Not Found");
//			return null; //null 처리 하는 경우
		
		// 사용자 정보 있을 경우 추가 로직 수행
		} else {
			// 권한 부여
			member.setAuthorities(loginDao.listAuthorities(m_id));
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

	@Override
	public List<Member> getSessionMembers() {
		List<Member> list = new ArrayList<Member>();
		
		//로그인 중인 멤버리스트 가져오기
		List<Object> listOfObject = sessionRegistry.getAllPrincipals();
				
		for (Object member : listOfObject) {
			if (member instanceof Member) {
				((Member) member).setM_password(null); //비밀번호 정보 삭제하기
			}
			list.add((Member) member);
		}
		
		return list;
	}

	@Override
	public int welcomeLogin(String m_id) {
		int result;
		result = loginDao.updateLastdateOfMember(m_id);
		return result;
	}

	@Override
	public int updateMemberPhoto(String m_id, MultipartFile multipartFile) {
		// 파일 경로 설정
		String uploadPath = WebMvcConfig.RESOURCE_PATH + "/member/photo";
		File fileDirectory = new File(uploadPath);
		if (!fileDirectory.exists()) {
			fileDirectory.mkdirs();
		}
			
		// 기존 파일 삭제
		File fileForDelete = new File(uploadPath+ "/" + m_id);
		if(fileForDelete.exists()) fileForDelete.delete();
		
		// 서버에 파일 저장
	    File target = new File(uploadPath, m_id+".jpg");    
		try {
			byte[] fileData = multipartFile.getBytes();
			System.out.println(multipartFile.getOriginalFilename());
			System.out.println(multipartFile.getSize());
			System.out.println(fileData);
			FileCopyUtils.copy(fileData, target);
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		// DB update
		loginDao.updateMemberPhoto(m_id);
	    
	    
	    return 1;
	}
}

