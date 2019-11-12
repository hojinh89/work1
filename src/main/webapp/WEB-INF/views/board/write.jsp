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
<!-- 스마트에디터용 -->
<script type="text/javascript" src="/se2/js/service/HuskyEZCreator.js" charset="utf-8"> </script> 

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
                <form role="form" id="writeForm" method="post" action="<c:url value='/board/write' />" enctype="multipart/form-data">
                    <div class="box box-primary">
                        <div class="box-header with-border">
                            <h3 class="box-title">게시글 작성</h3>
                        </div>
                        <div class="box-body">
                        	<div class="form-group">
                                <label for="writer">작성자</label>
                            
                                <c:if test="${empty login }">
                                <input class="form-control" id="writer" name="writer">
                            	</c:if>
                            	<c:if test="${not empty login }">
                                 <input class="form-control" id="writer" name="writer" value="${login.userId}" readonly="readonly"/>
                            	</c:if>
                            	
                            
                            </div>
                            <div class="form-group">
                                <label for="title">제목</label>
                                <input class="form-control" id="title" name="title" placeholder="제목을 입력해주세요">
                            </div>
                            <div class="form-group">
                                <label for="content">내용</label>
                           		     <!--  
                            		    <textarea class="form-control" id="content" name="content" rows="30"
                                          placeholder="내용을 입력해주세요" style="resize: none;"></textarea>
                            			-->
                            		<textarea name="content" id="content"  
                            			style="width:100%; height:350px " placeholder="텍스트 입력 장소">
                            			
                           		 	</textarea>
                           		 	
                           		 
                           		 	<td></td>
                            		
                            		<div>
                            	<!-- 		<img id="preImg"  style="margin-top : 5px; width : 300px; height : 300px;"/> -->
                            	<button id="btn_upload" class = "btn form-control tooltipstered"
							 	style = "width : 250px; background-color: #ff52a0; margin-top: 0; height: 40px; color: white; border: 0px solid #f78f24; opacity: 0.8">사진 업로드</button> 
							  		</div>
							  		<div>
                            			<input type="file" style = "display: none;" id="upload_file" name="file">
                            		</div>
                            	
                            </div>
                            
                        </div>
                        <div class="box-footer">
                            <button type="button" class="btn btn-primary" id="listBtn"><i class="fa fa-list"></i> 목록</button>
                            <div class="pull-right">
                                <button type="reset" class="btn btn-warning"><i class="fa fa-reply"></i> 초기화</button>
                    	        <button type="submit" class="btn btn-success" id="writeBtn"><i class="fa fa-save"></i> 입력</button>
                             	
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

<!--  스마트 에디터용 -->
<script type="text/javascript" >
	var oEditors = [];
	
	$(document).ready(function(){
			nhn.husky.EZCreator.createInIFrame({
			 oAppRef: oEditors,
			 elPlaceHolder: "content",
			 sSkinURI: "/se2/SmartEditor2Skin.html",
			 fCreator: "createSEditor2"
			});
			
			
			
	});
	
	
	 //join에서 이미지 미리보기용
	   $('#btn_upload').click(function(e){
		   e.preventDefault();
		   $("#upload_file").click();
	   });
	
	//이미지 미리보기
	$("#upload_file").on("change", handleImgFileSelect);
	
	$("#listBtn").on("click", function(){
		if(confirm("작성중인 내용이 저장되지 않습니다. 목록으로 돌아가시겠습니까?")){
			self.location="/board/list";
		}
	});
	
	$("#logoutBtn").on("click", function(){
		if(confirm("로그아웃 하시겠습니까?")){
				self.location="/user/logout";	
		} 
	});
	
	$("#writeBtn").on("click", function(){
	
		oEditors.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);
		
		//alert(document.getElementById("content").value); 
		
	});
	
	//파일 업로드한 사진 미리보기
	var sel_file;	
	var preImghtml = '<img id="preImg"  style="margin-top : 5px; width : 250px; height : 250px;"/>';
	
	function handleImgFileSelect(e){
		var files = e.target.files;
		var filesArr = Array.prototype.slice.call(files);
		
		console.log(files);
		console.log(filesArr);
		
		filesArr.forEach(function(f){
			sel_file=f;
			
			var reader = new FileReader();
			reader.onload = function(e){
				$("#upload_file").before(preImghtml);
				$("#preImg").attr("src", e.target.result);
			}
			reader.readAsDataURL(f);
		});
		
	}


</script>



</body>

</html>








