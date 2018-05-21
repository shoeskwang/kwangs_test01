<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Ticket Theme</title>
<%@ include file="../include/header.jsp" %>
<style type="text/css">	
	#contents {width:900px}
	#contents li {display:inline-block; width:180px; height:180px}
	#contents div {display:inline;}
	
	
	#sortBtnDiv {margin-left:38px; margin-bottom:10px;}
	button{width:220px; /* border-color:#f7e6ff; */}
	
	#themeOption div {width:700px;}
	#themelist {display:inline; width:180px ; margin-start:0px}
	#themelist ul{display:inline-block; width:180px ; -webkit-padding-start:0}
	#themelist li{display:inline-block; width:160px;}
	#themeul {display:inline; width:200px;}
	
	/* tr{height:200px; width:200px} */
	/* td{height:200px; width:200px} */
</style>

<script>
	/* $("#sort1_btn").click(function() {
		console.log("sort1");
		sort(1);
	}
	$("#sort2_btn").click(function() {
		console.log("sort2");
		sort(2);
	}
	$("#sort3_btn").click(function() {
		console.log("sort3");
		sort(3);
	} */
	var sortOption=${sessionScope.sortOption};
		// **원하는 정렬형태로 변경
	
	
	function pageChange(tno){
		console.log(" tno = " + tno);
		location.href="${path}/ticket/view.do?tno="+tno;
	}
	
	
	$(document).ready(function(){
		// 초기 변수 선언
		var theme = document.getElementsByName("theme");
		var genre = document.getElementsByName("genre");
		var location = document.getElementsByName("location");
		var themeVal;
		var genreVal;
		var locationVal;
		
		// 라디오 체크 유무 체크
		function radioCheck(){
			console.log(" radioCheck!! ");
			theme = document.getElementsByName("theme");
			genre = document.getElementsByName("genre");
			location = document.getElementsByName("location");
			
			// radio check 값 확인 처리
			for(var i=0; i<theme.length;i++){
				if(theme[i].checked){
					themeVal=theme[i].value;
					break;
				}
			}
			
			for(var i=0; i<genre.length;i++){
				if(genre[i].checked){
					genreVal=genre[i].value;
					break;
				}
			}
			
			for(var i=0; i<location.length;i++){
				if(location[i].checked){
					locationVal=location[i].value;
					break;
				}
			}
			
			console.log("themeVal  = " + themeVal);
			console.log("genreVal  = " + genreVal);
			console.log("locationVal  = " + locationVal);
		}
		// 서버통신 후 전달받은 데이터 출력 처리
		function contentsPrint(responseData){
			console.log("contentsPrint!!");
			
			console.log("responseData = " + responseData);
            var data = JSON.parse(responseData);
            
            if(!data){
            	alert("데이터가 존재하지 않습니다.");
                return false;
            }
            
			var html = '';
            for(i=0 ; i<data.length ; i++){
   				
   				html += '<li style="display:inline-block;  height:210px; margin:3px; " onclick="pageChange(\''+data[i].tno+'\')">';
   				html += '<img src="${pageContext.request.contextPath}/images/'+data[i].poster+'.png">';
   				html += data[i].title+'<br/>';
   				html += '<div style="font-size:15px">'+data[i].sdate + ' ~ '; 
   				html += data[i].edate+'</div>';
   				html += '</li>';
            }
           	
            $("#contents").html(html); 
		}
		
		//초기 데이터 ajax 통신작업 
		function init(){
			radioCheck();
			
    		console.log("Init session sortOption = " + sortOption);
    		
            $.ajax({
                url : "${path}/ticket/themeajax.do?sortOption="+sortOption+"&theme="+themeVal+"&genre="+genreVal+"&location="+locationVal,
                type: "get",
                data : null,
                success : function(responseData){
                   contentsPrint(responseData);
                }
           	});
		}
		// 정렬 값 변경 처리
		$("#sort1_btn").bind("click",function(){
			radioCheck();
    		
			$.ajax({
                url : "${path}/ticket/themeajax.do?sortOption=1"+"&theme="+themeVal+"&genre="+genreVal+"&location="+locationVal,
                type: "get",
                data : null,
                success : function(responseData){
                    contentsPrint(responseData);
                    sortOption=1;
                }
            });
		});
		
		$("#sort2_btn").bind("click",function(){
			radioCheck();
			
			$.ajax({
                url : "${path}/ticket/themeajax.do?sortOption=2"+"&theme="+themeVal+"&genre="+genreVal+"&location="+locationVal,
                type: "get",
                data : null,
                success : function(responseData){
                   contentsPrint(responseData);
                   sortOption=2;
                }
            });
		});
		
		$("#sort3_btn").bind("click",function(){
			radioCheck();
    		
			$.ajax({
                url : "${path}/ticket/themeajax.do?sortOption=3"+"&theme="+themeVal+"&genre="+genreVal+"&location="+locationVal,
                type: "get",
                data : null,
                success : function(responseData){
                   contentsPrint(responseData);
                   sortOption=3;
                }
            });
		});
		
		// 테마에 따른 데이터 조회
        $("#searchBtn").bind("click",function(){
        	radioCheck();
    		console.log("session sortOption = " + sortOption);
    		
    		//location.href="${path}/ticket/theme.do?sortOption=2"+"&theme="+themeVal+"&genre="+genreVal;
            $.ajax({
                url : "${path}/ticket/themeajax.do?sortOption="+sortOption+"&theme="+themeVal+"&genre="+genreVal+"&location="+locationVal,
                type: "get",
                data : null,
                success : function(responseData){
                   contentsPrint(responseData);
                }
            });
        });
        
        init();
    });
</script>
</head>
<body>
<%@ include file="../include/menu.jsp" %>

<div id="wrapper">
<section class="wrapper style1 fullscreen">
	<div id="themeOption">
		<ul id="themelist">
			<li>
				테마
				<ul id="themeul">
					<li>
						<input type="radio" name="theme" id="theme_all" value="0" checked="checked"/><label for="theme_all">전체</label>
					</li>
					<li>
						<input type="radio" name="theme" id="theme1" value="1"/><label for="theme1">내한</label>
					</li>
					<li>
						<input type="radio" name="theme" id="theme2" value="2"/><label for="theme2">홍대</label>
					</li>
					<li>
						<input type="radio" name="theme" id="theme3" value="3"/><label for="theme3">아이돌</label>
					</li>
					<li>
						<input type="radio" name="theme" id="theme4" value="4"/><label for="theme4">페스티벌</label>
					</li>
					
				</ul>
			</li>
			<li>	
				장르
				<ul id="themeul">
					<li>
						<input type="radio" name="genre" id="gen_all" value="0" checked="checked"/><label for="gen_all">전체</label>
					</li>
					<li>
						<input type="radio" name="genre" id="gen1" value="1"/><label for="gen1">발라드</label>
					</li>
					<li>
						<input type="radio" name="genre" id="gen2" value="2"/><label for="gen2">록/힙합/댄스</label>
					</li>
					<li>
						<input type="radio" name="genre" id="gen3" value="3"/><label for="gen3">인디</label>
					</li>
					<li>
						<input type="radio" name="genre" id="gen4" value="4"/><label for="gen4">POP</label>
					</li>
					<li>
						<input type="radio" name="genre" id="gen5" value="5"/><label for="gen5">트로트</label>
					</li>
				</ul>
			</li>
			<li>	
				지역
				<ul id="themeul">
					<li>
						<input type="radio" name="location" id="loc_all" value="0" checked="checked" /><label for="loc_all">전체</label>
					</li>
					<li>
						<input type="radio" name="location" id="loc1" value="1"/><label for="loc1">서울</label>
					</li>
					<li>
						<input type="radio" name="location" id="loc2" value="2"/><label for="loc2">경기/인천</label>
					</li>
					<li>
						<input type="radio" name="location" id="loc3" value="3"/><label for="loc3">충청/강원</label>
					</li>
					<li>
						<input type="radio" name="location" id="loc4" value="4"/><label for="loc4">전라</label>
					</li>
					<li>
						<input type="radio" name="location" id="loc5" value="5"/><label for="loc5">경상</label>
					</li>
				</ul>
			</li>
		</ul>
	</div>
	<div id="searchBtnDiv"> <button id="searchBtn" style="float:right">조회</button></div>
	<hr>
	<div id="sortBtnDiv">
		<button id="sort1_btn">인기순</button>
		<button id="sort2_btn">최신순</button>
		<button id="sort3_btn">가격순</button>
	</div>
	
	
	<ul id="contents">
	</ul>
	<!-- <ul id="contentsAjax">
	
			
	</ul> -->
</section>
</div>


</body>
</html>