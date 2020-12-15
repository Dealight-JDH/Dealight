	<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="../../includes/mainMenu.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>예약 내역</title>
<link rel="stylesheet" href="/resources/css/mypage.css?ver=1" type ="text/css" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=9a6bde461f2e377ce232962931b7d1ce"></script>
</head>
<body>
    <main class="mypage_wrapper">
        <%@include file="/WEB-INF/views/includes/mypageSidebar.jsp" %>
        <div class="mypage_content">
            <div class="content_head">
                <h2>예약 내역<span>지난 예약 내역을 가져옵니다.</span></h2>
            </div>
            <div>
                	<h2>회원 아이디 : ${userId }</h2>
					<h2>현재 예약 횟수 : ${curCnt}회</h2>
					<h2>총 지난 예약 횟수 : ${last}회</h2>
					<h2>총 예약 횟수 : ${total}회</h2>
            </div>
            <div class="content_main">
				<div id="rsvdWrapper">
					<c:if test="${empty rsvdList}">
						<h2>예약한 이력이 없습니다.</h2>
					</c:if>
					
					<c:if test="${not empty rsvdList}">
					<h2>예약 리스트</h2>
						<c:forEach items="${rsvdList}" var="rsvd">
							<div>
								====================================
								<h5>예약 번호 : <span class="rsvd_id">${rsvd.rsvdId}</span></h5>
								<h5>매장번호 : <span class="store_id">${rsvd.storeId}</span></h5></br>
								날짜 : ${rsvd.time } </br>
								인원 : ${rsvd.pnum }</br>
								메뉴 : 
								<c:forEach items="${rsvd.rsvdDtlsList}" var="rsvdDtls">
								${rsvdDtls.menuNm}
								</c:forEach>
								</br>
								결제금액 : ${rsvd.totAmt}</br>
								결제수량 : ${rsvd.totQty}</br>
								현재 예약 상태 : ${rsvd.stusCd}</br>
								리뷰 상태 : <span class="revw_stus">${rsvd.revwStus }</span></br>
								<button class="btn_rsvd_dtls">예약 상세 보기</button>
								<button class="btn_store_info">매장 정보 보기</button>
								<c:if test="${rsvd.revwStus > 0}"> <button class="btn_revw_info">리뷰 보기</button></c:if>
								<c:if test="${rsvd.revwStus == 0}"><button class="btn_revw_reg">리뷰 쓰기</button></c:if>
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
			<form id='actionForm' action="/dealight/mypage/reservation" method='get'>
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
			<ul class="revwInfo"></ul>
			<div id="map" style="width:500px;height:400px;"></div>
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
window.onload = function () {
	
    const userRsvdListUL = $(".userRsvdList"),
	    rsvdDtlsUL = $(".rsvdDtls"),
	    userId = '${userId}',
	    revwRegFormUL = $(".revw_regForm"),
	    storeInfoUL = $(".store_info"),
	    btn_show_board = $("#btn_show_board"),
	    revwInfoUL = $(".revwInfo")
	;
	    
	let container,options,map,mapContainer,mapOption,markerPosition,marker;
	
	/* 페이징 로직*/
	let actionForm = $("#actionForm");
	
	let pagingHandler = function(e) {
		e.preventDefault();
		
		console.log("page click");
		
		actionForm.find("input[name='pageNum']").val($(this).attr("href"));
		actionForm.submit();
	}
	
	/* 페이징 핸들러 */
	$(".paginate_button a").on("click", pagingHandler);
	
    /*get 함수*/
	// 예약의 '예약상세'를 가져온다.
    let getRsvdDtls = function (param,callback,error) {
    	
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
    	
    }
	
    // 사용자의 '해당 매장'의 '예약 리스트'를 가져온다.
	let getUserRsvdList = function (param,callback,error) {
      	
      	let storeId = param.storeId,
      		userId = param.userId;
      	
      	//console.log(storeId);
      	//console.log(userId);
      	
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

	    let removeLike = function (params,callback,error) {
	    	
	    	let storeId = params.storeId,
	    		userId = params.userId;
	    	
	        $.ajax({
	            type:'delete',
	            url:'/dealight/mypage/like/remove/'+userId+'/'+storeId,
	            data : {'userId' : userId, 'storeId':storeId},
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
	        
        }
	    
	    let addLike = function (params,callback,error) {
	    	
	    	let storeId = params.storeId,
	    		userId = params.userId;
	    	
	        $.ajax({
	            type:'post',
	            url:'/dealight/mypage/like/add/'+userId+'/'+storeId,
	            data : {'userId' : userId, 'storeId':storeId},
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
	        
        }
       
       let getStoreInfo = function (param,callback,error){
       	
    	 
       	let storeId = param.storeId,
       		userId = param.userId;
       	
       	$.getJSON("/dealight/mypage/reservation/store/"+userId+"/"+ storeId +".json",
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
       
       let getRsvdRevw = function (param,callback,error) {
    	   
    	   let rsvdId = param.rsvdId;
    	   
          	$.getJSON("/dealight/mypage/review/rsvd/"+ rsvdId +".json",
                    function(data){
                        if(callback){
                            callback(data);
                        }
                    }).fail(function(xhr,status,err){
                        if(error){
                            error();
                        }
            });
       }
       
    /* 출력 로직*/
    
    let showRsvdRevw = function (rsvdId) {
    	
    	getRsvdRevw({rsvdId : rsvdId}, revw => {
    		
    		let strRevw = "";
    		if(!revw) return;
    		
    		strRevw += "<h1>리뷰 보기</h1>";
    		strRevw += "<h5>리뷰 번호 : "+revw.revwId+"</h5>";
    		strRevw += "<h5>매장 번호 : "+revw.storeId+"</h5>";
    		strRevw += "<h5>매장 이름 : "+revw.storeNm+"</h5>";
    		strRevw += "<h5>예약 번호 : "+revw.rsvdId+"</h5>";
    		strRevw += "<h5>회원 아이디 : "+revw.userId+"</h5>";
    		strRevw += "<h5>리뷰 내용 : "+revw.cnts+"</h5>";
    		strRevw += "<h5>평점 : "+revw.rating+"</h5>";
    		strRevw += "<h5>답글 내용 : "+revw.replyCnts+"</h5>";
    		strRevw += "<h5>답글 등록 날짜 : "+revw.replyRegDt+"</h5>";
    		strRevw += "<h5>리뷰 사진</h5>";
    		for(let i = 0; i < revw.imgs.length; i++)
    			if(revw.imgs[i].fileName !== null) strRevw += "<img src='/display?fileName="+encodeURIComponent(revw.imgs[i].uploadPath+"/s_"+revw.imgs[i].uuid+"_"+revw.imgs[i].fileName)+"'>";
    		
    		revwInfoUL.html(strRevw);
    	});
    };
    
    // 매장 정보를 보여준다.
    let showStoreInfo = function (userId,storeId) {
    	
    	console.log("user id : "+userId);
    	console.log("store id : "+storeId);
    	
    	getStoreInfo({userId:userId,storeId : storeId}, store => {
    		
    		let strStoreInfo = "";
    		if(!store)
    			return;
    		
    		strStoreInfo += "<h1>매장 정보</h1>";
    		strStoreInfo += "<img src='/display?fileName="+store.bstore.repImg+"'>";
    		if(!store.like) strStoreInfo += "<button class='btn_like_pick'>찜 하기</button>";
    		if(store.like) strStoreInfo += "<button class='btn_like_cancel'>찜 취소하기</button>";
    		strStoreInfo += "<li>매장 번호 : <span class='store_info_id'>"+store.storeId+"</span></l1>";
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
    		strStoreInfo += "<li>매장 좋아요 수 : "+store.eval.likeTotNum+"</l1>";
    		strStoreInfo += "<li>매장 리뷰 수 : "+store.eval.revwTotNum+"</l1>";
    		strStoreInfo += "<li>매장 평균 평점 : "+store.eval.avgRating+"</l1>";
    		//strStoreInfo += "<li>좋아요 여뷰 : "+store.like+"</l1>";
    		strStoreInfo += "<li>매장 주소 : "+store.loc.addr+"</l1><br>";

    		
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
    	    $(".btn_like_pick").on("click",likeAddHandler);
    	    $(".btn_like_cancel").on("click",likeRemoveHandler);
    		
    	});
    	
    };
    /*
	유저의 예약 히스토리를 보여준다.
	*/
	let showUserRsvdList = function (storeId,userId,selRsvdId){
		
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
			
		});
	};
	
	/*
	예약 상세를 보여준다.
	*/
	let showRsvdDtls = function (rsvdId){
		
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
    let showRevwRegForm = function (storeId,userId,rsvdId){
 	   
 	let strRevwRegForm = "";    			
 			
 	getStoreInfo({userId : userId, storeId : storeId}, store => {
 		
 		console.log("get store info..................");
    		
    		if(!store)
    			return;
	       	
	       	strRevwRegForm += "<h1>리뷰 작성</h1>";
	       	strRevwRegForm += "<form id='revwRegForm' action='/dealight/mypage/review/register' method='post'>";
	       	strRevwRegForm += "매장 번호 : <input name='storeId' value='"+store.storeId+"' readonly></br>";
	       	strRevwRegForm += "매장 이름 : <input name='storeNm' value='"+store.storeNm+"' readonly></br>";
	       	strRevwRegForm += "예약 번호 : <input name='rsvdId' value='"+rsvdId+"' readonly></br>";
	       	strRevwRegForm += "회원 아이디 : <input name='userId' value='"+userId+"' readonly></br>";
	       	strRevwRegForm += "리뷰 내용 : <input type='textarea' name='cnts' id=''></br>";
	       	strRevwRegForm += "평점 : <input type='number' name='rating' id=''></br>";
	       	strRevwRegForm += "파일첨부 : <div class='file_body'>"; 
	       	strRevwRegForm += "<div class='form_img'><input id='js_upload' type='file' name='uploadFile' multiple></div>";
	       	strRevwRegForm += "<div class='uploadResult'><ul></ul></div></div>";
	       	strRevwRegForm += "<input name='prevPage' value='reservation' id='' hidden>";
	       	strRevwRegForm += "<div class='bigPictureWrapper'><div class='bigPicture'></div></div>";
	       	strRevwRegForm += "</form>";
	       	strRevwRegForm += "<button id='submit_revwRegForm'>제출하기</button>";
	       	
	       	revwRegFormUL.html(strRevwRegForm);
	       	
	       	// 리뷰
	    	// btn id
	    	btnSubmit = "#submit_revwRegForm";
	    	/* form 역할을 하는 엘리먼트를 선택한다. */
	    	formObj = $("#revwRegForm");

	       	// 파일첨부 관련 이벤트 등록
	       	if(btnSubmit) $(btnSubmit).on("click", inputHandler);
	    	if(!isModal) $("input[type='file']").change(uploadHandler);
	    	if(isModal)  $("#js_upload").change(uploadHandler); 
	    	$(".uploadResult").on("click", "button", deleteHandler);
	        //$(".uploadResult").on("click", "li", showImageHandler);
	    	$(".bigPictureWrapper").on("click",bigImgAniHandler);
	    	if(pageType === 'modify' || pageType === 'register') $(".uploadResult").on("click","img",selRepImgHandler);
 		
 	});
 			
 	
    };
    
    let showRsvdRevwHandler = function(e) {
    	
    	let rsvdId = $(e.target).parent().find(".rsvd_id").text();
    	
    	showRsvdRevw(rsvdId);
    	modal.css("display","block");
    	
    }
	
	let showRsvdDtlsHandler = function(e) {
		
    	let rstoreId = $(e.target).parent().find(".store_id").text(),
		selRsvdId = $(e.target).parent().find(".rsvd_id").text(),
		ruserId = '${userId}';
	
	
		showUserRsvdList(rstoreId, ruserId, selRsvdId);
		modal.css("display","block");
	};
	
	let showRevwRegFormHandler =  function(e) {
    	let storeId = $(e.target).parent().find(".store_id").text(),
		rsvdId = $(e.target).parent().find(".rsvd_id").text(),
		revwStus = $(e.target).parent().find(".revw_stus").text();
       	
	    if(revwStus > 0) return;
		
		showRevwRegForm(storeId,userId,rsvdId);
		modal.css("display","block");
	}
	
	let showStoreInfoHandler = function(e) {
    	let storeId = $(e.target).parent().find(".store_id").text(),
    	userId = '${userId}';
    	
    	modal.css("display","block");
    	showStoreInfo(userId, storeId);
	}
	
    let likeRemoveHandler = function(e){
    	
    	let storeId = $(e.target).parent().find(".store_info_id").text(),
			userId = '${userId}';

		
		removeLike({userId:userId,storeId:storeId});
		alert("찜이 취소 되었습니다.");		
		showStoreInfo(userId, storeId);
		
    }
    
    let likeAddHandler = function(e){
    	
    	let storeId = $(e.target).parent().find(".store_info_id").text(),
			userId = '${userId}';

		addLike({userId:userId,storeId:storeId});
		
		alert($(e.target).parent().find(".store_info_id").text()+"번이 추가 되었습니다.");

		
		
		showStoreInfo(userId, storeId);
    }
	
	/* 이벤트 등록 */
    /*매장의 예약 리스트 보여주기*/
    $(".btn_rsvd_dtls").on("click", showRsvdDtlsHandler);
	
    /* 리뷰 등록 */
    $(".btn_revw_reg").on("click", showRevwRegFormHandler);
    
    $(".btn_revw_info").on("click", showRsvdRevwHandler);
    
    /* 매장 상세 */
    $(".btn_store_info").on("click", showStoreInfoHandler);
    
    $(".btn_like_pick").on("click",likeAddHandler);
    $(".btn_like_cancel").on("click",likeRemoveHandler);
    
}; /* document ready end*/



</script>
<%@include file="../../includes/mainFooter.jsp" %>
</body>
</html>