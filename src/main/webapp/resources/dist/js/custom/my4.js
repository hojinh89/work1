

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
	   
	   
	   $("input:radio[name=gender]").click(function(){
		 if($("input[name=gender]:checked").val() == "female"){
			 $("#armySelect").attr("disabled", true);
			 $("#armySelect").val("no").prop("selected", true);
		 } else{
			 $("#armySelect").attr("disabled", false);
		 }
	   });
	   
	   $("#hobbyBtn1").on('click', function(){
		   $("input[name=hobbySelect]").each(function(){
			   $("input[name='hobbySelect']").prop('checked', true);
		   })
	   });
	   $("#hobbyBtn2").on('click', function(){
		   $("input[name=hobbySelect]").each(function(){
			   $("input[name='hobbySelect']").prop('checked', false);
		   })
	   });
	   $("#hobbyBtn3").on('click', function(){
		   var cnt=0;
		   
		   $("input[name=hobbySelect]").each(function(){
			   if($(this).prop('checked') ==true) cnt++;
		  
		   })
		   alert('선택된 취미의 갯수 : ' + cnt);
	   });
	   
	   $("#rndBtn").click(function(e){
		   var num1 = Math.floor(Math.random()*255);
		   var num2 = Math.floor(Math.random()*255);
		   var num3 = Math.floor(Math.random()*255);
	
		   $(this).css('background', 'rgb('+num1+','+num2+','+num3+')');
	   });
	   
	   $(".rBtn").click(function(e){
		  $("form").each(function(){
			  
			this.reset();  
		  });
		   
	   });
	 
	   
	   var slider = document.getElementById("bgRange");
	   var output = document.getElementById("txtRange");
	   output.value = slider.value; // Display the default slider value

	   // Update the current slider value (each time you drag the slider handle)
	   slider.oninput = function() {
		  
	     output.value = this.value;
	     //alert(this.value + '- ' + output.text);
	   }
	   
	   
	   
});