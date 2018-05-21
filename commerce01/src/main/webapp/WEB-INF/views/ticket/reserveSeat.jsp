<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Ticket View</title>
<%@ include file="../include/header.jsp" %>
<style type="text/css">
	#mainContents {border:1px;}
	#summary {display:inline-block; width:600px}
	#imgsection {float:left; width:200px}
	#textsection {width:400px}
	#detail {display:block;width:600px}
</style>
<script>
$(document).ready(function(){
	var tno = "${dto.tno}";
	var userId = "${sessionScope.userId}";
	console.log("  tno = " + tno);
	console.log("  userId = " + userId);
	// 테마에 따른 데이터 조회
    $("#cartAddBtn").bind("click",function(){
		
		//location.href="${path}/ticket/theme.do?sortOption=2"+"&theme="+themeVal+"&genre="+genreVal;
        $.ajax({
            url : "${path}/cart/cartAdd.do?tno="+tno+"&userId="+userId,
            type: "get",
            data : null,
            success : function(responseData){
            	var data = JSON.parse(responseData);
            	if(data.result == "success"){
            		alert("success!");
            	}else{
            		// 이미 찜목록에 저장되어있는 티켓임
            		alert("fail!");
            	}
            }
        });
    });
	
    $("#buyBtn").bind("click",function(){
    	var tno = "${dto.tno}";
    	var userId = "${sessionScope.userId}";
    	var amount = document.getElementById("amount").selectedIndex+1;
    	console.log("  tno = " + tno);
    	console.log("  userId = " + userId);
    	console.log("  amount = " + amount);
    	
    	location.href="${path}/order/buyTicket.do?tno="+tno+"&userId="+userId+"&amount="+amount;
    });
    
});
</script>
</head>
<body>
<%@ include file="../include/menu.jsp" %>


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
			<c:if test="${sessionScope.userId != null}">
				<button id="cartAddBtn">찜</button>
			</c:if>
						
		</div>
		
	</div>
		<c:if test="${sessionScope.userId != null}">
			<select name="amount" id="amount">
                <c:forEach begin="1" end="10" var="i">
                    <option value="${i}">${i}</option>
                </c:forEach>
            </select>
            &nbsp;장
			<button id="buyBtn">구매하기</button>
		</c:if>
	
	<div id="detail">
		공연기간 <strong><fmt:formatDate pattern = "yyyy-MM-dd" value = "${dto.sdate}" /> - <fmt:formatDate pattern = "yyyy-MM-dd" value = "${dto.edate}" /> </strong><br>
		관람시간&nbsp;&nbsp; <strong>${dto.rtime}</strong>  분<br>
		관람등급 &nbsp;&nbsp; <strong>${dto.tclass} </strong> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		장르 &nbsp;&nbsp; <strong> ${dto.genre}</strong> <br>
		판매상태 &nbsp;&nbsp; <strong> ${dto.state}</strong> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		인기도 &nbsp;&nbsp; <strong> ${dto.tcount}</strong> <br>
		관람가격 &nbsp;&nbsp; <strong> ${dto.tprice}</strong> <br>
	</div>
	
</div>
<hr>
<div>
${dto.content} 
</div>
</body>
</html>