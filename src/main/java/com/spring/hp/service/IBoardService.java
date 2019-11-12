package com.spring.hp.service;

import java.util.List;

import com.spring.hp.commons.paging.Criteria;
import com.spring.hp.commons.paging.SearchCriteria;
import com.spring.hp.model.BoardUploadFileVO;
import com.spring.hp.model.BoardVO;
import com.spring.hp.user.model.UserUploadFileVO;

public interface IBoardService {

	void insert(BoardVO article) throws Exception;
	//게시물 상세보기, 업로드한 파일정보까지 포함
	BoardVO getArticle(int boardNo) throws Exception;
	void modify(BoardVO article) throws Exception;
	void delete(int boardNo) throws Exception;
	
	//게시물 전체목록
	List<BoardVO> getAllArticles() throws Exception;
	
	//게시글 페이지별로 불러오기
	List<BoardVO> listPaging(Criteria cri) throws Exception;
	
	//총 게시물 수 
	int countArticles() throws Exception;
	
	
	//검색조건으로 검색항 게시물 목록불러오기
	//목록 불러와서 리턴하기전에 new 붙일지 여부를 컨트롤러에 보내기전에 저장할수잇음
	List<BoardVO> listSearch(SearchCriteria cri) throws Exception;
		
	//검색 후 총 게시물 수 가져오기
	int countSearchedArticles(SearchCriteria cri) throws Exception;
	
	//파일업로드
	void insert(BoardVO article, BoardUploadFileVO file) throws Exception;
	BoardUploadFileVO getFile(int fileId) throws Exception;
	
	
}
