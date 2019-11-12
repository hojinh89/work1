package com.spring.hp.reply.service;

import java.util.List;
import java.util.Map;

import com.spring.hp.commons.paging.Criteria;
import com.spring.hp.reply.model.ReplyVO;

public interface IReplyService {
	
	//댓글 목록 불러오기
		List<ReplyVO> list(int boardNo) throws Exception;
		
		//댓글 쓰기 기능
		void insert(ReplyVO reply) throws Exception;
		
		//댓글 수정 기능
		void update(ReplyVO reply) throws Exception;
		
		//댓글 삭제 기능
		void delete(int replyNo, int boardNo) throws Exception;
		
		List<ReplyVO> listPaging(int boardNo, Criteria cri) throws Exception;
		
		
		//원본 게시물 댓글 전체 삭제
		void deleteAll(int boardNo) throws Exception;
			
		//특정 게시물의 총 댓글 수 불러오기 기능
		int countReplies(int boardNo) throws Exception;

		/////////////////////////////////
		void reReplyinsert(Map<String, Object> params) throws Exception;
		void deleteReplies(int parentNo) throws Exception;
		
		ReplyVO getReply(int replyNo) throws Exception;
		

}
