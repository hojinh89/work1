<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>

<html>

<head>
<meta charset="UTF-8">



<script type="text/javascript" src="/se2/js/service/HuskyEZCreator.js" charset="utf-8"> </script> 
</head>




<body>
	<form>
		<h1> test page</h1>
 		<textarea name="ir1" id="ir1" rows="10" cols="30"  style="width:650px; height:350px "></textarea>
	</form>
</body>

<jsp:include page="../include/plugin-js.jsp"/>
<script type="text/javascript" >
	var oEditors = [];
	
	$(document).ready(function(){
			nhn.husky.EZCreator.createInIFrame({
			 oAppRef: oEditors,
			 elPlaceHolder: "ir1",
			 sSkinURI: "/se2/SmartEditor2Skin.html",
			 fCreator: "createSEditor2"
			});
			
	});

</script>




</html>