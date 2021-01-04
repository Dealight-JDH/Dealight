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
<link rel="stylesheet" href="/resources/css/fileupload.css">
<link rel="stylesheet" href="/resources/css/mypage.css?ver=1" type ="text/css" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=9a6bde461f2e377ce232962931b7d1ce"></script>
<script src="/resources/js/Rater.js"></script>
<title>딜라이트</title>
</head>

<body>
<main>
        <div class="mypage_wrapper">
        <%@include file="/WEB-INF/views/includes/mypageSidebar.jsp" %>
        
        <div class="mypage_right">
                <div class="mypage_main_header">
                    <div class="main_header_title">리뷰 가능 리스트</div>
                    <div class="main_header_subtitle">리뷰가 가능한 예약과 웨이팅을 불러옵니다.</div>
                    <div class="main_header_link"><a href="/dealight/mypage/review/written-list">작성한 리뷰 보기</a></div>
                </div>
                <div class="mypage_main_content">
                                    <div class="mypage_main_sub">
                        <div>
                            <span class="main_tit">리뷰 가능한 예약 내역</span>
                            <span class="main_value">${writableRsvd} 개</span>
                        </div>
                        <div>
                            <span class="main_tit">리뷰 가능한 웨이팅 내역</span>
                            <span class="main_value">${writableWait} 개</span>
                        </div>
                    </div>
                    <div class="mypage_main_board">
	                    <c:if test="${empty dtoList}">
							<h2>리뷰 가능한 내역이 없습니다.</h2>
						</c:if>
						
						<c:if test="${not empty dtoList}">
							<c:forEach items="${dtoList}" var="dto">
								<c:if test="${not empty dto.rsvd }">
			                        <div class="rsvd_wrapper">
			                            <div class="css_rsvd_time">
			                                <span>${dto.rsvd.time }</span>
			                            </div>
			                            <div class="css_rsvd_box">
			                                <div class="rsvd_tit">
			                                    <div>
			                                    	예약번호 : <span class="rsvd_id">${dto.rsvd.rsvdId}</span>
			                                    	<span style='display:none;' class="revw_stus">${dto.rsvd.revwStus}</span>
			                                    	<span style='display:none;' class="store_id">${dto.storeId}</span>
			                                    </div>
			                                    <div><button class="btn_rsvd_dtls"><i class="fas fa-angle-right"></i></button></div>
			                                </div>
			                                <div class="rsvd_cnts">
			                                    <div class="rsvd_cnts_wrapper">
			                                        <div class="rsvd_cnts_img">
			                                        <img src='/display?fileName=${dto.rsvd.storeRepImg}'>
			                                        
			                                        </div>
			                                        <div class="cnts">
			                                            <div>
			                                                <span class="rsvd_cnts_tit">예약인원</span>
															<span class="rsvd_cnts_val">${dto.rsvd.pnum}명</span>
			                                            </div>
			                                            <div>
			                                                <span class="rsvd_cnts_tit">결제금액</span>
			                                                <span class="rsvd_cnts_val">${dto.rsvd.totAmt}원</span>
			                                            </div>
			                                            <div>
			                                                <span class="rsvd_cnts_tit">예약상태</span>
			                                                <c:if test="${dto.rsvd.stusCd eq 'C'}">
			                                                	<span class="rsvd_cnts_val wait_stus_cd" style='color:blue;'>현재예약</span>
			                                                </c:if>
			                                                <c:if test="${dto.rsvd.stusCd eq 'L'}">
			                                                	<span class="rsvd_cnts_val wait_stus_cd" style='color:orange;'>지난예약</span>
			                                                </c:if>
			                                                <c:if test="${dto.rsvd.stusCd eq 'P'}">
			                                                	<span class="rsvd_cnts_val wait_stus_cd" style='color:red;'>예약대기</span>
			                                                </c:if>
			                                            </div>
			                                        </div>
			                                    </div>
			                                    <div class="rsvd_btn_box">
			                                        <button class="btn_store_info">매장 정보 보기</button>
			                                        <c:if test="${dto.rsvd.revwStus > 0}"> <button class="btn_revw_info">리뷰 보기</button></c:if>
													<c:if test="${dto.rsvd.revwStus == 0}"><button class="btn_revw_reg">리뷰 쓰기</button></c:if>
			                                    </div>
			                                </div>
			                            </div>
			                        </div>
			                     </c:if>
			                     <c:if test="${not empty dto.wait }">
			                     	<div class="rsvd_wrapper">
			                            <div class="css_rsvd_time">
			                                <span>${dto.wait.waitRegTm }</span>
			                            </div>
			                            <div class="css_rsvd_box">
			                                <div class="rsvd_tit">
			                                    <div>
			                                    	웨이팅 번호 : <span class="wait_id">${dto.wait.waitId}</span>
			                                    	<span style='display:none;' class="revw_stus">${dto.wait.revwStus}</span>
			                                    	<span style='display:none;' class="store_id">${dto.storeId}</span>
			                                    </div>
			                                    <div><button class="btn_wait"><i class="fas fa-angle-right"></i></button></div>
			                                </div>
			                                <div class="rsvd_cnts">
			                                    <div class="rsvd_cnts_wrapper">
			                                        <div class="rsvd_cnts_img">
			                                        <img src='/display?fileName=${dto.wait.storeRepImg}'>
			                                        
			                                        </div>
			                                        <div class="cnts">
			                                            <div>
			                                                <span class="rsvd_cnts_tit">웨이팅 인원</span>
															<span class="rsvd_cnts_val">${dto.wait.waitPnum }명</span>
			                                            </div>
			                                            <div>
			                                                <span class="rsvd_cnts_tit">웨이팅 상태</span>
			                                               	<c:if test="${dto.wait.waitStusCd eq 'W'}">
			                                                	<span class="rsvd_cnts_val wait_stus_cd" style="color:blue;">웨이팅</span>
			                                                </c:if>
			                                                <c:if test="${dto.wait.waitStusCd eq 'E'}">
			                                                	<span class="rsvd_cnts_val wait_stus_cd">입장</span>
			                                                </c:if>
			                                                <c:if test="${dto.wait.waitStusCd eq 'P'}">
			                                                	<span class="rsvd_cnts_val wait_stus_cd" style="color:red;">노쇼</span>
			                                                </c:if>
			                                                <c:if test="${dto.wait.waitStusCd eq 'C'}">
			                                                	<span class="rsvd_cnts_val wait_stus_cd" style="color:red;">취소</span>
			                                                </c:if>
			                                            </div>
			                                        </div>
			                                    </div>
			                                    <div class="rsvd_btn_box">
			                                        <button class="btn_store_info">매장 정보 보기</button>
			                                        <c:if test="${dto.wait.revwStus > 0}"> <button class="btn_revw_info">리뷰 보기</button></c:if>
													<c:if test="${dto.wait.revwStus == 0}"><button class="btn_revw_reg">리뷰 쓰기</button></c:if>
			                                    </div>
			                                </div>
			                            </div>
			                        </div>
			                     </c:if>
	                        </c:forEach>
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
			<form id='actionForm' action="/dealight/mypage/review/" method='get'>
				<input type='hidden' name='pageNum' value='${pageMaker.cri.pageNum}'>
				<input type='hidden' name='amount' value = '${pageMaker.cri.amount}'>
			</form>
    </main>
            
            	<!-- The Modal -->
	<div id="myModal" class="modal">
		<!-- Modal content -->
		<div class="modal-content">
			<span class="close_modal"><i class="fas fa-times"></i></span>
	        <div class="modal_header"></div>
			<ul class="rsvdDtls"></ul>
			<ul class="userRsvdList"></ul>
			<ul class="revw_regForm"></ul>
			<div class="modal_wrapper_revw_reg content_div"></div>
			<div class='modal_wrapper_revw_info content_div'></div>
			<div class="modal_wrapper_store_info content_div"></div>
			<div class="modal_wrapper_rsvdDtls content_div"></div>
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
	    btn_show_board = $("#btn_show_board"),
	    revwInfoDiv = $(".modal_wrapper_revw_info"),
	    storeInfoDiv = $(".modal_wrapper_store_info"),
        rsvdDtlsDiv = $(".modal_wrapper_rsvdDtls"),
        rsvdDtlsInfoDiv = $("#modal_rsvd_dtls"),
        revwRegDiv = $(".modal_wrapper_revw_reg"),
        pageNum = ${pageMaker.cri.pageNum},
        amount = ${pageMaker.cri.amount}
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
    		
    		strStoreInfo += "<div class='modal_tit'>";
    		strStoreInfo += "<span>매장 정보</span>";
    		strStoreInfo += "</div>";
    		
    		strStoreInfo += "<div class='modal_top_store'>";
    		strStoreInfo += "<div class='modal_top_left'>";
    		strStoreInfo += "<div class='modal_top_left'>";
    		strStoreInfo += "<img src='/display?fileName="+store.bstore.repImg+"'>";
    		strStoreInfo += "</div>";
    		strStoreInfo += "</div>";
    		strStoreInfo += "<div class='modal_top_right'>";
    		strStoreInfo += "<div class='store_info_name'>"+store.storeNm+"</div>";
    		strStoreInfo += "<div class='store_info_brch'>"+store.bstore.brch+"</div>";
    		strStoreInfo += "<div class='store_info_telno'>"+store.telno+"</div>";
    		strStoreInfo += "<div class='store_info_rating'><div class='rating' data-rate-value='"+store.eval.avgRating+"'></div></div>";
    		strStoreInfo += "<div class='store_info_eval'>";
    		if(store.like) strStoreInfo += "<div class='store_info_tot_like btn_like_cancel'><i class='fas fa-heart'></i> "+store.eval.likeTotNum+"</div>";
    		else if (!store.like) strStoreInfo += "<div class='store_info_tot_like btn_like_pick'><i class='far fa-heart'></i> "+store.eval.likeTotNum+"</div>";
    		strStoreInfo += "<div class='store_info_tot_revw'><i class='fas fa-pencil-alt'></i> "+store.eval.revwTotNum+"</div>";
    		strStoreInfo += "</div>";
    		strStoreInfo += "<div class='store_info_tm'>";
    		strStoreInfo += "<div class='store_info_biz_tm'>영업 시간 : "+store.bstore.openTm+" - "+store.bstore.closeTm+"</div>";
    		strStoreInfo += "<div class='store_info_break_tm'>브레이크 타임 : "+store.bstore.breakSttm+" - "+store.bstore.breakEntm+"</div>";
    		strStoreInfo += "<div class='store_info_break_tm'>라스트오더 : "+store.bstore.lastOrdTm+"</div>";
    		strStoreInfo += "</div>";
    		strStoreInfo += "<div class='store_info_detail'>";
    		strStoreInfo += "<i class='fas fa-angle-right'></i>";
    		strStoreInfo += "</div>";
    		strStoreInfo += "</div>";
    		strStoreInfo += "</div>";
    		strStoreInfo += "<span style='display:none;' class='store_info_id'>"+store.storeId+"</span>";
    		
    		
    		storeInfoDiv.css("display","flex");
    		storeInfoDiv.html(strStoreInfo);
    		
    		/* Rater.js 로직*/
	        $(".rating").rate({
	            max_value: 5,
	            step_size: 0.5,
	            initial_value: 3,
	            selected_symbol_type: 'utf8_star', // Must be a key from symbols
	            cursor: 'default',
	            readonly: true,
	        });
    		
    		$(".store_info_detail").on("click", e => window.open("/dealight/store/"+store.storeId))
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
    		
    		strUserRsvdList += "<div class='modal_top rsvdDtls' id='modal_rsvd_dtls'>";
    		
    		strUserRsvdList += "<div class='rsvd_top_wrapper'>";
    		strUserRsvdList += "</div>";
    		strUserRsvdList += "<div class='rsvd_mid_wrapper'>";
    		strUserRsvdList += "</div>";

    		strUserRsvdList += "<div class='rsvd_bot_wrapper'>";
    		strUserRsvdList += "<div class='rsvd_history_tit'>";
    		strUserRsvdList += "매장 방문 히스토리";
    		strUserRsvdList += "</div>";
    		userRsvdList.forEach(rsvd => {
	    		strUserRsvdList += "<div class='rsvd_history'>";
	    		if(rsvd.htdlId !== null) strUserRsvdList += "<span class='htdl_stus'><i class='fas fa-burn'></i></span>";
	    		strUserRsvdList += "<div class='info'>";
	    		strUserRsvdList += "<div>예약 번호</div>";
	    		strUserRsvdList += "<div>"+rsvd.rsvdId+"</div>";
	    		strUserRsvdList += "</div>";
	    		strUserRsvdList += "<div class='info'>";
	    		strUserRsvdList += "<div>예약 인원</div>";
	    		strUserRsvdList += "<div>"+ rsvd.pnum + "</div>";
	    		strUserRsvdList += "</div>";
	    		strUserRsvdList += "<div class='info'>";
	    		strUserRsvdList += "<div>예약 시간</div>";
	    		strUserRsvdList += "<div>"+ rsvd.time + "</div>";
	    		strUserRsvdList += "</div>";
	    		strUserRsvdList += "<div class='info'>";
	    		strUserRsvdList += "<div>예약 총 금액</div>";
	    		strUserRsvdList += "<div>"+ rsvd.totAmt + "</div>";
	    		strUserRsvdList += "</div>";
	    		strUserRsvdList += "<div class='info'>";
	    		strUserRsvdList += "<div>예약 총 수량</div>";
	    		strUserRsvdList += "<div>"+ rsvd.totQty + "</div>";
	    		strUserRsvdList += "</div>";
	    		strUserRsvdList += "</div>";
    		});
    		strUserRsvdList += "</div>";
    		


    		rsvdDtlsDiv.css("display","flex");
    		rsvdDtlsDiv.html(strUserRsvdList);
    		console.log("=======================");
    		console.log("user history complete");
    		console.log("sel rsvd id : " + selRsvdId);
    		showRsvdDtls(selRsvdId);
   		})
   	};
   	
   	/*
   	예약 상세를 보여준다.
   	*/
   	function showRsvdDtls(rsvdId){
   		
   		getRsvdDtls({rsvdId:rsvdId}, function(rsvd){
   			
console.log("rsvd id : "+rsvdId)
    		
			let strRsvdDtlsTop = "";
			
			if(!rsvd)
				return;
			
			strRsvdDtlsTop += "<div class='modal_rsvd_tit'>예약 상세</div>";
			strRsvdDtlsTop += "<div class='rsvd_top_box'>";
			if(rsvd.htdlId != null) strRsvdDtlsTop += "<span class='htdl_stus'><i class='fas fa-burn'></i></span>";
			strRsvdDtlsTop += "<div class='modal_rsvd_info'>";
			strRsvdDtlsTop += "<div>예약 번호</div>";
			strRsvdDtlsTop += "<div>"+rsvd.rsvdId+"</div>";
			strRsvdDtlsTop += "</div>";
			strRsvdDtlsTop += "<div class='modal_rsvd_info'>";
			strRsvdDtlsTop += "<div>예약 시간</div>";
			strRsvdDtlsTop += "<div>"+rsvd.time+"</div>";
			strRsvdDtlsTop += "</div>";
			strRsvdDtlsTop += "<div class='modal_rsvd_info'>";
			strRsvdDtlsTop += "<div>예약 총 가격</div>";
			strRsvdDtlsTop += "<div>"+rsvd.totAmt+"원</div>";
			strRsvdDtlsTop += "</div>";
			strRsvdDtlsTop += "<div class='modal_rsvd_info'>";
			strRsvdDtlsTop += "<div>예약 총 수량</div>";
			strRsvdDtlsTop += "<div>"+rsvd.totQty+"개</div>";
			strRsvdDtlsTop += "</div>";
			strRsvdDtlsTop += "</div>";
			
			$(".rsvd_top_wrapper").html(strRsvdDtlsTop);
			
			let strRsvdDtlsMid = "";
			
			strRsvdDtlsMid += "<div class='modal_menu_head'>";
			strRsvdDtlsMid += "<div>메뉴</div>";
			strRsvdDtlsMid += "<div>가격</div>";
			strRsvdDtlsMid += "<div>수량</div>";
			strRsvdDtlsMid += "</div>";
			rsvd.rsvdDtlsList.forEach(dtls => {
				strRsvdDtlsMid += "<div class='modal_menu_info'>";
				strRsvdDtlsMid += "<div>" + dtls.menuNm +"</div>";
				strRsvdDtlsMid += "<div>" + dtls.menuPrc +"원</div>";
				strRsvdDtlsMid += "<div>" + dtls.menuTotQty +"</div>";
				strRsvdDtlsMid += "</div>";
			});
			
			$(".rsvd_mid_wrapper").html(strRsvdDtlsMid);
    		
    		console.log("=======================");
    		console.log("rsvd dtls complete");
   			
   		})
   	};
       
       
       /* 리뷰 등록 폼을 보여준다.*/
       let showRevwRegForm = function (storeId,userId,waitId,rsvdId){
    	   
    	let strRevwRegForm = "";    			
    			
    	getStoreInfo({userId:userId,storeId : storeId}, store=>{
    		
			console.log("get store info..................");
    		
    		if(!store)
    			return;
    		let strRevw = "";
    		
    		strRevw += "<div class='modal_tit'>";
            strRevw += "<span>리뷰 작성</span>";
            strRevw += "</div>";
            strRevw += "<div class='modal_top_revw'>";
    		strRevw += "<div class='revw_reg_wrapper'>";
    		strRevw += "<div class='revw_store_info'>";
    		strRevw += "<div class='revw_store_name'>"+store.storeNm+"</div>";
    		if(waitId) strRevw += "<div class='revw_rsvd_id'>웨이팅 번호 : "+waitId+"</div>";
    		if(rsvdId) strRevw += "<div class='revw_rsvd_id'>예약번호 : "+rsvdId+"</div>";
    		strRevw += "</div>";
    		strRevw += "<form id='revwRegForm' action='/dealight/mypage/review/register' method='post'>";
    		strRevw += "<div class='revw_rate_wrapper'>";
    		strRevw += "<div class='rating' dat	a-rate-value=3></div>";
    		strRevw += "</div>";
    		strRevw += "<div class='revw_cnts_textarea'>";
    		strRevw += "<textarea cols='30' row='20' name='cnts' placeholder='리뷰 내용을 입력해주세요.'></textarea>";
    		strRevw += "</div>";
    		strRevw += "<input name='rating' id='rate_input' hidden>";
    		strRevw += "<div class='file_body'></div><div class='form_img'>";
    		strRevw += "<label for='js_upload'>";
    		strRevw += "<i class='fas fa-arrow-circle-up'></i> 사진 첨부하기";
    		strRevw += "</label>";
    		strRevw += "<input style='display:none;' id='js_upload' type='file' name='uploadFile' multiple></div>";
    		strRevw += "<div class='uploadResult'><ul></ul></div>";
    		strRevw += "<div class='revw_btn_box'>";
    		strRevw += "<button id='submit_revwRegForm'>리뷰 등록</button>";
    		strRevw += "</div>";
    		strRevw += "<input name='storeId' value='"+store.storeId+"' hidden>";
    		strRevw += "<input name='storeNm' value='"+store.storeNm+"' hidden>";
    		if(rsvdId) strRevw += "<input name='rsvdId' value='"+rsvdId+"' hidden>";
    		if(waitId) strRevw += "<input name='waitId' value='"+waitId+"' hidden>";
    		strRevw += "<input name='rating' id='rate_input' hidden>";
    		strRevw += "<input name='userId' value='"+userId+"' hidden>";
    		strRevw += "<input name='prevPage' value='review/?pageNum="+pageNum+"&amount="+amount+"' id='' hidden>";
    		strRevw += "</form>";
    		strRevw += "</div>";	
    		strRevw += "</div>";
	       	
    		revwRegDiv.css("display","flex");
	       	revwRegDiv.html(strRevw);

	       	/* Rater.js 로직*/
	        $(".rating").rate({
	            max_value: 5,
	            step_size: 0.5,
	            initial_value: 3,
	            selected_symbol_type: 'utf8_star', // Must be a key from symbols
	            cursor: 'default',
	            readonly: false,
	            update_input_field_name: $("#rate_input")
	        });
	    	
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
	    	//$(".bigPictureWrapper").on("click",bigImgAniHandler);
	    	if(pageType === 'modify' || pageType === 'register') $(".uploadResult").on("click","img",selRepImgHandler);
 		
 	});
       };
	       	
       
   		/* 이벤트 등록 */
       /*매장의 예약 리스트 보여주기*/
       $(".btn_rsvd_dtls").on("click", e => {
       	
    	  let rstoreId = $(e.target).parent().parent().parent().parent().find(".store_id").text(),
	   		selRsvdId = $(e.target).parent().parent().parent().parent().find(".rsvd_id").text(),
	   		ruserId = '${userId}';
       		
       	console.log('store id ............... : ' + rstoreId);
       	console.log('rsvd id ............... : ' + selRsvdId);
       	console.log('user id ............... : ' + ruserId);
       	

       	showUserRsvdList(rstoreId, ruserId, selRsvdId);
       	modal.css("display","block");
       	
       });
       
       /* 리뷰 등록  모달 */
       $(".btn_revw_reg").on("click", e => {
       	
    	   let storeId = $(e.target).parent().parent().parent().parent().find(".store_id").text(),
   				rsvdId = $(e.target).parent().parent().parent().parent().find(".rsvd_id").text(),
   				revwStus = $(e.target).parent().parent().parent().parent().find(".revw_stus").text(),
   				waitId = $(e.target).parent().parent().parent().parent().find(".wait_id").text();
       	
       	showRevwRegForm(storeId,userId,waitId,rsvdId);
       	modal.css("display","block");
       	
       });
       
       $(".btn_wait").on("click",(e) => {
    		
    		
    		let waitId = $(e.target).parent().parent().parent().parent().find(".wait_id").text();
    		
    		window.open("/dealight/waiting/"+waitId);
    		
    	});
       
       /* 매장 상세 */
       $(".btn_store_info").on("click", e => {
    	   
       	
    	   let storeId = $(e.target).parent().parent().parent().parent().find(".store_id").text(),
	    		userId = '${userId}';
	       	
    	    console.log('storeId.....................'+storeId);
    	   
	       	showStoreInfo(userId,storeId);
	       	modal.css("display","block");
       	
       });
       
       let likeRemoveHandler = function(e){
       	
    	let storeId = $(e.target).parent().parent().parent().parent().parent().parent().find(".store_info_id").text(),
			userId = '${userId}';

		console.log("store id : "+storeId);
		removeLike({userId:userId,storeId:storeId});
		alert("찜이 취소 되었습니다.");		
		showStoreInfo(userId, storeId);
   		
       }
       
       let likeAddHandler = function(e){
       	
       	let storeId = $(e.target).parent().parent().parent().parent().parent().parent().find(".store_info_id").text(),
			userId = '${userId}';

		console.log("store id : "+storeId);
		addLike({userId:userId,storeId:storeId});
		
		alert("찜이 추가 되었습니다.");
	
		showStoreInfo(userId, storeId);
       }
	
}); /* document ready end*/
$(".mypage_side_menu > div").on("click",(e) => {
	
	if(e.currentTarget === "div.side_noti") return;
	
	console.log(e.currentTarget);
	
	location.href = $(e.currentTarget).find("a").attr("href");
	
});
</script>
<%@include file="../../../includes/mainFooter.jsp" %>
</body>
</html>