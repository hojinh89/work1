package com.spring.hp.reply.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.spring.hp.commons.paging.Criteria;
import com.spring.hp.reply.model.ReplyVO;
import com.spring.hp.reply.repository.IReplyDAO;
import com.spring.hp.repository.IBoardDAO;

@Service
public class ReplyService implements IReplyService{

	@Autowired
	private IReplyDAO replyDao;
	
	@Autowired
	private IBoardDAO boardDao;
	
	
	@Override
	public List<ReplyVO> list(int boardNo) throws Exception {
		return replyDao.list(boardNo);
	}

	@Transactional
	@Override
	public void insert(ReplyVO reply) throws Exception {
		System.out.println("insert service 시작");
		
		int maxP = replyDao.maxParentId();
		reply.setParentId(maxP+1);
		
		replyDao.insert(reply);
		boardDao.updateReplyCnt(reply.getBoardNo(), 1);
		
	}

	@Override
	public void update(ReplyVO reply) throws Exception {
		replyDao.update(reply);		
	}
	
	@Transactional
	@Override
	public void delete(int replyNo, int boardNo) throws Exception {
		boardDao.updateReplyCnt(boardNo, -1);
		replyDao.delete(replyNo);
		
	}

	@Override
	public List<ReplyVO> listPaging(int boardNo, Criteria cri) throws Exception {
		System.out.println("reply listpaging테스트");
		return replyDao.listPaging(boardNo, cri);
	}

	@Override
	public void deleteAll(int boardNo) throws Exception {
		replyDao.deleteAll(boardNo);
		
	}

	@Override
	public int countReplies(int boardNo) throws Exception {
		return replyDao.countReplies(boardNo);
	
	}

	@Transactional
	@Override
	public void reReplyinsert(Map<String, Object> params) throws Exception {
		
		//parent_id, depth 최대값 구하기
		int getP = replyDao.getParentId(Integer.parseInt((String) params.get("upperNo"))) ;
		int maxD = replyDao.maxDepth(getP);
		
		System.out.println("uppderNo: " + params.get("upperNo") + "getP : " + getP + "replydao.maxpepth : " + replyDao.maxDepth(getP));
		
		ReplyVO reply = new ReplyVO();
		
		
		//맵으로받은 params와 db에서 검색한 parent_id, depth 데이터 모두 reply클래스에 할당
		reply.setParentId(getP);
		reply.setDepth(maxD+1);
		reply.setBoardNo(Integer.parseInt((String) params.get("boardNo")));
        reply.setReplyWriter((String)params.get("replyWriter"));
		reply.setReplyText((String)params.get("replyText"));
		
		System.out.println("replyVO : " + reply.toString());
		
		//boardVO의 댓글 카운트+1
		boardDao.updateReplyCnt(reply.getBoardNo(), 1);
		
		replyDao.reReplyinsert(reply);
	
	}

	@Override
	public void deleteReplies(int parentNo) throws Exception {
		replyDao.deleteReplies(parentNo);
		
	}

	@Override
	public ReplyVO getReply(int replyNo) throws Exception {
		return replyDao.getReply(replyNo);
	}

}
