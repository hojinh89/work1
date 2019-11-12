package com.spring.hp.reply.repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.hp.commons.paging.Criteria;
import com.spring.hp.reply.model.ReplyVO;

@Repository
public class ReplyDAO implements IReplyDAO{
	
	
	@Autowired
	private SqlSession sqlSession;	
	
	private static final String NAMESPACE = "ReplyMapper";
	

	
	@Override
	public List<ReplyVO> list(int boardNo) throws Exception {
		System.out.println("댓글 리스트");
		
		return sqlSession.selectList(NAMESPACE + ".list", boardNo);
	}

	@Override
	public void insert(ReplyVO reply) throws Exception {
		System.out.println("댓글 삽입");
		
		sqlSession.insert(NAMESPACE + ".insert", reply);
	}

	@Override
	public void update(ReplyVO reply) throws Exception {
		System.out.println("댓글 수정");
		sqlSession.update(NAMESPACE+".update", reply);
		
	}

	@Override
	public void delete(int replyNo) throws Exception {
		System.out.println("댓글 삭제");
		sqlSession.delete(NAMESPACE + ".delete", replyNo);
		
	}

	@Override
	public List<ReplyVO> listPaging(int boardNo, Criteria cri) throws Exception {
		System.out.println("페이징 처리된 댓글목록");
		Map<String, Object> datas = new HashMap<>();
		datas.put("boardNo", boardNo);
		datas.put("criteria", cri);
		
		return sqlSession.selectList(NAMESPACE + ".listPaging",datas);
	}

	@Override
	public void deleteAll(int boardNo) throws Exception {
		
		sqlSession.delete(NAMESPACE+".deleteAll", boardNo);
	}

	@Override
	public int countReplies(int boardNo) throws Exception {
		return sqlSession.selectOne(NAMESPACE + ".countReplies", boardNo);
	}

	@Override
	public void reReplyinsert(ReplyVO reply) throws Exception {
		sqlSession.insert(NAMESPACE+".reReplyinsert", reply);
		
	}

	@Override
	public int maxParentId() throws Exception {
		return sqlSession.selectOne(NAMESPACE+".maxParentId");
	}

	@Override
	public int getParentId(int upperNo) throws Exception {
		return sqlSession.selectOne(NAMESPACE+".getParentId", upperNo);
	}

	@Override
	public int maxDepth(int parentId) throws Exception {
		return sqlSession.selectOne(NAMESPACE+".maxDepth", parentId);
	}

	@Override
	public void deleteReplies(int parentNo) throws Exception {
		sqlSession.delete(NAMESPACE+".deleteReplies", parentNo);
		
	}

	
	@Override
	public ReplyVO getReply(int replyNo) throws Exception {
		return sqlSession.selectOne(NAMESPACE+".getReply", replyNo);
	}

	
}
