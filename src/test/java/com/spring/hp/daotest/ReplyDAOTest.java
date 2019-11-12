package com.spring.hp.daotest;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.spring.hp.commons.paging.Criteria;
import com.spring.hp.reply.model.ReplyVO;
import com.spring.hp.reply.repository.IReplyDAO;

//spring에 등록된 bean이 설정된 파일 불러주기
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations= {"classpath:/spring/mvc-config.xml"})



public class ReplyDAOTest {
		
	@Autowired
	private IReplyDAO dao;
	
	@Test
	public void testReplyInsert() throws Exception{
		for(int i=1; i<115; i++) {
			ReplyVO reply = new ReplyVO();
			reply.setBoardNo(300);
			reply.setReplyText("reply text : " + i);
			reply.setReplyWriter(i + "번 작성자");
			
			dao.insert(reply);
		}
		System.out.println("댓글등록 성공");
	}
	
	/*
	@Test
	public void replyListTest() throws Exception{
		for(ReplyVO vo : dao.list(57)) {
			if(vo.getReplyNo() == 57) break;
			System.out.println(vo);
		}
	}*/
	/*
	@Test
	public void replyUpdateTest() throws Exception{
		ReplyVO vo = new ReplyVO();
		vo.setReplyNo(35);
		vo.setReplyText("수정된 내용입니다");
		
		dao.update(vo);
		
	}
*/	
	/*
	@Test
	public void deleteTest() throws Exception{
		dao.delete(25);
	}
	*/
	
	//댓글 페이징 테스트
	/*
	@Test
	public void pagingTest() throws Exception{
		
		Criteria cri = new Criteria();
		
		cri.setPage(2);
		cri.setCountPerPage(20);
		
		for(ReplyVO reply : dao.listPaging(57, cri)) {
			System.out.println(reply);
		}
		
	}*/
	
}
