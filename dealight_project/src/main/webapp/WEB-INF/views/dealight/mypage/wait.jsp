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
<script src="/resources/js/Rater.js"></script>
</head>
<body>
    <main class="mypage_wrapper">
        <%@include file="/WEB-INF/views/includes/mypageSidebar.jsp" %>
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
								<h3>웨이팅 번호 : <span class="wait_id">${wait.waitId}</span></h3>
								<h5>매장번호 : <span class="store_id">${wait.storeId}</span></h5></br>
								날짜 : ${wait.waitRegTm } </br>
								인원 : ${wait.waitPnum }</br>
								이용자 전화번호 : ${wait.custTelno }</br>
								이용자 이름 : ${wait.custNm }</br>
								현재 웨이팅 상태 : ${wait.waitStusCd}<br>
								리뷰 상태 : <span class="revw_stus">${wait.revwStus }</span></br>
								<button class="btn_store_info">매장 정보 보기</button>
								<c:if test="${wait.revwStus > 0}"> <button class="btn_revw_info">리뷰 보기</button></c:if>
								<c:if test="${wait.revwStus == 0}"><button class="btn_revw_reg">리뷰 쓰기</button></c:if>
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
	
    const userId = '${userId}',
	    revwRegFormUL = $(".revw_regForm"),
	    storeInfoUL = $(".store_info"),
	    btn_show_board = $("#btn_show_board"),
	    revwInfoUL = $(".revwInfo")
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
       
       let getWaitRevw = function (param,callback,error) {
    	   
    	   let waitId = param.waitId;
    	   
          	$.getJSON("/dealight/mypage/review/wait/"+ waitId +".json",
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
       
      let showWaitRevw = function (waitId) {
    	
    	getWaitRevw({waitId : waitId}, revw => {
    		
    		let strRevw = "";
    		if(!revw) return;
    		
    		strRevw += "<h1>리뷰 보기</h1>";
    		strRevw += "<h5>리뷰 번호 : "+revw.revwId+"</h5>";
    		strRevw += "<h5>매장 번호 : "+revw.storeId+"</h5>";
    		strRevw += "<h5>매장 이름 : "+revw.storeNm+"</h5>";
    		strRevw += "<h5>웨이팅 번호 : "+revw.waitId+"</h5>";
    		strRevw += "<h5>회원 아이디 : "+revw.userId+"</h5>";
    		strRevw += "<h5>리뷰 내용 : "+revw.cnts+"</h5>";
    		strRevw += "<h5>평점 : "+revw.rating+"</h5>";
    		strRevw += "<h5>답글 내용 : "+revw.replyCnts+"</h5>";
    		strRevw += "<h5>답글 등록 날짜 : "+revw.replyRegDt+"</h5>";
    		strRevw += "<div class='rating' data-rate-value='"+revw.rating+"'></div>";
    		strRevw += "<h5>리뷰 사진</h5>";
    		for(let i = 0; i < revw.imgs.length; i++)
    			if(revw.imgs[i].fileName !== null) strRevw += "<img src='/display?fileName="+encodeURIComponent(revw.imgs[i].uploadPath+"/s_"+revw.imgs[i].uuid+"_"+revw.imgs[i].fileName)+"'>";
    		
    		revwInfoUL.html(strRevw);
    		
    		/* Rater.js 로직*/
	        $(".rating").rate({
	            max_value: 5,
	            step_size: 0.5,
	            initial_value: 3,
	            selected_symbol_type: 'utf8_star', // Must be a key from symbols
	            cursor: 'default',
	            readonly: true,
	        });
    	});
    };
       
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
       	
       }
       
       /* 리뷰 등록 폼을 보여준다.*/
       function showRevwRegForm(storeId,userId,waitId){
    	   
    	let strRevwRegForm = "";    			
    			
    	getStoreInfo({userId:userId,storeId : storeId}, store=>{
    		
    		console.log("get store info..................");
       		
       		if(!store)
       			return;
       	
	       	
	       	strRevwRegForm += "<h1>리뷰 작성</h1>";
	       	strRevwRegForm += "<form id='revwRegForm' action='/dealight/mypage/review/register' method='post'>";
	       	strRevwRegForm += "매장 번호 : <input name='storeId' value='"+store.storeId+"' readonly></br>";
	       	strRevwRegForm += "매장 이름 : <input name='storeNm' value='"+store.storeNm+"' readonly></br>";
	       	strRevwRegForm += "웨이팅 번호 : <input name='waitId' value='"+waitId+"' readonly></br>";
	       	strRevwRegForm += "회원 아이디 : <input name='userId' value='"+userId+"' readonly></br>";
	       	strRevwRegForm += "리뷰 내용 : <input type='textarea' name='cnts' id=''></br>";
	       	strRevwRegForm += "평점 주기"
		    strRevwRegForm += "<div class='rating' data-rate-value=3></div>";
		    strRevwRegForm += "<input name='rating' id='rate_input' hidden>";
	       	strRevwRegForm += "파일첨부 : <div class='file_body'>"; 
	       	strRevwRegForm += "<div class='form_img'><input id='js_upload' type='file' name='uploadFile' multiple></div>";
	       	strRevwRegForm += "<div class='uploadResult'><ul></ul></div></div>";
	       	strRevwRegForm += "<input name='prevPage' value='wait' id='' hidden>";
	       	strRevwRegForm += "<div class='bigPictureWrapper'><div class='bigPicture'></div></div>";
	       	strRevwRegForm += "</form>";
	       	strRevwRegForm += "<button id='submit_revwRegForm'>제출하기</button>";
	       	
	       	revwRegFormUL.html(strRevwRegForm);
	       	
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
       
   	let showRevwRegFormHandler =  function(e) {
       	let storeId = $(e.target).parent().find(".store_id").text(),
	   		waitId = $(e.target).parent().find(".wait_id").text(),
	   		revwStus = $(e.target).parent().find(".revw_stus").text();
       	
	    if(revwStus > 0) return;
		
       	showRevwRegForm(storeId,userId,waitId);
       	modal.css("display","block");
	}
   	
    let showWaitRevwHandler = function(e) {
    	
    	let waitId = $(e.target).parent().find(".wait_id").text();
    	
    	showWaitRevw(waitId);
    	modal.css("display","block");
    	
    }
   	
	let showStoreInfoHandler = function(e) {
    	let storeId = $(e.target).parent().find(".store_id").text(),
    		userId = '${userId}';
    	showStoreInfo(userId,storeId);
    	modal.css("display","block");
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
       
       /* 리뷰 등록 */
       $(".btn_revw_reg").on("click",showRevwRegFormHandler);
       
       /* 리뷰 보기 */
       $(".btn_revw_info").on("click", showWaitRevwHandler);
       
       /* 매장 상세 */
       $(".btn_store_info").on("click",showStoreInfoHandler);
       
	    $(".btn_like_pick").on("click",likeAddHandler);
	    $(".btn_like_cancel").on("click",likeRemoveHandler);
	
}; /* document ready end*/

</script>
<%@include file="../../includes/mainFooter.jsp" %>
</body>
</html>