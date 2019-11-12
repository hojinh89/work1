package com.spring.hp.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.spring.hp.commons.paging.PageCreator;
import com.spring.hp.commons.paging.SearchCriteria;
import com.spring.hp.model.BoardUploadFileVO;
//import com.spring.hp.commons.paging.asdasdCriteria;
//import com.spring.hp.commons.paging.asdasdPageCreator;
import com.spring.hp.model.BoardVO;
import com.spring.hp.service.IBoardService;
import com.spring.hp.user.model.UserUploadFileVO;
import com.spring.hp.user.model.UserVO;
import com.spring.hp.user.service.IUserService;

@Controller
@RequestMapping("/board")
public class BoardController {

	
	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);
	
	@Autowired
	private IBoardService service;
	
	@Autowired
	private IUserService u_service;
	
	
	//페이징 처리전
	/*
	@GetMapping(value="/list")
	public String list(Model model) throws Exception{
		logger.info("/board/list request~~");
		
		model.addAttribute("articles", service.getAllArticles());
		
		return "board/list";
	}*/
	
	//페이징 처리 후 게시글 목록 요청
	/*
	@GetMapping(value="/list")
	public String list(Criteria cri, Model model) throws Exception{
		logger.info("/board/list : GET요청 발생!");
		logger.info(cri.toString());
		
		PageCreator pc = new PageCreator();
		pc.setCriteria(cri);
		pc.setArticleTotalCount(service.countArticles());
		
		model.addAttribute("articles", service.listPaging(cri));
		model.addAttribute("pageCreator", pc);
		
		return "board/list";
	}
	*/
	
	//페이징 + 검색조건 처리 후 게시글 목록요청
	@GetMapping(value="/list")
	public String list(SearchCriteria cri, Model model) throws Exception{
		logger.info("/board/list: get");
		
		
		PageCreator pc = new PageCreator();
		pc.setCriteria(cri);
		pc.setArticleTotalCount(service.countSearchedArticles(cri));
		
		model.addAttribute("articles", service.listSearch(cri));
		model.addAttribute("pageCreator", pc);
		
		
		logger.info("articles : " + service.listSearch(cri));	
		logger.info("page 정보 : " + pc.getCriteria().getPage());
		logger.info("countPerPage 정보 : " + pc.getCriteria().getCountPerPage());
		
		return "board/list";
	}
	
	@GetMapping(value="/write")
	public String write() throws Exception{
		logger.info("/board/write request(get)");
		
		return "board/write";
	}
	/*//업로드체크용 원본
	@PostMapping(value="/write")
	public String write( BoardVO vo, RedirectAttributes redirectAttr) throws Exception{
		logger.info("/board/write request(post)");	
		logger.info(vo.toString());
		
		//단일 파일업로드 (MultipartFile 활용)	
		MultipartFile mfile = vo.getFile();
		
		if(mfile != null && !mfile.isEmpty()) {
			BoardUploadFileVO file = new BoardUploadFileVO();
			
			file.setFileName(mfile.getOriginalFilename());
			file.setFileSize(mfile.getSize());
			file.setFileContentType(mfile.getContentType());
			file.setFileData(mfile.getBytes());
			
			service.insert(vo, file);
			redirectAttr.addFlashAttribute("message", "regSuccess");
			
		} else {
			service.insert(vo);
			redirectAttr.addFlashAttribute("message", "regSuccess");
		}
		return "redirect:/board/list";
	}
	*/
	
	//파일업로드 v2
	@PostMapping(value="/write")
	public String write( BoardVO vo, @RequestParam("file") MultipartFile mfile , RedirectAttributes redirectAttr) throws Exception{
		logger.info("/board/write request(post)");	
		logger.info(vo.toString());
		
		//단일 파일업로드 (MultipartFile 활용)	
		//MultipartFile mfile = vo.getFile();
		
		if(mfile != null && !mfile.isEmpty()) {
			BoardUploadFileVO file = new BoardUploadFileVO();
			
			file.setFileName(mfile.getOriginalFilename());
			file.setFileSize(mfile.getSize());
			file.setFileContentType(mfile.getContentType());
			file.setFileData(mfile.getBytes());
			
			service.insert(vo, file);
			redirectAttr.addFlashAttribute("message", "regSuccess");
			
		} else {
			service.insert(vo);
			redirectAttr.addFlashAttribute("message", "regSuccess");
		}
		return "redirect:/board/list";
	}
	
	@GetMapping("/profile")
	public String profile() throws Exception{
		System.out.println("profile");
		
		return "board/profile";
	}
	
	//파일업로드 - 프로필용
	@PostMapping(value="/profile")
	public String profile( @RequestParam("file") MultipartFile mfile , HttpServletRequest request,
			RedirectAttributes redirectAttr) throws Exception{
		logger.info("/board/profile request(post)");	
	
		//세션정보 session으로 받음
		HttpSession session = request.getSession();
		//vo에 세션에 저장되어있는 "login"의 데이터 저장
		
		//로그인할때 세션에 UserVO로 저장해놔서 loginvo로 못받음, 무적권 uservo로 받아짐
		UserVO vo = (UserVO) session.getAttribute("login");
		
		if(mfile != null && !mfile.isEmpty()) {
			UserUploadFileVO file = new UserUploadFileVO();
			file.setUserId(vo.getUserId());
			file.setFileName(mfile.getOriginalFilename());
			file.setFileSize(mfile.getSize());
			file.setFileContentType(mfile.getContentType());
			file.setFileData(mfile.getBytes());
			
			u_service.insertFile(file);
			redirectAttr.addFlashAttribute("message", "profileSuccess");
			
		} 
		
		return "redirect:/board/list";
	}
		
	@GetMapping(value="/content")
	  public String content(@ModelAttribute("criteria") SearchCriteria cri, 
			  				@RequestParam("boardNo") int boardNo, 
			  				Model model) throws Exception{		
		logger.info("/board/content request(get)");
		
		//해당 번호의 게시물 정보 가져옴, 업로드한 파일정보포함
		BoardVO rvo = service.getArticle(boardNo);
		
		logger.info("파일 업로드확인 : " + rvo.getFileId() );
		logger.info("파일정보 확인 : " + rvo.toString());
		model.addAttribute("article", rvo); 
		
		//criteria requestparam으로 받아서 한줄더 쓰기 번거로워서 @modelattribute로 변경
		//model.addAttribute("criteria", cri);
		
		//조회수 증가 -> 서비스에 구현		
		
		return "board/content";
		
	}
	
	@GetMapping(value="/modify")
	public String modify(@RequestParam("boardNo") int boardNo, Model model) throws Exception{
		logger.info("/board/modify request(get)");
		
		model.addAttribute("article", service.getArticle(boardNo));
		
		logger.info("제목 확인 : " + service.getArticle(boardNo).getTitle());
		return "board/modify";
	}
	
	@PostMapping (value="/modify")
	public String modify(BoardVO article, Model model, RedirectAttributes redirectAttr) throws Exception{
		logger.info("/board/modify request(post)");
		
		service.modify(article);
		redirectAttr.addFlashAttribute("message", "modSuccess");
		
		return "redirect:/board/list";
		
	}
	
	@PostMapping(value="/delete")
	public String delete(@RequestParam("boardNo") int boardNo, Model model, RedirectAttributes redirectAttr) throws Exception{
		logger.info("/board/delete");
		
		service.delete(boardNo);
		redirectAttr.addFlashAttribute("message", "delSuccess");
		
		return "redirect:/board/list";
	}
	
	@RequestMapping("/file/{fileId}")
	public ResponseEntity<byte[]> getFile(@PathVariable int fileId) throws Exception{
		logger.info("test:  getFile/////////////////////////////////////////////");
		BoardUploadFileVO file = service.getFile(fileId);
			
		HttpHeaders headers = new HttpHeaders();
		String[] ftypes = file.getFileContentType().split("/");
		headers.setContentType(new MediaType(ftypes[0], ftypes[1]));
		headers.setContentLength(file.getFileSize());
		headers.setContentDispositionFormData("attachment", file.getFileName());
		return new ResponseEntity<byte[]>(file.getFileData(), headers, HttpStatus.OK);
		
	}
	
	@RequestMapping("/p_file/{userId}")
	public ResponseEntity<byte[]> getp_File(@PathVariable String userId) throws Exception{
		logger.info("getFile : " + userId);
		
		//사용자나 파일이 존재 하지 않았을시 NULL을 반환해서 onError이벤트 불러옴.
		try {
			UserUploadFileVO file = u_service.getFile(userId);
			
			HttpHeaders headers = new HttpHeaders();
			String[] ftypes = file.getFileContentType().split("/");
			headers.setContentType(new MediaType(ftypes[0], ftypes[1]));
			headers.setContentLength(file.getFileSize());
			headers.setContentDispositionFormData("attachment", file.getFileName());
			return new ResponseEntity<byte[]>(file.getFileData(), headers, HttpStatus.OK);
			
		} catch (Exception e) {
			System.out.println("해당 아이디에 관한 데이터는 존재하지않습니다 : " + userId);
			return null;
		}
		
	}
	
	
}
