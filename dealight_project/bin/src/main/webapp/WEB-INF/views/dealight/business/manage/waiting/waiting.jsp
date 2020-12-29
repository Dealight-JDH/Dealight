<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>웨이팅 상세</title>
<!--  common  -->
<link rel="stylesheet" href="/resources/css/common.css" type ="text/css" />
<link rel="stylesheet" href="/resources/css/main_footer.css" type ="text/css" />
<link rel="stylesheet" href="/resources/css/main_header.css" type ="text/css" />
<link rel="stylesheet" href="/resources/css/alert_manager.css" type ="text/css" />
<link rel="shortcut icon" href="/resources/icon/favicon.png" type="image/x-icon">
<link rel="icon" href="/resources/icon/favicon.png" type="image/x-icon">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic&display=swap" rel="stylesheet">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@800&display=swap" rel="stylesheet">
<script src="https://kit.fontawesome.com/0f892675ba.js" crossorigin="anonymous"></script>
<!--  end common  -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=9a6bde461f2e377ce232962931b7d1ce"></script>
    <style>

        .wait_wrapper {
            width: 700px;
            margin: 100px auto;
            height: auto;
            /*border: black 1px solid;*/
            
            border-radius: 3px;
            box-shadow: 3px 3px 7px rgba(44, 36, 36, 0.342);
        }

        .wait_tit{
            /*border: 1px solid black;*/
            width: 100%;
            height: 15%;
            text-align: center;
            position: relative;
            display: flex;
            justify-content: center;
            flex-direction: column;
            align-items: center;
            background-color: black;
            border-radius: 3px 3px 0 0;
        }
        .wait_tit > .badge {
            
            padding: 5px 15px;
            background-color: rgba(106, 153, 255, 0.87);
            color: white;
            font-size: 24px;
            font-weight: bold;
            position: absolute;
            border-radius: 20px;
            left: 5px;
            top: -60px;
            
            box-shadow: 2px 2px 8px rgba(44, 36, 36, 0.342);
        }
        .wait_tit > span{
            color: white;
            line-height: 3.5em;
            font-size: 28px;
            font-weight: bold;
        }
        .wait_info{
            height: 250px;
            /*border: 1px solid black;*/
            width: 100%;
        }
        .wait_info_wrapper {
            display: grid;
            grid-template-rows: repeat(3,1fr);
            grid-template-columns: repeat(4,1fr);
            grid-template-areas: 
            ". store store .",
            ". id id .",
            ". pnum tm .",
            ". name telno ."
            ;
            /*border: 1px solid black;*/
            margin: 20px 30px;
            height: 250px;
            text-align: center;
        }
        #store_name {
            grid-column: 1/5;
            /*border: 1px solid black;*/
            font-weight: bold;
            font-size: 24px;
        }
        #wait_id_wrapper {
            grid-column: 2/4;
            /*border: 1px solid black;*/
            font-weight: bold;
            
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
        }
        .wait_id_tit{
            font-size: 18px;
            color: rgba(75, 75, 75, 0.431);
            
        }
        .wait_id_val{
            font-size: 36px;
        }
        
        #wait_pnum_wrapper{
            grid-column: 2/3;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            font-weight: bold;
            font-size: 24px;
            /*border: 1px solid black;*/
        }
        .wait_pnum_tit{
            font-size: 14px;
            color: rgba(75, 75, 75, 0.431);
            
        }
        #wait_tm_wrapper{
            grid-column: 3/4;
            /*border: 1px solid black;*/
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            font-weight: bold;
            font-size: 24px;
            /*border: 1px solid black;*/
        }
        .wait_tm_tit{
            font-size: 14px;
            color: rgba(75, 75, 75, 0.431);
            /*text-shadow: 3px 3px 7px rgba(44, 36, 36, 0.342);*/
        }
        #cust_name_wrapper{
            grid-column: 2/3;
            /*border: 1px solid black;*/
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            font-weight: bold;
            font-size: 24px;
            /*border: 1px solid black;*/
        }
        .cust_name_tit{
            font-size: 14px;
            color: rgba(75, 75, 75, 0.431);
        }
        #cust_telno_wrapper{
            grid-column: 3/4;
            /*border: 1px solid black;*/
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            font-weight: bold;
            font-size: 18px;
            /*border: 1px solid black;*/
        }
        .cust_telno_tit{
            font-size: 14px;
            color: rgba(75, 75, 75, 0.431);
        }
        .wait_order{
            position: relative;
            text-align: center;
            /*border: 1px solid black;*/
            width: 100%;
            height: 100px;
            display: flex;
            flex-direction: row;
            justify-content: flex-start;
            align-content: flex-start;
            background-color: rgba(167, 167, 167, 0.479);
        }
        #wait_time_wrapper{
            width: 50%;
            height: 100%;
            margin-left: auto;
            /*border: 1px solid black;*/
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            font-weight: bold;
            font-size: 14px;
        }
        .wait_time_tit{
            width: 100%;
            height: 30%;
            font-size: 14px;
            color:white;
            display: flex;
            flex-direction: column;
            justify-content: flex-start;
            align-items: center;
            /*text-shadow: 3px 3px 7px rgba(44, 36, 36, 0.342);*/
            margin-top: 3px;
        }
        .wait_time_val{
            width: 100%;
            height: 50%;
            display: flex;
            flex-direction: column;
            justify-content: flex-end;
            align-items: center;
            font-size: 36px;
            font-weight: bold;
            color: rgba(0, 0, 0, 0.897);
        }
        #cur_wait_pnum_wrapper{
            width: 50%;
            height: 100%;
            margin-left: auto;
            /*border: 1px solid black;*/
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            font-weight: bold;
            font-size: 14px;
        }
        .cur_wait_pnum_tit{
            width: 100%;
            height: 30%;
            font-size: 14px;
            color: white;
            display: flex;
            flex-direction: column;
            justify-content: flex-start;
            align-items: center;
            /*text-shadow: 3px 3px 7px rgba(44, 36, 36, 0.342);*/
            margin-top: 3px;
        }
        .cur_wait_pnum_val{
            width: 100%;
            height: 50%;
            display: flex;
            flex-direction: column;
            justify-content: flex-end;
            align-items: center;
            font-size: 36px;
            font-weight: bold;
        }
        .store_info{
            /*border: 1px solid black;*/
            width: 100%;
            height: 350px;
            text-align: center;
            align-items: center;
        }
        .store_info_wrapper{
            display: flex;
            flex-direction: row;
            justify-content: flex-start;
            align-items: center;
            height: 100px;
        }
        .store_info_wrapper > div{
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            /*border: 1px solid black;*/
            width: 50%;
            height: 100%;
            font-size: 24px;
            font-weight: bold;
        }
        #store_telno{
            /*border: 1px solid black;*/
        }
        #store_telno{
            /*border: 1px solid black;*/
        }
        #map{
            display: flex;
            justify-content: center;
            align-items: center;
            flex-direction: column;
            margin: 0 auto;
            margin-top: 25px;
        }
        #store_telno{
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            /*border: 1px solid black;*/
            width: 100%;
            height: auto;
            font-size: 24px;
            font-weight: bold;
        }
        #btn_reload{
            border-radius: 40px;
            padding: 3px 8px;
            position: absolute;
            left: 10px;
            top: 10px;
            cursor: pointer;
            font-size: 18px;
            font-weight: bold;
            color: rgba(0, 0, 0, 0.664);
            background-color: white;
            box-shadow: 2px 2px 8px rgba(44, 36, 36, 0.342);
        }
    </style>
</head>
<body>
<div class="wait_wrapper">
        <div class="wait_tit">
        <c:if test="${wait.waitStusCd eq 'W'}"><div class="badge">현재 웨이팅 중</div></c:if>
        <c:if test="${wait.waitStusCd eq 'E'}"><div class="badge" style="background-color: gray;">입장</div></c:if>
        <c:if test="${wait.waitStusCd eq 'P'}"><div class="badge" style="background-color: gray;">노쇼</div></c:if>
            <span>웨이팅 번호표</span>
        </div>
        <div class="wait_info">
            <div class="wait_info_wrapper">
                <div id="wait_id_wrapper">
                    <div class="wait_id_val">${wait.waitId}</div>
                    <div class="wait_id_tit">웨이팅 번호</div>
                </div>
                <div id="wait_pnum_wrapper">
                    <div class="wait_pnum_val">${wait.waitPnum}명</div>
                    <div class="wait_pnum_tit">웨이팅 인원</div>
                </div>
                <div id="wait_tm_wrapper">
                    <div class="wait_tm_val">${wait.waitRegTm}</div>
                    <div class="wait_tm_tit">웨이팅 등록 시간</div>
                </div>
                <div id="cust_name_wrapper">
                    <div class="cust_name_val">${wait.custNm}</div>
                    <div class="cust_name_tit">고객 이름</div>
                </div>
                <div id="cust_telno_wrapper">
                    <div class="cust_telno_val">${wait.custTelno}</div>
                    <div class="cust_telno_tit">전화번호</div>
                </div>
            </div>
        </div>
        <div class="wait_order">
            <span id="btn_reload"><i class="fas fa-redo-alt"></i></span>
            <div id="cur_wait_pnum_wrapper">
                <div class="cur_wait_pnum_val">${order}명</div>
                <div class="cur_wait_pnum_tit">현재 대기 고객</div>
            </div>
            <div id="wait_time_wrapper">
                <div class="wait_time_val">${waitTime}분</div>
                <div class="wait_time_tit">예상 대기 시간</div>
            </div>
        </div>
        <div class="store_info">
            <div class="store_info_wrapper">
                <div>${store.storeNm}</div>
                <div><img src='/display?fileName=${store.bstore.repImg}'></div>
            </div>
            <div id="store_telno">${store.telno}</div>
            <div id="map" style="width:500px;height:150px;"></div>
        </div>
    </div>
<script type="text/javascript">
let container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
let options = { //지도를 생성할 때 필요한 기본 옵션
	center: new kakao.maps.LatLng(${store.loc.lat}, ${store.loc.lng}), //지도의 중심좌표.
	level: 3 //지도의 레벨(확대, 축소 정도)
};

let map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴

var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
mapOption = { 
    center: new kakao.maps.LatLng(${store.loc.lat}, ${store.loc.lng}), // 지도의 중심좌표
    level: 3 // 지도의 확대 레벨
};


//마커가 표시될 위치입니다 
var markerPosition  = new kakao.maps.LatLng(${store.loc.lat}, ${store.loc.lng}); 

//마커를 생성합니다
var marker = new kakao.maps.Marker({
position: markerPosition
});

//마커가 지도 위에 표시되도록 설정합니다
marker.setMap(map);

//아래 코드는 지도 위의 마커를 제거하는 코드입니다
//marker.setMap(null); 
$("#btn_reload").on("click",()=>{location.reload();})
</script>
</body>
</html>