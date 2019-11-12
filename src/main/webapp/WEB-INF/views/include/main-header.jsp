<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<!-- Main Header -->
  <header class="main-header">

    <!-- Logo -->
    <a href="index2.html" class="logo">
      <!-- mini logo for sidebar mini 50x50 pixels -->
      <span class="logo-mini"><b>A</b>LT</span>
      <!-- logo for regular state and mobile devices -->
      <span class="logo-lg"><b>TEST</b>homepage</span>
    </a>

    <!-- Header Navbar -->
    <nav class="navbar navbar-static-top" role="navigation" >
      <!-- Sidebar toggle button-->
      
      
      <!-- Navbar Right Menu -->
      <div class="navbar-custom-menu">
        <ul class="nav navbar-nav" style="font-size: 25px">
          <c:if test="${not empty login}">
                    <li class="dropdown user user-menu">
                    	<c:set var="profileImg" value='/board/p_file/${login.userId}'/>
                  
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" style="height:50px; padding:3px; margin-right : 15px;">  
                        	<span><img src="<c:url value='/board/p_file/${login.userId}'/>" alt="" onerror="this.src='/resources/profile2.jpg'" style="width:44px; height:44px;"></span>
                        	
                        	
                            <span class="hidden-xs" style="margin: 10px"> ${login.userId}</span>
                        </a>
                        <ul class="dropdown-menu">
                            <li class="user-header" style = "background-color : white; padding: 0px;">                                
                                <p style = "color : black;  margin:  0; padding: 0; font-size: 25px;">
                                ${login.userName} 님</p>
                                <span><img src="<c:url value='/board/p_file/${login.userId}'/>" alt="" onerror="this.src='/resources/profile2.jpg'" style="width:150px; height:140px;"></span>
                            </li>
                            
                            <li class="user-footer">
                                <div class="pull-left">
                                    <a href="<c:url value='/board/profile'/>" class="btn btn-default btn-flat"><i
                                            class="fa fa-info-circle"></i><b> 프로필</b></a>
                                
                               
                                    <a href="<c:url value='/user/mypage'/>" class="btn btn-default btn-flat"><i
                                            class="fa fa-info-circle"></i><b> 정보</b></a>
                              
                                    <a href="#" class="btn btn-default btn-flat" id="logoutBtn">
                                    <i class="glyphicon glyphicon-log-out"><b>로그아웃</b></i></a>
                                </div>
                            </li>
                        </ul>
                    </li>
                </c:if>
        
          <!-- Messages: style can be found in dropdown.less-->
          
           
            <!-- Menu Toggle Button -->
       
           <c:if test="${empty login }">
         	<li>
            <a href='<c:url value="/user/login"/>' >
              <b>Login</b>
            </a>
            </li>
           
          <li>
            <a href="<c:url value="/user/join"/>" >
            <b>Sign in</b></a>
          </li>
          </c:if>
        </ul>
      </div>
    </nav>
  </header>
  
  