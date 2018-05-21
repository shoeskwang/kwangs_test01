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
	var tno = "${dto.tno}";
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
	<h3>티켓구매</h3>
		<hr>
		<div>
				<div id="mainContents">
					<div id="summary"  onclick="pageChange('${dto.tno}')">
						<div id="imgsection">
							<img src="<%=request.getContextPath()%>/images/${dto.poster}.png" />
						</div>
						<div id="textsection">
							<div>
								<strong>${dto.title}</strong>
							</div>
							<div>
								<strong>${dto.summary}</strong>
							</div>
							<div>
							공연기간 <strong><fmt:formatDate pattern = "yyyy-MM-dd" value = "${dto.sdate}" /> - <fmt:formatDate pattern = "yyyy-MM-dd" value = "${dto.edate}" /> </strong><br>
							장르  <strong> 
								<c:if test="${dto.genre == 1}">
								발라드/재즈
								</c:if>
								<c:if test="${dto.genre == 2}">
									록/힙합/댄스
								</c:if>
								<c:if test="${dto.genre == 3}">
									인디
								</c:if>
								<c:if test="${dto.genre == 4}">
									POP
								</c:if>
								<c:if test="${dto.genre == 5}">
									트로트
								</c:if>
							<%-- ${dto.genre} --%>
							</strong> <br>
							관람가격 <strong> ${dto.tprice}</strong> <br>
							개수 : <strong> ${map.amount}</strong> <br>
							<br>
							예약좌석 : <strong> ${map.reserveSeat}</strong> <br>
							총금액 : <strong> ${dto.tprice * map.amount}</strong> <br>
							</div>
						</div>
					</div>
					<div id="detail">
						
					</div>
				</div>
				<hr>
		</div>
	
	<div>
		<h3>입금계좌</h3>
		신한은행 123-123-123456<br>
		예금주: 김티켓 <br><br>
		* 입금 확인시 구매처리해드립니다.
	</div>
	<hr>
	<div>
		<button id="okBtn">확인</button>
	</div>
	
</section>
</div>
</body>
</html>