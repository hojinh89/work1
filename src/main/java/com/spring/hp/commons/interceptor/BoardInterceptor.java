package com.spring.hp.commons.interceptor;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class BoardInterceptor extends HandlerInterceptorAdapter{

	@Override
	public boolean preHandle(HttpServletRequest request, 
			HttpServletResponse response, Object handler) 
	throws Exception{
		System.out.println("게시판 인터셉트 발동");
		
		//글쓰기, 댓글, 수정같은것들 하기전에 로그인체크필요
		//컨트롤러로 들어가기전에 체크해서 login없으면 되돌아감
		HttpSession session = request.getSession();
	
		if(session.getAttribute("login") == null) {
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			//간단한 자바스크립트 하나쓰면되니 아래와 같이 간단하게 사용
		
			out.print("<script> " + "alert('로그인이 필요합니다!'); "
						+ "location.href='/user/login'; "
						+ "</script>" );
			out.flush();
			out.close();
			
			return false;
			
		}
		return true;
		
		
	}
	

	
	
}
