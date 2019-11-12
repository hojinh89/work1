<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri= "http://java.sun.com/jsp/jstl/functions"%>

<%
	request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html>

<jsp:include page="../include/static-head.jsp" />

<body class="hold-transition skin-blue sidebar-mini layout-boxed">

<div class="wrapper">

    <!-- Main Header -->
   
                        

    <!-- Left side column. contains the logo and sidebar -->


    <!-- Content Wrapper. Contains page content -->
    <div class="content-wrapper" style="margin-left : 0px ">
        <!-- Content Header (Page header) -->
        <section class="content-header">
            <h1>
                게시판
                <small>조회페이지</small>
            </h1>
            <ol class="breadcrumb">
                <li><i class="fa fa-edit"></i> article</li>
                <li class="active"><a href="<c:url value='/board/write'/>"> list</a></li>
            </ol>
        </section>

        <!-- Main content -->
        <section class="content container-fluid">

            <div class="col-lg-12">
                <div class="box box-primary">
                	
                    <div class="box-header with-border">
                        <h3 class="box-title">글제목 : ${article.title}</h3>
                    </div>
                    <div class="box-body" style="height: 350px; overflow: auto" >
                      
                   
                  			  <c:set var="len" value="${fn:length(article.fileName)}"/>
							  <c:set var="filetype" value="${fn:toUpperCase(fn:substring(article.fileName, len-4, len))}" />
								<c:choose>
									<c:when test="${(filetype eq '.JPG') or (filetype eq 'JPEG') or (filetype eq '.GIF') or (filetype eq '.PNG') or (filetype eq '.jpg')}">
									<div style="text-align:left;"><br><img src="<c:url value='/board/file/${article.fileId}'/>" alt="" style="width:300px; height:300px;"></div>
									</c:when>
								</c:choose>
								<br>
							${article.content}
					
				
                    </div>
                    
                    
                    
                   
                    
                    <div class="box-footer">
                        <div class="user-block">
                            <img class="img-circle img-bordered-sm" src="<c:url value='/board/p_file/${article.writer}'/>" alt="user image" onerror="this.src='/resources/profile1.jpg'">
                            <span class="username">
                                <a href="#">${article.writer}</a>
                            </span>
                            <span class="description"><fmt:formatDate pattern="yyyy-MM-dd a hh:mm" value="${article.regDate}"/></span>
                        </div>
                    </div>
                    
                    <div class="box-footer">
                        <form role="form" method="post">
                            <input type="hidden" name="boardNo" 		value="${article.boardNo}">
                            <input type="hidden" name="page"			value="${criteria.page}">
                            <input type="hidden" name="countPerPage" 	value="${criteria.countPerPage}">
                        </form>
                        <button type="submit" id="listBtn" class="btn btn-primary listBtn"><i class="fa fa-list"></i> 목록</button>
                        <div class="pull-right">
                        	<button type="submit" class="btn btn-warning modBtn"> <i class="fa fa-edit"></i>수정</button>
                            <button type="submit" class="btn btn-danger delBtn"><i class="fa fa-trash"></i> 삭제</button>
                         
                       
                        <!-- 
                            <button type="submit" class="btn btn-warning modBtn">	
                            <i class="fa fa-edit"></i> 								//이미지용
                                                 수정</button>
                            <button type="submit" class="btn btn-danger delBtn"><i class="fa fa-trash"></i> 삭제</button>
                         -->
                        
                         
                        </div>
                    </div>
                </div>
            </div>

        </section>
        
        <%-- 댓글 --%>
        <%-- 댓글 작성영역 --%>
	            <div class="box box-warning">
	                    <div class="box-header with-border">
	                        <a class="link-black text-lg"><i class="fa fa-pencil margin-r-5"></i>댓글 쓰기</a>
	                    </div>
	                    <div class="box-body">
	                         <form class="form-horizontal">
	                             <div class="form-group margin">
	                             	<div class="col-sm-10">
	                                 <textarea class="form-control" id="newReplyText" rows="3" placeholder="댓글내용을 입력하세요" style="resize: none"></textarea>
	                             	</div>
	                             
		                            <div class="col-sm-2" hidden="hidden">
		                            	<c:choose>
		                            	<c:when test="${empty login}">
		                               		 <input class="form-control" id="newReplyWriter" type="text" placeholder="작성자" value="GUEST" readonly="readonly">
		                                </c:when>	
		                            	<c:otherwise>
		                            		<input class="form-control" id="newReplyWriter" type="text" placeholder="작성자" value="${login.userId}" readonly="readonly">
		                            	</c:otherwise>		                            	
		                            	</c:choose>
		                            </div>
		                            <div class="col-sm-2">
			                            <button type="button" class="btn btn-primary btn-block replyAddBtn">
			                                <i class="fa fa-save"></i> 등록
			                            </button>
		                            </div>
	                             </div>
	                         </form>                        
	                    </div>
	              </div>
	              
	              
	              
	              
	              <div class="box box-success">
						<%--댓글 유무 / 댓글 갯수 / 댓글 펼치기, 접기--%>
						<div class="box-header with-border">
							<a class="link-black text-lg">
							<i class="fa fa-comments-o margin-r-5 replyCount"></i> 댓글갯수</a>
							<div class="box-tools">
								<button type="button" class="btn btn-box-tool"
									data-widget="collapse">
									<i class="fa fa-plus">댓글접기버튼</i>
								</button>
							</div>
						</div>
						<%--댓글 목록--%>
						<div class="box-body repliesDiv testreplies">댓글목록</div>
						<%--댓글 페이징--%>
						<div class="box-footer">
							<div class="text-center">
								<ul class="pagination pagination-sm no-margin">
						댓글페이징
								</ul>
								
								
							</div>
						</div>
					</div>
					
					
					
					<%--댓글 수정 modal 영역--%>
					<div class="modal fade" id="modModal">
						<div class="modal-dialog">
							<div class="modal-content">
								<div class="modal-header">
									<button type="button" class="close" data-dismiss="modal"
										aria-label="Close">
										<span aria-hidden="true">&times;</span>
									</button>
									<h4 class="modal-title">댓글수정</h4>
								</div>
								<div class="modal-body" data-rno>
									<input type="hidden" class="replyNo" />
									<%--<input type="text" id="replytext" class="form-control"/>--%>
									<textarea class="form-control" id="replyText" rows="3"
										style="resize: none"></textarea>
								</div>
								<div class="modal-footer">
									<button type="button" class="btn btn-default pull-left"
										data-dismiss="modal">닫기</button>
									<button type="button" class="btn btn-primary modalModBtn">수정</button>
								</div>							
								</div>						
								</div>							</div>

					<%--댓글 삭제 modal 영역--%>
					<div class="modal fade" id="delModal">
						<div class="modal-dialog">
							<div class="modal-content">
								<div class="modal-header">
									<button type="button" class="close" data-dismiss="modal"
										aria-label="Close">
										<span aria-hidden="true">&times;</span>
									</button>
									<h4 class="modal-title">댓글 삭제</h4>
									<input type="hidden" class="rno" />
								</div>
								<div class="modal-body" data-rno>
									<input type="hidden" class="replyNo" />
									<p>댓글을 삭제하시겠습니까?</p>
									<input type="hidden" class="rno" />
								</div>
								<div class="modal-footer">
									<button type="button" class="btn btn-default pull-left"
										data-dismiss="modal">아니요.</button>
									<button type="button" class="btn btn-primary modalDelBtn">네.
										삭제합니다.</button>
								</div>
							</div>
						</div>
					</div>
					
					

	        
	              
        
        
        
        
        
        <!-- /.content -->
    </div>
    <!-- /.content-wrapper -->
    
    
    <!-- Main Footer -->
    

</div>
<!-- ./wrapper -->

<jsp:include page="../include/plugin-js.jsp" />


<%-- Handlebars // https://handlebarsjs.com --%>
<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.0.11/handlebars.min.js"></script>
	<%--
	댓글 목록들을 출력하기 위한 Handlebars 라이브러리의 템플릿 코드
	아래의 템플릿 코드는 하나의 댓글을 구성하기 위한 코드입니다.
	<img class="img-circle img-bordered-sm" src="<c:url value='/dist/img/{{profilePhoto replyWriter}}.jpg'/>" alt="user image">
 --%>
<script id="replyTemplate" type="text/x-handlebars-template">
    {{#each.}}
    <div class="post replyDiv" data-replyNo={{replyNo}} style = "margin-left: <c:out value='{{replyMarginTest depth}}'/>;">
        <div class="user-block">
            <%--댓글 작성자 프로필사진, 추후 수청필요. cif테스트용으로 사용 --%>
		
			<img class="img-circle img-bordered-sm" src="<c:url value='/board/p_file/{{replyWriter}}'/>" alt="user image" onerror="this.src='/resources/profile1.jpg'">
			


            <%--댓글 작성자--%>
            <span class="username">
                <%--작성자 이름--%>

					<a href="#"> {{replyWriter}} </a>
			
                
                <%--댓글 삭제 버튼--%>
                <a href="#" class="pull-right btn-box-tool replyDelBtn" data-toggle="modal" data-target="#delModal">
                    <i class="fa fa-times"> 삭제</i>
                </a>
                <%--댓글 수정 버튼--%>
                <a href="#" class="pull-right btn-box-tool replyModBtn" data-toggle="modal" data-target="#modModal">
                    <i class="fa fa-edit"> 수정</i>
                </a>
            </span>
            <%--댓글 작성일자--%>
            <span class="description" >{{prettifyDate regDate}}</span>
        </div>
        <%--댓글 내용--%>
		<%----------------------------------------------------------%>
		<%-- collapse --%>
		<%--
        <a href="#rereply{{replyNo}}" aria-expanded="false" aria-controls="rereply{{replyNo}}" style = "color : black;"
			 class="oldReplyText" data-toggle="collapse"  id="replyClickBtn" > --%>
		<div id="replyContext">
      		<text style = "color : black; margin-left: <c:out value='{{replyNoTest replyNo}}'/>;" class = "oldReplyText"  id = "replyClickBtn" name="replyClickBtn">
				{{{escape replyText}}}
			</text>
		</div>
        <br>
    </div>
	




    {{/each}}
</script>

<script type="text/javascript">
/*
$(document).on("click","text[name='replyClickBtn']",function(){ //동적 이벤트
	alert('test');
});
*/
$(document).ready(function () {
	
	let boardNo = "${article.boardNo}"; //현재 게시글 번호
	console.log(boardNo);
	let replyPageNum = 1; //댓글 페이지 번호
	let replyArray;
	
	//test
	Handlebars.registerHelper("replyNoTest", function(replyNo) {
		return replyNo/10 + "px";
	});
	
	
	
	
	Handlebars.registerHelper("replyMarginTest", function(depth) {
		if(depth == 0) 
			return depth/10 + "px";
		else
			return 100+"px";
	});

	//댓글 내용 줄바꿈 공백 처리
	Handlebars.registerHelper("escape", function(replytext) {
		let text = Handlebars.Utils.escapeExpression(replytext);
		text = text.replace(/(\r\n|\n|\r)/gm, "<br>");
		text = text.replace(/( )/gm, "&nbsp;");
		return new Handlebars.SafeString(text);
	});
	
	//댓글 등록 날짜 포맷팅
	Handlebars.registerHelper("prettifyDate", function(time) {
		let dateObj = new Date(time);
		let year = dateObj.getFullYear();
		let month = dateObj.getMonth() + 1;
		let date = dateObj.getDate();
		let hours = dateObj.getHours();
		let minutes = dateObj.getMinutes();
		//2자리 숫자로 변환
		month < 10 ? month = '0' + month : month;
		date < 10 ? date = '0' + date : date;
		hours < 10 ? hours = '0' + hours : hours;
		minutes < 10 ? minutes = '0' + minutes : minutes;
		return year + "-" + month + "-" + date + "-" + hours + ":" + minutes;
	});
	
	
	//프로필 사진 체크
	Handlebars.registerHelper("profilePhoto", function(replyWriter) {
		if(replyWriter == "GUEST"){
			return "GUEST";
		}
		else
			return "HOJIN";
		
	});
	

	
	//댓글 목록 함수 호출
	getReplies("/replies/" + boardNo + "/" + replyPageNum);
	
	
	
	//댓글 목록 불러오기 함수
	function getReplies(uri) {
		console.log(uri);
		$.getJSON(uri, function(data) {
			console.log("data : ");
			console.log(data);
		
			replyArray = data.replies;
			//댓글번호
			console.log("replies values : ");
			console.log(replyArray);
			
			
			printReplyCount(data.pageCreator.articleTotalCount);
			printReplies(data.replies, $(".repliesDiv"), $("#replyTemplate"));
			printReplyPaging(data.pageCreator, $(".pagination"));
		});
	}
	
	
	
	//댓글 총 개수 출력 함수
	function printReplyCount(totalCount) {
		const replyCount = $(".replyCount");
		const collapsedBox = $(".collapsed-box");
		
		//댓글이 없을 때
		if(totalCount === 0) {
			replyCount.html("댓글이 없습니다. 댓글을 작성해주세요!");
			return;
		}
		
		//댓글이 존재할 때
		replyCount.html("댓글 목록 (" + totalCount + ")");
		
		collapsedBox.find(".btn-box-tool").html(
			"<button type='button' class='btn btn-box-tool' data-widget='collapse'>"
			+ "<i class='fa fa-plus'></i>"
			+ "</button>"			
		);
		
		
		
	}
	
	//댓글 목록 출력 함수
	function printReplies(replyArr, targetArea, templateObj) {
		const replyTemplate = Handlebars.compile(templateObj.html());
		const html = replyTemplate(replyArr);
		$(".replyDiv").remove();
		targetArea.html(html);
	}
	

	
	//댓글 페이지 출력 함수
	function printReplyPaging(pageCreator, targetArea) {
		let element = "";
		if(pageCreator.prev) {
			element += "<li><a href='" + (pageCreator.beginPage - 1) + "'>이전</a></li>";
		}
		
		const len = pageCreator.endPage;
		for(let i=pageCreator.beginPage; i <= len; i++) {
			const active = pageCreator.criteria.pageCnt === i ? "class=active" : "";
			element += "<li " + active + "><a href='" + i + "'>" + i + "</a></li>";
		}
		
		if(pageCreator.next) {
			element += "<li><a href='" + (pageCreator.endPage + 1) + "'>다음</a></li>";
		}
		
		targetArea.html(element);
	}
	
	//댓글 페이지 번호 클릭 이벤트
	$(".pagination").on("click", "li a", function(e) {
		console.log("page click!")
		e.preventDefault();
		replyPageNum = $(this).attr("href");
		console.log(replyPageNum);
		getReplies("/replies/" + boardNo + "/" + replyPageNum);
		
	});
	
	// 댓글 저장 버튼 클릭 이벤트
    $(".replyAddBtn").on("click", function () {

        // 입력 form 선택자
        const replyWriterObj = $("#newReplyWriter");
        const replyTextObj = $("#newReplyText");
        let replyWriter = replyWriterObj.val();
        let replyText = replyTextObj.val();
       
        
        console.log("원본 글 번호: " + boardNo + "작성자 : " + replyWriter);

        // 댓글 입력처리 수행
        $.ajax({
            type: "POST",
            url: "/replies/",
            headers: {
                "Content-Type": "application/json",
                "X-HTTP-Method-Override": "POST"
            },
            dataType: "text",
            data: JSON.stringify({
                boardNo: boardNo,
                replyWriter: replyWriter,
                replyText: replyText
              
            }),
            success: function (result) {
                console.log("result : " + result);
                if (result === "regSuccess") {
                    alert("댓글이 등록되었습니다.");
                    replyPageNum = 1;  // 페이지 1로 초기화
                    getReplies("/replies/" + boardNo + "/" + replyPageNum); // 댓글 목록 호출
                    replyTextObj.val("");   // 댓글 입력창 공백처리
                    ////////////////////////////////////////////////// 댓글작성자 GUEST 통일위해 사용, 추후 수정
                    //replyWriterObj.val("");   // 댓글 입력창 공백처리
                	///////////////////////////////////////////////////
                }
            }
        });
    });
	
	
 		// 대댓글 저장
 		//$(".reReplyAddBtn").on("click", function () {
		 $(document).on("click", '.reReplyAddBtn', function(){    
 			
        // 입력 form 선택자
        const replyWriterObj = $("#newreReplyWriter");
        const replyTextObj = $("#newreReplyText");
       
        	
        	
        let replyWriter = replyWriterObj.val();
        let replyText = replyTextObj.val();
        
        if(${login != null}){  	
        	
        	replyWriter = "${login.userId}";
        }
        
        var parentTag = $(this).parent().parent().parent().parent().parent().parent();
        var upperNo = parentTag.attr("data-replyno");
        console.log('parenttag : ' );
        console.log(parentTag);
        console.log('upperNo: ' );
        console.log(upperNo);
    
        console.log("원본 글 번호 boardNo: " + boardNo);
		
      
        
        // 대댓글 입력처리 수행
        $.ajax({
            type: "POST",
            url: "/replies/reReplyInsert",
            headers: {
                "Content-Type": "application/json",
                "X-HTTP-Method-Override": "POST"
            },
            dataType: "text",
            
            data: JSON.stringify({
            	 boardNo: boardNo,
                 replyWriter: replyWriter,
                 replyText: replyText,
                 upperNo : upperNo
            }),
        
            success: function (result) {
                console.log("result123123 : " + result);
                if (result === "reReplyregSuccess") {
                    alert("대댓글이 등록되었습니다.");
                    replyPageNum = 1;  // 페이지 1로 초기화
                    getReplies("/replies/" + boardNo + "/" + replyPageNum); // 댓글 목록 호출
                    replyTextObj.val("");   // 댓글 입력창 공백처리
                    //replyWriterObj.val("");   // 댓글 입력창 공백처리
                    
                    
                    var removeTag = $(this).parent().parent().parent().parent().parent();
                	
                	removeTag.remove();
                   
                    
                }
            }
        });
    });
       	
      //대댓글 목록 함수 호출
    	//getSequence("/reReplies/" + boardNo);
    	
    	
    	
    	//댓글 목록 불러오기 함수
    	function getReplies(uri) {
    		console.log(uri);
    		$.getJSON(uri, function(data) {
    			console.log("data : ");
    			console.log(data);
    		
    			replyArray = data.replies;
    			//댓글번호
    			console.log("replies values : ");
    			console.log(replyArray);
    			
    			
    			printReplyCount(data.pageCreator.articleTotalCount);
    			printReplies(data.replies, $(".repliesDiv"), $("#replyTemplate"));
    			printReplyPaging(data.pageCreator, $(".pagination"));
    		});
    	}   	
       	
	
 	// 댓글 수정을 위해 modal창에 선택한 댓글의 값들을 세팅
 	//돌아감
 	//$(document).on("click", ".replyModBtn", function (event) {	
 	$(".repliesDiv").on("click", ".replyModBtn", function (event) {
 	//안됨, handlebars 사용할땐 미리 뷰 설정한 클래스만 인식가능한듯, 아니면 맨위처럼쓰던가
 	//$(".replyModBtn").on("click",  function () {

        const reply = $(this).parent().parent().parent();
        console.log('댓글 수정 클릭 이벤트 : (this).parent.parent.parent : ');
        console.log(reply);
        
        $(".replyNo").val(reply.attr("data-replyNo"));
        $("#replyText").val(reply.find(".oldReplyText").text());
    });
 	
    $(".repliesDiv").on("click", ".replyDelBtn", function (event) {
     
            const reply = $(this).parent().parent().parent();
            
            $(".replyNo").val(reply.attr("data-replyNo"));
          
        });
 	
    //대댓글 입력취소
    $(document).on("click", '.reReplyCXL', function(){    
    	var parentTag = $(this).parent().parent().parent().parent().parent();
    	
    	parentTag.remove();
    	
    });
    
    
	//댓글 클릭시 대댓글 작성창 on (1)
    $(document).on("click", '#replyContext', function(){
    // // $(document).on("click", "div[id='replyContext']", function(){    });	
    	
    	//var reReplyTemplate =$("#reReplyWrite").html();
 		//Handlebars.registerPartial('reReplyWriteHeader', reReplyTemplate);
 		//	getReplies("/replies/" + boardNo + "/" + replyPageNum);
 		
 		
 		//'	<textarea class="form-control" id="newReplyText'+${article.boardNo}+'" rows="3" placeholder="대댓글내용을 입력하세요" style="resize: none"></textarea> '+
              
 		console.log('대댓글 작성창 this : '); 		
 		console.log($(this));
 		
 		console.log('클릭한 댓글번호 : '); 		
 		console.log($(this).parent().attr("data-replyno"));
 		
 		
    		var rereplyEditor = 
				' <div class="box box-warning reReplyInput"> '+
				' 	<div class="box-body">' +
				'		 <form class="form-horizontal">' +                            
                '			 <div class="form-group margin">'+
                ' 		     <div class="col-sm-10"> '+ 
                '				<textarea class="form-control" id="newreReplyText" rows="3" placeholder="대댓글내용을 입력하세요" style="resize: none"></textarea> '+
                '			 </div> <div class="col-sm-2" hidden="hidden"> '+
                '                       <input class="form-control" id="newreReplyWriter" type="text" placeholder="작성자" value="GUEST" readonly="readonly"> '+
                '                  </div> '+
                '                 <div class="col-sm-2"> '+
                '                    <button type="button" class="btn btn-primary btn-block reReplyAddBtn"> '+
                '                           <i class="fa fa-save"></i> 등록 '+
                '                    </button> ' +
                '                    <button type="button" class="btn btn-danger btn-block reReplyCXL"> '+
                '                           <i class="fa fa-trash"></i> 입력취소 '+
                '                    </button> ' +              
                '</div> </div> </form> </div> </div> ';                      
     		$(this).next().after(rereplyEditor);			
     		
   	 });
 	
 	//댓글 클릭시 대댓글 작성창 on (2), 안되서폐기 이유는찾아보기, 핸들러바 안에있는거에 클릭이벤트 줄때 뭔가 문제가있는듯
 	/*
 	$(".box-title").on("click", function(){
 		console.log('대댓창 입력 on' + $(this)); 	
 		alert('test');
 		//reReplyWritePage
 		
 		//reReplyWrite
 		//var reReplyTemplate =$("#reReplyWrite").html();
 		//Handlebars.registerPartial('reReplyWriteHeader', reReplyTemplate);
 		//	getReplies("/replies/" + boardNo + "/" + replyPageNum);
    		var rereplyEditor = 
				' <div class="box box-warning "> '+
				' 	<div class="box-body">' +
				'		 <form class="form-horizontal">' +                            
                '			 <div class="form-group margin">'+
                ' 		     <div class="col-sm-10"> '+ 
                '				<textarea class="form-control" id="newReplyText" rows="3" placeholder="대댓글내용을 입력하세요" style="resize: none"></textarea> '+
                '			 </div> <div class="col-sm-2" hidden="hidden"> '+
                '                       <input class="form-control" id="newReplyWriter" type="text" placeholder="작성자" value="${login.userId}" readonly="readonly"> '+
                '                  </div> '+
                '                 <div class="col-sm-2"> '+
                '                    <button type="button" class="btn btn-primary btn-block replyAddBtn"> '+
                '                           <i class="fa fa-save"></i> 등록 '+
                '                       </button> </div> </div> </form> </div> </div> ';                      
     		//$(this).next().after(rereplyEditor);	
 		
 	
 	});
	*/
 	

    // modal 창의 댓글 수정버튼 클릭 이벤트
    $(".modalModBtn").on("click", function () {
        let replyNo = $(".replyNo").val();
        let replyText = $("#replyText").val();
       
       
        $.ajax({
            type: "put",
            url: "/replies/" + replyNo,
            headers: {
                "Content-Type": "application/json",
                "X-HTTP-Method-Override": "PUT"
            },
            dataType: "text",
            data: JSON.stringify({
            	replyNo: replyNo,
            	boardNo: boardNo,
                replyText: replyText
            }),
            success: function (result) {
                console.log("result : " + result);
                if (result === "modSuccess") {
                    alert("댓글이 수정되었습니다.");
                    getReplies("/replies/" + boardNo + "/" + replyPageNum); // 댓글 목록 호출
                    $("#modModal").modal("hide"); // modal 창 닫기
                }
            }
        })
    });

    // modal 창의 댓글 삭제버튼 클릭 이벤트
    $(".modalDelBtn").on("click", function () {
        const replyNo = $(".replyNo").val();
        
        console.log("replyNo : " + replyNo);
       
        $.ajax({
            type: "delete",
            url: "/replies/" + replyNo,
            headers: {
                "Content-Type": "application/json",
                "X-HTTP-Method-Override": "DELETE"
            },
            data: JSON.stringify({
            	replyNo: replyNo,
            	boardNo: boardNo
            }),
            dataType: "text",
            success: function (result) {
                console.log("result : " + result);
                if (result === "delreplySuccess") {
                    alert("댓글이 삭제되었습니다.");                 
                }
                else if(result === "delrepliesSuccess"){
                	alert("댓글과 대댓글이 모두 삭제되었습니다.");                      
                }
                getReplies("/replies/" + boardNo + "/" + replyPageNum); // 댓글 목록 호출
                $("#delModal").modal("hide"); // modal 창 닫기
                
            }
        });
    });
	
	
	
	
	
	
	
	
	const formObj = $("form[role='form']");
	
	$("#listBtn").on("click", function() {
		formObj.attr("method", "get");
		formObj.attr("action", "list");
		formObj.submit();
	});
	
	$(".modBtn").on("click", function() {
		formObj.attr("method", "get");
		formObj.attr("action", "modify");
		formObj.submit();
	});
	
	$(".delBtn").on("click", function () {
        formObj.attr("action", "delete");
        formObj.submit();
     });
	

	
});

</script>

</body>

</html>








