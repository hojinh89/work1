package com.spring.hp.model;

import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;



@Data
public class BoardVO {
	
	private int boardNo;
	private String title;
	private String content;
	private String writer;
	private Date regDate;
	private int viewCnt;
	private int replyCnt;
	
	
	private boolean newMark; 	// 신규게시물에 new 를띄울지 결정하는 논리필드
	
	//파일업로드
	//private MultipartFile file;
	private int fileId;
	private String fileName;
	private long fileSize;
	private String fileContentType;
	
	
}
