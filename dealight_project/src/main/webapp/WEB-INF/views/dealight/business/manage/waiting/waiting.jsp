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
    <style>
        main {
            width: 1050px;
            margin: 100px auto;
            height: auto;
            border: black 1px solid;
        }

        .wait_tit{
            border: 1px solid black;
            width: 100%;
            height: 150px;
            text-align: center;
        }
        .wait_tit > span{
            top: 50px;
            line-height: 3.5em;
            font-size: 40px;
            font-weight: bold;
        }
        .wait_info{
            height: 400px;
            border: 1px solid black;
            width: 100%;
        }
        .wait_info_wrapper {
            display: grid;
            grid-template-rows: repeat(4,1fr);
            grid-template-columns: repeat(4,1fr);
            grid-template-areas: 
            ". store store .",
            ". id id .",
            ". pnum tm .",
            ". name telno ."
            ;
            border: 1px black solid;
            margin: 30px 30px;
            height: 300px;
            text-align: center;
        }
        #store_name {
            grid-column: 1/5;
            border: 1px black solid;
            font-weight: bold;
            font-size: 24px;
            margin-top: 40px;
        }
        #wait_id {
            grid-column: 2/4;
            border: 1px black solid;
            font-weight: bold;
            font-size: 46px;
        }
        #wait_pnum{
            grid-column: 2/3;
            display: inline-block;
            border: 1px black solid;
            
        }
        #wait_tm {
            grid-column: 3/4;
            border: 1px black solid;
            display: inline-block;
        }
        #cust_name{
            grid-column: 2/3;
            border: 1px black solid;
            display: inline-block;
        }
        #cust_telno{
            grid-column: 3/4;
            border: 1px black solid;
            display: inline-block;
        }
        .wait_order{
            text-align: center;
            border: 1px solid black;
            width: 100%;
            height: 150px;
            display: flex;
            flex-direction: row;
            flex-wrap: wrap;
            justify-content: space-around;
            align-content: center;
        }
        #wait_time{
            line-height: 6em;
            float: left;
            width: 30%;
            height: 100px;
            margin-left: auto;
            border: 1px solid black;
            order: 0;
            flex-grow: 1;
        }
        #cur_wait_pnum{
            line-height: 6em;
            float : right;
            margin-right: auto;
            width: 30%;
            height: 100px;
            border: 1px solid black;
            order: 1;
            flex-grow: 1;
            align-items: center;
        }

        .store_info{
            border: 1px solid black;
            width: 100%;
            height: 400px;
            text-align: center;
            align-items: center;
        }
        #store_telno{
            border: 1px solid black;
        }
        #store_telno{
            border: 1px solid black;
        }
        #map{
            margin: 0 auto;
        }
    </style>
</head>
<body>
    <main>
        <div class="wait_tit"><span>웨이팅 번호표</span></div>
        <div class="wait_info">
            <div class="wait_info_wrapper">
                <div id="store_name">매장 이름 : 버거킹</div>
                <div id="wait_id">웨이팅 번호 : ${wait.waitId}</div>
                <div id="wait_pnum">웨이팅 인원 : ${wait.waitPnum}명</div>
                <div id="wait_tm">웨이팅 접수 시간 : ${wait.waitRegTm}</div>
                <div id="cust_name">웨이팅 고객 이름 : 김동인</div>
                <div id="cust_telno">웨이팅 고객 연락처 : ${wait.custTelno}</div>
                <div>웨이팅 상태 : ${wait.waitStusCd}</div>
            </div>
        </div>
        <div class="wait_order">
            <div id="cur_wait_pnum">현재 대기 고객 : ${order}명</div>
            <div id="wait_time">예상 대기 시간 : ${waitTime}분</div>
        </div>
        <div class="store_info">
            <h2>매장 정보</h2>
            <div>매장 이름 : ${store.storeNm}</div>
            <div id="store_telno">매장 전화번호 : ${store.telno}</div>
            <div id="store_loc">매장 위치</div>
            <div id="map" style="width:500px;height:200px; border: black 1px solid;"></div>
        </div>
    </main>

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