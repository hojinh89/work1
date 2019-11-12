<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>

<jsp:include page="../include/static-head.jsp" />

<body class="hold-transition skin-blue sidebar-mini layout-boxed">

<div class="wrapper">

    <!-- Main Header -->
   

    <!-- Left side column. contains the logo and sidebar -->


    <!-- Content Wrapper. Contains page content -->
    <div class="content-wrapper" style="margin-left : 0px " >
        <!-- Content Header (Page header) -->
        <section class="content-header">
            <h1>
                게시판
                <small>입력페이지</small>
            </h1>
            <ol class="breadcrumb">
                <li><i class="fa fa-edit"></i> article</li>
                <li class="active"><a href="#"> write</a></li>
            </ol>
        </section>

        <!-- Main content -->
        <section class="content container-fluid">

            <div class="col-lg-12">
                <form role="form" id="writeForm" method="post" action="<c:url value='/board/modify' />">
                    <div class="box box-primary">
                        <div class="box-header with-border">
                            <h3 class="box-title">게시글 작성</h3>
                        </div>
                        <div class="box-body">
                        	<input type="hidden" name="boardNo" value="${article.boardNo }">
                        
                        	<div class="form-group">
                                <label for="writer">작성자</label>
                                <input class="form-control" id="writer" name="writer" value="${article.writer}" readonly="readonly"/>
                            </div>
                            <div class="form-group">
                                <label for="title">제목</label>
                                <input class="form-control" id="title" name="title" value="${article.title}"/> 
                            </div>
                            <div class="form-group">
                                <label for="content">내용</label>
                                <textarea class="form-control" id="content" name="content" rows="30"
                                          placeholder="내용을 입력해주세요"  style="resize: none;">${article.content} </textarea>
                            </div>
                            
                        </div>
                        <div class="box-footer">
                            <button type="button" class="btn btn-primary" name = "listBtn" id="listBtn"><i class="fa fa-list"></i> 목록</button>
                            <div class="pull-right">
                                <button type="reset" class="btn btn-warning"><i class="fa fa-reply"></i> 초기화</button>
                                <button type="submit" id = "writeBtn" name = "writeBtn" class="btn btn-success"><i class="fa fa-save"></i> 입력</button>
                            </div>
                        </div>
                    </div>
                </form>
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


var oEditors = [];

$(document).ready(function () {
	
	const formObj = $("form[role='form']");
	
	$("#listBtn").on("click", function() {
		formObj.attr("method", "get");
		formObj.attr("action", "list");
		formObj.submit();
	});
	
	//스마트에딧용
	nhn.husky.EZCreator.createInIFrame({
		 oAppRef: oEditors,
		 elPlaceHolder: "content",
		 sSkinURI: "/se2/SmartEditor2Skin.html",
		 fCreator: "createSEditor2"
		});

		
	
});

$("#writeBtn").on("click", function(){
	
	oEditors.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);
	
	//alert(document.getElementById("content").value); 
	
});

</script>


</body>

</html>








