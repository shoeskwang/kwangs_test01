<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Join</title>
<%@ include file="../include/header.jsp" %>
<style type="text/css">
	label { font-size: 0.8em!important;}
</style>
<script>
    $(document).ready(function(){
    	var idCheckState = false;
    	$("#btnIdCheck").click(function(){
    		var id = $("#id").val();
    		
    		 $.ajax({
                 url : "${path}/member/idCheck.do?id="+id,
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
            
            var id = $("#id").val();
            var pw = $("#pw").val();
            var pwCheck = $("#pwCheck").val();
            var name = $("#name").val();
            var phone = $("#phone").val();
            var email = $("#email").val();
            if(id == ""){
                alert("아이디를 입력하세요");
                document.form1.id.focus();
                return;
            }
            if(pw == ""){
                alert("비밀번호를 입력하세요");
                document.form1.pw.focus();
                return;
            }
            if(pwCheck == ""){
                alert("비밀번호 확인을 입력하세요");
                document.form1.pwCheck.focus();
                return;
            }
            if(name == ""){
                alert("이름을 입력하세요");
                document.form1.name.focus();
                return;
            }
            if(phone == ""){
                alert("이메일을 입력하세요");
                document.form1.phone.focus();
                return;
            }
            if(email == ""){
                alert("이메일을 입력하세요");
                document.form1.email.focus();
                return;
            }
            
            if(pw != pwCheck){
            	alert("비밀번호와 비밀번호 확인이 다릅니다.");
                document.form1.pw.focus();
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
<div id="wrapper" style="margin-left:20px">
<section class="wrapper style1 fullscreen">
	<h2>회원가입</h2>
	<br/>
	<form name="form1" method="post" action="${path}/member/insert.do">
	<div style="width:650px;">
	
	    <div class="row uniform">
				<div class="2u 12u$(small)">
					<label>아이디</label>
				</div>
				<div class="4u 12u$(small)">
					<input type="text" name="id" id="id" size="50" placeholder="아이디를 입력해주세요">
				</div>
				<div class="4u 12u$(small)">
					<button type="button" id="btnIdCheck">중복체크</button>
				</div>
		</div>
		
		<div class="row uniform">
				<div class="2u 12u$(small)">
					<label>비밀번호</label>
				</div>
				<div class="6u 12u$(xsmall)">
					<input name="pw" id="pw" size="50" type="password" placeholder="비밀번호를 입력해주세요">
				</div>
		</div>
		<div class="row uniform">
				<div class="2u 12u$(small)">
					<label>비밀번호 확인</label>
				</div>
				<div class="6u 12u$(xsmall)">
					<input name="pwCheck" id="pwCheck" size="50" type="password" placeholder="비밀번호를 한번 더 입력해주세요">
				</div>
		</div>
		<div class="row uniform">
				<div class="2u 12u$(small)">
					<label>이름</label>
				</div>
				<div class="6u 12u$(xsmall)">
					<input type="text" name="name" id="name" size="50" placeholder="이름을 입력해주세요">
				</div>
		</div>
		<div class="row uniform">
				<div class="2u 12u$(small)">
					<label>이메일</label>
				</div>
				<div class="6u 12u$(xsmall)">
					<input type="text" name="email" id="email" size="50" placeholder="이메일을 입력해주세요">
				</div>
		</div>
		<div class="row uniform">
				<div class="2u 12u$(small)">
					<label>전화번호</label>
				</div>
				<div class="6u 12u$(xsmall)">
					<input type="text" name="phone" id="phone" size="50" maxLength="11" placeholder="전화번호를 입력해주세요">
				</div>
		</div>
	</div>	
	    
	    <hr>
	    
	    <div style="width:650px; margin-left:120px">
	        <button type="button" id="btnJoin">확인</button>
	        <button type="reset">취소</button>
	    </div>
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
