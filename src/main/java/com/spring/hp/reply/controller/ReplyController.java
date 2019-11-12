package com.spring.hp.reply.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.spring.hp.commons.paging.Criteria;
import com.spring.hp.commons.paging.PageCreator;
import com.spring.hp.reply.model.ReplyVO;
import com.spring.hp.reply.service.IReplyService;

@RestController
@RequestMapping("/replies")
public class ReplyController {
	
	private static final Logger logger = LoggerFactory.getLogger(ReplyController.class);
	
	@Autowired
	private IReplyService service;
	
	//댓글 등록
	@PostMapping(value="")
	public String register(@RequestBody ReplyVO reply) throws Exception{
		logger.info("댓글 등록요청 시작");
		logger.info("원본 게시글 번호 : " + reply.getBoardNo());
		service.insert(reply);
		
		logger.info("댓글 등록 성공");
		
		return "regSuccess";
	}
	
	//대댓글 등록
	@PostMapping(value="/reReplyInsert")
	public String reReplyregister(@RequestBody Map<String, Object> params) throws Exception{
			logger.info("대댓글 등록요청 시작");
			logger.info("원본 게시글 번호 : " + params.get("boardNo"));
			logger.info(" 현 게시물의 상위 태그에 있는 댓글번호 : " +  params.get("upperNo"));
			
			System.out.println(params.toString()+ "///////////////////////////");
			System.out.println("boardno : " + params.get("boardNo"));
			System.out.println(params.get("replyNo"));
			
			service.reReplyinsert(params);			
			
			logger.info("대댓글 등록 성공");			
			
			return "reReplyregSuccess";
		}
	
	
	//댓글 목록가져오기()
	@GetMapping(value = "/all/{boardNo}")
	public List<ReplyVO> list(@PathVariable int boardNo) throws Exception{
		logger.info("댓글 목록 가져오기 : get");
		
		return service.list(boardNo);
	}
	
	//댓글 목록가져오기()
	@GetMapping(value="/{boardNo}/{page}")
	public Map<String, Object> listPaging(@PathVariable("boardNo")int boardNo, 
											@PathVariable("page") int page) throws Exception{
		logger.info("uri로부터 받은 boardNo : " + boardNo);
		logger.info("uri로부터 받은 replypage : " + page);
		
		Criteria cri = new Criteria();
		cri.setPage(page);
		logger.info("criteria : " + cri.toString());
		List<ReplyVO> replies = service.listPaging(boardNo, cri);
		logger.info("replise : " + replies.toString());
		
		
		PageCreator pc = new PageCreator();
		pc.setCriteria(cri);		
		pc.setArticleTotalCount(service.countReplies(boardNo));
		logger.info("pageCreator : " + pc.toString());
		
		Map<String, Object> datas = new HashMap<>();
		datas.put("replies", replies);
		datas.put("pageCreator", pc);
		
		return datas;
		
		
	}
	
	//댓글 삭제 요청
		@RequestMapping(value="/{replyNo}", method=RequestMethod.DELETE)
		public String delete(@PathVariable int replyNo,
				@RequestBody ReplyVO reply) throws Exception{
			logger.info("replyNo : " + replyNo + " reply : " + reply.toString());
			
			reply = service.getReply(replyNo);
			logger.info("reply info : " + reply.toString());
			
			if(reply.getDepth() != 0) {
				logger.info("해당 댓글만 삭제");
				service.delete(replyNo, reply.getBoardNo());
				return "delreplySuccess";
			}
			else {
				logger.info("댓글+대댓글 모두 삭제");
				
				service.deleteReplies(reply.getParentId());
				return "delrepliesSuccess";
			}
			
		}

		//댓글 수정 요청
		@RequestMapping(value="/{replyNo}", method=RequestMethod.PUT)
		public String update(@PathVariable int replyNo, 
				@RequestBody ReplyVO reply) throws Exception{

			logger.info("/replies/" + replyNo + " : put요청발생!");
			reply.setReplyNo(replyNo);
			service.update(reply);
			return "modSuccess";
		}
		
	
	
	
}

