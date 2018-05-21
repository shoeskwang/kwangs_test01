<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Ticket MyTicket</title>
<%@ include file="../include/header.jsp" %>
<style type="text/css">
	#mainContents {border:1px;}
	#summary {display:inline-block; width:600px}
	#imgsection {float:left; width:200px}
	#textsection {width:800px}
	#detail {display:block;width:600px}
</style>

<script>
	function pageChange(tno){
		console.log(" tno = " + tno);
		location.href="${path}/ticket/view.do?tno="+tno;
	}
	
	function cartDelete(cartId){
		console.log(" cartDelete cartId = " + cartId);
		location.href="${path}/cart/cartDelete.do?cartId="+cartId;
	}
</script>
</head>
<body>
<%@ include file="../include/menu.jsp" %>
<div id="wrapper">
<section class="wrapper style1 fullscreen">
	<h2>마이티켓</h2>
	
		<hr>
		<h3>구매목록</h3>
		<hr>
		<div>
		<c:choose>
		    <c:when test="${map.orderList.size()>0}">
		        <c:forEach var="dto" items="${map.orderList}">
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
							관람가격 <strong> ${dto.tprice}</strong> <br>
							개수 : <strong> ${dto.amount}</strong> <br>
							<br>
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
		
		
		<h3>찜목록</h3>
		<hr>
		<div>
		<c:choose>
		    <c:when test="${map.list.size()>0}">
		        <c:forEach var="dto" items="${map.list}">
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
							장르  <strong> ${dto.genre}</strong> <br>
							관람가격 <strong> ${dto.tprice}</strong> <br>
							</div>
						</div>
					</div>
					<button onclick="cartDelete(${dto.cartId})">삭제</button>
					<div id="detail">
						
					</div>
				</div>
				<hr>
				</c:forEach>
		    </c:when>    
		    <c:otherwise>
		        	마이티켓 목록이 없습니다.
		    </c:otherwise>
		</c:choose>
		</div>
</section>
</div>
</body>
</html>