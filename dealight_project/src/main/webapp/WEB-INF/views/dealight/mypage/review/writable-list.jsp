<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 수빈 -->
<%@ include file="../../../includes/mainMenu.jsp" %>
	
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script src="https://use.fontawesome.com/releases/v5.2.0/js/all.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
	
<link rel="stylesheet" href="/resources/css/mypage.css?ver=1" type ="text/css" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=9a6bde461f2e377ce232962931b7d1ce"></script>
</head>

<body>
<main class="mypage_wrapper">
        <%@include file="/WEB-INF/views/includes/mypageSidebar.jsp" %>
        <div class="mypage_content">
            <div class="content_head">
                <h2>리뷰 가능 리스트<span>리뷰가 가능한 예약과 웨이팅을 불러옵니다.</span></h2>
                <a href="/dealight/mypage/review/written-list">작성한 리뷰 보기</a>
            </div>
            <div class='total'>
            		<h2>유저 아이디 : ${userId}</h2>
					<h2>리뷰 가능한 리스트</h2>
            </div>
            <div class="content_main">
				<div id="revwWrapper">
					<div class="revw_list">
						<c:if test="${empty dtoList}">
							리뷰 가능한 항목이 없습니다.
						</c:if>
						
						<c:if test="${not empty dtoList}">
							<c:forEach items="${dtoList }" var="dto">
							<div>
							==================================================
								<h5>매장번호 : <span class="store_id">${dto.storeId}</span></h5>
								<h5>회원 아이디 : ${dto.userId}</h5>
								<h5>시간 : <h2>${dto.time}</h2></h5>
								<h5>리뷰 상태 : ${dto.revwStus}</h5>
								<c:if test="${not empty dto.rsvd }">
									<h2>예약</h2>
									<h5>예약 번호 : <span class='rsvd_id'>${dto.rsvd.rsvdId}</span></h5>
									<h5>핫딜 번호 : ${dto.rsvd.htdlId}</h5>
									<h5>승인 번호 : ${dto.rsvd.aprvNo}</h5>
									<h5>예약 인원 : ${dto.rsvd.pnum}</h5>
									<h5>예약 상태 : ${dto.rsvd.stusCd}</h5>
									<h5>예약 총 금액 : ${dto.rsvd.totAmt}</h5>
									<h5>예약 총 수량 : ${dto.rsvd.totQty}</h5>
									<button class="btn_rsvd_dtls">예약 상세 보기</button>
								</c:if>
								<c:if test="${not empty dto.wait }">
									<h2>웨이팅</h2>
									<h5>웨이팅 번호: <span class='wait_id'>${dto.wait.waitId}</span></h5>
									<h5>웨이팅 인원: ${dto.wait.waitPnum}</h5>
									<h5>손님 이름: ${dto.wait.custNm}</h5>
									<h5>손님 번호: ${dto.wait.custTelno}</h5>
									<h5>웨이팅 상태: ${dto.wait.waitStusCd}</h5>
								</c:if>
								<button class="btn_store_info">매장 정보 보기</button>
								<button class="btn_revw_reg">리뷰 쓰기</button></br>
								</div>
							</c:forEach>
						</c:if>
					</div>
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
			<form id='actionForm' action="/dealight/mypage/review/" method='get'>
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
			<ul class="rsvdDtls"></ul>
			<ul class="userRsvdList"></ul>
			<ul class="revw_regForm"></ul>
			<ul class="store_info"></ul>
			<div id="map" style="width:500px;height:400px;"></div>
		</div>
	</div>
		
	
	</div>
<script type="text/javascript" src="/resources/js/modal.js"></script>
<script>
	/* 정규식으로 파일 형식을 제한한다. */
	const regex = new RegExp("(.*>)\.(exe|sh|zip|alz)$");
	/*최대 파일 크기를 제어한다  */
	const maxSize = 5242880; /* 5MB */
	// add category ***페이지마다 변경 필요
	const category = 'revwImgs';
	// page type
	const pageType = "register";
	// storeId
	const storeId = null;
	// isModal
	const isModal = true;
	// btn id
	let btnSubmit = "#submit_revwRegForm";
	/* form 역할을 하는 엘리먼트를 선택한다. */
	let formObj = $("#revwRegForm");
</script>
<script type="text/javascript" src="/resources/js/reg_file.js?ver=1"></script>
<script type="text/javascript">
$(document).ready(function() {
	
    const userId = '${userId}',
	    revwRegFormUL = $(".revw_regForm"),
	    storeInfoUL = $(".store_info"),
	    userRsvdListUL = $(".userRsvdList"),
	    rsvdDtlsUL = $(".rsvdDtls"),
	    btn_show_board = $("#btn_show_board")
	;
	    
	let container,options,map,mapContainer,mapOption,markerPosition,marker;
	
	let actionForm = $("#actionForm");
	
	$(".paginate_button a").on("click", function(e) {
		
		e.preventDefault();
		
		console.log("page click");
		
		actionForm.find("input[name='pageNum']").val($(this).attr("href"));
		actionForm.submit();
	});
	
    /*get 함수*/
	// 예약의 '예약상세'를 가져온다.
    function getRsvdDtls(param,callback,error) {
    	
    	let rsvdId = param.rsvdId;
    	
    	$.getJSON("/dealight/business/manage/board/reservation/dtls/" + rsvdId + ".json",
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
    
 // 사용자의 '해당 매장'의 '예약 리스트'를 가져온다.
	function getUserRsvdList(param,callback,error) {
      	
      	let storeId = param.storeId,
      		userId = param.userId;
      	
      	$.getJSON("/dealight/business/manage/board/reservation/list/" + storeId +"/" + userId + ".json",
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
       	
       };
       
       /*
   	유저의 예약 히스토리를 보여준다.

   	*/
   	function showUserRsvdList(storeId,userId,selRsvdId){
   		
   		getUserRsvdList({storeId:storeId,userId:userId}, function(userRsvdList){
   			
   			let strUserRsvdList = "";
   			if(!userRsvdList)
   				return;
   			
   			strUserRsvdList += "<h1>예약 히스토리</h1>";
   			userRsvdList.forEach(rsvd => {
   				strUserRsvdList += "========================================";
   				strUserRsvdList += "<li>예약 번호 : "+rsvd.rsvdId+"</li>"; 
   	            strUserRsvdList += "<li>매장번호 : "+ rsvd.storeId + "</li>";
   	            strUserRsvdList += "<li>회원 아이디 : "+ rsvd.userId + "</li>";
   	            strUserRsvdList += "<li>핫딜 번호 :"+ rsvd.htdlId + "</li>";
   	            strUserRsvdList += "<li>승인 번호 : "+ rsvd.aprvNo + "</li>";
   	            strUserRsvdList += "<li>예약 인원 : "+ rsvd.pnum + "</li>";
   	            strUserRsvdList += "<li>예약 시간 : "+ rsvd.time + "</li>";
   	            strUserRsvdList += "<li>예약 상태 : "+ rsvd.stusCd + "</li>";
   	            strUserRsvdList += "<li>예약 총 금액 : "+ rsvd.totAmt + "</li>";
   	            strUserRsvdList += "<li>예약 총 수량 : "+ rsvd.totQty + "</li>";
   	            strUserRsvdList += "<li>예약 등록 날짜 : "+ rsvd.regdate + "</li>";
   			});
   			
   			userRsvdListUL.html(strUserRsvdList);
   			
   			showRsvdDtls(selRsvdId);
   		})
   	};
   	
   	/*
   	예약 상세를 보여준다.
   	*/
   	function showRsvdDtls(rsvdId){
   		
   		getRsvdDtls({rsvdId:rsvdId}, function(rsvd){
   			
   			let strRsvdDtls = "";
   			if(!rsvd)
   				return;
   			
   			strRsvdDtls += "<h1>해당 유저 예약 상세</h1>"
   			strRsvdDtls += "<li>예약 번호 :" + rsvd.rsvdId +"</li>";
   			strRsvdDtls += "<li>매장 번호 :" + rsvd.storeId +"</li>";
   			strRsvdDtls += "<li>회원 아이디 : " + rsvd.userId +"</li>";
   			strRsvdDtls += "<li>핫딜 번호 : " + rsvd.htdlId +"</li>";
   			strRsvdDtls += "<li>승인 번호 : " + rsvd.aprvNo +"</li>";
   			strRsvdDtls += "<li>예약 인원 : " + rsvd.pnum +"</li>";
   			strRsvdDtls += "<li>예약 시간 : " + rsvd.time +"</li>";
   			strRsvdDtls += "<li>예약 상태 : " + rsvd.stusCd +"</li>";
   			strRsvdDtls += "<li>예약 총 가격 : " + rsvd.totAmt +"</li>";
   			strRsvdDtls += "<li>예약 총 수량 : " + rsvd.totQty +"</li>";
   			strRsvdDtls += "<li>예약 등록 날짜 : " + rsvd.regdate +"</li>";
   			let cnt = 1;
   			rsvd.rsvdDtlsList.forEach(dtls => {
   				strRsvdDtls += "==============================";
   				strRsvdDtls += "<li>상세 순서 [" + cnt +"]</li>";
   				strRsvdDtls += "<li>예약 상세 번호 : " + dtls.rsvdSeq +"</li>";
   				strRsvdDtls += "<li>예약 메뉴 이름 : " + dtls.menuNm +"</li>";
   				strRsvdDtls += "<li>메뉴 가격 : " + dtls.menuPrc +"</li>";
   				strRsvdDtls += "<li>메뉴 총 개수 : " + dtls.menuTotQty +"</li>";
   				cnt += 1;
   			})
   			
   			rsvdDtlsUL.html(strRsvdDtls);
   			
   		})
   	};
       
       
       /* 리뷰 등록 폼을 보여준다.*/
       let showRevwRegForm = function (storeId,userId,waitId,rsvdId){
    	   
    	let strRevwRegForm = "";    			
    			
    	getStoreInfo({storeId : storeId}, store=>{
    		
    		console.log("get store info..................");
       		
       		if(!store)
       			return;
       	
	       	
	       	strRevwRegForm += "<h1>리뷰 작성</h1>";
	       	strRevwRegForm += "<form id='revwRegForm' action='/dealight/mypage/review/register' method='post'>";
	       	strRevwRegForm += "매장 번호 : <input name='storeId' value='"+store.storeId+"' readonly></br>";
	       	strRevwRegForm += "매장 이름 : <input name='storeNm' value='"+store.storeNm+"' readonly></br>";
	       	if(rsvdId) strRevwRegForm += "예약 번호 : <input name='rsvdId' value='"+rsvdId+"' readonly></br>";
	       	if(waitId) strRevwRegForm += "웨이팅 번호 : <input name='waitId' value='"+waitId+"' readonly></br>";
	       	strRevwRegForm += "회원 아이디 : <input name='userId' value='"+userId+"' readonly></br>";
	       	strRevwRegForm += "리뷰 내용 : <input type='textarea' name='cnts' id=''></br>";
	       	strRevwRegForm += "평점 : <input type='number' name='rating' id=''></br>";
	       	strRevwRegForm += "파일첨부 : <div class='file_body'>"; 
	       	strRevwRegForm += "<div class='form_img'><input id='js_upload' type='file' name='uploadFile' multiple></div>";
	       	strRevwRegForm += "<div class='uploadResult'><ul></ul></div></div>";
	       	strRevwRegForm += "<input name='prevPage' value='review/' id='' hidden>";
	       	strRevwRegForm += "<div class='bigPictureWrapper'><div class='bigPicture'></div></div>";
	       	strRevwRegForm += "</form>";
	       	strRevwRegForm += "<button id='submit_revwRegForm'>제출하기</button>";
	       	
	       	revwRegFormUL.html(strRevwRegForm);
	       	
	    	// btn id
	    	btnSubmit = "#submit_revwRegForm";
	    	/* form 역할을 하는 엘리먼트를 선택한다. */
	    	formObj = $("#revwRegForm");

	       	// 파일첨부 관련 이벤트 등록
	       	if(btnSubmit) $(btnSubmit).on("click", inputHandler);
	    	if(!isModal) $("input[type='file']").change(uploadHandler);
	    	if(isModal)  $("#js_upload").change(uploadHandler); 
	    	$(".uploadResult").on("click", "button", deleteHandler);
	        $(".uploadResult").on("click", "li", showImageHandler);
	    	$(".bigPictureWrapper").on("click",bigImgAniHandler);
	       	
    	});
       };
	       	
       
   		/* 이벤트 등록 */
       /*매장의 예약 리스트 보여주기*/
       $(".btn_rsvd_dtls").on("click", e => {
       	
       	let rstoreId = $(e.target).parent().find(".store_id").text(),
       		selRsvdId = $(e.target).parent().find(".rsvd_id").text(),
       		ruserId = '${userId}';
       		
       	console.log('store id ............... : ' + rstoreId);
       	console.log('rsvd id ............... : ' + selRsvdId);
       	console.log('user id ............... : ' + ruserId);
       	

       	showUserRsvdList(rstoreId, ruserId, selRsvdId);
       	modal.css("display","block");
       	
       });
       
       /* 리뷰 등록  모달 */
       $(".btn_revw_reg").on("click", e => {
       	
       	let storeId = $(e.target).parent().find(".store_id").text(),
       		waitId = $(e.target).parent().find(".wait_id").text(),
       		rsvdId = $(e.target).parent().find(".rsvd_id").text();
       	
       	showRevwRegForm(storeId,userId,waitId,rsvdId);
       	modal.css("display","block");
       	
       });
       
       /* 매장 상세 */
       $(".btn_store_info").on("click", e => {
    	   
       	
	       	let storeId = $(e.target).parent().find(".store_id").text();
	       	
    	    console.log('storeId.....................'+storeId);
    	   
	       	showStoreInfo(storeId);
	       	modal.css("display","block");
       	
       });
	
}); /* document ready end*/
</script>
</body>
</html>