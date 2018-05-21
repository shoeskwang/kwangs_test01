<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">
<title>코스 저장</title>
<%@ include file="../include/header.jsp" %>
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
<div id="map" style="width:70%;height:800px;">
	<ul class="measure-control">
		<li><input id="bicycle" type="button" value="자전거 도로 표시" class="control-btn"></li>
	</ul>
	
</div>
<div id="info" style="width:29%;height:300px; display:inline; position:fixed; top:300px; right:0px; background-color:#f0f5f5; z-index:999">
	<form name="form1" method="post" action="${path}/course/insert.do">
		<!-- <input type="text" name="geoName" id="geoName" /> -->
		<input type="hidden" name="gjson" id="gjson" />
		<input type="hidden" name="distance" id="distance" />
		<h2>코스명</h2>  <input type="text" name="title" id="title" /><br/>
		
	    <div style="width:650px; margin-left:80px">
	        <button type="button" id="btnSave">저장</button>
	        <!-- <button type="reset">취소</button> -->
	    </div>
</form>
</div>
<div id="imgsection"  style="width:25%;height:500px; display:inline; position:fixed; top:600px; right:0px; z-index:999">
		<img src="<%=request.getContextPath()%>/images/adv.jpg" height="80%" width="80%" style="margin:10px;"/>
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
    /* polylineOptions: {
        strokeColor: '#222',
        strokeWeight: 3,
    }, */
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

function getDistance(){
	// distance 처리 (km)
    var geojson = drawingManager.toGeoJson();
    // console.log(JSON.stringify(geojson));
    
    var it = makeIterator(geojson.features[0].geometry.coordinates);
    
    var temp=it.next().value;
    var prevlat,prevlon;
    var total = 0;
    while(temp){	
    	prevlat = temp[0];
    	prevlon = temp[1];
    	
    	temp = it.next().value;
    	if(temp){
    		total = total + calculateDistance(prevlat,prevlon,temp[0],temp[1]);
    	}
    }
    // 소수점 둘째짜리까지
    total = total*1000; // m단위 변환
    total = Math.round(total);
    return total;
}

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

$("#navUl li").removeClass("current");
$("#registli").attr('class','current');
</script>
</body>
</html>