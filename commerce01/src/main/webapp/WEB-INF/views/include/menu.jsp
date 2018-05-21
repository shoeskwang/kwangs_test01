<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- jstl 코어 태그 -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- context 경로 -->
<c:set var="path" value="${pageContext.request.contextPath}"/>
<section id="sidebar" class="wapper style1">
	<div class="inner">
		<nav>
			<ul>
				<li>
					<a href="${path}/ticket/list.do" class="scrolly active">홈</a>
				</li>
				<li>
					<a href="${path}/ticket/theme.do" class="scrolly active">테마</a>
				</li>
				<li>
					<a href="${path}/board/list.do" class="scrolly active">이벤트</a>
				</li>
				
				<c:choose>
    				<c:when test="${sessionScope.userId == null}">
					<li>
						<a href="${path}/member/login.do" class="scrolly active">마이티켓</a>
					</li>
					</c:when>
					<c:otherwise>
					<li>
						<a href="${path}/cart/cartList.do" class="scrolly active">마이티켓</a>
					</li>
					</c:otherwise>
				</c:choose>
				
				<c:choose>
    				<c:when test="${sessionScope.userId == null}">
						<li>
							<a href="${path}/member/login.do" class="scrolly active">로그인</a>
						</li>
					</c:when>
    				<c:otherwise>
						<li>
							${sessionScope.userName}님이 로그인중입니다.
        					
						</li>
						<li>
						<a href="${path}/member/logout.do" class="scrolly active">로그아웃</a>
						</li>
					</c:otherwise>
				</c:choose>
				
				<c:if test="${sessionScope.userId == 'admin'}">
					<li>
						<a href="${path}/order/orderManagement.do" class="scrolly active">구매관리</a>
					</li>
				</c:if>
			</ul>
		</nav>
	</div>
</section>


<hr>
