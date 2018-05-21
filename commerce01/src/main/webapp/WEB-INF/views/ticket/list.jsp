<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Ticket</title>
<%@ include file="../include/header.jsp" %>
<style type="text/css">
	#prev_btn {position:absolute;margin-top:60px;left:0}
	#next_btn {position:absolute;margin-top:60px;right:0}
	.btn {width:40px;height:100px;border:0;display:none;}
	 
	#slider {position:relative;margin:0 auto;padding:0;list-style:none;width:180px;height:180px;overflow-x:hidden}
	#slider li {display:none;position:absolute;left:0;top:0}
	#slider img {width:180px;height:160px} 
	
	#contents {width:750px}
	#contents li {display:inline-block; width:180px; height:180px}
	#contents div {display:inline;}
	
	#sortBtnDiv {margin:38px}
	#sortBtnDiv	button{width:220px;}
	
</style>

<script>
	/* $("#sort1_btn").click(function() {
		console.log("sort1");
		sort(1);
	}
	$("#sort2_btn").click(function() {
		console.log("sort2");
		sort(2);
	}
	$("#sort3_btn").click(function() {
		console.log("sort3");
		sort(3);
	} */
		// **원하는 정렬형태로 변경
	function sort(sortOption){
	    location.href="${path}/ticket/list.do?sortOption="+sortOption;
	}
	
	function pageChange(tno){
		console.log(" tno = " + tno);
		location.href="${path}/ticket/view.do?tno="+tno;
	}
</script>
</head>
<body>
<%@ include file="../include/menu.jsp" %>

<script>
$(function() {
    var time = 500;
    var idx = idx2 = 0;
    var slide_width = $("#slider").width();
    var slide_count = $("#slider li").length;
    $("#slider li:first").css("display", "block");
    if(slide_count > 1)
        $(".btn").css("display", "inline");
 
    $("#prev_btn").click(function() {
        if(slide_count > 1) {
            idx2 = (idx - 1) % slide_count;
            if(idx2 < 0)
                idx2 = slide_count - 1;
            $("#slider li:hidden").css("left", "-"+slide_width+"px");
            $("#slider li:eq("+idx+")").animate({ left: "+="+slide_width+"px" }, time, function() {
                $(this).css("display", "none").css("left", "-"+slide_width+"px");
            });
            $("#slider li:eq("+idx2+")").css("display", "block").animate({ left: "+="+slide_width+"px" }, time);
            idx = idx2;
        }
    });
 	
    var next = function() {
        if(slide_count > 1) {
            idx2 = (idx + 1) % slide_count;
            $("#slider li:hidden").css("left", slide_width+"px");
            $("#slider li:eq("+idx+")").animate({ left: "-="+slide_width+"px" }, time, function() {
                $(this).css("display", "none").css("left", slide_width+"px");
            });
            $("#slider li:eq("+idx2+")").css("display", "block").animate({ left: "-="+slide_width+"px" }, time);
            idx = idx2;
        }
    };
    
    $("#next_btn").click(next);
    
    setInterval(next, 3000);
    
}); 
</script>

<div id="wrapper">
<section class="wrapper style1 fullscreen">
	
	<div>
		<button type="button" id="prev_btn" >◀이전</button>
		<button type="button" id="next_btn" >다음▶</button>
		<ul id="slider">
		    <c:forEach var="row" items="${map.list}">
			<li><img src="<%=request.getContextPath()%>/images/${row.tno}.png" onclick="pageChange('${row.tno}')"></li>
			</c:forEach>
		</ul>
	</div>
	<div id="sortBtnDiv">
		<button id="sort1_btn" class="button" onclick="sort(1)">인기순</button>
		<button id="sort2_btn" onclick="sort(2)">최신순</button>
		<button id="sort3_btn" onclick="sort(3)">가격순</button>
	</div>
	
	
	<ul id="contents">
	<c:forEach var="row" items="${map.list}">
			<li onclick="pageChange('${row.tno}')" ><img src="<%=request.getContextPath()%>/images/${row.tno}.png" />
			<%-- <a href="${path}/ticket/view.do?tno=${row.tno}"> --%> ${row.title} <!-- </a> --> <br> 
				<div style="font-size:15px"><fmt:formatDate pattern = "yyyy-MM-dd" value = "${row.sdate}" /> ~ <fmt:formatDate pattern = "yyyy-MM-dd" value = "${row.edate}" /></div>
			</li>
	</c:forEach>
	</ul>

</section>
</div>
</body>
</html>