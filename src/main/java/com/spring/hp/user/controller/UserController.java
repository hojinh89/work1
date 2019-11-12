package com.spring.hp.user.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.util.WebUtils;

import com.spring.hp.user.model.LoginVO;
import com.spring.hp.user.model.UserUploadFileVO;
import com.spring.hp.user.model.UserVO;
import com.spring.hp.user.service.IUserService;

@RestController
@RequestMapping("/user")
public class UserController {
	private static final Logger logger = LoggerFactory.getLogger(UserController.class);

	@Autowired
	private IUserService service;

	@GetMapping("/join")
	public ModelAndView join() throws Exception {

		logger.info("/user/join: get");

		return new ModelAndView("user/join");
	}

	@PostMapping("/join")
	public String join(@RequestBody UserVO user) throws Exception {

		logger.info("/user/join: post");
		logger.info("user info : " + user);
		
		service.register(user);

		return "joinSuccess";
	}

	// ID 중복 확인 체크 요청
	@PostMapping("/idCheck")
	public Map<String, Object> confirmId(@RequestBody String userId) throws Exception {

		System.out.println("중복 확인 요청 Id: " + userId);
		Map<String, Object> data = new HashMap<>();

		// 서비스에 id줄테니까중복 확인해보고 리턴해봐라
		int result = service.isDuplicateId(userId);
		if (result == 0) {
			System.out.println("아이디 사용가능");
			data.put("confirm", "OK");
		} else {
			System.out.println("아이디 중복");
			data.put("confirm", "NO");
		}

		return data;
	}
	
	// 로그인 화면 요청
	@GetMapping("/login")
	public ModelAndView login() throws Exception{
		System.out.println("로그인 화면 start");
				
		return new ModelAndView("user/login");
	}
	
	
	
	
	// 로그아웃 요청
	@GetMapping("/logout")
	public ModelAndView logout(HttpServletRequest request,
			HttpSession session,
			HttpServletResponse response,
			RedirectAttributes redirectAttr) throws Exception{
		logger.info("logout 실행");
		logger.info("logout 전 'login'세션정보 : " + session.getAttribute("login"));
		

		//session.removeAttribute("login");
		//session.invalidate();
		
		Object object = session.getAttribute("login");
	

		
		if(object != null) {
			UserVO userVO = (UserVO) object;
			session.removeAttribute("login");
			session.invalidate();
			Cookie loginCookie = WebUtils.getCookie(request, "loginCookie");
			
			//loginCookie가 존재할 시 쿠키 삭제를위해 다음을 실행
			if(loginCookie != null) {
				loginCookie.setPath("/");
				loginCookie.setMaxAge(0);
				response.addCookie(loginCookie);
				service.keepLogin(userVO.getUserId(), "none", new Date());
			}
		}
		
		
		
		redirectAttr.addFlashAttribute("message", "logoutSuccess");
		
		return new ModelAndView("redirect:/board/list");
	}
	
	
	// 로그인
	@PostMapping("/loginCheck")
	public String login(@RequestBody LoginVO login,
			  HttpSession session, HttpServletResponse res
						) throws Exception{
		System.out.println("로그인 시도 start");
		logger.info("/user/loginCheck 요청! : POST");	   
	     logger.info("parameters : " + login);
		
	     //회원이 입력한 정보 암호화
		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		UserVO user = service.login(login);
		logger.info("로그인 시도 회원정보: " + user);
		
		String result = null;
	
		//유저 정보가 존재할경우
		 if(user != null) {
		        //아이디 존재
		        if(encoder.matches(login.getUserPw(), user.getUserPw())) {
		           //비밀번호 일치 -> 로그인 성공
		           result = "loginSuccess";
		           //세션에 login라는 이름으로 user의 모든 정보를 보관
		           session.setAttribute("login", user);
		           session.setMaxInactiveInterval(60*60);	//세션만료 1시간으로 증가
		           
		          
		           
		           logger.info("session 11 : " + session.getAttribute("login"));
		           logger.info("session 22 : " + session.getId());
		           
		           //자동로그인 쿠키 생성, 자동로그인되었을때만 쿠키생성하도록
		           if(login.isAutoLogin()) {
		        	   logger.info("자동로그인 체크함");
		        	   long limitTime = 60 * 60 * 24 * 90;
		        	   
		        	   //현재시간 읽은다음에 제한시간인 3개월(limittime)을 넣음
		        	   Date sessionLimit = new Date(System.currentTimeMillis() + (limitTime * 1000));
		        	   
		        	   //쿠키생성 , 세션의 고유id를 loginCookie에 저장, 고유id란 f12 어플에 있는 value값
		        	   Cookie loginCookie = new Cookie("loginCookie", session.getId());
		        	   //쿠키 속성 설정
		        	   loginCookie.setMaxAge((int)limitTime);
		        	   loginCookie.setPath("/");
		        	   //생성된 쿠키를 response 객체에 실어서 전송
		        	   res.addCookie(loginCookie);
		        	   
		        	   logger.info("userid : " + user.getUserId());
		        	   logger.info("sessionid : " + session.getId());
		        	   logger.info("sessionlimit: " + sessionLimit);
		        	   service.keepLogin(user.getUserId(), session.getId(), sessionLimit);
		        	   
		        	   
		           }
		           
		           
		        } else {
		           //비밀번호 틀림
		           result = "pwFail";
		        }
		     } else {
		        //아이디 없음
		        result = "idFail";
		     }
		     
		     return result;
	}
	
	// 로그인 화면 요청
		@GetMapping("/mypage")
		public ModelAndView mypage(HttpServletRequest request, HttpSession session) throws Exception{
			System.out.println("마이페이지 start");
			
			UserVO user = (UserVO)session.getAttribute("login");
			System.out.println(user.toString());
			
			ModelAndView mv = new ModelAndView();
			mv.setViewName("user/mypage");
			mv.addObject("user", user);
			
			
					
			return mv;
		}
	
}
