<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="../include/static-head.jsp" />
</head>
<body class="hold-transition register-page">
<div class="register-box">
    <div class="register-logo">
        <a href="#">
            <b>Profile</b>&nbsp
        </a>
    </div>

    <div class="register-box-body">



          <form role="form" id="profileForm" method="post" action="<c:url value='/board/profile' />" enctype="multipart/form-data">
        
            <table style="cellpadding: 0; cellspacing: 0; margin: 0 auto; width: 100%">
						
						
						<tr>
							<td style="font-size : 15px; text-align: left">
								<p ><strong>프로필 사진을 등록해주세요.</strong>&nbsp;&nbsp;&nbsp;<span id="fileChk"></span></p>
							</td>
						</tr>
						
						<tr>
							<td>
							 	<button id="btn_upload" class = "btn form-control tooltipstered"
							 	style = "background-color: #ff52a0; margin-top: 0; height: 40px; color: white; border: 0px solid #f78f24; opacity: 0.8">업로드</button> 
							  	<input type="file" style="display :none;" id="upload_file" name="file" value="프로필사진"  />
							  	<img id="preImg" src="<c:url value='/board/p_file/${login.userId }'/>" onerror="this.src='/resources/profile1.jpg'" style="margin-top : 5px; width : 320px; height : 300px;"/>							
							</td>
						</tr>
						
						<tr><td><br></td></tr>
						
						<tr>
							<td style="padding-top: 10px; text-align: center">
								<p><strong>사진을 등록하시고 더 많은 서비스를 이용하세요!</strong></p>
							</td>
						</tr>
						<tr>
							<td style="width: 100%; text-align: center; colspan: 2;">
							<input
								type="submit" value="프로필 사진 등록" 
								class="btn btn-primary form-control tooltipstered" id="profile_btn"
								style="background-color: orange; margin-top: 0; height: 40px; color: white; border: 0px solid #388E3C; opacity: 0.8">
							</td>
						</tr>

					</table>
        </form>

        
    </div>
    <!-- /.form-box -->
</div>
<!-- /.register-box -->
<jsp:include page="../include/plugin-js.jsp" />
<script>  
	$(function(){
		
		/*$("#profile_btn").on("click", function(){
			
			self.location="/board/profile";
		});*/
		
		//join에서 이미지 미리보기용
		   $('#btn_upload').click(function(e){
			   e.preventDefault();
			   $("#upload_file").click();
		   });
		   
			$("#upload_file").on("change", handleImgFileSelect);
			 
		
		
		//파일 업로드한 사진 미리보기
		var sel_file;	
		//var preImghtml = '<img id="preImg"  style="margin-top : 5px; width : 300px; height : 300px;"/>';
		function handleImgFileSelect(e){
			var files = e.target.files;
			var filesArr = Array.prototype.slice.call(files);
			
			console.log(files);
			console.log(filesArr);
			
			filesArr.forEach(function(f){
				sel_file=f;
				
				var reader = new FileReader();
				reader.onload = function(e){
					//$("#upload_file").after(preImghtml);
					$("#preImg").attr("src", e.target.result);
				}
				reader.readAsDataURL(f);
			});
			
		}
	   
		
	})
</script>

</body>
</html>
