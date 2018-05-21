<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Ticket Event</title>
<%@ include file="../include/header.jsp" %>
<script>
//var replyCount = 0; // 댓글이 있는 게시글을 삭제할 수없도록 변수 사용 reply함수로는 board의 함수를 사용하기가 복잡해서 전체 변수 사용
    $(document).ready(function(){
    	var replyCount = Number("${count}");
    	
    	listReply("1"); // **댓글 목록 불러오기
        //listReply2(); // ** json 리턴방식
        
        // ** 댓글 쓰기 버튼 클릭 이벤트 (ajax로 처리)
        $("#btnReply").click(function(){
            var replytext=$("#replytext").val();
            var bno="${dto.bno}";

        	 // **비밀댓글 파라미터 추가
            var param="replytext="+replytext+"&bno="+bno;

            $.ajax({                
                type: "post",
                url: "${path}/boardreply/insert.do",
                data: param,
                contentType: 'application/x-www-form-urlencoded; charset=utf-8',
                success: function(data){
                	console.log(" /boardreply/insert.do success!!!" +data);
                    alert("댓글이 등록되었습니다.");
                    listReply("1");
                    $("#replytext").val('');
                    //location.reload();
                    //replyCount = replyCount+1;
                }
            });
        });

    	
    	// ** 목록 버튼 클릭 이벤트 : 버튼 클릭시 상세보기화면에 있던 페이지, 검색옵션, 키워드 값을 가지로 목록으로 이동
        $("#btnList").click(function(){
            location.href="${path}/board/list.do?curPage=${map.curPage}&searchOption=${map.searchOption}&keyword=${map.keyword}";
        });

    
        $("#btnDelete").click(function(){
        	console.log("boardreply count = " + replyCount);
        	if(replyCount>0){
        		alert("댓글이 있는 게시물은 삭제할 수 없습니다.");
        		return;
        	}
            if(confirm("삭제하시겠습니까?")){
                document.form1.action = "${path}/board/delete.do";
                document.form1.submit();
            }
        });
        
        $("#btnUpdete").click(function(){
            //var title = document.form1.title.value; ==> name속성으로 처리할 경우
            //var content = document.form1.content.value;
            //var writer = document.form1.writer.value;
            var title = $("#title").val();
            var content = $("#content").val();
            //var writer = $("#writer").val();
            if(title == ""){
                alert("제목을 입력하세요");
                document.form1.title.focus();
                return;
            }
            if(content == ""){
                alert("내용을 입력하세요");
                document.form1.content.focus();
                return;
            }
            /* if(writer == ""){
                alert("이름을 입력하세요");
                document.form1.writer.focus();
                return;
            } */
            document.form1.action="${path}/board/update.do"
            // 폼에 입력한 데이터를 서버로 전송
            document.form1.submit();
        });
    });
    
 // Controller방식
    // **댓글 목록1
    function listReply(num){
        $.ajax({
            type: "get",
            url: "${path}/boardreply/list.do?bno=${dto.bno}&curPage="+num,
            success: function(result){
            // responseText가 result에 저장됨.
            	console.log("result = " + result);
                $("#listReply").html(result);
            }
        });
    }
 
	function listReplyDelete(rno){
		if(confirm("댓글을 삭제하시겠습니까?")){		

     	 // **비밀댓글 파라미터 추가
         var param="rno="+rno;

         $.ajax({                
             type: "post",
             url: "${path}/boardreply/delete.do",
             data: param,
             contentType: 'application/x-www-form-urlencoded; charset=utf-8',
             success: function(data){
             	console.log(" /boardreply/delete.do success!!!" +data);
             	//replyCount = replyCount-1;
                 alert("댓글이 삭제되었습니다.");
                 listReply("1");
                 $("#replytext").val('');
                 //location.reload();
             }
         });
		}
	}
    /* 
    // RestController방식 (Json)
    // **댓글 목록2 (json)
    function listReply2(){
        $.ajax({
            type: "get",
            //contentType: "application/json", ==> 생략가능(RestController이기때문에 가능)
            url: "${path}/reply/listJson.do?bno=${dto.bno}",
            success: function(result){
                console.log(result);
                var output = "<table>";
                for(var i in result){
                    output += "<tr>";
                    output += "<td>"+result[i].userName;
                    output += "("+changeDate(result[i].regdate)+")<br>";
                    output += result[i].replytext+"</td>";
                    output += "<tr>";
                }
                output += "</table>";
                $("#listReply").html(output);
            }
        });
    }
    // **날짜 변환 함수 작성
    function changeDate(date){
        date = new Date(parseInt(date));
        year = date.getFullYear();
        month = date.getMonth();
        day = date.getDate();
        hour = date.getHours();
        minute = date.getMinutes();
        second = date.getSeconds();
        strDate = year+"-"+month+"-"+day+" "+hour+":"+minute+":"+second;
        return strDate;
    } 
    */

</script>
</head>
<body>
<%@ include file="../include/menu.jsp" %>
<div id="wrapper">
<section class="wrapper style1 fullscreen">
	<header>
		<h2 style="margin-left:20px">게시글 보기</h2>
	</header>
	<form name="form1" method="post" style="margin-left:20px">
		 <div>
		 <h3> 작성자 : ${dto.writer} </h3>
	    </div>
	    <div>        <!-- 원하는 날짜형식으로 출력하기 위해 fmt태그 사용 -->
	       	<h3>작성일자 : <fmt:formatDate value="${dto.regdate}" pattern="yyyy-MM-dd a HH:mm:ss"/></h3> 
	                <!-- 날짜 형식 => yyyy 4자리연도, MM 월, dd 일, a 오전/오후, HH 24시간제, hh 12시간제, mm 분, ss 초 -->
	    </div>
	    <div>
	       	<h3>조회수 : ${dto.viewcnt}</h3> 
	    </div>
	    <div>
	    <br/>
	    <div class="row uniform">
	    	<div class="6u 12u$(xsmall)">
	    	<h3>제목</h3> 
	    	<input type="text" name="title" id="title" size="80" value="${dto.title}" placeholder="제목을 입력해주세요">
	    	</div>
		</div>
	        
	    </div>
	    <div style="width:650px; ">
	        	<h3>내용</h3>
	        <textarea name="content" id="content" rows="4" cols="80" placeholder="내용을 입력해주세요">${dto.content}</textarea>
	    </div>
	   
	    <div style="width:650px; text-align: center;">
	        <!-- 게시물번호를 hidden으로 처리 -->
	        <input type="hidden" name="bno" value="${dto.bno}">
	        <!-- 본인이 쓴 게시물만 수정, 삭제가 가능하도록 처리 -->
		    <c:if test="${sessionScope.userId == dto.writer}">
		        <button type="button" id="btnUpdete">수정</button>
		        <button type="button" id="btnDelete">삭제</button>
		    </c:if>
		    <!-- **상세보기 화면에서 게시글 목록화면으로 이동 -->
			<button type="button" id="btnList">목록</button>
	    </div>
	</form>
		<div style="width:650px; text-align: center;">
	        <br>
	        <!-- **로그인 한 회원에게만 댓글 작성폼이 보이게 처리 -->
	        <c:if test="${sessionScope.userId != null}">    
		        <textarea rows="5" cols="80" id="replytext" placeholder="댓글을 작성해주세요"></textarea>
		        <br>
		        
		        <button type="button" id="btnReply">댓글 작성</button>
	        </c:if>
	    </div>
	    <!-- **댓글 목록 출력할 위치 -->
	    <div id="listReply"></div>
</section>
</div>
<%@ include file="../include/footer.jsp" %>
<script>
$("#navUl li").removeClass("current");
$("#boardli").attr('class','current');
</script>
</body>
</html>
