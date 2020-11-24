<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@include file="../../includes/mainMenu.jsp" %>

<!DOCTYPE html>
<!-- 다울 -->
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link rel="stylesheet" href="/resources/css/store.css">
</head>
<body>

	<div class="container">
	
		<div class="left">
			<div class="column">
				<h1 >${store.storeNm }</h1>
				<button type="button">하트</button>
				<br>
			</div>
			<div class="column">
				<h1>매장정보</h1>
				<c:if test="${store.telno!= null}">
					<p>전화번호 : ${store.telno }</p>
				</c:if>
				<c:if test="${store.nstore.bizTm!= null}">
					<p>영업시간 : ${store.nstore.bizTm }</p>
				</c:if>
				<c:if test="${store.nstore.menu!= null}">
					<p>메뉴 : ${store.nstore.menu }</p>
				</c:if>

			</div>
			<div class="column">
				<h1>평점</h1>
				<label>좋아요수:${store.eval.likeTotNum } </label>
			</div>
			<div class="column">
			<h1>지도</h1>
			<div id="map" style="width:100%;height:350px;"></div>
			</div>
		</div>

	</div>
	
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=0e7b9cd1679ce3dedf526e66a6c1a860&libraries=services,clusterer,drawing"></script>
	<script>
	var lat =${store.loc.lat};
	var lng =${store.loc.lng};
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = { 
        center: new kakao.maps.LatLng(lat, lng), // 지도의 중심좌표
        level: 5 // 지도의 확대 레벨
    };

	var map = new kakao.maps.Map(mapContainer, mapOption); // 지도 생성

	// 마커 표시 위치
	var markerPosition  = new kakao.maps.LatLng(lat, lng); 

	// 마커를생성
	var marker = new kakao.maps.Marker({
    position: markerPosition
	});

	// 마커 지도 위에 표시되도록 설정
	marker.setMap(map);


	</script>
	
</body>
</html>