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
<title>거리 표시하기</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?clientId=ZD0P2V80MJ57K5qoMKF8&submodules=panorama,geocoder,drawing,visualization"></script>

<style type="text/css">
    ul.measure-control { position:absolute;z-index:100;top:5px;right:10px;margin:0;padding:0; }
    ul.measure-control li { list-style:none;float:left;display:block;padding-right:5px; }
</style>

</head>
<body>

</body>
</html>