package com.spring.hp.repository;

import java.util.List;

import com.spring.hp.commons.paging.Criteria;
import com.spring.hp.commons.paging.SearchCriteria;
import com.spring.hp.model.BoardUploadFileVO;
import com.spring.hp.model.BoardVO;

public interface IBoardDAO {

	void insert(BoardVO article) throws Exception;
	//게시물 상세보기
	BoardVO getArticle(int boardNo) throws Exception;
	void modify(BoardVO article) throws Exception;
	void delete(int boardNo) throws Exception;
	
	//게시물 전체목록
	List<BoardVO> getAllArticles() throws Exception;
	
	//게시글 페이지별로 불러오기
	List<BoardVO> listPaging(Criteria cri) throws Exception;
	
	//총 게시물 수 
	int countArticles() throws Exception;
	
	//검색된 총 게시물 수 가져오기
	int countSearchedArticles(SearchCriteria cri) throws Exception;
	
	//동적 sql이용한 검색된 게시물 불러오기
	List<BoardVO> listSearch(SearchCriteria cri) throws Exception;
	
	
	
	
	//조회수
	void updateViewCnt(int boardNo) throws Exception;
	
	//댓글 상승,하락
	void updateReplyCnt(int boardNo, int count) throws Exception;
	
	
	//파일업로드
	void insertFile(BoardUploadFileVO file)throws Exception;
	//최대 게시글 번호 조회
	int selectMaxBoardNo();
	//파일 DB에서 불러옴
	BoardUploadFileVO getFile(int fileId);
	
}
