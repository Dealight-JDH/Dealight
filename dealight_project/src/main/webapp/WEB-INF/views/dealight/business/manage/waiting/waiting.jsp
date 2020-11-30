<!-- 동인 추가 -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>웨이팅 상세</title>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=9a6bde461f2e377ce232962931b7d1ce"></script>
</head>
<body>
<h1>Business Waiting Page</h1>
===========================================
<h5>웨이팅 번호 : ${wait.waitId}</h5>
<h5>매장 번호 : ${wait.storeId}</h5>
<h5>회원 아이디 : ${wait.userId}</h5>
<h5>웨이팅 접수시간 : ${wait.waitRegTm}</h5>
<h5>웨이팅 인원 : ${wait.waitPnum}</h5>
<h5>웨이팅 고객 연락처 : ${wait.custTelno}</h5>
<h5>웨이팅 고객 이름 : ${wait.custNm}</h5>
<h5>웨이팅 상태 : ${wait.waitStusCd}</h5>
===========================================
<h2>현재 대기 순서 : ${order}번째</h2>
<h2>현재 예상 대기 시간 : ${waitTime}분</h2>
===========================================
<h2>매장 정보</h2>
매장명 : ${store.storeNm}</br>
매장 전화번호 : ${store.telno}
<h2>매장 위치</h2>
<div id="map" style="width:500px;height:400px;"></div>
<script type="text/javascript">
let container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
let options = { //지도를 생성할 때 필요한 기본 옵션
	center: new kakao.maps.LatLng(${loc.lat}, ${loc.lng}), //지도의 중심좌표.
	level: 3 //지도의 레벨(확대, 축소 정도)
};

let map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴

var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
mapOption = { 
    center: new kakao.maps.LatLng(${loc.lat}, ${loc.lng}), // 지도의 중심좌표
    level: 3 // 지도의 확대 레벨
};


//마커가 표시될 위치입니다 
var markerPosition  = new kakao.maps.LatLng(${loc.lat}, ${loc.lng}); 

//마커를 생성합니다
var marker = new kakao.maps.Marker({
position: markerPosition
});

//마커가 지도 위에 표시되도록 설정합니다
marker.setMap(map);

//아래 코드는 지도 위의 마커를 제거하는 코드입니다
//marker.setMap(null);    
</script>
</body>
</html>