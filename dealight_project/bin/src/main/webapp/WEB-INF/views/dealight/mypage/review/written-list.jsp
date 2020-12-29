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
<script src="/resources/js/Rater.js"></script>
<style>
	.revw_wrapper{
		    margin-top: 20px;
            display: flex;
            flex-direction: column;
            justify-content: flex-start;
            align-items: flex-start;
            width: 100%;
            padding: 20px 0;
	}
	.modal_top_revw{
		height: auto;
	}
	.border{
		height: 20px;
		border-bottom: 1px #eeeeef solid;
	}
</style>
</head>
<body>

<main>
        <div class="mypage_wrapper">
        <%@include file="/WEB-INF/views/includes/mypageSidebar.jsp" %>
        
        <div class="mypage_right">
                <div class="mypage_main_header">
                    <div class="main_header_title">마이 리뷰 리스트</div>
                    <div class="main_header_subtitle">작성한 리뷰를 보여줍니다.</div>
                    <div class='main_header_link'><a href="/dealight/mypage/review/">작성 가능한 내역 보기</a></div>
                </div>
                <div class="mypage_main_content">
                                    <div class="mypage_main_sub">
                        <div>
                            <span class="main_tit">리뷰 개수</span>
                            <span class="main_value">${countRevw } 개</span>
                        </div>
                        <div>
                            <span class="main_tit">예약 횟수</span>
                            <span class="main_value">${countRsvd } 회</span>
                        </div>
                        <div>
                            <span class="main_tit">웨이팅 횟수</span>
                            <span class="main_value">${countWait } 회</span>
                        </div>
                        <div>
                            <span class="main_tit">총 이용 횟수</span>
                            <span class="main_value">${countTotal } 회</span>
                        </div>
                    </div>
                    <div class="mypage_main_board">
	                    <c:if test="${empty writtenList}">
							작성한 리뷰가 없습니다.
						</c:if>
						
						<c:if test="${not empty writtenList}">
			                <div class="revw_wrapper">
							<c:forEach items="${writtenList}" var="revw">
										<div class='modal_top_revw'>
											<div class='revw_reg_wrapper'>
												<div class='revw_store_info'>
													<div class='revw_store_name'>${revw.storeNm}</div>
													<div class='revw_rsvd_id'>
														<span>리뷰 등록 날짜 : ${revw.regdate}</span>
													</div>
												</div>
												<div class='revw_info_wrapper' action='/dealight/mypage/review/register' method='post'>
													<div class='revw_rate_wrapper'>
														<div class='rating' data-rate-value='"+revw.rating+"'></div>
													</div>
													<div class='revw_cnts_textarea'>
														<textarea cols='30' row='20' name='cnts' readonly>${revw.cnts}</textarea>
													</div>
													<input name='rating' id='rate_input' hidden>
													<c:if test="${revw.imgs != null}">
														<div class='revw_img_box'>
															<div class='revw_img_wrapper'>
														<c:forEach items="${revw.imgs}" var="img">
															<c:if test="${img.fileName != null}">
																<img src='/display?fileName=${img.uploadPath}/s_${img.uuid}_${img.fileName}'>
															</c:if>
														</c:forEach>
														</div>
														</div>
													</c:if>
													<c:if test="${revw.replyCnts != null}">
														<div class='reply_wrapper'>
															<div class='reply_item'>
																<div class='reply_item_icon'>
																	<i class='fas fa-reply'></i>
																	<div class='reply_item_name'>${revw.storeNm}</div>
																	<div class='reply_item_date'>${revw.replyRegDt}</div>
																</div>
															<div class='reply_cnts_wrapper'>
																<div class='reply_cnts'>
																	${revw.replyCnts}
																</div>
															</div>
														</div>
														</div>
													</c:if>
												</div>
												<div class="border">
												
												</div>
											</div>
										</div>
	                        	</c:forEach>
			                </div>
                        </c:if>
                    </div>
			<!-- end pagination -->
                </div>
            </div>
        </div> <!-- end mypage wrapper -->
                    <!-- pagination -->
			<div class='pull-right panel-footer'>
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
			<form id='actionForm' action="/dealight/mypage/review/written-list" method='get'>
				<input type='hidden' name='pageNum' value='${pageMaker.cri.pageNum}'>
				<input type='hidden' name='amount' value = '${pageMaker.cri.amount}'>
			</form>
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
<script type="text/javascript">
$(document).ready(function() {
	
    const userId = '${userId}',
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
	
	/* Rater.js 로직*/
    $(".rating").rate({
        max_value: 5,
        step_size: 0.5,
        initial_value: 3,
        selected_symbol_type: 'utf8_star', // Must be a key from symbols
        cursor: 'default',
        readonly: true,
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
    
    
	
    function getStoreInfo(param,callback,error){
       	
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
       
       
       /* 출력 로직*/
       
       function showStoreInfo(userId,storeId) {
       	
       	getStoreInfo({userId:userId,storeId : storeId}, store=>{
       		
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
    		strStoreInfo += "<div class='rating' data-rate-value='"+store.eval.avgRating+"'></div>";
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
       		/* Rater.js 로직*/
	        $(".rating").rate({
	            max_value: 5,
	            step_size: 0.5,
	            initial_value: 3,
	            selected_symbol_type: 'utf8_star', // Must be a key from symbols
	            cursor: 'default',
	            readonly: true,
	        });
       		
    	    $(".btn_like_pick").on("click",likeAddHandler);
    	    $(".btn_like_cancel").on("click",likeRemoveHandler);
       		
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
       
       /* 리뷰 등록 */
       $(".btn_revw_reg").on("click", e => {
       	
       	let storeId = $(e.target).parent().find(".store_id").text()
       	
       	showRevwRegForm(storeId);
       	modal.css("display","block");
       	
       	//$("#waitRegForm").submit();        		
       	
       });
       
       /* 매장 상세 */
       $(".btn_store_info").on("click", e => {
    	   
       	
	       	let storeId = $(e.target).parent().find(".store_id").text(),
	    		userId = '${userId}';
	       	
    	    console.log('storeId.....................'+storeId);
    	   
	       	showStoreInfo(userId,storeId);
	       	modal.css("display","block");
       	
       });
       
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
	
}); /* document ready end*/

/* get review img (즉시실행함수)*/
$(document).ready(function() {

    (function(){
        
    	let revw_id_list = document.getElementsByClassName("revw_id_list");
    	
    	for(let i = 0; i < revw_id_list.length; i++){
    		
    		let revwId = revw_id_list[i].value;
    		
            $.getJSON("/dealight/mypage/getRevwImgs", {revwId:revwId}, function(imgs){
                
                let strRevwImg = "";
                
                $(imgs).each(function(i, img){
                	
                    if(img.image) {
                    	
                        let fileCallPath = encodeURIComponent(img.uploadPath+"/s_" +img.uuid + "_" +img.fileName);
                        strRevwImg += "<li data-path='" + img.uploadPath + "'data-uuid='" + img.uuid + "'data-filename='"
                            + img.fileName +"'data-type='" + img.image+"'><div>";
                        strRevwImg += "<img src='/display?fileName=" + fileCallPath+"'>";
                        strRevwImg += "</li>";
                        
                    } else {
                        
                    	strRevwImg += "<li data-path='" + img.uploadPath +"' data-uuid='" + img.uuid 
                                +"' data-filename='" + img.fileName +"' data-type='" + img.image+"'><div>";
                        strRevwImg += "<span>" + img.fileName+"</span><br/>";
                        strRevwImg += "<img src='/resources/img/attach.png'>";
                        strRevwImg += "</div>";
                        strRevwImg += "</li>";
                    }
	                $(".revw_imgs_"+img.imgSeq).html(strRevwImg);
	                strRevwImg = "";
                });
                
                
            }); // end getjson
    	}
    })(); // end function
});
</script>
<%@include file="../../../includes/mainFooter.jsp" %>
</body>
</html>