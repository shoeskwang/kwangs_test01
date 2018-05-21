<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Ticket View</title>
<%@ include file="../include/header.jsp" %>
<link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
<script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
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
	var sDate = "<fmt:formatDate pattern = "yyyy-MM-dd" value = "${dto.sdate}" />";
	var eDate =  "<fmt:formatDate pattern = "yyyy-MM-dd" value = "${dto.edate}" />";
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
    
    $("#selectBtn").bind("click",function(){
    	
    	var selectday = document.getElementById("datepicker").value;
    	
    	if(selectday == "" || selectday == NaN || selectday == null){
    		alert("날짜를 선택하세요");
    		return;
    	}
    	var tno = "${dto.tno}";
    	var title="${dto.title}";
    	var userId = "${sessionScope.userId}";
    	var amount = document.getElementById("amount").selectedIndex+1;
    	var sdate ="${map.convertSdate}";
    	var date1 = new Date(selectday);
    	var date2 = new Date(sdate);
    	var day = 24*60*60*1000;
    	var whatday = (date1-date2)/day;
    
    	console.log("  tno = " + tno);
    	console.log("  userId = " + userId);
    	console.log("  amount = " + amount);
    	console.log("  sdate = " + sdate);
    	console.log("  selectday = " + selectday);
    	console.log("  day = " + (date1-date2)/day);
    	
    	//location.href="${path}/order/buyTicket.do?tno="+tno+"&userId="+userId+"&amount="+amount;
    	location.href="${path}/ticket/seats.do?tno="+tno+"&title="+title+"&userId="+userId+"&amount="+amount+"&whatday="+whatday+"&selectday="+selectday;
    });
    
    $(function() {
	    $( "#datepicker" ).datepicker({
	    	dateFormat: "yy-mm-dd",
	    	minDate: new Date(sDate.split("-")[0], sDate.split("-")[1] - 1, sDate.split("-")[2]),
	    	maxDate: new Date(eDate.split("-")[0], eDate.split("-")[1] - 1, eDate.split("-")[2])
	    	});
	 });
    
	$("#testBtn").bind("click",function(){
    	
    	var test = document.getElementById("datepicker").value;
    	console.log("test = " + test)
	});
    
});
</script>
</head>
<body>
<%@ include file="../include/menu.jsp" %>

<div id="wrapper">
<section class="wrapper style1 fullscreen">
	<div id="mainContents">
		<div id="summary">
			<div id="imgsection">
				<img src="<%=request.getContextPath()%>/images/${dto.poster}.png" />
			</div>
			<div id="textsection">
				<div>
					<label><strong>${dto.title}</strong></label>
				</div>
				<div>
					<label><strong>${dto.summary}</strong></label>
				</div>
				<c:if test="${sessionScope.userId != null}">
					<button id="cartAddBtn">찜</button>
				</c:if>
							
			</div>
			
		</div>
			<c:if test="${sessionScope.userId != null}">
				<div class="row uniform" style="width:600px;">
					<div class="4u 12u$(small)">
						<label>장수 선택</label>
					</div>
	   				<div class="4u 12u$(small)">
		   				<select name="amount" id="amount">
			                <c:forEach begin="1" end="10" var="i">
			                    <option value="${i}">${i}</option>
			                </c:forEach>
			            </select>
	   				</div>
	   				<!-- <div class="4u 12u$(small)">
		   				<button id="buyBtn">구매하기</button>
	   				</div> -->
	   				<div class="4u 12u$(small)">
		   				<button id="selectBtn">좌석선택</button>
	   				</div>
	   			</div>
	   			<div class="row uniform" style="width:600px;">
					<div class="4u 12u$(small)">
						<label>날짜 선택</label>
					</div>
	   				<div class="4u 12u$(small)">
		   				<input type="text" id="datepicker">
	   				</div>
	   				<div class="4u 12u$(small)">
	   				</div>
	   			</div>
	   			
				
			</c:if>
		
		<div id="detail">
			<div class="row uniform">
				<div class="4u 12u$(small)">
					<label>공연기간</label>
				</div>
				<div class="6u 12u$(xsmall)">
					<strong><fmt:formatDate pattern = "yyyy-MM-dd" value = "${dto.sdate}" /> - <fmt:formatDate pattern = "yyyy-MM-dd" value = "${dto.edate}" /> </strong>
				</div>
			</div>
			<div class="row uniform">
				<div class="4u 12u$(small)">
					<label>관람시간</label>
				</div>
				<div class="6u 12u$(xsmall)">
					<strong>${dto.rtime}</strong>  분
				</div>
			</div>
			<div class="row uniform">
				<div class="4u 12u$(small)">
					<label>관람등급</label>
				</div>
				<div class="6u 12u$(xsmall)">
					<strong>
					<c:if test="${dto.tclass == 1}">
						전체 관락가
					</c:if>
					<c:if test="${dto.tclass == 2}">
						12세 관락가
					</c:if>
					<c:if test="${dto.tclass == 3}">
						15세 관락가
					</c:if>
					<c:if test="${dto.tclass == 4}">
						19세 관락가
					</c:if>
					<%-- ${dto.tclass} --%>
					 </strong>
				</div>
			</div>
			<div class="row uniform">
				<div class="4u 12u$(small)">
					<label>장르</label>
				</div>
				<div class="6u 12u$(xsmall)">
					<strong> 
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
					</strong>
				</div>
			</div>
			<div class="row uniform">
				<div class="4u 12u$(small)">
					<label>판매상태</label>
				</div>
				<div class="6u 12u$(xsmall)">
					<strong>
					<c:if test="${dto.state == 1}">
						판매중
					</c:if>
					<c:if test="${dto.state == 2}">
						판매예정
					</c:if>
					 <%-- ${dto.state} --%>
					 </strong>
				</div>
			</div>
			<div class="row uniform">
				<div class="4u 12u$(small)">
					<label>인기도</label>
				</div>
				<div class="6u 12u$(xsmall)">
					<strong> ${dto.tcount}</strong>
				</div>
			</div>
			<div class="row uniform">
				<div class="4u 12u$(small)">
					<label>관람가격</label>
				</div>
				<div class="6u 12u$(xsmall)">
					<strong> ${dto.tprice}</strong>
				</div>
			</div>
		</div>
		
	</div>
	<hr>
	<div>
	<label>${dto.content}</label>
	</div>
</section>

	<!-- <button id="testBtn">Test</button> -->
</div>
</body>
</html>