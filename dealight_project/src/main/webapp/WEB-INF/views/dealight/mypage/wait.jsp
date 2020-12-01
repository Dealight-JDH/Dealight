<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../../includes/mainMenu.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>웨이팅 내역</title>
<link rel="stylesheet" href="/resources/css/mypage.css?ver=1" type ="text/css" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=9a6bde461f2e377ce232962931b7d1ce"></script>
<style>
	/* The Modal (background) */
        .modal {
        display: none; /* Hidden by default */
        position: fixed; /* Stay in place */
        z-index: 1; /* Sit on top */
        left: 0;
        top: 0;
        width: 100%; /* Full width */
        height: 100%; /* Full height */
        overflow: auto; /* Enable scroll if needed */
        background-color: rgb(0,0,0); /* Fallback color */
        background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
        }

        /* Modal Content/Box */
        .modal-content {
        background-color: #fefefe;
        margin: 15% auto; /* 15% from the top and centered */
        padding: 20px;
        border: 1px solid #888;
        width: 80%; /* Could be more or less, depending on screen size */
        }

        /* The Close Button */
        .close {
        color: #aaa;
        float: right;
        font-size: 28px;
        font-weight: bold;
        }

        .close:hover,
        .close:focus {
        color: black;
        text-decoration: none;
        cursor: pointer;
        }
        
        /* The Delete Button*/
        .btn_delete {
        color: #aaa;
        float: right;
        font-size: 28px;
        font-weight: bold;
        }

        .btn_delete:hover,
        .btn_delete:focus {
        color: black;
        text-decoration: none;
        cursor: pointer;
        }
</style>
</head>
<body>
    <main class="mypage_wrapper">
        <div class="mypage_menu_nav">
            <h2 class="tit_nav">마이 페이지</h2>
            <div class="inner_nav">
                <ul class="menu_list">
                    <li><a href="/dealight/mypage/reservation">예약 내역</a></li>
                    <li><a href="/dealight/mypage/wait">웨이팅 내역</a></li>
                    <li><a href="/dealight/mypage/myreview">나의 리뷰</a></li>
                    <li><a href="/dealight/mypage/like">찜 목록</a></li>
                    <li><a href="/dealight/mypage/modify">회원 정보 수정</a></li>
                </ul>
            </div>
        </div>
        <div class="mypage_content">
            <div class="content_head">
                <h2>웨이팅 내역<span>웨이팅 내역을 가져옵니다.</span></h2>
            </div>
            <div>
                	<h2>회원 아이디 : ${userId }</h2>
					<h2>현재 웨이팅 횟수 : ${curWaitCnt}회</h2>
					<h2>총 노쇼 횟수 : ${panaltyCnt}회</h2>
					<h2>총 웨이팅 횟수 : ${enterCnt}회</h2>
					<h2>총 웨이팅 횟수 : ${total}회</h2>
            </div>
            <div class="content_main">
				<div id="waitWrapper">
					<c:if test="${empty waitList}">
						<h2>웨이팅 이력이 없습니다.</h2>
					</c:if>
					
					<c:if test="${not empty waitList}">
					<h2>웨이팅 리스트</h2>
						<c:forEach items="${waitList}" var="wait">
							<div>
								====================================
								<h3>웨이팅 번호 : ${wait.waitId}</h3>
								<h5>매장번호 : <span class="store_id">${wait.storeId}</span></h5></br>
								날짜 : ${wait.waitRegTm } </br>
								인원 : ${wait.waitPnum }</br>
								이용자 전화번호 : ${wait.custTelno }</br>
								이용자 이름 : ${wait.custNm }</br>
								현재 웨이팅 상태 : ${wait.waitStusCd}<br>
								<button class="btn_store_info">매장 정보 보기</button>
								<button class="btn_revw_reg">리뷰 쓰기</button>
							</div>
						</c:forEach>
					</c:if>
				</div>
            </div>
            <!-- pagination -->
			<div class='pull-right'>
				<ul class='pagination'>
			
					<c:if test="${pageMaker.prev}">
						<li class='paginate_button previous'>
							<a href="${pageMaker.startPage - 1}">Previous</a>
						</li>
					</c:if>
					
					<c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
						<li class="paginate_button ${pageMaker.cri.pageNum == num ? "active" : ""}">
							<a href="${num}">${num}</a>
						</li>
					</c:forEach>
					
					<c:if test="${pageMaker.next}">
						<li class='paginate_button next'>
							<a href="${pageMaker.endPage + 1}">Next</a>
						</li>
					</c:if>
				</ul>
			</div>
			<form id='actionForm' action="/dealight/mypage/wait" method='get'>
				<input type='hidden' name='pageNum' value='${pageMaker.cri.pageNum}'>
				<input type='hidden' name='amount' value = '${pageMaker.cri.amount}'>
			</form>
			<!-- end pagination -->
        </div>
    </main>
    
    <div id="myModal" class="modal">
		<!-- Modal content -->
		<div class="modal-content">
			<span class="close">&times;</span>
			<ul class="revw_regForm"></ul>
			<ul class="store_info"></ul>
			<div id="map" style="width:500px;height:400px;"></div>
		</div>
	</div>

<script type="text/javascript">
$(document).ready(function() {
	
	// 모달 선택
	const modal = $("#myModal"),
		close = $(".close"),
		modalContent = $(".modal-content"),
		btn_show_board = $("#btn_show_board");

	close.on("click", (e) => {
		modal.css("display","none");
		modal.find("ul").html("");
		modal.find("#map").html("");
		modal.find("#map").css("display", "none");
	});
	
	modal.find("#map").css("display", "none");
	
	/*
	 모달이 아닌 화면을 클릭하면 모달이 종료가 되어야 하는데 그렇지 않음.
	*/
	window.onclick = function(event) {
		  if (event.target == modal) {
			  modal.css("display","none");
			  modal.find("ul").html("");
		  }
	};
	
    const userId = '${userId}',
	    revwRegFormUL = $(".revw_regForm"),
	    storeInfoUL = $(".store_info")
	;
	    
	let container,options,map,mapContainer,mapOption,markerPosition,marker;
	
	let actionForm = $("#actionForm");
	
	$(".paginate_button a").on("click", function(e) {
		
		e.preventDefault();
		
		console.log("page click");
		
		actionForm.find("input[name='pageNum']").val($(this).attr("href"));
		actionForm.submit();
	});
	
    function getStoreInfo(param,callback,error){
       	
       	
       	let storeId = param.storeId;
       	
       	
       	$.getJSON("/dealight/mypage/reservation/store/"+ storeId +".json",
                   function(data){
                       if(callback){
                           callback(data);
                       }
                   }).fail(function(xhr,status,err){
                       if(error){
                           error();
                       }
           });
       };
       
       
       /* 출력 로직*/
       
       function showStoreInfo(storeId) {
       	
       	getStoreInfo({storeId : storeId}, store=>{
       		
       		let strStoreInfo = "";
       		if(!store)
       			return;
       		
       		strStoreInfo += "<h1>매장 정보</h1>";
       		strStoreInfo += "<img src='/display?fileName="+store.bstore.repImg+"'>";
       		strStoreInfo += "<li>매장 번호 : "+store.storeId+"</l1>";
       		strStoreInfo += "<li>매장 이름 : "+store.storeNm+"</l1>";
       		strStoreInfo += "<li>매장 번호 : "+store.telno+"</l1>";
       		strStoreInfo += "<li>매장 상태 : "+store.clsCd+"</l1>";
       		strStoreInfo += "<li>매장 관리자 아이디 : "+store.bstore.buserId+"</l1>";
       		strStoreInfo += "<li>매장 분점 : "+store.bstore.brch+"</l1>";
       		strStoreInfo += "<li>매장 대표 메뉴 : "+store.bstore.repMenu+"</l1>";
       		strStoreInfo += "<li>매장 착석 상태 : "+store.bstore.seatStusCd+"</l1>";
       		strStoreInfo += "<li>매장 영업 시작 시간 : "+store.bstore.openTm+"</l1>";
       		strStoreInfo += "<li>매장 영업 마감 시간 : "+store.bstore.closeTm+"</l1>";
       		strStoreInfo += "<li>매장 브레이크타임 시작 시간 : "+store.bstore.breakSttm+"</l1>";
       		strStoreInfo += "<li>매장 브레이크타임 종료 시간 : "+store.bstore.breakEntm+"</l1>";
       		strStoreInfo += "<li>매장 라스트오더 시간 : "+store.bstore.lastOrdTm+"</l1>";
       		strStoreInfo += "<li>매장 1인 테이블 수 : "+store.bstore.n1SeatNo+"</l1>";
       		strStoreInfo += "<li>매장 2인 테이블 수 : "+store.bstore.n2SeatNo+"</l1>";
       		strStoreInfo += "<li>매장 4인 테이블 수 : "+store.bstore.n4SeatNo+"</l1>";
       		strStoreInfo += "<li>매장 소개 : "+store.bstore.storeIntro+"</l1>";
       		strStoreInfo += "<li>매장 평균 식사 시간 : "+store.bstore.avgMealTm+"</l1>";
       		strStoreInfo += "<li>매장 휴무일 : "+store.bstore.hldy+"</l1>";
       		strStoreInfo += "<li>매장 수용 가능 인원 : "+store.bstore.acmPnum+"</l1>";
       		strStoreInfo += "<li>매장 주소 : "+store.loc.addr+"</l1>";
       		
       		modal.find("#map").css("display", "block");
       		
       		container = document.getElementById('map');
       		options = {
       					center : new kakao.maps.LatLng(store.loc.lat, store.loc.lng),
       					level : 3
       				};
       		map = new kakao.maps.Map(container, options);
       		mapContainer = document.getElementById('map'), // 지도를 표시할 div 
       		mapOption = { 
       		    center: new kakao.maps.LatLng(store.loc.lat, store.loc.lng), // 지도의 중심좌표
       		    level: 3 // 지도의 확대 레벨
       		};
       		markerPosition  = new kakao.maps.LatLng(store.loc.lat, store.loc.lng);
       		marker = new kakao.maps.Marker({
       			position: markerPosition
       		});
       		marker.setMap(map);
       		
       		storeInfoUL.html(strStoreInfo);
       		
       	});
       	
       }
       
       /* 리뷰 등록 폼을 보여준다.*/
       function showRevwRegForm(storeId){
       	
       	let today = new Date();
       	let strRevwRegForm = "";
       	strRevwRegForm += "<h1>리뷰 작성</h1>";
       	strRevwRegForm += "<form id='revwRegForm' action='/dealight/mypage/review' method='post'>";
       	strRevwRegForm += "매장 번호 : <input name='storeId' id='' readonly></br>";
       	strRevwRegForm += "매장 이름 : <input name='storeNm' id=''></br>";
       	strRevwRegForm += "예약 번호 : <input name='rsvdId' id=''></br>";
       	strRevwRegForm += "웨이팅 번호 : <input name='waitId' id=''></br>";
       	strRevwRegForm += "회원 아이디 : <input name='userId' id='' readonly></br>";
       	strRevwRegForm += "리뷰 내용 : <input type='' name='storeId' id=''></br>";
       	strRevwRegForm += "평점 : <input type='rating' name='storeId' id='' readonly></br>";
       	strRevwRegForm += "답글내용 : <input type='textarea' name='replyCnts' id='' readonly></br>";
       	strRevwRegForm += "답글날짜 : <input type='text'  name='replyRegDt' id='' readonly></br>";
       	strRevwRegForm += "파일첨부 : <input type='file' name='storeId' id=''></br>";
       	strRevwRegForm += "<button id='submit_revwRegForm' type='submit'>제출하기</button>";
       	strRevwRegForm += "</form>";
       	strRevwRegForm += "<h2>현재 시간</h2>";
       	strRevwRegForm += "<h2>"+today+"</h2>";
       	
       	revwRegFormUL.html(strRevwRegForm);
       };
       
       /* 리뷰 등록 */
       $(".btn_revw_reg").on("click", e => {
       	
       	let storeId = $(e.target).parent().find(".store_id").text()
       	
       	modal.css("display","block");
       	showRevwRegForm(storeId);
       	
       	//$("#waitRegForm").submit();        		
       	
       });
       
       /* 매장 상세 */
       $(".btn_store_info").on("click", e => {
       	
       	let storeId = $(e.target).parent().find(".store_id").text()
       	
       	modal.css("display","block");
       	showStoreInfo(storeId);
       	
       	//$("#waitRegForm").submit();        		
       	
       });
	
}); /* document ready end*/

</script>
</body>
</html>