<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	request.setCharacterEncoding("UTF-8");
%>

<!DOCTYPE html>
<html>


 
<jsp:include page="../include/static-head.jsp" />
 
 
<style>
	#count-per-page input[type=button] {
		padding: 0 12px;
	}
	
</style>

<body class="hold-transition skin-blue sidebar-mini layout-boxed">

<div class="wrapper">

    <!-- Main Header -->
 <jsp:include page="../include/main-header.jsp" />
 
	<div class="content-wrapper" style="margin-left: 0px">
        <!-- Content Header (Page header) -->
        <section class="content-header">
            <h1>
                	게시판
                <small>목록페이지</small>
            </h1>
            <ol class="breadcrumb">
                <li><i class="fa fa-edit"></i> article!!!</li>
                <li class="active"><a href="#"> list</a></li>
            </ol>
        </section>

        <!-- Main content -->
        <section class="content container-fluid">

            <div class="col-lg-12">
                <div class="box box-primary"  >
                    <div class="box-header with-border">
                        <h3 class="box-title">게시글 목록</h3>
                        
                        <select id="count-per-page" name="count-per-page" style="float: right;">
                      	        	
                        	<option value="10" <c:if test="${PageCreator.Criteria.countPerPage == 10}"> 'selected'</c:if>>  10개씩 보기 </option>
                        	<option value="20" <c:out value="${pageCreator.criteria.countPerPage == 20 ? 'selected' : ''}"/>>  20개씩 보기 </option>
                        	<option value="30" <c:if test="${pageCreator.criteria.countPerPage == 30 }"> selected </c:if>> 30개씩 보기 </option>
                        	
                      	
                        
                        </select>
                        
                        <!-- 
                        <span id="count-per-page" style="float: right;">
                        	<i class="fa fa-list">목록 보기</i>
	                        <input class="btn" type="button" value="10">  
	                        <input class="btn" type="button" value="20">   
	                        <input class="btn" type="button" value="30">
                        </span>
                         -->
                        
                    </div>
                    <div class="box-body">
                        <table class="table table-bordered">
                            <tbody>
                            <tr>
                                <th style="width: 30px">#</th>
                                <th>제목</th>
                                <th style="width: 100px">작성자</th>
                                <th style="width: 150px">작성시간</th>
                                <th style="width: 60px">조회</th>
                            </tr>
                            
                            <%-- 게시물이 들어갈 공간 --%>
                            <c:forEach var="article" items="${articles}">
                            <tr>
                                <td>${article.boardNo}</td>
                                
                                <td><a href="<c:url value='/board/content?boardNo=${article.boardNo}&page=${pageCreator.criteria.page}&countPerPage=${pageCreator.criteria.countPerPage}'/>">${article.title}[${article.replyCnt}]</a></td>
                                
                                <td>${article.writer}</td>
                                <td><fmt:formatDate value="${article.regDate}" pattern="yyyy-MM-dd a hh:mm"/></td>
                                <td>${article.viewCnt}</td>
                            </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                    
                     
					<div class="box-footer">
					      <div class="text-center"> 
					          <ul class="pagination">
					              
					              <c:if test="${pageCreator.prev}">                                
					              	<li><a href="<c:url value='/board/list?page=${pageCreator.beginPage - 1}' />">이전</a></li> 
					              </c:if>                               
					              
					              <c:forEach var="idx" begin="${pageCreator.beginPage}" end="${pageCreator.endPage}">              
					              	<li <c:out value="${pageCreator.criteria.page == idx ? 'class=active' : ''}"/>>
					              	<a href="<c:url value='/board/list?page=${idx}&countPerPage=${pageCreator.criteria.countPerPage }'/>">${idx}</a></li>                                
					              </c:forEach>    
					              
					              <c:if test="${pageCreator.next}">               
					              	<li><a href="<c:url value='/board/list?page=${pageCreator.endPage + 1}' />">다음</a></li>
					              </c:if>
					         
					         </ul>
					      </div>
					</div>
                    
                    <div class="box-footer">
                    
                        <div class="form-group col-sm-2 col-sm-offset-2">
                            <select id="condition" class="form-control" name="condition">                            	
                                <option value="title" <c:out value="${param.condition == 'title' ? 'selected' : ''}"/>>제목</option>
                                <option value="content" <c:out value="${param.condition == 'content' ? 'selected' : ''}"/>>내용</option>
                                <option value="writer" <c:out value="${param.condition == 'writer' ? 'selected' : ''}"/>>작성자</option>
                                <option value="titleContent" <c:out value="${param.condition == 'titleContent' ? 'selected' : ''}"/>>제목+내용</option>
                            </select>
                        </div>
                        <div class="form-group col-sm-6">
                            <div class="input-group">
                                <input type="text" class="form-control" name="keyword" id="keywordInput" value="${param.keyword}" placeholder="검색어">
                                <span class="input-group-btn">
                                    <button type="button" class="btn btn-primary btn-flat" id="searchBtn">
                                        <i class="fa fa-search"> 검색</i>
                                    </button>
                                </span>
                            </div>
                        </div>
                    	
                    
                        <div class="pull-right">
                            <button type="button" class="btn btn-success btn-flat" id="writeBtn">
                            
                            	<i class="fa fa-pencil"> <a href="<c:url value='/board/write'/>" ><font color="white">글쓰기</font> </a></i> 
                            </button>
                        </div>
                    </div>
                </div>
            </div>

        </section>
        <!-- /.content -->
    </div>
    <!-- /.content-wrapper -->

    <!-- Main Footer -->
  
</div>
<!-- ./wrapper -->

<jsp:include page="../include/plugin-js.jsp" />

<script type="text/javascript">
	const result = "${message}";
		
	if(result === "regSuccess") {
		alert("게시글 등록이 완료되었습니다.");
	} else if(result === "modSuccess") {
		alert("게시글 수정이 완료되었습니다.");
	} else if(result === "delSuccess") {
		alert("게시글 삭제가 완료되었습니다.");
	} else if(result === "logoutSuccess"){
		alert("로그아웃이 완료되었습니다.");
	} else if(result === "profileSuccess"){
		alert("프로필 설정이 완료되었습니다.");
	} else if(result === "reReplyregSuccess"){
		alert("대댓 입력이 완료되었습니다.");
	}
	
	
	//JQuery문의 시작
	$(document).ready(function() {
		$("#searchBtn").on("click", function(){
			self.location= "list?page=" + ${pageCreator.criteria.page}
							+ "&countPerPage=" + ${pageCreator.criteria.countPerPage}
							+ "&condition=" + $("#condition option:selected").val()
							+ "&keyword=" + $("#keywordInput").val();
		});
		
		
		$("#count-per-page").change(function(){
			console.log($(this).val());
			var count = $(this).val();
			self.location = "list?page="+ ${pageCreator.criteria.page} + "&countPerPage=" + count; 
		});
		
		
	});
       

	//엔터키 입력 이벤트
	$("#keywordInput").keydown(function (key){
		if(key.keyCode == 13){
			$("searchBtn").click();
		}
	});
	


	$("#logoutBtn").on("click", function(){
		if(confirm("로그아웃 하시겠습니까?")){
				self.location="/user/logout";	
		} 
	});
		
	
     
</script>
</body>

</html>








