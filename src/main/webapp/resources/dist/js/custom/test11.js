

$(function(){
		//회원이 입력한 데이터를 검증할때 비교할 데이터
		const getIdCheck= RegExp(/^[a-zA-Z0-9]{4,14}$/);
	   const getPwCheck= RegExp(/([a-zA-Z0-9].*[!,@,#,$,%,^,&,*,?,_,~])|([!,@,#,$,%,^,&,*,?,_,~].*[a-zA-Z0-9])/);
	   const getName= RegExp(/^[가-힣]+$/);
	   const getMail = RegExp(/^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/);
	   let chk1 = false, chk2 = false, chk3 = false, chk4 = false;

	  
	   
	   //join에서 이미지 미리보기용
	   $('#btn_upload').click(function(e){
		   e.preventDefault();
		   $("#upload_file").click();
	   });
	   
		$("#upload_file").on("change", handleImgFileSelect);
		 
		
		
	   
	   //회원가입 검증~~
	   //ID 입력값 검증.
	   $('#user_id').on('keyup', function() {
	      if($("#user_id").val() === ""){
	         $('#user_id').css("background-color", "pink");
	         $('#idChk').html('<b style="font-size:14px;color:red;">[ID를 입력해주세요]</b>');
	         chk1 = false;
	      }
	      
	      //아이디 유효성검사
	      else if(!getIdCheck.test($("#user_id").val())){
	         $('#user_id').css("background-color", "pink");
	         $('#idChk').html('<b style="font-size:14px;color:red;">[영문자,숫자 4-14자]</b>');     
	         chk1 = false;
	      } 
	      //ID 중복확인 비동기 처리
	      else {
	         const userId = $('#user_id').val();
	         $.ajax({
	            type: "POST",
	            url: "/user/idCheck",
	            headers: {
	                   "Content-Type": "application/json",
	                   "X-HTTP-Method-Override": "POST"
	               },
	            data: userId ,
	            datatype: "json",
	            success: function(data) {
	               console.log(data);
	               if(data.confirm === "OK") {
	                  $('#user_id').css("background-color", "aqua");
	                  $('#idChk').html('<b style="font-size:14px;color:green;">[사용가능한 ID입니다]</b>');
	                  chk1 = true;
	               } else {
	                  $('#user_id').css("background-color", "pink");
	                  $('#idChk').html('<b style="font-size:14px;color:red;">[중복된 ID입니다]</b>');
	                  chk1 = false;
	               }
	            },
	            error : function(error) {
	                   
	                   console.log("error : " + error);
	               }
	         });
	      }
	   });
	   
	   //패스워드 입력값 검증.
	   $('#password').on('keyup', function() {
	      //비밀번호 공백 확인
	      if($("#password").val() === ""){
	          $('#password').css("background-color", "pink");
	         $('#pwChk').html('<b style="font-size:14px;color:red;">[비밀번호를 입력해주세요]</b>');
	         chk2 = false;
	      }               
	      //비밀번호 유효성검사
	      else if(!getPwCheck.test($("#password").val()) || $("#password").val().length < 8){
	          $('#password').css("background-color", "pink");
	         $('#pwChk').html('<b style="font-size:14px;color:red;">[특수문자 포함 8자이상]</b>');
	         chk2 = false;
	      } else {
	         $('#password').css("background-color", "aqua");
	         $('#pwChk').html('<b style="font-size:14px;color:green;"></b>');
	         chk2 = true;
	      }
	      
	   });
	   
	   //패스워드 확인란 입력값 검증.
	   $('#password_check').on('keyup', function() {
	      //비밀번호 확인란 공백 확인
	      if($("#password_check").val() === ""){
	          $('#password_check').css("background-color", "pink");
	         $('#pwChk2').html('<b style="font-size:14px;color:red;">[비밀번호 확인창을 입력해주십시오]</b>');
	         chk3 = false;
	      }               
	      //비밀번호 확인란 유효성검사
	      else if($("#password").val() != $("#password_check").val()){
	          $('#password_check').css("background-color", "pink");
	         $('#pwChk2').html('<b style="font-size:14px;color:red;">[기존 비밀번호랑 똑같이 작성해야합니다]</b>');
	         chk3 = false;
	      } else {
	         $('#password_check').css("background-color", "aqua");
	         $('#pwChk2').html('<b style="font-size:14px;color:green;"></b>');
	         chk3 = true;
	      }
	      
	   });
	   
	   //이름 입력값 검증.
	   $('#user_name').on('keyup', function() {
	      //이름값 공백 확인
	      if($("#user_name").val() === ""){
	          $('#user_name').css("background-color", "pink");
	         $('#nameChk').html('<b style="font-size:14px;color:red;">[이름을 입력해주세요]</b>');
	         chk4 = false;
	      }               
	      //이름값 유효성검사
	      else if(!getName.test($("#user_name").val())){
	          $('#user_name').css("background-color", "pink");
	         $('#nameChk').html('<b style="font-size:14px;color:red;">[한글 이름만 가능합니다]</b>');
	         chk4 = false;
	      } else {
	         $('#user_name').css("background-color", "aqua");
	         $('#nameChk').html('<b style="font-size:14px;color:green;"></b>');
	         chk4 = true;
	      }
	      
	   });
	   
	   
	   
	   $('#signup-btn').click(function(e) {
		
	      if(chk1 && chk2 && chk3 && chk4) {
	         const id = $("#user_id").val();
	         const pw = $("#password").val();
	         const name = $("#user_name").val();
	         const user = {
	            userId: id,
	               userPw: pw,
	               userName: name
	         };
	         console.log(user);
	         
	         $.ajax({
	            type: "POST",
	            url: "/user/join",
	               headers: {
	                   "Content-Type": "application/json",
	                   "X-HTTP-Method-Override": "POST"
	               },
	               dataType: "text",
	               data: JSON.stringify(user),
	               success: function(result) {
	                  console.log("result: " + result);
	                  if(result === "joinSuccess") {
	                     alert("회원가입 성공!");
	                     self.location = "/user/login";
	                  }
	               }
	         });
	      } else {
	         alert('입력정보를 다시 확인하세요.');         
	      }
	   });
	   
	 //파일 업로드한 사진 미리보기
		var sel_file;	
		var preImghtml = '<img id="preImg"  style="margin-top : 5px; width : 300px; height : 300px;"/>';
		function handleImgFileSelect(e){
			var files = e.target.files;
			var filesArr = Array.prototype.slice.call(files);
			
			console.log(files);
			console.log(filesArr);
			
			filesArr.forEach(function(f){
				sel_file=f;
				
				var reader = new FileReader();
				reader.onload = function(e){
					$("#upload_file").after(preImghtml);
					$("#preImg").attr("src", e.target.result);
				}
				reader.readAsDataURL(f);
			});
			
		}
	   
	   ///////////////////////////////////////////////////////////////////////////////////////////
	   
	   //로그인 검증~~
	   //ID 입력값 검증.
	   $('#loginId').on('keyup', function() {
	      if($("#loginId").val() == ""){
	         $('#loginId').css("background-color", "pink");
	         $('#idCheck').html('<b style="font-size:14px;color:red;">[ID를 입력해주세요!]</b>');
	         chk1 = false;
	      }            
	      //아이디 유효성검사
	      else if(!getIdCheck.test($("#loginId").val())){
	         $('#loginId').css("background-color", "pink");
	         $('#idCheck').html('<b style="font-size:14px;color:red;">[영문자,숫자 4-14자]</b>');     
	         chk1 = false;
	      } else {
	         $('#loginId').css("background-color", "aqua");
	         $('#idCheck').html('<b style="font-size:14px;color:green;"></b>');
	         chk1 = true;
	      }
	   });
	   
	   //패스워드 입력값 검증.
	   $('#loginPw').on('keyup', function() {
	      //비밀번호 공백 확인
	      if($("#loginPw").val() === ""){
	          $('#loginPw').css("background-color", "pink");
	         $('#pwCheck').html('<b style="font-size:14px;color:red;">[비밀번호를 입력해주세요]</b>');
	         chk2 = false;
	      }               
	      //비밀번호 유효성검사
	      else if(!getPwCheck.test($("#loginPw").val()) || $("#loginPw").val().length < 8){
	          $('#loginPw').css("background-color", "pink");
	         $('#pwCheck').html('<b style="font-size:14px;color:red;">[특수문자 포함 8자이상]</b>');
	         chk2 = false;
	      } else {
	         $('#loginPw').css("background-color", "aqua");
	         $('#pwCheck').html('<b style="font-size:14px;color:green;"></b>');
	         chk2 = true;
	      }
	      
	   });
	   
	
	   
	 //로그인 버튼 클릭 이벤트
	   $('#login-btn').click(function() {
	      if(chk1 && chk2) {
	         //ajax통신으로 서버에서 값 받아오기
	         const id = $('#loginId').val();
	         const pw = $('#loginPw').val();
	         const autoLogin = $("input[name=autoLogin]").is(":checked");
	         
	         console.log("id: " + id);
	         console.log("pw: " + pw);
	         console.log("autoLogin: " + autoLogin);
	        
	         //json으로 보내면 자동으로 파싱됨. 
	         //uservo 에 있는 데이터에 맞춰서 보내면 
	         //컨트롤러에서 @requestbody LoginVO login에서 
	         //userid와 userpw에 자동파싱(저장)해서 쓸수있음  
	         const userInfo = {
	            userId : id,
	            userPw : pw,
	            autoLogin: autoLogin
	         };
	         
	         $.ajax({
	            type: "POST",
	            url: "/user/loginCheck",
	            headers: {
	                   "Content-Type": "application/json",
	                   "X-HTTP-Method-Override": "POST"
	               },
	            data: JSON.stringify(userInfo),
	            dataType : "text",
	            success: function(data) {
	               console.log("result: " + data);  
	               if(data === "idFail") {
	                   $('#loginId').css("background-color", "pink");
	                   $('#idCheck').html('<b style="font-size:14px;color:red;">[등록된 ID가 아닙니다.]</b>');
	                   $('#loginPw').val("");
	                   $('#loginId').focus();
	                   chk2 = false;
	                 } else if(data === "pwFail") {
	                   $('#loginPw').css("background-color", "pink");
	                   $('#loginPw').val("");
	                   $('#loginPw').focus();
	                   $('#pwCheck').html('<b style="font-size:14px;color:red;">[비밀번호 오류]</b>');
	                   chk2 = false;
	                } else if(data === "loginSuccess") {
	                	  alert('로그인 성공');
	                      self.location="/board/list";
	                }
	               
	            }
	         });
	         
	      } else {
	    	  console.log("result: " + data);
	    	  
	         alert('입력정보를 다시 확인하세요.');
	         console.log("result: " + data);
	      }
	   
	   });
	
})

