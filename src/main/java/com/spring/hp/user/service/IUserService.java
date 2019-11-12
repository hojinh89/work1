package com.spring.hp.user.service;

import java.util.Date;

import com.spring.hp.model.BoardUploadFileVO;
import com.spring.hp.user.model.LoginVO;
import com.spring.hp.user.model.UserUploadFileVO;
import com.spring.hp.user.model.UserVO;

public interface IUserService {

	void register(UserVO user) throws Exception;
	UserVO login(LoginVO login) throws Exception;
	int isDuplicateId(String userId) throws Exception;
	void keepLogin(String userId, String sessionId, Date sessionLimit) throws Exception;
	public UserVO getUserWithSessionId(String sessionId) throws Exception;	
	
	
	void register(UserVO user, UserUploadFileVO file) throws Exception;
		
	//파일업로드-프로필사진
	void insertFile(UserUploadFileVO file) throws Exception;
	//파일정보 가져오기 - 유저아이디기준
	UserUploadFileVO getFile(String userId) throws Exception;
	

	
}
