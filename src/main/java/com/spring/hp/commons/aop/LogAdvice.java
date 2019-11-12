package com.spring.hp.commons.aop;

import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.slf4j.Logger;
import org.springframework.stereotype.Component;

import lombok.extern.log4j.Log4j;


@Aspect

@Component
public class LogAdvice {
	
	@Before( "execution(* org.spring.hp*.*(..))")
	public void logBefore() {
		System.out.println("======================");
	}
	
}
