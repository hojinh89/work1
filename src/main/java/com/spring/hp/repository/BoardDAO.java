package com.spring.hp.repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.hp.commons.paging.Criteria;
import com.spring.hp.commons.paging.SearchCriteria;
import com.spring.hp.model.BoardUploadFileVO;
import com.spring.hp.model.BoardVO;

@Repository
public class BoardDAO implements IBoardDAO{


	private final SqlSession sqlSession;
	
	private static final String NAMESPACE = "BoardMapper";
	
	@Autowired
	 public BoardDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	
	@Override
	public void insert(BoardVO article) throws Exception {
		System.out.println("게시글 정보 : "+ article.toString());
		sqlSession.insert(NAMESPACE+".insert", article);
		
	}

	@Override
	public BoardVO getArticle(int boardNo) throws Exception {
		System.out.println("게시글번호" + boardNo);
		
		return sqlSession.selectOne(NAMESPACE+".getArticle", boardNo);
	}

	@Override
	public void modify(BoardVO article) throws Exception {
		System.out.println("수정할 게시판 내용 : " + article.toString());
		sqlSession.update(NAMESPACE+".modify", article);
	}

	@Override
	public void delete(int boardNo) throws Exception {
		
		sqlSession.delete(NAMESPACE+".delete", boardNo);
	}

	@Override
	public List<BoardVO> getAllArticles() throws Exception {
		return sqlSession.selectList(NAMESPACE+".getAllArticles");
	}

	@Override
	public List<BoardVO> listPaging(Criteria cri) throws Exception {
		return sqlSession.selectList(NAMESPACE+".listPaging", cri);
	}

	@Override
	public int countArticles() throws Exception {
	
		return sqlSession.selectOne(NAMESPACE+".countArticles");
	}


	@Override
	public int countSearchedArticles(SearchCriteria cri) throws Exception {
		
		return sqlSession.selectOne(NAMESPACE + ".countSearchedArticles", cri);
	}


	@Override
	public List<BoardVO> listSearch(SearchCriteria cri) throws Exception {
		return sqlSession.selectList(NAMESPACE + ".listSearch", cri);
	}


	@Override
	public void updateViewCnt(int boardNo) throws Exception {
		sqlSession.update(NAMESPACE + ".updateViewCnt", boardNo);
		
	}


	@Override
	public void updateReplyCnt(int boardNo, int count) throws Exception {
		Map<String , Object> datas = new HashMap<>();
		  System.out.println("원본 글 번호: " + boardNo);
		datas.put("boardNo", boardNo);
		datas.put("count", count);
		
		sqlSession.update(NAMESPACE+".updateReplyCnt", datas);
		
		
	}


	@Override
	public void insertFile(BoardUploadFileVO file) throws Exception {
		sqlSession.insert(NAMESPACE+".insertFile", file);
	}


	@Override
	public int selectMaxBoardNo() {
		return sqlSession.selectOne(NAMESPACE + ".selectMaxBoardNo");
	}


	@Override
	public BoardUploadFileVO getFile(int fileId) {
		return sqlSession.selectOne(NAMESPACE+".getFile", fileId);
	}

}
