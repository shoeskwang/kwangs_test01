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
	
	button{width:220px; /* border-color:#f7e6ff; */}
	#line1,#line2,#line3,#line4,#line5 {padding:10px}
</style>
<script>
$(document).ready(function(){
	var tno = "${map.tno}";
	var userId = "${map.userId}";
	var amount = "${map.amount}";
	var whatday = "${map.whatday}";
	var selectday = "${map.selectday}";
	var seat = "${seat}";
	
	console.log("tno = " + tno);
	console.log("userId = " + userId);
	console.log("amount = " + amount);
	console.log("whatday = " + whatday);
	console.log("selectday = " + selectday);
	
	var count=0;
	for(var i=0;i<seat.length;i++){
		if(seat.charAt(i)=='1'){
			count++;
		}
	}
	console.log("count = " + count);
	
	
	// checkbox 선택 개수 제한
	$("input[name=able]:checkbox").change(function(){
		var cnt =(amount*1);
		if(cnt == $("[name=able]:checkbox:checked").length){
			$("[name=able]:checkbox:not(:checked)").attr("disabled" ,"disabled");
		}else{
			$("input[name=able]:checkbox").removeAttr("disabled");
			//$("input[name=default]:checkbox").attr("disabled" ,"disabled");
		}
	});
	// checkbox 선택 확인
	$("#seatSelectBtn").bind("click",function(){
		var temp="";
		var cnt=(amount*1);
		if(cnt == $("[name=able]:checkbox:checked").length){
			$("input[name=able]:checkbox:checked").each(function(index){
				temp = temp+","+$(this).val();
			});
			temp = temp.substring(1);
			
			console.log("temp = " + temp);
			
			location.href="${path}/order/buyTicket.do?tno="+tno+"&userId="+userId+"&amount="+amount+"&temp="+temp+"&whatday="+whatday;
		}else{
			alert("구매한 좌석 수만큼 선택해주세요.")
		}
		
	})
});
</script>
</head>
<body>
<%@ include file="../include/menu.jsp" %>

<div id="wrapper">
<section class="wrapper style1 fullscreen">
	<div id="themeOption">
		<div id="textsection">
				<h2>좌석선택</h2>
				<hr>
				<div>
					<label><strong>공연명: ${map.title}</strong></label>
				</div>
				<div>
					<label><strong>예약자: ${map.userId}</strong></label>
				</div>
				<div>
					<label><strong>장수: ${map.amount}</strong></label>
				</div>
				<div>
					<label><strong>회차: ${map.whatday+1} </strong>( ${map.selectday} )</label>
				</div>
				예약가능: □ &nbsp; 예약불가: ■
		</div>
	</div>
	<hr>
	<div id="mainContents">
		<div>
			<label style="margin-left:320px"><strong>Stage</strong></label>
		</div>
		<hr>
		<div id="line1">
			A&nbsp;&nbsp;      
			<%
				String seat  = String.valueOf(request.getAttribute("seat"));
				
				for(int i=0;i<10;i++){
					if(seat.charAt(i)=='1'){// 예약된 좌석일 경우
			%>
			<input type="checkbox" id="seat<%= i%>" name="default" value="<%= i%>" checked disabled><label for=seat<%= i%>>■</label>
			<%
					}else{
			%>
			
			<input type="checkbox" id="seat<%= i%>" name="able" value=<%= i%>><label for=seat<%= i%>>□</label>
			<% 		}
				} %>
		</div>
		
		<div id="line2">
			B&nbsp;&nbsp;      
			<%
				for(int i=10;i<20;i++){
				if(seat.charAt(i)=='1'){// 예약된 좌석일 경우
			%>
			<input type="checkbox" id="seat<%= i%>" name="default" value="<%= i%>" checked disabled><label for=seat<%= i%>>■</label>
			<%
					}else{
			%>
			
			<input type="checkbox" id="seat<%= i%>" name="able" value=<%= i%>><label for=seat<%= i%>>□</label>
			<% 		}
				} %>
		</div>
		
		<div id="line3">
			C&nbsp;&nbsp;      
			<%
				for(int i=20;i<30;i++){
				if(seat.charAt(i)=='1'){// 예약된 좌석일 경우
			%>
			<input type="checkbox" id="seat<%= i%>" name="default" value="<%= i%>" checked disabled><label for=seat<%= i%>>■</label>
			<%
					}else{
			%>
			
			<input type="checkbox" id="seat<%= i%>" name="able" value=<%= i%>><label for=seat<%= i%>>□</label>
			<% 		}
				} %>
		</div>
		
		<div id="line4">
			D&nbsp;&nbsp;      
			<%
				for(int i=30;i<40;i++){
				if(seat.charAt(i)=='1'){// 예약된 좌석일 경우
			%>
			<input type="checkbox" id="seat<%= i%>" name="default" value="<%= i%>" checked disabled><label for=seat<%= i%>>■</label>
			<%
					}else{
			%>
			
			<input type="checkbox" id="seat<%= i%>" name="able" value=<%= i%>><label for=seat<%= i%>>□</label>
			<% 		}
				} %>
		</div>
		
		<div id="line5">
			E&nbsp;&nbsp;      
			<%
				for(int i=40;i<50;i++){
				if(seat.charAt(i)=='1'){// 예약된 좌석일 경우
			%>
			<input type="checkbox" id="seat<%= i%>" name="default" value="<%= i%>" checked disabled><label for=seat<%= i%>>■</label>
			<%
					}else{
			%>
			
			<input type="checkbox" id="seat<%= i%>" name="able" value=<%= i%>><label for=seat<%= i%>>□</label>
			<% 		}
				} %>
		</div>
		<hr>
		<div>
			<button id="seatSelectBtn">선택완료</button>
		</div>
	</div>
</section>
</div>
</body>
</html>