<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">
<title>코스 보기</title>
<%@ include file="../include/header.jsp" %>
<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?clientId=ZD0P2V80MJ57K5qoMKF8&submodules=panorama,geocoder,drawing,visualization"></script>

<style type="text/css">
    ul.measure-control { position:absolute;z-index:100;top:15px;right:120px;margin:0;padding:0; }
    ul.measure-control li { list-style:none;float:left;display:block;padding-right:5px; }
    
    input[type="button"], input[type="submit"], input[type="reset"], button, .button {
	    font-size: 0.8em !important;
	    padding: 0.65em 1.5em 0.65em 1.5em;
	}
</style>

</head>
<body>
<%@ include file="../include/menu.jsp" %>
<div id="map" style="width:70%;height:800px;">
	<ul class="measure-control">
		<li><input id="bicycle" type="button" value="자전거 도로 표시" class="control-btn"></li>
	</ul>
</div>
<div id="info" style="width:30%;height:200px; display:inline; position:fixed; top:300px; right:0px; background-color:#f0f5f5; z-index:999">
	
	<ul class="dates">
		<li>
			<span class="date">way<strong>${dto.gno}</strong></span>
			<h2>
				<a href="${path}/course/view.do?gno=${dto.gno}">${dto.title}</a>
            </h2>
			<p>${Math.round((dto.distance/100))/10} km  /  ${dto.writer}  /  <fmt:formatDate value="${dto.regdate}" pattern="yyyy-MM-dd HH:mm"/></p>
		</li>
	</ul>
	<%-- <h2>${dto.title}</h2><hr/>
	<h4> ${Math.round((dto.distance/100))/10} km</h4>
	<h4> ${dto.writer} &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <fmt:formatDate value="${dto.regdate}" pattern="yyyy-MM-dd HH:mm"/> </h4>
	<h4> 코스번호 : ${dto.gno}</h4>
	<br/> --%>
	<button type="button" id="btnList" style="margin-left:100px" class="alt">목록</button>
	<c:if test="${sessionScope.userId == dto.writer}">
        <button type="button" id="btnDelete">삭제</button>
    </c:if>
</div>
<div style="width:30%;height:630px; display:inline; position:fixed; top:600px; right:0px; background-color:#f0f5f5; z-index:999">
	        <br>
	        <!-- **로그인 한 회원에게만 댓글 작성폼이 보이게 처리 -->
	        <c:if test="${sessionScope.userId != null}"> 
		        <textarea rows="3" cols="50" id="replytext" placeholder="댓글을 작성해주세요" style="margin-left:20px"></textarea>
		        <br>
		        
		        <button type="button" id="btnReply" style="margin-left:100px">댓글 작성</button>
		        <hr/>
	        </c:if>
	    <!-- **댓글 목록 출력할 위치 -->
	    <div id="listReply" style="margin-left:20px"></div>
</div>
	  
<%@ include file="../include/footer.jsp" %>  
<script>
var mapOptions = {
    center: new naver.maps.LatLng(37.5189375, 126.85354749999999),
    mapTypeControl: true,
    mapTypeControlOptions: {
        style: naver.maps.MapTypeControlStyle.DROPDOWN
    },
    zoom: 10,
    scaleControl: false,
    logoControl: false,
    mapDataControl: false,
    zoomControl: true,
    minZoom: 1
};

var map = new naver.maps.Map('map', mapOptions);


var drawingManager = new naver.maps.drawing.DrawingManager({
    map: map,
    drawingControl: []
    //,
    
    /* rectangleOptions: {
        fillColor: '#ff0000',
        fillOpacity: 0.5,
        strokeWeight: 3,
        strokeColor: '#ff0000'
    },
    ellipseOptions: {
        fillColor: '#ff25dc',
        fillOpacity: 0.5,
        strokeWeight: 3,
        strokeColor: '#ff25dc'
    }, */
    /* polylineOptions: {
        strokeColor: '#222',
        strokeWeight: 3,
    },
    arrowlineOptions: {
        endIconSize: 16,
        strokeWeight: 3
    } */
    /* ,
    polygonOptions: {
        fillColor: '#ffc300',
        fillOpacity: 0.5,
        strokeWeight: 3,
        strokeColor:'#ffc300'
    } */
});

// 호출된 오버레이어 출력
var geojson = ${dto.gjson};

setTimeout(function(){ map.data.addGeoJson(geojson, true); }, 500);

// 댓글 부분
$(document).ready(function(){
    	var replyCount = Number("${count}");
    	
    	listReply("1"); // **댓글 목록 불러오기
        //listReply2(); // ** json 리턴방식
        
        // ** 댓글 쓰기 버튼 클릭 이벤트 (ajax로 처리)
        $("#btnReply").click(function(){
            var replytext=$("#replytext").val();
            var gno="${dto.gno}";
			var replyer="tester";
        	 // **비밀댓글 파라미터 추가
            var param="replytext="+replytext+"&gno="+gno+"&replyer="+replyer;

            $.ajax({                
                type: "post",
                url: "${path}/reply/insert.do",
                data: param,
                contentType: 'application/x-www-form-urlencoded; charset=utf-8',
                success: function(data){
                	//console.log(" /reply/insert.do success!!!" +data);
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
            location.href="${path}/course/list.do";
        });

    
        $("#btnDelete").click(function(){
        	/* console.log("reply count = " + replyCount);
        	if(replyCount>0){
        		alert("댓글이 있는 게시물은 삭제할 수 없습니다.");
        		return;
        	} */
            if(confirm("삭제하시겠습니까?")){
            	location.href="${path}/course/delete.do?gno=${dto.gno}";
                /* document.form1.action = "${path}/course/delete.do";
                document.form1.submit();  */
            }
        });
        
        
        /* $("#btnUpdete").click(function(){
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
            } */
            /* if(writer == ""){
                alert("이름을 입력하세요");
                document.form1.writer.focus();
                return;
            } */
        /*     document.form1.action="${path}/board/update.do"
            // 폼에 입력한 데이터를 서버로 전송
            document.form1.submit();
        }); */
    });
    
 // Controller방식
    // **댓글 목록1
    function listReply(num){
        $.ajax({
            type: "get",
            url: "${path}/reply/list.do?gno=${dto.gno}&curPage="+num,
            success: function(result){
            // responseText가 result에 저장됨.
            	console.log("result = " + result);
                $("#listReply").html(result);
            }
        });
    }
 
	function listReplyDelete(grno){
		if(confirm("댓글을 삭제하시겠습니까?")){		

     	 // **비밀댓글 파라미터 추가
         var param="grno="+grno;

         $.ajax({                
             type: "post",
             url: "${path}/reply/delete.do",
             data: param,
             contentType: 'application/x-www-form-urlencoded; charset=utf-8',
             success: function(data){
             	console.log(" /reply/delete.do success!!!" +data);
             	//replyCount = replyCount-1;
                 alert("댓글이 삭제되었습니다.");
                 listReply("1");
                 $("#replytext").val('');
                 //location.reload();
             }
         });
		}
	}
	
	//자전거도로 레이어 생성
	var bicycleLayer = new naver.maps.BicycleLayer();
	var btn = $('#bicycle');

	naver.maps.Event.addListener(map, 'bicycleLayer_changed', function(bicycleLayer) {
	    if (bicycleLayer) {
	        btn.addClass('control-on');
	    } else {
	        btn.removeClass('control-on');
	    }
	});

	// 자전거도로 레이어 설정
	bicycleLayer.setMap(null);

	$('#bicycle').on("click", function(e) {
	    e.preventDefault();

	    if (bicycleLayer.getMap()) {
	        bicycleLayer.setMap(null);
	    } else {
	        bicycleLayer.setMap(map);
	    }
	});
	
	$("#navUl li").removeClass("current");
	$("#courseli").attr('class','current');
	
</script>
</body>
</html>