<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>

<!-- 슬라이더바 관련 css -->
<style>
	
	.slidecontainer {
  width: 100%; /* Width of the outside container */
}

/* The slider itself */
.slider {
  -webkit-appearance: none;  /* Override default CSS styles */
  appearance: none;
  width: 100%; /* Full-width */
  height: 25px; /* Specified height */
  background: #d3d3d3; /* Grey background */
  outline: none; /* Remove outline */
  opacity: 0.3; /* Set transparency (for mouse-over effects on hover) */
  -webkit-transition: .2s; /* 0.2 seconds transition on hover */
  transition: opacity .2s;
}

/* Mouse-over effects */
.slider:hover {
  opacity: 1; /* Fully shown on mouse-over */
}

#hobbyBtn1:hover{
  background: #4CAF50;
}

/* The slider handle (use -webkit- (Chrome, Opera, Safari, Edge) and -moz- (Firefox) to override default look) */
.slider::-webkit-slider-thumb {
  -webkit-appearance: none; /* Override default look */
  appearance: none;
  width: 25px; /* Set a specific slider handle width */
  height: 25px; /* Slider handle height */
  background: #4CAF50; /* Green background */
  cursor: pointer; /* Cursor on hover */
}

.slider::-moz-range-thumb {
  width: 25px; /* Set a specific slider handle width */
  height: 25px; /* Slider handle height */
  background: #4CAF50; /* Green background */
  cursor: pointer; /* Cursor on hover */
}

/* 사이드바 내비 */
.sidenav {
  height: 30%; /* 100% Full-height */
  width: 0; /* 0 width - change this with JavaScript */
  position: fixed; /* Stay in place */
  z-index: 1; /* Stay on top */
  top: 0; /* Stay at the top */
  left: 0;
  background-color: #111; /* Black*/
  overflow-x: hidden; /* Disable horizontal scroll */
  padding-top: 60px; /* Place content 60px from the top */
  transition: 0.5s; /* 0.5 second transition effect to slide in the sidenav */
}

/* The navigation menu links */
.sidenav a {
  padding: 8px 8px 8px 32px;
  text-decoration: none;
  font-size: 25px;
  color: #818181;
  display: block;
  transition: 0.3s;
}

/* When you mouse over the navigation links, change their color */
.sidenav a:hover {
  color: #f1f1f1;
}

/* Position and style the close button (top right corner) */
.sidenav .closebtn {
  position: absolute;
  top: 0;
  right: 25px;
  font-size: 36px;
  margin-left: 50px;
}

</style>


<body class="hold-transition skin-blue layout-boxed register-page">
<jsp:include page="../include/static-head.jsp" />

 <jsp:include page="../include/main-header.jsp" />

<div class="register-box">
    <div class="register-logo">
        <a href="#">
            <b>USER</b>&nbsp Information
        </a>
    </div>

    <div class="register-box-body">
        <p class="login-box-msg">회원정보 수정페이지</p>

<!--       <form id="joinForm" action="<c:url value='/user/join'/>" method="post" enctype="multipart/form-data">  -->
         <form> 
        
        
            <table
						style="cellpadding: 0; cellspacing: 0; margin: 0 auto; width: 100%">
						<tr>
							<td style="text-align: left" >
								<p ><strong>아이디</strong>&nbsp;&nbsp;&nbsp;<span id="idChk"></span></p>
							</td>
								
							
						</tr>
						<tr>
							<td><input type="text" name="userId" id="user_id"
								class="form-control tooltipstered" maxlength="14"
								required="required" aria-required="true"
								style="margin-bottom: 25px; width: 100%; height: 40px; border: 1px solid #d9d9de"
								placeholder="숫자와 영어로 4-14자" readonly="readonly" value="${user.userId}">
								
								</td>
							
						</tr>

						<tr>
							<td style="text-align: left">
								<p><strong>새 비밀번호</strong>&nbsp;&nbsp;&nbsp;<span id="pwChk"></span></p>
							</td>
						</tr>
						<tr>
							<td><input type="password" size="17" maxlength="20" id="password"
								name="userPw" class="form-control tooltipstered" 
								maxlength="20" required="required" aria-required="true"
								style="ime-mode: inactive; margin-bottom: 25px; height: 40px; border: 1px solid #d9d9de"
								placeholder="영문과 특수문자를 포함한 최소 8자"></td>
						</tr>
						<tr>
							<td style="text-align: left">
								<p><strong>새 비밀번호 확인</strong>&nbsp;&nbsp;&nbsp;<span id="pwChk2"></span></p>
							</td>
						</tr>
						<tr>
							<td><input type="password" size="17" maxlength="20" id="password_check"
								name="pw_check" class="form-control tooltipstered" 
								maxlength="20" required="required" aria-required="true"
								style="ime-mode: inactive; margin-bottom: 25px; height: 40px; border: 1px solid #d9d9de"
								placeholder="비밀번호가 일치해야합니다."></td>
						</tr>

						<tr>
							<td style="text-align: left">
								<p><strong>이름 수정</strong>&nbsp;&nbsp;&nbsp;<span id="nameChk"></span></p>
							</td>
						</tr>
						<tr>
							<td><input type="text" name="userName" id="user_name"
								class="form-control tooltipstered" maxlength="6"
								required="required" aria-required="true"
								style="margin-bottom: 25px; width: 100%; height: 40px; border: 1px solid #d9d9de"
								placeholder="한글로 최대 6자" value="${user.userName}"></td>
						</tr>
						<!-- 
						///////////////////////////////////////////////////////////////////////////////////
						///////////////////////////////////////////////////////////////////////////////////
						////기존정보
						 -->
						 <tr>
							<td style="text-align: left">
								<p><strong>비밀번호 분실시 사용할 질문 입력 or 선택</strong>&nbsp;&nbsp;&nbsp;</p>
							</td>
						</tr>
						<tr>
							<td><input list="browsers" name="" id="" class="form-control tooltipstered" 
								style="margin-bottom: 25px; width: 100%; height: 40px; border: 1px solid #d9d9de"
								>
								<datalist id="browsers">
									<option value="나의 고향은?">
									<option value="내 어렸을때 별명은?">
									<option value="가장 기억에 남는 여행지">
									<option value="기타">
								</datalist>
								
								</td>
								
							
						</tr> 
						 
						 <tr>
							<td style="text-align: left">
								<p><strong>생일입력</strong>&nbsp;&nbsp;&nbsp;</p>
							</td>
						</tr>
						<tr>
							<td><input type="date" name="bday" id="" class="form-control tooltipstered" 
								style="margin-bottom: 25px; width: 100%; height: 40px; border: 1px solid #d9d9de"
								></td>
						</tr> 
						
						 
						<tr>
							<td style="text-align: left">
								<p><strong>성별</strong>&nbsp;&nbsp;&nbsp;</p>
							</td>
						</tr>
						<tr>
							<td>	<input type="radio" name="gender" id="" value="male"  
								style="margin-bottom: 25px;" >남자 &nbsp&nbsp&nbsp
								<input type="radio" name="gender" id="" value="female" checked >여자  
								
							</td>
						</tr> 
						<tr>
							<td style="text-align: left">
								<p><strong>병역체크</strong>&nbsp;&nbsp;&nbsp;</p>
							</td>
						</tr>
						<tr>
							<td><select name="" id="armySelect" disabled="disabled"
								style="margin-bottom: 25px;" >
									<option value = "yes">예</option>
									<option value = "no" selected="selected">아니오</option>
									
								</select>
							</td>
						</tr> 
						
						<tr>
							<td style="text-align: left">
								<p><strong>취미</strong>&nbsp;&nbsp;&nbsp;</p>
							</td>
						</tr>
						<tr class="form-control tooltipstered" 
						style="width: 100%; height: 40px; border: 1px solid #d9d9de;
						padding-top: 10px;padding-bottom: 10px;">
							<td>
								<input type="checkbox" name="hobbySelect" id="" value="movie" /> 영화 &nbsp;&nbsp;
								<input type="checkbox" name="hobbySelect" id="" value="read" /> 독서 &nbsp;&nbsp;
 								<input type="checkbox" name="hobbySelect" id="" value="trip" /> 여행 &nbsp;&nbsp;
								<input type="checkbox" name="hobbySelect" id="" value="ride" /> 라이딩 &nbsp;&nbsp;
							
							</td>
						
						</tr> 
						<tr style="margin-bottom: 25px; margin-top: 10px;">
							<td  style = "padding-top: 5px;">
								<input type="button" name="hobbyBtn1" id="hobbyBtn1" value="전체선택" style="margin-bottom: 25px;"/>
								<input type="button" name="hobbyBtn2" id="hobbyBtn2" value="전체해제"/>
								<input type="button" name="hobbyBtn3" id="hobbyBtn3" value="선택 갯수 확인"/>
							</td>
						</tr>
						
						 <tr>
							<td style="text-align: left">
								<p style="margin-bottom:5px;"><strong>소유차량</strong>&nbsp;&nbsp;&nbsp;</p>
							</td>
						</tr>
						<tr >
							<td >
								<select style="margin-bottom: 25px;">
									<optgroup label="수입차">
										<option value="mercedes">Mercedes</option>
										<option value="audi">Audi</option>
									</optgroup>
									<optgroup label="국산차">
										<option value="sonata">쏘나타</option>
										<option value="avante">아반떼</option>
									</optgroup>
									<optgroup label="기타">
										<option value="none" selected="selected">없음</option>
									</optgroup>
								</select>
							</td>
						</tr>
						
						<tr>
							<td style="text-align: left; margin-top: 25px">
								<p><strong>배경색 랜덤선택	</strong>&nbsp;&nbsp;&nbsp;</p>
							</td>
						</tr>
						<tr>
							<td><input type="button" id="rndBtn" class="form-control tooltipstered" 
								style="margin-bottom: 25px; width: 100%; height: 40px; border: 1px solid #d9d9de"
								value="버튼색 랜덤선택(호버링 전)"></td>
						</tr> 
						
						<tr>
							<td style="text-align: left">
								<p><strong>배경색 조절</strong>&nbsp;&nbsp;&nbsp;</p>
							</td>
						</tr>
						<tr>
							<td><input type="range" min="1" max="100" value="50" class="slider" id="bgRange" 
								style="margin-bottom: 10px;"
								></td>
						</tr> 
						<tr>
							<td style="text-align: center;" >
								<p><input type="text" style="width: 25px;"value="50" id="txtRange" readonly="readonly" ></p>
							</td>
						</tr>
						
						
						
					
						
							
						<tr>
							<td style="width: 100%; text-align:center;">
								<input type="button" class = "btn btn-primary form-control tooltipstered" id="sideNavi"
								value = "사이드바 네비">
							</td>
						</tr>
		
						


						<tr>
							<td style="padding-top: 10px; text-align: center">
								<p><strong></strong></p>
							</td>
						</tr>
						<tr>
						
							<td style="width: 100%; text-align: center; ">
							<input type="button" value="리셋" 
								class="btn btn-primary form-control tooltipstered rBtn" id="resetBtn"
								style="background-color: #57ef5e; margin-top: 0;width: 20%; height: 40px; color: white; border: 0px solid #388E3C; opacity: 0.8">
							
							
							<input type="button" value="확인" 
								class="btn btn-primary form-control tooltipstered" id="signup-btn"
								style="background-color: orange; margin-top: 0;width: 79%; height: 40px; color: white; border: 0px solid #388E3C; opacity: 0.8">
							</td>
							
						</tr>

					</table>
					
						
        </form>

        
    </div>
    <!-- /.form-box -->
</div>
<!-- /.register-box -->

<!-- 사이드바 -->
<div id="mySidenav" class="sidenav">
	<a href="javascript:void(0)" class="closebtn" onclick="closeNav()">&times;</a>
	<a href='/board/list'>메인으로</a>				
</div>
		
						

<jsp:include page="../include/plugin-js.jsp" />
<script src="<c:url value='/dist/js/custom/mypage.js'/>"></script>  


</body>
</html>
