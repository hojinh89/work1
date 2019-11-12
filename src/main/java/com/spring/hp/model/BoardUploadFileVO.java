package com.spring.hp.model;

import lombok.Data;

@Data
public class BoardUploadFileVO {
	private int fileId;
	private int boardNo;
	private String fileName;
	private long fileSize;
	private String fileContentType;
	private byte[] fileData;
	
}
