package com.spring.hp.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.hp.commons.paging.Criteria;
import com.spring.hp.commons.paging.SearchCriteria;
import com.spring.hp.model.BoardUploadFileVO;
import com.spring.hp.model.BoardVO;
import com.spring.hp.repository.IBoardDAO;
import com.spring.hp.user.model.UserUploadFileVO;
import com.spring.hp.user.repository.IUserDAO;

@Service
public class BoardService implements IBoardService{
	
	@Autowired
	private IBoardDAO dao;
	

	@Override
	public void insert(BoardVO article) throws Exception {

		dao.insert(article);
		
	}

	@Override
	public BoardVO getArticle(int boardNo) throws Exception {
		dao.updateViewCnt(boardNo);
		return dao.getArticle(boardNo);
	}

	@Override
	public void modify(BoardVO article) throws Exception {
		dao.modify(article);
	}

	@Override
	public void delete(int boardNo) throws Exception {
		dao.delete(boardNo);
		
		
	}

	@Override
	public List<BoardVO> getAllArticles() throws Exception {
		return dao.getAllArticles();
	}

	@Override
	public List<BoardVO> listPaging(Criteria cri) throws Exception {
		return dao.listPaging(cri);
	}

	@Override
	public int countArticles() throws Exception {
		return dao.countArticles();
	}

	@Override
	public List<BoardVO> listSearch(SearchCriteria cri) throws Exception {
		List<BoardVO> list = dao.listSearch(cri);
		
		
		return list;
	}

	@Override
	public int countSearchedArticles(SearchCriteria cri) throws Exception {
		return dao.countSearchedArticles(cri);
	}

	
	@Override
	public void insert(BoardVO article, BoardUploadFileVO file) throws Exception {
		System.out.println("test insert(article, file) //////////////////");
		
		dao.insert(article);
		
		if(file != null && file.getFileName() != null && !file.getFileName().equals("")) {
			file.setBoardNo(dao.selectMaxBoardNo());
			
			System.out.println("maxBoardNo : " + file.getBoardNo());
			dao.insertFile(file);
			
		}
	}

	
	@Override
	public BoardUploadFileVO getFile(int fileId) throws Exception {
		return dao.getFile(fileId);
	}

}
