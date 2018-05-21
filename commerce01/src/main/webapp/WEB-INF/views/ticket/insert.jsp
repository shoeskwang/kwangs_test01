<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>게시글 목록</title>
<%@ include file="../include/header.jsp" %>

<script>
    $(document).ready(function(){
        $("#btnSave").click(function(){
            //var title = document.form1.title.value; ==> name속성으로 처리할 경우
            //var content = document.form1.content.value;
            //var writer = document.form1.writer.value;
            var title = $("#title").val();
            var tno = $("#tno").val();
            var summary = $("#summary").val();
            var sdate = $("#sdate").val();
            /* var edate = $("#edate").val();
            var location = $("#location").val();
            var tclass = $("#tclass").val();
            var genre = $("#genre").val();
            var rtime = $("#state").val();
            var rdate = $("#rdate").val();
            var state = $("#state").val();
            var theme = $("#theme").val();
            var content = $("#content").val();
            var poster = $("#poster").val();*/
            var tcount = $("#tcount").val();
            var tprice = $("#tprice").val(); 
            
            //var writer = $("#writer").val();
            if(title == ""){
                alert("제목을 입력하세요");
                document.form1.title.focus();
                return;
            }
            if(tno == ""){
                alert("tno을 입력하세요");
                document.form1.tno.focus();
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
	<h2>상품추가</h2>
	<form name="form1" method="post" action="${path}/ticket/insertcont.do">
		<div>
			tno <input name="tno" id="tno" size="80">	
		</div>
		<div>
			title <input name="title" id="title" size="80">	
		</div>
		<div>
			summary <input name="summary" id="summary" size="80">	
		</div>
		 <div>
			sdate <input name="sdate" id="sdate">	
		</div>
		<!--<div>
			edate <input name="edate" id="edate" size="80">	
		</div>
		<div>
			location <input name="location" id="location" size="80">	
		</div>
		<div>
			tclass <input name="tclass" id="tclass" size="80">	
		</div>
		<div>
			genre <input name="genre" id="genre" size="80">	
		</div>
		<div>
			rtime <input name="rtime" id="rtime" size="80">	
		</div>
		<div>
			rdate <input name="rdate" id="rdate" size="80">	
		</div>
		<div>
			state <input name="state" id="state" size="80">	
		</div>
		<div>
			theme <input name="theme" id="theme" size="80">	
		</div>
		<div>
			content <input name="content" id="content" size="80">	
		</div>
		<div>
			poster <input name="poster" id="poster" size="80">	
		</div>-->
		<div>
			tcount <input name="tcount" id="tcount" size="80">	
		</div>
		<div>
			tprice <input name="tprice" id="tprice" size="80">	
		</div> 
		 <div style="width:650px; text-align: center;">
	        <button type="button" id="btnSave">확인</button>
	        <button type="reset">취소</button>
	    </div>
	</form>
	
	
	<!-- 
	tno <input name="tno" id="tno" size="80"><br>
		title <input name="title" id="title" size="80"> <br>
		summary <input name="summary" id="summary" size="80"><br>
		sdate  <input name="sdate" id="sdate" size="80"><br>
		edate  <input name="edate" id="edate" size="80"><br>
		location  <input name="location" id="location" size="80"><br>
		tclass  <input name="tclass" id="tclass" size="80"><br>
		genre  <input name="genre" id="genre" size="80"><br>
		rtime  <input name="rtime" id="rtime" size="80"><br>
		rdate  <input name="rdate" id="rdate" size="80"><br>
		state  <input name="state" id="state" size="80"><br>
		theme <input name="theme" id="theme" size="80"><br>
		content  <input name="content" id="content" size="80"><br>
		poster  <input name="poster" id="poster" size="80"><br>
		tcount  <input name="tcount" id="tcount" size="80"><br>
		tprice  <input name="tprice" id="tprice" size="80">
	
	 -->
</section>
</div>
</body>
</html>