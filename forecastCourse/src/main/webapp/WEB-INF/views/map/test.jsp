<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- jstl 코어 태그 -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">
<title>간단한 지도 표시하기</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?clientId=ZD0P2V80MJ57K5qoMKF8&submodules=panorama,geocoder,drawing,visualization"></script>
</head>
<body>
<%@ include file="../include/menu.jsp" %>
<!--  지도 사이즈 조절 -->
<div id="map" style="width:70%;height:800px;"></div>
<div id="info" style="width:30%;height:300px; display:inline; position:fixed; top:60px; right:0px; background-color:#f0f5f5; z-index:999">
	${map.DATE} <br/>
	강수 : ${map.PTY} <br/>
	강수량 : ${map.RN1} mm<br/>
	낙뢰 : ${map.LGT} <br/>
	하늘 : ${map.SKY} <br/>
	온도 : ${map.T1H} ℃<br/>
	미세먼지 농도: ${dustMap.CAISTEP}<br/>
	(${dustMap.ALARM_CNDT})
</div>

<div id="formDiv" style="width:30%;height:300px; display:inline; position:fixed; top:360px; right:0px; background-color:#f0f5f5; z-index:999">
	<hr/>
	
	<hr/>
	<input id="restore" type="button" value="오버레이 추출">
	<input id="distanceBtn" type="button" value="거리 추출">
	<input id="bicycle" type="button" value="자전거 도로 표시" class="control-btn">
</div>


	
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
        naver.maps.drawing.DrawingMode.POLYLINE,
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
    polylineOptions: {
        strokeColor: '#222',
        strokeWeight: 3,
    },
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
	
	console.log("distance = " + distance);
	console.log("click");
    e.preventDefault();

    if (bicycleLayer.getMap()) {
        bicycleLayer.setMap(null);
    } else {
        bicycleLayer.setMap(map);
    }
});


//var geojsonStr = '{"type":"FeatureCollection","features":[{"type":"Feature","geometry":{"type":"LineString","coordinates":[[126.8524353,37.5206214],[126.8523527,37.5210131],[126.8505836,37.5220985],[126.8498187,37.5222115],[126.8497374,37.5217964]],"mantle_properties":{"strokeColor":"#007EEA","strokeOpacity":1,"strokeWeight":3,"strokeStyle":"solid","strokeLineCap":"butt","strokeLineJoin":"miter","visible":true,"clickable":true,"endIcon":2,"endIconSize":16,"zIndex":0,"overlayType":"Polyline"}},"properties":{"strokeColor":"#007EEA","strokeOpacity":1,"strokeWeight":3,"strokeStyle":"solid","strokeLineCap":"butt","strokeLineJoin":"miter","visible":true,"clickable":true,"endIcon":2,"endIconSize":16,"zIndex":0,"overlayType":"Polyline"}}],"bbox":[126.8497374,37.5206214,126.8524353,37.5222115]}';
//var geojsonStr = '{"type":"FeatureCollection","features":[{"type":"Feature","geometry":{"type":"LineString","coordinates":[[126.8529756,37.5209534],[126.8652084,37.5223267],[126.8641847,37.5256021],[126.8647158,37.5256951],[126.8650759,37.5259404],[126.8694051,37.5252245],[126.8783336,37.5239469],[126.878359,37.5236135],[126.8785512,37.5236416],[126.878468,37.5241188],[126.8790332,37.5241939],[126.8782206,37.5252893],[126.8794851,37.5270265],[126.8802642,37.5272379],[126.8806065,37.5282673],[126.8815859,37.5289033],[126.8830698,37.5287489],[126.8867137,37.5301829],[126.8889407,37.5346562],[126.8885913,37.5358712],[126.8856659,37.5406421],[126.8845017,37.5431779],[126.8840351,37.5434909],[126.8826593,37.5456019],[126.8800135,37.5479496],[126.8760498,37.5535621],[126.8756576,37.5544343],[126.8793005,37.5533899],[126.8810637,37.5523717],[126.8832321,37.5516439],[126.8900388,37.5471365],[126.8917,37.5447114],[126.8926458,37.5439501],[126.8930387,37.5443488],[126.892629,37.5446171]],"mantle_properties":{"strokeColor":"#007EEA","strokeOpacity":1,"strokeWeight":3,"strokeStyle":"solid","strokeLineCap":"butt","strokeLineJoin":"miter","visible":true,"clickable":true,"endIcon":2,"endIconSize":16,"zIndex":0,"overlayType":"Polyline"}},"properties":{"strokeColor":"#007EEA","strokeOpacity":1,"strokeWeight":3,"strokeStyle":"solid","strokeLineCap":"butt","strokeLineJoin":"miter","visible":true,"clickable":true,"endIcon":2,"endIconSize":16,"zIndex":0,"overlayType":"Polyline"}}],"bbox":[126.8529756,37.5209534,126.8930387,37.5544343]}';
//var geojson2 =  JSON.parse("\""+${geoJson}+"\"");

//var geojson="";  //${geoJson};
//console.log("geojson : "  + geojson);
$("#restore").on("click", function(e) {
    e.preventDefault();
	//console.log("restore : " + JSON.stringify(geojson) );
   // map.data.addGeoJson(geojson, true);
    bicycleLayer.setMap(null);
    
    // distance 처리 (km)
    
    
    /*  if (geojson) {
        geojson = null;
    }

    geojson = drawingManager.toGeoJson();
    console.log(geojson);
    console.log(JSON.stringify(geojson));  */
    //restoreMap.data.addGeoJson(geojson, true);
});




Number.prototype.toRad = function() {
	return this * Math.PI / 180;
}
	
function makeIterator(array){
  var nextIndex = 0;

  return {
     next: function(){
         return nextIndex < array.length ?
             {value: array[nextIndex++], done: false} :
             {done: true};
     }
  }
}

function getDistance(){
	// distance 처리 (km)
	/*
    if (geojson) {
        geojson = null;
    }
	*/
    var geojson = drawingManager.toGeoJson();
    console.log(geojson);
    console.log(JSON.stringify(geojson));
    
    var it = makeIterator(geojson.features[0].geometry.coordinates);
    
    var temp=it.next().value;
    var prevlat,prevlon;
    var total = 0;
    while(temp){	
    	//console.log(temp[0]);
    	//console.log(temp[1]);
    	
    	prevlat = temp[0];
    	prevlon = temp[1];
    	
    	temp = it.next().value;
    	if(temp){
    		//console.log("+ " + calculateDistance(prevlat,prevlon,temp[0],temp[1]));
    		total = total + calculateDistance(prevlat,prevlon,temp[0],temp[1]);
    	}
    	
    	
    	/*
    	tempVal1 = tempIt.next();
    	tempVal2 = tempIt.next();
    	if(tempVal1.value){
    	
    	console.log(tempVal1.value);
    	console.log(tempVal2.value);
    	}
    	*/
    		
    	//tempIt = makeIterator(it.next().value);
    	
    	//console.log("tempIt = " + tempIt);  
    	
    	
    	/*
    	while(!tempIt.next().done){
    		console.log(tempIt.next().value);
    		console.log(tempIt.next().value);
    	}
    	tempIt = makeIterator(it.next().value);
    	*/
    }
    // 소수점 둘째짜리까지
    total = total*1000; // m단위 변환
    total = Math.round(total);
    return total;
}
$("#distanceBtn").on("click", function(e) {
    e.preventDefault();
    console.log("distance click");
    total = getDistance();

    console.log("getDistance total : " + total);
    
    //restoreMap.data.addGeoJson(geojson, true);
});

$(document).ready(function(){
    $("#btnSave").click(function(){
        //var title = document.form1.title.value; ==> name속성으로 처리할 경우
        //var content = document.form1.content.value;
        //var writer = document.form1.writer.value;
        console.log("save");
	   var geoJson = JSON.stringify(drawingManager.toGeoJson());
	   //var geoJson = drawingManager.toGeoJson();
	   $("#gjson").val(geoJson);
	   $("#distance").val(getDistance());
	   console.log("geoJson : " + geoJson);
        // 폼에 입력한 데이터를 서버로 전송
        document.form1.submit();
    });
});


/// 정보 API 처리

var forecastData = ${forecastRes};
/* var dustData = ${dustRes}; */

//console.log("forecastData : " + JSON.stringify(forecastData));
//console.log("dustData : " + JSON.stringify(dustData));


function calculateDistance(lat1, lon1, lat2, lon2) {
    var R = 6371; // km
    var dLat = (lat2-lat1).toRad();
    var dLon = (lon2-lon1).toRad(); 
    var a = Math.sin(dLat/2) * Math.sin(dLat/2)
    		+ Math.cos(lat1.toRad()) * Math.cos(lat2.toRad())
    		* Math.sin(dLon/2) * Math.sin(dLon/2); 
    var c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a)); 
    var d = R * c;
    return d;
}

console.log("LGT : " + ${map.LGT});
console.log("PTY : " + ${map.PTY});
console.log("RN1 : " + ${map.RN1});
console.log("SKY : " + ${map.SKY});
console.log("T1H : " + ${map.T1H});

// console.log("APPLC_DT : " + ${dustMap.APPLC_DT}); // 시각 정보
console.log("CAISTEP : " + ${dustMap.CAISTEP});
console.log("ALARM_CNDT : " + ${dustMap.ALARM_CNDT});
//var ALARM_CNDT = ${dustMap.ALARM_CNDT};

// 거리뷰 파노라마 기능
/*
var pano = null;

function initPanorama() {
    pano = new naver.maps.Panorama("pano", {
        position: new naver.maps.LatLng(37.3599605, 127.1058814),
        pov: {
            pan: -135,
            tilt: 29,
            fov: 100
        },
        aroundControl: true,
        aroundControlOptions: {
            position: naver.maps.Position.TOP_RIGHT
        }
    });
}

naver.maps.onJSContentLoaded = initPanorama;

$("#around").on("click", function(e) {
    e.preventDefault();

    var el = $(this),
        aroundControlEnabled = pano.getOptions("aroundControl");

    if (aroundControlEnabled) {
        pano.setOptions({
            aroundControl: false
        });
        el.val("AroundControl 켜기").removeClass("control-on");
    } else {
        pano.setOptions({
            aroundControl: true
        });
        el.val("AroundControl 끄기").addClass("control-on");
    }
}); */

</script>

<form name="form1" method="post" action="${path}/main/insert.do">
		<!-- <input type="text" name="geoName" id="geoName" /> -->
		<input type="hidden" name="gjson" id="gjson" />
		<input type="hidden" name="distance" id="distance" />
		<input type="text" name="title" id="title" />
		<input type="text" name="writer" id="writer" />
		
	    <div style="width:650px;">
	        <button type="button" id="btnSave">확인</button>
	        <button type="reset">취소</button>
	    </div>
</form>
	
</body>
</html>