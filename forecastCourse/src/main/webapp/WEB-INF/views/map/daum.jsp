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
<meta name="twitter:description" content="NAVER Maps API v3로 여러분의 지도를 만들어 보세요. 유용한 기술문서와 다양한 예제 코드를 제공합니다.">
<meta name="twitter:image" content="https://navermaps.github.io/maps.js/docs/img/NAVERMaps.png">
<meta name="twitter:url" content="https://navermaps.github.io/maps.js">
<title>거리 표시하기</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?clientId=ZD0P2V80MJ57K5qoMKF8&submodules=panorama,geocoder,drawing,visualization"></script>

<style type="text/css">
    ul.measure-control { position:absolute;z-index:100;top:5px;right:10px;margin:0;padding:0; }
    ul.measure-control li { list-style:none;float:left;display:block;padding-right:5px; }
</style>

</head>
<body>
<!--  지도 사이즈 조절 -->
<div id="map" style="width:70%;height:800px;">
	<ul class="measure-control">
        <li><input id="distance" type="button" value="거리재기" class="control-btn" /></li>
        <li><input id="area" type="button" value="면적재기" class="control-btn" /></li>
    </ul>
</div>

<input id="getInfo" type="button" value="맵정보 추출">
<input id="restore" type="button" value="오버레이 추출">
<input id="bicycle" type="button" value="자전거 도로 표시" class="control-btn">

	
<!-- <div id="pano" style="width:100%;height:800px;"></div> -->
<!-- <input id="bicycle" type="button" value="자전거 도료 표시" class="control-btn">
<input id="execute" type="button" value="날씨정보">
<input id="execute2" type="button" value="미세먼지정보"> -->
<!-- <input id="around" type="button" value="거리뷰" class="control-btn"> -->
<script>
var HOME_PATH = window.HOME_PATH || '.';

//지도내 거리재기 또는 면적재기를 클릭하세요.
//거리/면적재기 동작 중 마우스 오른쪽 버튼을 클릭하면 해당 거리/면적재기가 종료됩니다.
var Measure = function(buttons) {
 this.$btnDistance = buttons.distance;
 this.$btnArea = buttons.area;

 this._mode = null;

 this._bindDOMEvents();
};


$.extend(Measure.prototype, {
 constructor: Measure,

 setMap: function(map) {
     if (this.map) {
         this._unbindMap(this.map);
     }

     this.map = map;

     if (map) {
         this._bindMap(map);
     }
 },

 startMode: function(mode) {
     if (!mode) return;

     if (mode === 'distance') {
         this._startDistance();
     } if (mode === 'area') {
         this._startArea();
     }
 },

 _startDistance: function() {
     var map = this.map;

     this._distanceListeners = [
         naver.maps.Event.addListener(map, 'click', this._onClickDistance.bind(this))
     ];

     //map.setCursor("url('"+ HOME_PATH +"/img/rule.cur'), default");
 },

 _startArea: function() {
     var map = this.map;

     this._areaListeners = [
         naver.maps.Event.addListener(map, 'click', this._onClickArea.bind(this)),
         naver.maps.Event.addListener(map, 'rightclick', this._finishArea.bind(this))
     ];

     $(document).on('mousemove.measure', this._onMouseMoveArea.bind(this));

     map.setCursor("url('"+ HOME_PATH +"/img/area.cur'), default");
 },

 _finishDistance: function() {
     naver.maps.Event.removeListener(this._distanceListeners);
     delete this._distanceListeners;

     $(document).off('mousemove.measure');

     if (this._guideline) {
         this._guideline.setMap(null);
         delete this._guideline;
     }

     if (this._polyline) {
         var path = this._polyline.getPath(),
             lastCoord = path.getAt(path.getLength() - 1),
             distance = this._polyline.getDistance();
             // 폴리라인의 거리를 미터 단위로 반환합니다.
			 console.log("_finishDistance  =  " + distance);
         delete this._polyline;

         if (lastCoord) {
             this._addMileStone(lastCoord, this._fromMetersToText(distance), {
                 'font-size': '14px',
                 'font-weight': 'bold',
                 'color': '#f00'
             });
         }
     }

     this.$btnDistance.removeClass('control-on').blur();

     map.setCursor('auto');

     delete this._lastDistance;
     this._mode = null;
 },

 _finishArea: function() {
     naver.maps.Event.removeListener(this._areaListeners);
     delete this._areaListeners;

     $(document).off('mousemove.measure');

     if (this._polygon) {
         var path = this._polygon.getPath();
         path.pop();

         // 폴리곤의 면적을 제곱미터 단위로 반환합니다.
         var squarMeters = this._polygon.getAreaSize(),
             lastCoord = path.getAt(path.getLength() - 1);

         if (lastCoord) {
             this._addMileStone(lastCoord, this._fromSquareMetersToText(squarMeters), {
                 'font-size': '14px',
                 'font-weight': 'bold',
                 'color': '#00f'
             });
         }

         delete this._polygon;
     }

     this.$btnArea.removeClass('control-on').blur();

     map.setCursor('auto');

     this._mode = null;
 },

 finishMode: function(mode) {
     if (!mode) return;

     if (mode === 'distance') {
         this._finishDistance();
     } if (mode === 'area') {
         this._finishArea();
     }
 },

 _fromMetersToText: function(meters) {
     meters = meters || 0;

     var km = 1000,
         text = meters;

     if (meters >= km) {
         text = parseFloat((meters / km).toFixed(1)) +'km';
     } else {
         text = parseFloat(meters.toFixed(1)) +'m';
     }

     return text;
 },

 _fromSquareMetersToText: function(squarMeters) {
     squarMeters = squarMeters || 0;

     var squarKm = 1000 * 1000,
         text = squarMeters;

     if (squarMeters >= squarKm) {
         text = parseFloat((squarMeters / squarKm).toFixed(1)) + 'km<sup>2</sup>';
     } else {
         text = parseFloat(squarMeters.toFixed(1)) + 'm<sup>2</sup>';
     }

     return text;
 },

 _addMileStone: function(coord, text, css) {
     if (!this._ms) this._ms = [];

     var ms = new naver.maps.Marker({
         position: coord,
         icon: {
             content: '<div style="display:inline-block;padding:5px;text-align:center;background-color:#fff;border:1px solid #000;"><span>'+ text +'</span></div>',
             anchor: new naver.maps.Point(-5, -5)
         },
         map: this.map
     });

     var msElement = $(ms.getElement());

     if (css) {
         msElement.css(css);
     } else {
         msElement.css('font-size', '11px');
     }

     this._ms.push(ms);
 },

 _onClickDistance: function(e) {
     var map = this.map,
         coord = e.coord;

     if (!this._polyline) {
         // 임시로 보여줄 점선 폴리라인을 생성합니다.
         this._guideline = new naver.maps.Polyline({
             strokeColor: '#f00',
             strokeWeight: 5,
             strokeStyle: [4, 4],
             strokeOpacity: 0.6,
             path: [coord],
             map: map
         });

         $(document).on('mousemove.measure', this._onMouseMoveDistance.bind(this));
         this._distanceListeners.push(naver.maps.Event.addListener(map, 'rightclick', this._finishDistance.bind(this)));

         // 실제 거리재기에 사용되는 폴리라인을 생성합니다.
         this._polyline = new naver.maps.Polyline({
             strokeColor: '#f00',
             strokeWeight: 5,
             strokeOpacity: 0.8,
             path: [coord],
             map: map
         });

         // 폴리라인의 거리를 미터 단위로 반환합니다.
         this._lastDistance = this._polyline.getDistance();
     } else {
         this._guideline.setPath([e.coord]);
         this._polyline.getPath().push(coord);

         // 폴리라인의 거리를 미터 단위로 반환합니다.
         var distance = this._polyline.getDistance();

         this._addMileStone(coord, this._fromMetersToText(distance - this._lastDistance));

         this._lastDistance = distance;
     }
 },

 _onMouseMoveDistance: function(e) {
     var map = this.map,
         proj = this.map.getProjection(),
         coord = proj.fromPageXYToCoord(new naver.maps.Point(e.pageX, e.pageY));
         path = this._guideline.getPath();

     if (path.getLength() === 2) {
         path.pop();
     }

     path.push(coord);
 },

 _onClickArea: function(e) {
     var map = this.map,
         coord = e.coord;

     if (!this._polygon) {
         this._polygon = new naver.maps.Polygon({
             strokeColor: '#00f',
             strokeOpacity: 0.6,
             strokeWeight: 5,
             fillColor: '#00f',
             fillOpacity: 0.3,
             paths: [coord],
             map: map
         });
     } else {
         this._polygon.getPath().push(coord);
     }
 },

 _onMouseMoveArea: function(e) {
     if (!this._polygon) return;

     var map = this.map,
         proj = this.map.getProjection(),
         coord = proj.fromPageXYToCoord(new naver.maps.Point(e.pageX, e.pageY)),
         path = this._polygon.getPath();

     if (path.getLength() >= 2) {
         path.pop();
     }

     path.push(coord);
 },

 _bindMap: function(map) {

 },

 _unbindMap: function() {
     this.unbindAll();
 },

 _bindDOMEvents: function() {
     this.$btnDistance.on('click.measure', this._onClickButton.bind(this, 'distance'));
     this.$btnArea.on('click.measure', this._onClickButton.bind(this, 'area'));
 },

 _onClickButton: function(newMode, e) {
     e.preventDefault();

     var btn = $(e.target),
         map = this.map,
         mode = this._mode;

     if (btn.hasClass('control-on')) {
         btn.removeClass('control-on');
     } else {
         btn.addClass('control-on');
     }

     this._clearMode(mode);

     if (mode === newMode) {
         this._mode = null;
         return;
     }

     this._mode = newMode;

     this.startMode(newMode);
 },

 _clearMode: function(mode) {
     if (!mode) return;

     if (mode === 'distance') {
         if (this._polyline) {
             this._polyline.setMap(null);
             delete this._polyline;
         }

         this._finishDistance();

         if (this._ms) {
             for (var i=0, ii=this._ms.length; i<ii; i++) {
                 this._ms[i].setMap(null);
             }

             delete this._ms;
         }
     } else if (mode === 'area') {
         if (this._polygon) {
             this._polygon.setMap(null);
             delete this._polygon;
         }

         this._finishArea();
     }
 }
});

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
	
	var distance = map.Polyline.getDistance();
	console.log("distance = " + distance);
	console.log("click");
    e.preventDefault();

    if (bicycleLayer.getMap()) {
        bicycleLayer.setMap(null);
    } else {
        bicycleLayer.setMap(map);
    }
});


var geojson;
console.log("geojson : "  + geojson);
$("#restore").on("click", function(e) {
    e.preventDefault();
	console.log("restore : " + JSON.stringify(geojson) );
    map.data.addGeoJson(geojson, true);
    bicycleLayer.setMap(null);
    /*  if (geojson) {
        geojson = null;
    }

    geojson = drawingManager.toGeoJson();
    console.log(geojson);
    console.log(JSON.stringify(geojson));  */
    //restoreMap.data.addGeoJson(geojson, true);
});

$("#getInfo").on("click", function(e) {
    e.preventDefault();
    
    var mapInfo = map.data.getMap();
    
    console.log("mapInfo = " + mapInfo);
    
    var latLng1 = new naver.maps.LatLng(126.8523527,37.5210131);
    var latLng2 = new naver.maps.LatLng(126.8505836,37.5220985);
    
    var distancer = new naver.maps.EPSG3857();
    
    var str = "";
	for(key in distancer) {
		console.log(key+"="+distancer[key]);
		//str += key+"="+obj[key]+"\n";
	}
	
    //console.log("distance = " + str);
});


var measures = new Measure({
    distance: $('#distance'),
    area: $('#area')
});

measures.setMap(map);

</script>

	
</body>
</html>