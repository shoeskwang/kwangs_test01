<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Login</title>
<%@ include file="../include/header.jsp" %>
<style type="text/css">
    table {
	    width: 40% !important;
	    margin-left:30px;
	}
</style>

<script>
    $(document).ready(function(){
    	$("#btnJoin").click(function(){
    		location.href="${path}/member/join.do";
    	});
        $("#btnLogin").click(function(){
            // 태크.val() : 태그에 입력된 값
            // 태크.val("값") : 태그의 값을 변경 
            var id = $("#id").val();
            var pw = $("#pw").val();
            if(id == ""){
                alert("아이디를 입력하세요.");
                $("#id").focus(); // 입력포커스 이동
                return; // 함수 종료
            }
            if(pw == ""){
                alert("아이디를 입력하세요.");
                $("#pw").focus();
                return;
            }
            // 폼 내부의 데이터를 전송할 주소
            document.form1.action="${path}/member/loginCheck.do"
            // 제출
            document.form1.submit();
        });
    });
</script>
</head>
<body>
<%@ include file="../include/menu.jsp" %>
<div id="wrapper">
<section class="wrapper style1 fullscreen">
	<header>
		<h2 style="margin-left:30px">Login</h2>
	</header>
	    <form name="form1" method="post">
	        <table border="1">
	            <tr>
	                <td>아이디</td>
	                <td><input type="text" name="id" id="id"></td>
	            </tr>
	            <tr>
	                <td>비밀번호</td>
	                <td><input type="password" name="pw" id="pw"></td>
	            </tr>
	            <tr style="margin-top:10px">
	                <td colspan="2" align="center">
	                    <button type="button" id="btnLogin">로그인</button>
	                    <button type="button" id="btnJoin">회원가입</button>
	                <c:if test="${msg == 'failure'}">
	                    <div style="color: red">
	                        아이디 또는 비밀번호가 일치하지 않습니다.
	                    </div>
	                </c:if>
	                <c:if test="${msg == 'logout'}">
	                    <div style="color: red">
	                        로그아웃되었습니다.
	                    </div>
	                </c:if>
	                </td>
	            </tr>
	        </table>
	    </form>
</section>
</div>
<%@ include file="../include/footer.jsp" %>
<script>
$("#navUl li").removeClass("current");
$("#loginli").attr('class','current');
</script>
</body>
</html>
