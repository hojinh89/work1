package com.spring.hp.daotest;

import java.util.List;

import javax.inject.Inject;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.spring.hp.model.BoardVO;
import com.spring.hp.repository.IBoardDAO;



//pom.xml에서 junit4 확인

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations= {"classpath:/spring/mvc-config.xml"})
public class BoardDAOTest {
	
	private static final Logger logger = LoggerFactory.getLogger(BoardDAOTest.class);
	
	@Inject
	private IBoardDAO boardDAO;
	
	/*
	@Test
	public void insertTest() throws Exception{
		for(int i=1; i<=30; i++) {
			BoardVO vo = new BoardVO();
			vo.setTitle(i + "번째 제목");
			vo.setContent(i + "번째 게시물입니다.");
			vo.setWriter("user" + i);
			boardDAO.insert(vo);
			
		}
	}
	*/
	/*
	@Test
	public void selectTest() throws Exception{
		logger.info(boardDAO.getArticle(25).toString()+ "\n" );
	}
	*/
	
	/*
	@Test
	public void selectAllTest() throws Exception{
		List<BoardVO> li = boardDAO.getAllArticles();
		for (BoardVO vo : li) {
			logger.info("글번호 : " + vo.getBoardNo() + "    " + vo.getTitle() +"       " +  vo.getWriter());
		}
		logger.info(boardDAO.getAllArticles().toString()+ "\n" );
	}
	*/
	
	@Test
	public void insertTest() throws Exception{
		BoardVO vo = new BoardVO();
		/*
		vo.setTitle("신규제목삽입");
		vo.setContent("newcontent");
		vo.setWriter("newja");
		*/
		vo.setTitle("번째 제목");
		vo.setContent("번째 게시물입니다.");
		vo.setWriter("user");
		logger.info(vo.toString());
		
		boardDAO.insert(vo);
	}
	

}
