<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- jstl 코어 태그 -->
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">
<title>코스 리스트</title>
<%@ include file="../include/header.jsp" %>

<style type="text/css">
	td { text-align:center}
    ul.measure-control { position:absolute;z-index:100;top:15px;right:120px;margin:0;padding:0; }
    #wrapper { margin-left:20px}
</style>
</head>
<body>
<script>
function list(page){
    location.href="${path}/course/list.do?curPage="+page;
}
</script>
<%@ include file="../include/menu.jsp" %>
<div id="wrapper" style="margin-left:20px">
	<div class="row">
		<div class="8u 12u(mobile)">
			<section>
				<header>
					<h2>Myway 추천경로</h2>
				</header>
				<ul class="dates">
					<c:forEach var="row" items="${map.list}">
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
						<p>${Math.round((row.distance/100))/10} km  /  ${row.writer}  /  <fmt:formatDate value="${row.regdate}" pattern="yyyy-MM-dd HH:mm"/>  /  ${row.viewcnt}</p>
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
		<div class="3u 12u(mobile)" style="background-color:#f0f5f5;">
			<h2>오늘의 날씨</h2>
			${forecastMap.DATE.substring(0,4)} 년 ${forecastMap.DATE.substring(4,6)} 월 ${forecastMap.DATE.substring(6,8)} 일 <br/>
			<br/>
			<c:choose>
				<c:when test="${forecastMap.PTY == 0}">
					<c:choose>
						<c:when test="${forecastMap.SKY == 1}">
							<img src="<%=request.getContextPath()%>/images/sun.svg" height="30" width="30" />
						</c:when>
						<c:when test="${forecastMap.SKY == 2}">
							<img src="<%=request.getContextPath()%>/images/cloud.svg" height="30" width="30" />
						</c:when>
						<c:when test="${forecastMap.SKY == 3 || forecastMap.SKY == 4}">
							<img src="<%=request.getContextPath()%>/images/clouds.svg" height="50" width="50" />
						</c:when>
						<c:otherwise>
						</c:otherwise>
				    </c:choose>
				</c:when>
				<c:when test="${forecastMap.PTY == 1}">
					<c:choose>
						<c:when test="${forecastMap.SKY == 1}">
							<img src="<%=request.getContextPath()%>/images/rain.svg" height="30" width="30" />
						</c:when>
						<c:when test="${forecastMap.SKY == 2}">
								<img src="<%=request.getContextPath()%>/images/cloud-rain.svg" height="30" width="30" />
						</c:when>
						<c:when test="${forecastMap.SKY == 3 || forecastMap.SKY == 4}">
								<img src="<%=request.getContextPath()%>/images/cloud-rain.svg" height="30" width="30" />
						</c:when>
					</c:choose>
					강수량 : ${forecastMap.RN1} mm<br/>
					<%-- 낙뢰 : ${forecastMap.LGT} <br/> --%>
				</c:when>
				<c:when test="${forecastMap.PTY == 2}">
					<!-- 비/눈<br/> -->
					<img src="<%=request.getContextPath()%>/images/snow.svg" height="30" width="30" />
					강수량 : ${forecastMap.RN1} mm<br/>
					<%-- 낙뢰 : ${forecastMap.LGT} <br/> --%>
				</c:when>
				<c:when test="${forecastMap.PTY == 3}">
					<!-- 눈 -->
					<img src="<%=request.getContextPath()%>/images/snow.svg" height="30" width="30" />
					강수량 : ${forecastMap.RN1} mm<br/>
					<%-- 낙뢰 : ${forecastMap.LGT} <br/> --%>
				</c:when>
				<c:otherwise>
				</c:otherwise>
		    </c:choose>
			<br/>
			온도 : ${forecastMap.T1H} ℃<br/>
			미세먼지 농도: ${dustMap.CAISTEP.replaceAll("\"","")}<br/>
			(${dustMap.ALARM_CNDT.replaceAll("\"","")})
			
			<br/><br/>
			<c:if test="${forecastMap.PTY == 0}">
				<c:if test="${dustMap.CAISTEP.replaceAll('\"','').equals('보통') || dustMap.CAISTEP.replaceAll('\"','').equals('좋음')}">
					<span>라이딩하기 좋은 날씨입니다 :)</span>
				</c:if>
			</c:if>
		</div>
	</div>
</div>
<%@ include file="../include/footer.jsp" %>
<script>
$("#navUl li").removeClass("current");
$("#courseli").attr('class','current');
</script>
	<%-- 
	<table border="1" width="600px">
		    <tr>
		        <th>코스 번호</th>
		        <th>코스명</th>
		        <th>코스거리</th>
		        <th>작성자</th>
		        <th>작성일</th>
		        <th>조회수</th>
		    </tr>
		    <c:forEach var="row" items="${map.list}">
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
		        <td>${row.writer}</td>
		        <td>
		            <!-- 원하는 날짜형식으로 출력하기 위해 fmt태그 사용 -->
		            <fmt:formatDate value="${row.regdate}" pattern="yyyy-MM-dd HH:mm"/>
		        </td>
		        <td>${row.viewcnt}</td>
		    </tr>    
		    </c:forEach>
		     
		      <tr>
	            <td colspan="6">
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
	        
		    
	</table> --%>
</body>
</html>