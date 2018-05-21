<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- jstl 코어 태그 -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<style type="text/css">
	#sidebar ul li {display:inline-block;}
	#sidebar nav {text-align: center; }
</style>

<!-- context 경로 -->
<c:set var="path" value="${pageContext.request.contextPath}"/>
<section id="sidebar" class="">
<div id="header-wrapper">
	<div id="header">
		<h1><a href="${path}/main/index.do">Myway</a></h1>
		<nav id="nav">
			<ul id="navUl">
				<li  style="white-space: nowrap;" id="homeli">
					<a href="${path}/main/index.do" >홈</a>
				</li>
				<li style="white-space: nowrap;" id="courseli">
					<a href="${path}/course/list.do" >추천경로</a>
				</li>
				<!-- 미로그인 시 경로등록 전에 로그인 화면으로 유도 -->
				<c:choose>
    				<c:when test="${sessionScope.userId == null}">
						<li>
							<a href="${path}/member/login.do" class="scrolly active">경로등록</a>
						</li>
					</c:when>
    				<c:otherwise>
						<li id="registli">
						<a href="${path}/course/write.do" class="scrolly active" >경로등록</a>
						</li>
					</c:otherwise>
				</c:choose>
				
				<li id="boardli">
					<a href="${path}/board/list.do" class="scrolly active">게시판</a>
				</li>
				
				
				<c:choose>
    				<c:when test="${sessionScope.userId == null}">
						<li id="loginli">
							<a href="${path}/member/login.do" class="scrolly active">로그인</a>
						</li>
					</c:when>
    				<c:otherwise>
    					<li id="mypageli">
						<a href="${path}/member/mypage.do" class="scrolly active">마이페이지</a>
						</li>
						<li>
							<span style="text-decoration:underline">${sessionScope.userName} </span> 님이 로그인중입니다. 
        					
						</li>
						<li>
						<a href="${path}/member/logout.do" class="scrolly active">로그아웃</a>
						</li>
					</c:otherwise>
				</c:choose>
				
			</ul>
		</nav>
	</div>
</div>
</section>

