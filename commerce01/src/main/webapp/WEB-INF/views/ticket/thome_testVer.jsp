<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Home</title>
<%@ include file="../include/header.jsp" %>
<style type="text/css">
	#prev_btn {position:absolute;top:10;left:0}
	#next_btn {position:absolute;top:10;right:0}
	.btn {width:2em;height:280px;border:0;background:#f5f6fa;display:none;}
	 
	#slider {position:relative;margin:0 auto;padding:0;list-style:none;width:280px;height:280px;overflow-x:hidden}
	#slider li {display:none;position:absolute;left:0;top:0}
	#slider img {width:280px;height:280px} 
	
	#contents {width:1200px}
	#contents li {display:inline-block; width:280px; height:280px}
	#contents div {display:inline;}
	
	#sortBtnDiv {margin:38px}
	#sortBtnDiv	button{width:350px;}
	
</style>

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
</head>
<body>
<%@ include file="../include/menu.jsp" %>


<h2>Home</h2>
<div>
	<button type="button" id="prev_btn" class="btn">이전</button>
	<button type="button" id="next_btn" class="btn">다음</button>
	<ul id="slider">
	    <li><img src="<%=request.getContextPath()%>/images/purple.png" /></li>
	    <li><img src="${pageContext.request.contextPath}/images/blue.png"></li>
	    <li><img src="<c:url value='/images/black.png'/>"/></li>
	</ul>
</div>
<div id="sortBtnDiv">
	<button>인기순</button>
	<button>최신순</button>
	<button>가격순</button>
</div>

<ul id="contents">
		<li><img src="<%=request.getContextPath()%>/images/purple.png" />purple</li>
	    <li><img src="${pageContext.request.contextPath}/images/blue.png">blue</li>
	    <li><img src="<c:url value='/images/black.png'/>"/>black</li>
	    <li><img src="<c:url value='/images/yellow.png'/>"/>yellow</li>
	    <li><img src="<c:url value='/images/yellow.png'/>"/>yellow</li>
	    <li><img src="<%=request.getContextPath()%>/images/purple.png" />purple</li>
	    <li><img src="${pageContext.request.contextPath}/images/blue.png">blue</li>
	    <li><img src="<c:url value='/images/black.png'/>"/>black</li>
</ul>

</body>
</html>