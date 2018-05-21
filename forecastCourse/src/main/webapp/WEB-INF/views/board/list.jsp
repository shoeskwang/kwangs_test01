<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Ticket Event</title>
<%@ include file="../include/header.jsp" %>
<style type="text/css">
	td { text-align:center;
		 font-size: 1.5em;}
	.wrapper{ margin-left:20px}
</style>
<script>
    $(document).ready(function(){
        $("#btnWrite").click(function(){
            // 페이지 주소 변경(이동)
            location.href = "${path}/board/write.do";
        });
    });
    
	 // **원하는 페이지로 이동시 검색조건, 키워드 값을 유지하기 위해 
    function list(page){
        location.href="${path}/board/list.do?curPage="+page+"&searchOption-${map.searchOption}"+"&keyword=${map.keyword}";
    }

</script>
</head>
<body>
<%@ include file="../include/menu.jsp" %>
<div id="wrapper">
<section class="wrapper style1 fullscreen">

<div id="wrapper">
	<div class="row">
		<div class="8u 12u(mobile)">
			<section>
				<header>
					<h2>게시글 목록</h2>
					<br/>
					   <form name="form1" method="post" action="${path}/board/list.do">
					   <div class="row uniform">
					   	<div class="2u 12u$(small)">
					   		<select name="searchOption">
					          <!-- 검색조건을 검색처리후 결과화면에 보여주기위해  c:out 출력태그 사용, 삼항연산자 -->
					          <option value="all" <c:out value="${map.searchOption == 'all'?'selected':''}"/> >제목+내용+이름</option>
					          <option value="writer" <c:out value="${map.searchOption == 'writer'?'selected':''}"/> >이름</option>
					          <option value="content" <c:out value="${map.searchOption == 'content'?'selected':''}"/> >내용</option>
					          <option value="title" <c:out value="${map.searchOption == 'title'?'selected':''}"/> >제목</option>
					      	</select>
					   	</div>
					 	<div class="4u 12u$(small)">
					 		<input type="text" name="keyword" value="${map.keyword}">
					 	</div>
					      <div class="4u 12u$(small)">
					      	
					      	<input type="submit" value="조회">
					      	 <!-- 로그인 사용자만 글쓰기 버튼 활성화 -->
							  <c:if test="${sessionScope.userId != null}">
							      <button type="button" id="btnWrite">글쓰기</button>
							  </c:if>
					      </div>
					   </div>
					      
					     
					      
					     
					  </form>
					  <!-- 레코드의 갯수를 출력 -->
					  ${map.count}개의 게시물이 있습니다.
				</header>
				<ul class="dates">
					<c:forEach var="row" items="${map.list}">
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
						<p> ${row.writer}  /  <fmt:formatDate value="${row.regdate}" pattern="yyyy-MM-dd HH:mm"/>  /  ${row.viewcnt}</p>
					</li>
					</c:forEach>
				</ul>
				<div id="pager" style="text-align:center">
				
				<!-- **처음페이지로 이동 : 현재 페이지가 1보다 크면  [처음]하이퍼링크를 화면에 출력-->
	                <c:if test="${map.boardPager.curBlock > 1}">
	                    <a href="javascript:list('1')">[처음]</a>
	                </c:if>
	                
	                <!-- **이전페이지 블록으로 이동 : 현재 페이지 블럭이 1보다 크면 [이전]하이퍼링크를 화면에 출력 -->
	                <c:if test="${map.boardPager.curBlock > 1}">
	                    <a href="javascript:list('${map.boardPager.prevPage}')">[이전]</a>
	                </c:if>
	                
	                <!-- **하나의 블럭에서 반복문 수행 시작페이지부터 끝페이지까지 -->
	                <c:forEach var="num" begin="${map.boardPager.blockBegin}" end="${map.boardPager.blockEnd}">
	                    <!-- **현재페이지이면 하이퍼링크 제거 -->
	                    <c:choose>
	                        <c:when test="${num == map.boardPager.curPage}">
	                            <span style="color: red">${num}</span>&nbsp;
	                        </c:when>
	                        <c:otherwise>
	                            <a href="javascript:list('${num}')">${num}</a>&nbsp;
	                        </c:otherwise>
	                    </c:choose>
	                </c:forEach>
	                
	                <!-- **다음페이지 블록으로 이동 : 현재 페이지 블럭이 전체 페이지 블럭보다 작거나 같으면 [다음]하이퍼링크를 화면에 출력 -->
	                <c:if test="${map.boardPager.curBlock <= map.boardPager.totBlock}">
	                    <a href="javascript:list('${map.boardPager.nextPage}')">[다음]</a>
	                </c:if>
	                
	                <!-- **끝페이지로 이동 : 현재 페이지가 전체 페이지보다 작거나 같으면 [끝]하이퍼링크를 화면에 출력 -->
	                <c:if test="${map.boardPager.curPage <= map.boardPager.totPage}">
	                    <a href="javascript:list('${map.boardPager.totPage}')">[끝]</a>
	                </c:if>
				</div>
			</section>
		</div>
		<!-- <div class="4u 12u(mobile)">
			<section>
				<header>
					<h2>What's this all about?</h2>
				</header>
				<a href="#" class="image featured"><img src="images/pic10.jpg" alt=""></a>
				<p>
					This is <strong>Dopetrope</strong> a free, fully responsive HTML5 site template by
					<a href="http://twitter.com/ajlkn">AJ</a> for <a href="http://html5up.net/">HTML5 UP</a> It's released for free under
					the <a href="http://html5up.net/license/">Creative Commons Attribution</a> license so feel free to use it for any personal or commercial project – just don't forget to credit us!
				</p>
				<footer>
					<a href="#" class="button">Find out more</a>
				</footer>
			</section>
		</div> -->
	</div>
</div>
<div id="imgsection"  style="width:27%;height:500px; display:inline; position:fixed; top:300px; right:0px; z-index:999">
		<img src="<%=request.getContextPath()%>/images/biker.jpg" height="80%" width="80%" style="margin:10px;"/>
</div>
<%@ include file="../include/footer.jsp" %>
<script>
$("#navUl li").removeClass("current");
$("#boardli").attr('class','current');
</script>
<%--
 <div id="wrapper" class="wrapper">
	<h2>게시글 목록</h2>
	
	   <form name="form1" method="post" action="${path}/board/list.do">
	   <div class="row uniform">
	   	<div class="2u 12u$(small)">
	   		<select name="searchOption">
	          <!-- 검색조건을 검색처리후 결과화면에 보여주기위해  c:out 출력태그 사용, 삼항연산자 -->
	          <option value="all" <c:out value="${map.searchOption == 'all'?'selected':''}"/> >제목+내용+이름</option>
	          <option value="writer" <c:out value="${map.searchOption == 'writer'?'selected':''}"/> >이름</option>
	          <option value="content" <c:out value="${map.searchOption == 'content'?'selected':''}"/> >내용</option>
	          <option value="title" <c:out value="${map.searchOption == 'title'?'selected':''}"/> >제목</option>
	      	</select>
	   	</div>
	 	<div class="4u 12u$(small)">
	 		<input type="text" name="keyword" value="${map.keyword}">
	 	</div>
	      <div class="4u 12u$(small)">
	      	
	      	<input type="submit" value="조회">
	      	 <!-- 로그인 사용자만 글쓰기 버튼 활성화 -->
			  <c:if test="${sessionScope.userId != null}">
			      <button type="button" id="btnWrite">글쓰기</button>
			  </c:if>
	      </div>
	   </div>
	      
	     
	      
	     
	  </form>
	  <!-- 레코드의 갯수를 출력 -->
	  ${map.count}개의 게시물이 있습니다.
	
		<table border="1" width="600px">
		    <tr>
		        <th>번호</th>
		        <th>제목</th>
		        <th>이름</th>
		        <th>작성일</th>
		        <th>조회수</th>
		    </tr>
		    <c:forEach var="row" items="${map.list}">
		    <tr>
		        <td>${row.bno}</td>
		        <td>
		        	<a href="${path}/board/view.do?bno=${row.bno}&curPage=${map.boardPager.curPage}&searchOption=${map.searchOption}&keyword=${map.keyword}">${row.title}</a>
		        	<!-- ** 댓글이 있으면 게시글 이름 옆에 출력하기 -->
	                <c:if test="${row.recnt > 0}">
	                <span style="color: red;">(${row.recnt})
	                </span>
	                </c:if>
		        </td>
		        <td>${row.writer}</td>
		        <td>
		            <!-- 원하는 날짜형식으로 출력하기 위해 fmt태그 사용 -->
		            <fmt:formatDate value="${row.regdate}" pattern="yyyy-MM-dd HH:mm"/>
		        </td>
		        <td>${row.viewcnt}</td>
		    </tr>    
		    </c:forEach>
		    
		     <tr>
	            <td colspan="5">
	                <!-- **처음페이지로 이동 : 현재 페이지가 1보다 크면  [처음]하이퍼링크를 화면에 출력-->
	                <c:if test="${map.boardPager.curBlock > 1}">
	                    <a href="javascript:list('1')">[처음]</a>
	                </c:if>
	                
	                <!-- **이전페이지 블록으로 이동 : 현재 페이지 블럭이 1보다 크면 [이전]하이퍼링크를 화면에 출력 -->
	                <c:if test="${map.boardPager.curBlock > 1}">
	                    <a href="javascript:list('${map.boardPager.prevPage}')">[이전]</a>
	                </c:if>
	                
	                <!-- **하나의 블럭에서 반복문 수행 시작페이지부터 끝페이지까지 -->
	                <c:forEach var="num" begin="${map.boardPager.blockBegin}" end="${map.boardPager.blockEnd}">
	                    <!-- **현재페이지이면 하이퍼링크 제거 -->
	                    <c:choose>
	                        <c:when test="${num == map.boardPager.curPage}">
	                            <span style="color: red">${num}</span>&nbsp;
	                        </c:when>
	                        <c:otherwise>
	                            <a href="javascript:list('${num}')">${num}</a>&nbsp;
	                        </c:otherwise>
	                    </c:choose>
	                </c:forEach>
	                
	                <!-- **다음페이지 블록으로 이동 : 현재 페이지 블럭이 전체 페이지 블럭보다 작거나 같으면 [다음]하이퍼링크를 화면에 출력 -->
	                <c:if test="${map.boardPager.curBlock <= map.boardPager.totBlock}">
	                    <a href="javascript:list('${map.boardPager.nextPage}')">[다음]</a>
	                </c:if>
	                
	                <!-- **끝페이지로 이동 : 현재 페이지가 전체 페이지보다 작거나 같으면 [끝]하이퍼링크를 화면에 출력 -->
	                <c:if test="${map.boardPager.curPage <= map.boardPager.totPage}">
	                    <a href="javascript:list('${map.boardPager.totPage}')">[끝]</a>
	                </c:if>
	            </td>
	        </tr>
		    
		</table>
</div> --%>
</section>
</div>
</body>
</html>
