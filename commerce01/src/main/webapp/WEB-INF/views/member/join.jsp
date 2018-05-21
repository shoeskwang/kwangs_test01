<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Join</title>
<%@ include file="../include/header.jsp" %>
<script>
    $(document).ready(function(){
    	var idCheckState = false;
    	$("#btnIdCheck").click(function(){
    		var userId = $("#userId").val();
    		
    		 $.ajax({
                 url : "${path}/member/idCheck.do?userId="+userId,
                 type: "get",
                 data : null,
                 success : function(responseData){
                	 console.log("responseData = " +responseData);
                	 var data = JSON.parse(responseData);
                	 console.log("data.result = " +data.result);
                	 
                	 if(data.result == "0"){
                		 idCheckState=true;
                		 alert("사용가능한 아이디입니다.");
                	 }else{
                		 idCheckState=false;
                		 alert("사용할수 없는 아이디입니다.");
                	 }
                 }
            	});
    	});
    	
        $("#btnJoin").click(function(){
            //var title = document.form1.title.value; ==> name속성으로 처리할 경우
            //var content = document.form1.content.value;
            //var writer = document.form1.writer.value;
            if(idCheckState==false){
            	alert("아이디 중복체크를 먼저 해주세요.")
            	return;
            }
            
            var userId = $("#userId").val();
            var userPw = $("#userPw").val();
            var userPwCheck = $("#userPwCheck").val();
            var userName = $("#userName").val();
            var userEmail = $("#userEmail").val();
            if(userId == ""){
                alert("아이디를 입력하세요");
                document.form1.userId.focus();
                return;
            }
            if(userPw == ""){
                alert("비밀번호를 입력하세요");
                document.form1.userPw.focus();
                return;
            }
            if(userPwCheck == ""){
                alert("비밀번호 확인을 입력하세요");
                document.form1.userPwCheck.focus();
                return;
            }
            if(userName == ""){
                alert("이름을 입력하세요");
                document.form1.userName.focus();
                return;
            }
            if(userEmail == ""){
                alert("이메일을 입력하세요");
                document.form1.userEmail.focus();
                return;
            }
            
            if(userPw != userPwCheck){
            	alert("비밀번호와 비밀번호 확인이 다릅니다.");
                document.form1.userPw.focus();
                return;
            }
            /* 
            if(writer == ""){
                alert("이름을 입력하세요");
                document.form1.writer.focus();
                return;
            } 
            */
            // 폼에 입력한 데이터를 서버로 전송
            document.form1.submit();
        });
    });
</script>
</head>
<body>
<%@ include file="../include/menu.jsp" %>
<div id="wrapper">
<section class="wrapper style1 fullscreen">
	<h2>회원가입</h2>
	<form name="form1" method="post" action="${path}/member/insert.do">
	<div style="width:650px;">
	
	    <div class="row uniform">
				<div class="4u 12u$(small)">
					<label>아이디</label>
				</div>
				<div class="4u 12u$(small)">
					<input type="text" name="userId" id="userId" size="50" placeholder="아이디를 입력해주세요">
				</div>
				<div class="4u 12u$(small)">
					<button type="button" id="btnIdCheck">중복체크</button>
				</div>
		</div>
		
		<div class="row uniform">
				<div class="4u 12u$(small)">
					<label>비밀번호</label>
				</div>
				<div class="6u 12u$(xsmall)">
					<input name="userPw" id="userPw" size="50" type="password" placeholder="비밀번호를 입력해주세요">
				</div>
		</div>
		<div class="row uniform">
				<div class="4u 12u$(small)">
					<label>비밀번호 확인</label>
				</div>
				<div class="6u 12u$(xsmall)">
					<input name="userPwCheck" id="userPwCheck" size="50" type="password" placeholder="비밀번호를 한번 더 입력해주세요">
				</div>
		</div>
		<div class="row uniform">
				<div class="4u 12u$(small)">
					<label>이름</label>
				</div>
				<div class="6u 12u$(xsmall)">
					<input type="text" name="userName" id="userName" size="50" placeholder="이름을 입력해주세요">
				</div>
		</div>
		<div class="row uniform">
				<div class="4u 12u$(small)">
					<label>이메일</label>
				</div>
				<div class="6u 12u$(xsmall)">
					<input type="text" name="userEmail" id="userEmail" size="50" placeholder="이메일을 입력해주세요">
				</div>
		</div>
	</div>	
	    
	    <hr>
	    
	    <div style="width:650px; text-align: center;">
	        <button type="button" id="btnJoin">확인</button>
	        <button type="reset">취소</button>
	    </div>
	</form>
</section>
</div>
</body>
</html>
