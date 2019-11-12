package com.spring.hp.user.service;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.spring.hp.user.model.LoginVO;
import com.spring.hp.user.model.UserUploadFileVO;
import com.spring.hp.user.model.UserVO;
import com.spring.hp.user.repository.IUserDAO;

@Service
public class UserService implements IUserService{

	@Autowired
	private IUserDAO dao;
	
	@Override
	public void register(UserVO user) throws Exception {
		
		//회우너 비밀번호를 인코딩
		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		System.out.println("암호화전 : " + user.getUserPw());
				
		//비밀번호를 암호화하여 다시 user객체에 저장
		String securePw = encoder.encode(user.getUserPw());
		user.setUserPw(securePw);
		System.out.println("암호화후 : " + user.getUserPw());
		
		dao.register(user);
		
	}


	@Override
	public int isDuplicateId(String userId) throws Exception {
		return dao.isDuplicateId(userId);
	}

	
	@Override
	public UserVO login(LoginVO login) throws Exception {
		
		return dao.login(login);
	}


	@Override
	public void keepLogin(String userId, String sessionId, Date sessionLimit) throws Exception {
		
		Map<String, Object> datas= new HashMap<>();
		datas.put("userId", userId);
		datas.put("sessionId", sessionId);
		datas.put("sessionLimit", sessionLimit);
		
		dao.keepLogin(datas);
		
		//dao.keepLogin(userId, sessionId, sessionLimit);
		
	}


	@Override
	public UserVO getUserWithSessionId(String sessionId) throws Exception {
	
		return dao.getUserWithSessionId(sessionId);
	}


	@Override
	public void register(UserVO user, UserUploadFileVO file) throws Exception {
		System.out.println("user의 register service//////////////");
		dao.register(user);
		
		if(file != null && file.getFileName() != null && !file.getFileName().equals("")) {
			file.setUserId(user.getUserId());
			
			System.out.println("userId : " + file.getUserId());
			dao.registerFile(file);
			
		}
		
	}


	@Override
	public UserUploadFileVO getFile(String userId) throws Exception {
		return dao.getFile(userId);
	}


	@Override
	public void insertFile(UserUploadFileVO file) throws Exception {
		int boolFile = dao.chkFile(file.getUserId());
		
		if(boolFile == 0) {
			System.out.println("기존 사진이 없습니다.");
			dao.insertFile(file);
		}
		else if(boolFile == 1) {
			System.out.println("기존 사진이 있으므로 update");
			dao.updateFile(file);
		}
	}


}
