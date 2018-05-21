<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Ticekt Order</title>
<%@ include file="../include/header.jsp" %>
<style type="text/css">
	#mainContents {border:1px;}
	#summary {display:inline-block; width:600px}
	#imgsection {float:left; width:200px}
	#textsection {width:600px}
	#detail {display:block;width:600px}
</style>
<script>
$(document).ready(function(){
	var tno = "${map.tno}";
	var userId = "${sessionScope.userId}";
	
	console.log("  tno = " + tno);
	console.log("  userId = " + userId);
	
	
    $("#okBtn").bind("click",function(){
    	/* var tno = "${dto.tno}";
    	var userId = "${sessionScope.userId}";
    	console.log("  tno = " + tno);
    	console.log("  userId = " + userId); */
    	location.href="${path}/ticket/view.do?tno="+tno;
    	
    });
    
    
});
</script>
</head>
<body>
<%@ include file="../include/menu.jsp" %>
<div id="wrapper">
<section class="wrapper style1 fullscreen">
	<h3>티켓구매 실패</h3>
	<hr>
		<h4> 해당 좌석이 이미 예약되어 구매에 실패하였습니다. <br>
			  구매과정이 초기화되어 해당 공연 상세페이지로 이동합니다. </h4>
	<hr>
	<div>
		<button id="okBtn">확인</button>
	</div>
	
</section>
</div>
</body>
</html>