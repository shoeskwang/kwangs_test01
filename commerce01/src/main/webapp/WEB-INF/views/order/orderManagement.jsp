<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Ticket OrderManagement</title>
<%@ include file="../include/header.jsp" %>
<style type="text/css">
	#mainContents {border:1px;}
	#summary {display:inline-block; width:600px}
	#imgsection {float:left; width:200px}
	#textsection {width:800px}
	#detail {display:block;width:600px}
</style>
<script>

function stateChange(orderId){
	console.log("orderId = " + orderId);
	var orderState = document.getElementById("orderState").selectedIndex+1;
	console.log("orderState = " + orderState);
		
	location.href="${path}/order/orderStateUpdate.do?orderId="+orderId+"&orderState="+orderState;
}


$(document).ready(function(){
    
}); 
</script>

<title>Ticket</title>
</head>
<body>
<%@ include file="../include/menu.jsp" %>
<h2>구매관리</h2>
	<hr>
	<h3>구매목록</h3>
	<hr>
	<div>
	<c:choose>
	    <c:when test="${map.orderList.size()>0}">
	        <c:forEach var="dto" items="${map.orderList}">
			<div id="mainContents">
				<div id="summary">
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
						공연기간 : <strong><fmt:formatDate pattern = "yyyy-MM-dd" value = "${dto.sdate}" /> - <fmt:formatDate pattern = "yyyy-MM-dd" value = "${dto.edate}" /> </strong><br>
						관람가격  :<strong> ${dto.tprice}</strong> <br>
						개수 : <strong> ${dto.amount}</strong> <br>
						<br>
						구매자 : <strong> ${dto.userId}</strong> <br>
						총금액 : <strong> ${dto.tprice * dto.amount}</strong> <br>
						</div>
					</div>
				</div>
				구매상태 : 
				<c:choose>
					<c:when test="${dto.orderState == '1'}">
						입금 대기중
					</c:when>
					<c:when test="${dto.orderState == '2'}">
						결제완료
					</c:when>
					<c:when test="${dto.orderState == '3'}">
						예약완료
					</c:when>
					<c:when test="${dto.orderState == '4'}">
						취소
					</c:when>
				</c:choose>
				
				<div id="detail">
					<div class="row uniform">
		   				<div class="4u 12u$(small)">
		   					구매상태 변경 :
		   				</div>
		   				<div class="4u 12u$(small)">
		   					<select name="orderState" id="orderState">
	                        <option value="1">입금 대기중</option>
	                        <option value="2">결제완료</option>
	                        <option value="3">예약완료</option>
	                        <option value="4">취소</option>
	                </select>
		   				</div>
		   				<div class="4u 12u$(small)">
		   					<button id="stateChangeBtn" onclick="stateChange(${dto.orderId})">변경하기</button>
		   				</div>
		   			</div>
				
				</div>
			</div>
			<hr>
			</c:forEach>
	    </c:when>    
	    <c:otherwise>
	        	구매 목록이 없습니다.
	        	<hr>
	    </c:otherwise>
	</c:choose>
	</div>
</body>
</html>