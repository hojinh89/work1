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
    <nav class="navbar navbar-static-top" role="navigation">
      <!-- Sidebar toggle button-->
      
      
      <!-- Navbar Right Menu -->
      <div class="navbar-custom-menu">
        <ul class="nav navbar-nav" style="font-size: 25px">
          <!-- Messages: style can be found in dropdown.less-->
          <li >
           
           
            <!-- Menu toggle button -->
            	
            <!-- Menu Toggle Button -->
            <c:if test="${not empty login }">
           
              <span style="font-size: 30px; color : white"><b>${login.userId} 님</b></span>
            
            
           </c:if>
           <c:if test="${empty login }">
            <a href='<c:url value="/user/login"/>' class="dropdown-toggle" >
              <b>Login</b>
            </a>
           </c:if>
          </li>
          <!-- Control Sidebar Toggle Button -->
          
          <c:if test="${not empty login}">
          <li>
            <a style="font-size: 30px" href="<c:url value="/user/join"/>" >
            <b>Logout</b></a>
          </li>
          </c:if>
          <c:if test="${empty login}">
          <li>
            <a href="<c:url value="/user/join"/>" >
            <b>Sign in</b></a>
          </li>
          </c:if>
        </ul>
      </div>
    </nav>
  </header>