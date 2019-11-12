package com.spring.hp.reply.repository;

import java.util.List;

import com.spring.hp.commons.paging.Criteria;
import com.spring.hp.reply.model.ReplyVO;

public interface IReplyDAO {
	
	//댓글 목록 불러오기
	List<ReplyVO> list(int boardNo) throws Exception;
	
	//댓글 쓰기 기능
	void insert(ReplyVO reply) throws Exception;
	
	//댓글 수정 기능
	void update(ReplyVO reply) throws Exception;
	
	//댓글 삭제 기능
	void delete(int replyNo) throws Exception;
	
	List<ReplyVO> listPaging(int boardNo, Criteria cri) throws Exception;
	
	
	//원본 게시물 댓글 전체 삭제
	void deleteAll(int boardNo) throws Exception;
		
	//특정 게시물의 총 댓글 수 불러오기 기능
	int countReplies(int boardNo) throws Exception;

	//////////////////////////대댓용
	//대댓 쓰기
	void reReplyinsert(ReplyVO reply) throws Exception;
	
	//대댓 max(parent_id)계산
	int maxParentId() throws Exception;
	
	int getParentId(int upperNo) throws Exception;
	int maxDepth(int parentId) throws Exception;
	

	void deleteReplies(int parentNo) throws Exception;
	
	ReplyVO getReply(int replyNo) throws Exception;


	
}
