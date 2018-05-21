<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Ticket Event</title>
<%@ include file="../include/header.jsp" %>
<script>
	 // **원하는 페이지로 이동시 검색조건, 키워드 값을 유지하기 위해 
    function list(page){
        location.href="${path}/course/list.do?curPage="+gpage;
    }

</script>
</head>
<body>
<%@ include file="../include/menu.jsp" %>
<div id="wrapper">
<section class="wrapper style1 fullscreen">
<div style="margin-left:20px">
	<header>
		<h2>내가 등록한 코스 목록</h2>
	</header>
	
	<ul class="dates">
		<c:forEach var="row" items="${map.glist}">
			<li>
			<span class="date">way<strong>${row.gno}</strong></span>
			<h2>
				<a href="${path}/course/view.do?gno=${row.gno}">${row.title}</a>
	        	<!-- ** 댓글이 있으면 게시글 이름 옆에 출력하기 -->
                <c:if test="${row.recnt > 0}">
	                <span style="color: red;">(${row.recnt})
	                </span>
                </c:if> 
               </h2>
			<p>${Math.round((row.distance/100))/10} km  / <fmt:formatDate value="${row.regdate}" pattern="yyyy-MM-dd HH:mm"/>  /  ${row.viewcnt}</p>
		</li>
		</c:forEach>
	</ul>
	<%-- <table border="1" width="600px">
		    <tr>
		        <th>코스 번호</th>
		        <th>코스명</th>
		        <th>코스거리</th>
		        <th>작성일</th>
		        <th>조회수</th>
		    </tr>
		    <c:forEach var="row" items="${map.glist}">
		    <tr>
		        <td>${row.gno}</td>
		        <td>
		        	<a href="${path}/course/view.do?gno=${row.gno}">${row.title}</a>
		        	<!-- ** 댓글이 있으면 게시글 이름 옆에 출력하기 -->
	                <c:if test="${row.recnt > 0}">
	                <span style="color: red;">(${row.recnt})
	                </span>
	                </c:if> 
		        </td>
		        <td>${Math.round((row.distance/100))/10} km</td>
		        <td>
		            <!-- 원하는 날짜형식으로 출력하기 위해 fmt태그 사용 -->
		            <fmt:formatDate value="${row.regdate}" pattern="yyyy-MM-dd HH:mm"/>
		        </td>
		        <td>${row.viewcnt}</td>
		    </tr>    
		    </c:forEach>
		    
	</table> --%>
	<hr/>
	<header>
		<h2>내가 등록한 게시글 목록</h2>
	</header>
	<ul class="dates">
		<c:forEach var="row" items="${map.blist}">
			<li>
			<span class="date">no<strong>${row.bno}</strong></span>
			<h2>
				<a href="${path}/board/view.do?bno=${row.bno}&curPage=${map.boardPager.curPage}&searchOption=${map.searchOption}&keyword=${map.keyword}">${row.title}</a>
	        	<!-- ** 댓글이 있으면 게시글 이름 옆에 출력하기 -->
                <c:if test="${row.recnt > 0}">
	                <span style="color: red;">(${row.recnt})
	                </span>
                </c:if> 
               </h2>
			<p> <fmt:formatDate value="${row.regdate}" pattern="yyyy-MM-dd HH:mm"/>  /  ${row.viewcnt}</p>
		</li>
		</c:forEach>
	</ul>
		<%-- <table border="1" width="600px">
		    <tr>
		        <th>번호</th>
		        <th>제목</th>
		        <th>작성일</th>
		        <th>조회수</th>
		    </tr>
		    <c:forEach var="row" items="${map.blist}">
		    <tr>
		        <td>${row.bno}</td>
		        <td>
		        	<a href="${path}/board/view.do?bno=${row.bno}">${row.title}</a>
		        	<!-- ** 댓글이 있으면 게시글 이름 옆에 출력하기 -->
	                <c:if test="${row.recnt > 0}">
	                <span style="color: red;">(${row.recnt})
	                </span>
	                </c:if>
		        </td>
		        <td>
		            <!-- 원하는 날짜형식으로 출력하기 위해 fmt태그 사용 -->
		            <fmt:formatDate value="${row.regdate}" pattern="yyyy-MM-dd HH:mm:ss"/>
		        </td>
		        <td>${row.viewcnt}</td>
		    </tr>    
		    </c:forEach>
		    
		</table> --%>
</div>
</section>
</div>
<%@ include file="../include/footer.jsp" %>
<script>
$("#navUl li").removeClass("current");
$("#mypageli").attr('class','current');
</script>
</body>
</html>
