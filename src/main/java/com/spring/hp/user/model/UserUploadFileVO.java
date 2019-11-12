package com.spring.hp.user.model;

import lombok.Data;

@Data
public class UserUploadFileVO {
	private int fileId;
	private String userId;
	private String fileName;
	private long fileSize;
	private String fileContentType;
	private byte[] fileData;
	
}
