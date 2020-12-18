<!-- 동인 추가 -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@include file="../../../../includes/mainMenu.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>매장 수정</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=9a6bde461f2e377ce232962931b7d1ce"></script>
<script src="/resources/js/Rater.js"></script>
<style>
	.file_body img {
	
	width : 100px;
	height : 100px;
	
	}
	main{
		margin : 30px auto;
		width:1050px;
	}
	.selected_img{
		border : 4px red solid;
	}
</style>
</head>
<body>
<main>
	<h1>Business Modify Page</h1>
	
	${msg}
	
	<form id="modifyForm" action="/dealight/business/manage/modify" method="post">
	
		<input name="storeId" value="${store.storeId}" hidden>
		<input name="clsCd" value="${store.clsCd}" hidden>
		<input name="brch" value="${store.brch}" hidden }>
		<input name="repMenu" value="${store.repMenu}" hidden }>
		
	
		<label id="storeNm">매장명</label>
		<input name="storeNm" value="${store.storeNm}" readonly></br>
		
		<label id="telno">전화번호</label>
		<input name="telno" value="${store.telno}" required></br>
		
		<label id="openTm">시작시간</label>
		<input name="openTm" value="${store.openTm}" required></br>
		
		<label id="closeTm">마감시간</label>
		<input name="closeTm" value="${store.closeTm}" required></br>
		
		<label id="buserId">사업자 회원 아이디</label>
		<input name="buserId" value="${store.buserId}" readonly></br>
		
		<label id="breakSttm">브레이크타임시작시간</label>
		<input name="breakSttm" value="${store.breakSttm}"></br>
		
		<label id="breakEntm">브레이크타임마감시간</label>
		<input name="breakEntm" value="${store.breakEntm}"></br>
		
		<label id="lastOrdTm">라스트오더 시간</label>
		<input name="lastOrdTm" value="${store.lastOrdTm}"></br>
		
		<label id="n1SeatNo">1인 테이블 개수</label>
		<input name="n1SeatNo" value="${store.n1SeatNo}" ></br>
		
		<label id="n2SeatNo">2인 테이블 개수</label>
		<input name="n2SeatNo" value="${store.n2SeatNo}"></br>
		
		<label id="n4SeatNo">4인 테이블 개수</label>
		<input name="n4SeatNo" value="${store.n4SeatNo}"></br>
		
		<label id="storeIntro">매장소개</label>
		<input name="storeIntro" value="${store.storeIntro}" required></br>
		
		<label id="avgMealTm">매장평균식사시간</label>
		<input name="avgMealTm" value="${store.avgMealTm}" readonly></br>
		
		<label id="hldy">매장휴무일</label>
		<input name="hldy" value="${store.hldy}"></br>
		
		<label id="acmPnum">매장수용인원</label>
		<input name="acmPnum" value="${store.acmPnum}"></br>
		
		<button id="btnSubmit" type="submit">제출하기</button>
		
		<input name="addr" value="${store.addr }" hidden>
		<input name="lat" value="${store.lat}" hidden>
		<input name="lng" value="${store.lng}" hidden>
		<input name="avgRating" value="${store.avgRating }" hidden>
		<input name="revwTotNum" value="${store.revwTotNum }" hidden>
		<input name="likeTotNum" value="${store.likeTotNum }" hidden>
		<input name="seatStusCd" value="${store.seatStusCd }" hidden>
		
</br>
======================================
	<div id="map" style="width:200px;height:200px;"></div>
	
	매장 주소 : ${store.addr } </br>
	매장 위도 : ${store.lat}</br>
	매장 경도 : ${store.lng}</br>
	
	평균 평점 : ${store.avgRating }</br>
	<div class='rating' data-rate-value='${store.avgRating }'></div>
	리뷰 수 : ${store.revwTotNum }</br>
	좋아요 합계 : ${store.likeTotNum }</br>
=====================================		
		
	<c:if test="${not empty menuList}">
	<c:forEach items="${menuList}" var="menu">
	<input name="menuSeq" value="${menu.menuSeq}" hidden>
		<input name="price" value="${menu.price }" hidden>
		<input name="imgUrl" value="${menu.imgUrl}" hidden>
		<input name="name" value="${menu.name }" hidden>
		<input name="recoMenu" value="${menu.recoMenu }" hidden>
	</c:forEach>
	</c:if>
	<c:if test="${not empty tagList}">
	<h2>태그 리스트</h2>
	<c:forEach items="${tagList}" var="tag">
	=====================================</br>
	해시 태그 이름 : ${tag.tagNm }</br>
	</c:forEach>
	</c:if>
	
	<h2>사진 리스트</h2>
	<c:if test="${not empty imgs}">
	<c:forEach items="${imgs}" var="img">
	=====================================</br>
	사진 일련번호 : ${img.imgSeq }</br>
	uuid : ${img.uuid }</br>
	매장 사진 주소 : ${img.uploadPath }</br>
	파일 이미지 여부 : ${img.image }</br>
	파일 이름 : ${img.fileName }</br>
	</c:forEach>
	=====================================</br>
	</c:if>
	
	<div class=""><h2>사진 첨부하기</h2></div>
	<div class="file_body">
		<div class="form_img">
			<input type="file" name='uploadFile' multiple>
		</div> 
		<div class='uploadResult'>
			<ul>
			</ul>
		</div> <!-- uploadResult -->
	</div> 
		<div class='bigPictureWrapper'>
			<div class='bigPicture'>
			</div>
		</div>
	</form>
	
	<h2>리뷰 리스트</h2>
	<c:if test="${not empty revwList}">
	<c:forEach items="${revwList}" var="revw">
	=====================================</br>
	<div>
		<h2>리뷰</h2>
		<h5>리뷰 번호 : <input name="revwId" value="${revw.revwId }" readonly></h5>
		<h5>예약 번호 : <input name="rsvdId" value="${revw.rsvdId }" readonly></h5>
		<h5>웨이팅 번호 : <input name="waitId" value="${revw.waitId }" readonly></h5>
		<h5>회원 아이디 : <input name="userId" value="${revw.userId }" readonly></h5>
		<h5>리뷰 내용 : <input name="cnts" value="${revw.cnts }" readonly></h5>
		<h5>평점 : <input name="rating" value="${revw.rating }" readonly></h5>
		<div class='rating' data-rate-value='${revw.rating }'></div>
		<h5>답글 내용 : <input name="replyCnts" value="${revw.replyCnts }"></h5>
		<h5>답글 등록 날짜 : <input name="replyRegDt" value="${revw.replyRegDt }"></h5>
		<button class="btn_reg_reply">답글 달기</button>
	</div>
	</c:forEach>
	</c:if>
	
	<h2>메뉴 리스트</h2>
	<c:if test="${not empty menuList}">
	<c:forEach items="${menuList}" var="menu">
	=====================================</br>
	메뉴 일련번호 : ${menu.menuSeq}</br>
	메뉴 가격 : ${menu.price }</br>
	메뉴사진주소 : ${menu.imgUrl}</br>
	메뉴이름 : ${menu.name }</br>
	메뉴추천여부 : ${menu.recoMenu }</br>
	<c:if test="${menu.imgUrl != null}"><img src="/display?fileName=${menu.encThumImgUrl}"></c:if></br>
	</c:forEach>
	</c:if>
	
	<h2><a href="/dealight/business/manage/menu?storeId=${store.storeId}" }>메뉴수정</a></h2>
</main>
<script>
    /* form 역할을 하는 엘리먼트를 선택한다. */
	const formObj = $("#modifyForm");
    /* 정규식으로 파일 형식을 제한한다. */
    const regex = new RegExp("(.*>)\.(exe|sh|zip|alz)$");
    /*최대 파일 크기를 제어한다  */
	const maxSize = 5242880; /* 5MB */
	// add category ***페이지마다 변경 필요
	const category = 'storeImgs';
	// page type
	const pageType = "modify";
	// storeId
	const storeId = ${store.storeId};
	// btn id
	const btnSubmit = "#btnSubmit";
	// isModal
	const isModal = false;
</script>
<script type="text/javascript" src="/resources/js/reg_file.js?ver=1"></script>
<script type="text/javascript">
let container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
let options = { //지도를 생성할 때 필요한 기본 옵션
	center: new kakao.maps.LatLng(${store.lat}, ${store.lng}), //지도의 중심좌표.
	level: 3 //지도의 레벨(확대, 축소 정도)
};

let map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴

var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
mapOption = { 
    center: new kakao.maps.LatLng(${store.lat}, ${store.lng}), // 지도의 중심좌표
    level: 3 // 지도의 확대 레벨
};


//마커가 표시될 위치입니다 
var markerPosition  = new kakao.maps.LatLng(${store.lat}, ${store.lng}); 

//마커를 생성합니다
var marker = new kakao.maps.Marker({
position: markerPosition
});

//마커가 지도 위에 표시되도록 설정합니다
marker.setMap(map);

//아래 코드는 지도 위의 마커를 제거하는 코드입니다
//marker.setMap(null);    

let getRevw = function (params,callback,error) {
	
	let revwId = params.revwId;
	console.log("getRevw....................." + revwId);
	
	$.getJSON("/dealight/business/manage/review/"+revwId+".json",
    		function(data) {
    			if(callback) {
    				callback(data);
    			}
    	}).fail(function(xhr,status,err){
    		if(error) {
    			error();
    		}
    	});
};

let regReply = function (params,callback,error){
	
	let replyCnts = params.replyCnts,
		revwId = params.revwId;
	
	console.log("reg reply....................." + revwId);
	
	$.ajax({
	    type:'put',
	    url:'/dealight/business/manage/review/reply',
	    data : JSON.stringify({replyCnts:replyCnts,revwId : revwId}),
	    contentType : "application/json",
	    success : function(result, status, xhr) {
	        if(callback) {
	            callback(result);
	        }
	    },
	    error : function(xhr, status, er) {
	        if(error) {
	            error(er);
	        }               
	    }
	});
};

let regReplyHandler = function (e) {
	
	console.log("reg reply.....................");
	
	e.preventDefault();
	
	let inputRevwId = $(e.target).parent().find("input[name='revwId']"),
		inputReplyCnts = $(e.target).parent().find("input[name='replyCnts']"),
		inputReplyRegDt = $(e.target).parent().find("input[name='replyRegDt']")
		;
		
	let revwId = inputRevwId.val(),
		replyCnts = inputReplyCnts.val();
	
	console.log("revwId : " +revwId +", replyCnts : " + replyCnts);
	
	regReply({revwId:revwId,replyCnts:replyCnts}, () => {
		
				getRevw({revwId:revwId}, revw => {
		
					console.log("revw.replyCnts : " + revw.replyCnts);
					console.log("revw.replyRegDate : " + revw.replyRegDt);
					
					inputReplyCnts.val(revw.replyCnts);
					inputReplyRegDt.val(revw.replyRegDt);
					console.log("reg reply complete");
		
				});
		});
	
};

	$(".btn_reg_reply").on("click",regReplyHandler);
	
	/* Rater.js 로직*/
    $(".rating").rate({
        max_value: 5,
        step_size: 0.5,
        initial_value: 3,
        selected_symbol_type: 'utf8_star', // Must be a key from symbols
        cursor: 'default',
        readonly: true,
    });

</script>
<%@include file="../../../../includes/mainFooter.jsp" %>
</body>
</html>