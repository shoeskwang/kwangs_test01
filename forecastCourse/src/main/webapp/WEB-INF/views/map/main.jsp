<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- jstl 코어 태그 -->
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">
<title>Myway Home</title>
<%@ include file="../include/header.jsp" %>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?clientId=ZD0P2V80MJ57K5qoMKF8&submodules=panorama,geocoder,drawing,visualization"></script>
<style type="text/css">
    ul.measure-control { position:absolute;z-index:100;top:15px;right:120px;margin:0;padding:0; }
    ul.measure-control li { list-style:none;float:left;display:block;padding-right:5px; }
    
    input[type="button"], input[type="submit"], input[type="reset"], button, .button {
	    font-size: 0.8em;
	    padding: 0.65em 1.5em 0.65em 1.5em;
	}
</style>
</head>
<body>
<%@ include file="../include/menu.jsp" %>
<!--  지도 사이즈 조절 -->
<div id="map" style="width:70%;height:800px;">
	<ul class="measure-control">
		<li><input id="bicycle" type="button" value="자전거 도로 표시" class="control-btn"></li>
	</ul>
</div>
<div id="info" style="width:29%;height:300px; display:inline; position:fixed; top:300px; right:0px; background-color:#f0f5f5; z-index:999; text-align:center;">
	<h2>오늘의 날씨</h2>
	${map.DATE.substring(0,4)} 년 ${map.DATE.substring(4,6)} 월 ${map.DATE.substring(6,8)} 일 <br/>
	<br/>
	<c:choose>
		<c:when test="${map.PTY == 0}">
			<c:choose>
				<c:when test="${map.SKY == 1}">
					<img src="<%=request.getContextPath()%>/images/sun.svg" height="30" width="30" />
				</c:when>
				<c:when test="${map.SKY == 2}">
					<img src="<%=request.getContextPath()%>/images/cloud.svg" height="30" width="30" />
				</c:when>
				<c:when test="${map.SKY == 3 || map.SKY == 4}">
					<img src="<%=request.getContextPath()%>/images/clouds.svg" height="50" width="50" />
				</c:when>
				<c:otherwise>
				</c:otherwise>
		    </c:choose>
		</c:when>
		<c:when test="${map.PTY == 1}">
			<c:choose>
				<c:when test="${map.SKY == 1}">
					<img src="<%=request.getContextPath()%>/images/rain.svg" height="30" width="30" />
				</c:when>
				<c:when test="${map.SKY == 2}">
						<img src="<%=request.getContextPath()%>/images/cloud-rain.svg" height="30" width="30" />
				</c:when>
				<c:when test="${map.SKY == 3 || map.SKY == 4}">
						<img src="<%=request.getContextPath()%>/images/cloud-rain.svg" height="30" width="30" />
				</c:when>
			</c:choose>
			강수량 : ${map.RN1} mm<br/>
			<%-- 낙뢰 : ${map.LGT} <br/> --%>
		</c:when>
		<c:when test="${map.PTY == 2}">
			<!-- 비/눈<br/> -->
			<img src="<%=request.getContextPath()%>/images/snow.svg" height="30" width="30" />
			강수량 : ${map.RN1} mm<br/>
			<%-- 낙뢰 : ${map.LGT} <br/> --%>
		</c:when>
		<c:when test="${map.PTY == 3}">
			<!-- 눈 -->
			<img src="<%=request.getContextPath()%>/images/snow.svg" height="30" width="30" />
			강수량 : ${map.RN1} mm<br/>
			<%-- 낙뢰 : ${map.LGT} <br/> --%>
		</c:when>
		<c:otherwise>
		</c:otherwise>
    </c:choose>
	<br/>
	온도 : ${map.T1H} ℃<br/>
	미세먼지 농도: ${dustMap.CAISTEP.replaceAll("\"","")}<br/>
	(${dustMap.ALARM_CNDT.replaceAll("\"","")})
	
	<br/><br/>
	<c:if test="${map.PTY == 0}">
		<c:if test="${dustMap.CAISTEP.replaceAll('\"','').equals('보통') || dustMap.CAISTEP.replaceAll('\"','').equals('좋음')}">
			<span>라이딩하기 좋은 날씨입니다 :)</span>
		</c:if>
	</c:if>
	
</div>
<div id="imgsection"  style="width:27%;height:500px; display:inline; position:fixed; top:600px; right:0px; z-index:999">
		<img src="<%=request.getContextPath()%>/images/adv.jpg" height="80%" width="80%" style="margin:10px;"/>
</div>



<%@ include file="../include/footer.jsp" %>

	
<!-- <div id="pano" style="width:100%;height:800px;"></div> -->
<!-- <input id="bicycle" type="button" value="자전거 도료 표시" class="control-btn">
<input id="execute" type="button" value="날씨정보">
<input id="execute2" type="button" value="미세먼지정보"> -->
<!-- <input id="around" type="button" value="거리뷰" class="control-btn"> -->
<script>
/* 지도 초기위치 지정 */
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
    drawingControl: [
        naver.maps.drawing.DrawingMode.ARROWLINE
    ],
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
    /*
    polylineOptions: {
        strokeColor: '#222',
        strokeWeight: 3,
    },*/
    arrowlineOptions: {
        endIconSize: 16,
        strokeWeight: 3
    }
    /* ,
    polygonOptions: {
        fillColor: '#ffc300',
        fillOpacity: 0.5,
        strokeWeight: 3,
        strokeColor:'#ffc300'
    } */
});

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
bicycleLayer.setMap(map);

$('#bicycle').on("click", function(e) {
    e.preventDefault();

    if (bicycleLayer.getMap()) {
        bicycleLayer.setMap(null);
    } else {
        bicycleLayer.setMap(map);
    }
});

$("#navUl li").removeClass("current");
$("#homeli").attr('class','current');
</script>
</body>
</html>