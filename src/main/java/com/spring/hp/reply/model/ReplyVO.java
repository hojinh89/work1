package com.spring.hp.reply.model;

import java.util.Date;

import lombok.Data;

@Data
public class ReplyVO {
	
	private int replyNo;
	private int boardNo;
	private String replyText;
	private String replyWriter;
	private Date regDate;
	private Date updateDate;
	
	//대댓관련
	private int parentId;
	private int depth;
	
	

}
