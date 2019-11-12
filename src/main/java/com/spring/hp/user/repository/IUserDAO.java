package com.spring.hp.user.repository;



import java.util.Map;

import com.spring.hp.user.model.LoginVO;
import com.spring.hp.user.model.UserUploadFileVO;
import com.spring.hp.user.model.UserVO;


public interface IUserDAO {
	
	void register(UserVO user) throws Exception;
	UserVO login(LoginVO login) throws Exception;
	int isDuplicateId(String userId) throws Exception;
	//void keepLogin(String userId, String sessionId, Date sessionLimit) throws Exception;
	void keepLogin(Map<String, Object> datas) throws Exception;
	
	public UserVO getUserWithSessionId(String sessionId) throws Exception;
	
	//유저용 파일업로드
	void registerFile(UserUploadFileVO file) throws Exception;
	//유저 db에서 파일 불러오기
	UserUploadFileVO getFile(String userId) throws Exception;
	
	//파일업로드-프로필사진 (board꺼 사용중)
	void insertFile(UserUploadFileVO file) throws Exception;
	
	int chkFile(String userId) throws Exception;
	void updateFile(UserUploadFileVO file) throws Exception;
}
