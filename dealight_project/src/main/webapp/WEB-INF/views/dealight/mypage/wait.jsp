<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../../includes/mainMenu.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>딜라이트</title>
<link rel="stylesheet" href="/resources/css/mypage.css?ver=1" type ="text/css" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=9a6bde461f2e377ce232962931b7d1ce"></script>
<script src="/resources/js/Rater.js"></script>
<link rel="stylesheet" href="/resources/css/fileupload.css">
</head>
<body>
	<main>
        <div class="mypage_wrapper">
        <%@include file="/WEB-INF/views/includes/mypageSidebar.jsp" %>
        
        <div class="mypage_right">
                <div class="mypage_main_header">
                    <div class="main_header_title">웨이팅 내역</div>
                    <div class="main_header_subtitle">회원님의 지난 웨이팅 내역을 가져옵니다.</div>
                </div>
                <div class="mypage_main_content">
                    <div class="mypage_main_sub">
                        <div>
                            <span class="main_tit">입장 횟수</span>
                            <span class="main_value">${enterCnt} 회</span>
                        </div>
                        <div>
                            <span class="main_tit">노쇼 횟수</span>
                            <span class="main_value">${panaltyCnt} 회</span>
                        </div>
                        <div>
                            <span class="main_tit">총 웨이팅 횟수</span>
                            <span class="main_value">${total} 회</span>
                        </div>
                    </div>
                    <div class="mypage_main_board">
	                    <c:if test="${empty waitList}">
							<h2>웨이팅 이력이 없습니다.</h2>
						</c:if>
						
						<c:if test="${not empty waitList}">
							<c:forEach items="${waitList}" var="wait">
	                        <div class="rsvd_wrapper">
	                            <div class="css_rsvd_time">
	                                <span>${wait.waitRegTm }</span>
	                            </div>
	                            <div class="css_rsvd_box">
	                                <div class="rsvd_tit">
	                                    <div>
	                                    	웨이팅 번호 : <span class="wait_id">${wait.waitId}</span>
	                                    	<span style='display:none;' class="revw_stus">${wait.revwStus}</span>
	                                    	<span style='display:none;' class="store_id">${wait.storeId}</span>
	                                    </div>
	                                    <div><button class="btn_wait"><i class="fas fa-angle-right"></i></button></div>
	                                </div>
	                                <div class="rsvd_cnts">
	                                    <div class="rsvd_cnts_wrapper">
	                                        <div class="rsvd_cnts_img">
	                                        <img src='/display?fileName=${wait.storeRepImg}'>
	                                        
	                                        </div>
	                                        <div class="cnts">
	                                            <div>
	                                                <span class="rsvd_cnts_tit">웨이팅 인원</span>
													<span class="rsvd_cnts_val">${wait.waitPnum }명</span>
	                                            </div>
	                                            <div>
	                                            	<span class="rsvd_cnts_tit">웨이팅 상태</span>
	                                                <c:if test="${wait.waitStusCd eq 'W'}">
	                                                	<span class="rsvd_cnts_val wait_stus_cd" style="color:blue;">웨이팅</span>
	                                                </c:if>
	                                                <c:if test="${wait.waitStusCd eq 'E'}">
	                                                	<span class="rsvd_cnts_val wait_stus_cd">입장</span>
	                                                </c:if>
	                                                <c:if test="${wait.waitStusCd eq 'P'}">
	                                                	<span class="rsvd_cnts_val wait_stus_cd" style="color:red;">노쇼</span>
	                                                </c:if>
	                                                <c:if test="${wait.waitStusCd eq 'C'}">
	                                                	<span class="rsvd_cnts_val wait_stus_cd" style="color:red;">취소</span>
	                                                </c:if>
	                                            </div>
	                                        </div>
	                                    </div>
	                                    <div class="rsvd_btn_box">
	                                        <button class="btn_store_info">매장 정보 보기</button>
	                                        <c:if test="${wait.revwStus > 0}"> <button class="btn_revw_info">리뷰 보기</button></c:if>
											<c:if test="${wait.revwStus == 0 && wait.waitStusCd eq 'E'}"><button class="btn_revw_reg">리뷰 쓰기</button></c:if>
	                                    </div>
	                                </div>
	                            </div>
	                        </div>
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
			<form id='actionForm' action="/dealight/mypage/wait" method='get'>
				<input type='hidden' name='pageNum' value='${pageMaker.cri.pageNum}'>
				<input type='hidden' name='amount' value = '${pageMaker.cri.amount}'>
			</form>
    </main>
    
    <div id="myModal" class="modal">
		<!-- Modal content -->
		<div class="modal-content">
			<span class="close_modal"><i class="fas fa-times"></i></span>
	        <div class="modal_header"></div>
			<ul class="revw_regForm"></ul>
			<ul class="store_info"></ul>
			<ul class="revwInfo"></ul>
			<div class="modal_wrapper_revw_reg content_div"></div>
			<div class='modal_wrapper_revw_info content_div'></div>
			<div class="modal_wrapper_store_info content_div"></div>
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
	    revwInfoUL = $(".revwInfo"),
	    revwInfoDiv = $(".modal_wrapper_revw_info"),
	    storeInfoDiv = $(".modal_wrapper_store_info"),
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
    		
    		strRevw += "<div class='modal_tit'>";
    		strRevw += "<span>리뷰 보기</span>";
    		strRevw += "</div>";
    		strRevw += "<div class='modal_top_revw'>";
    		strRevw += "<div class='revw_reg_wrapper'>";
    		strRevw += "<div class='revw_store_info'>";
    		strRevw += "<div class='revw_store_name'>"+revw.storeNm+"</div>";
    		strRevw += "<div class='revw_rsvd_id'>";
    		strRevw += "<span>리뷰 등록 날짜 : "+revw.regdate+"</span>";
    		strRevw += "</div>";
    		strRevw += "</div>";
    		strRevw += "<div class='revw_info_wrapper' action='/dealight/mypage/review/register' method='post'>";
    		strRevw += "<div class='revw_rate_wrapper'>";
    		strRevw += "<div class='rating' data-rate-value='"+revw.rating+"'></div>";
    		strRevw += "</div>";
    		strRevw += "<div class='revw_cnts_textarea'>";
    		strRevw += "<textarea cols='30' row='20' name='cnts' readonly>"+revw.cnts+"</textarea>";
    		strRevw += "</div>";
    		strRevw += "<input name='rating' id='rate_input' hidden>";
    		if(revw.imgs[0].imgSeq !== null){     			
    		strRevw += "<div class='revw_img_box'>";
    		strRevw += "<div class='revw_img_wrapper'>";
    		for(let i = 0; i < revw.imgs.length; i++)
    			if(revw.imgs[i].fileName !== null) 
    				strRevw += "<img src='/display?fileName="+encodeURIComponent(revw.imgs[i].uploadPath+"/s_"+revw.imgs[i].uuid+"_"+revw.imgs[i].fileName)+"'>";
    		strRevw += "</div>";
    		strRevw += "</div>";
    		}
    		if(revw.replyCnts){
    			
    		strRevw += "<div class='reply_wrapper'>";
    		strRevw += "<div class='reply_item'>";
    		strRevw += "<div class='reply_item_icon'>";
    		strRevw += "<i class='fas fa-reply'></i>";
    		strRevw += "<div class='reply_item_name'>"+revw.storeNm+"</div>";
    		strRevw += "<div class='reply_item_date'>"+revw.replyRegDt+"</div>";
    		strRevw += "</div>";
    		strRevw += "<div class='reply_cnts_wrapper'>";
    		strRevw += "<div class='reply_cnts'>";
    		strRevw += revw.replyCnts;
    		strRevw += "</div>";
    		strRevw += "</div>";
    		strRevw += "</div>";
    		}
    		strRevw += "</div>";
    		strRevw += "</div>";
    		
    		revwInfoDiv.css("display","block");
    		revwInfoDiv.html(strRevw);
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
       
    // 매장 정보를 보여준다.
    let showStoreInfo = function (userId,storeId) {
    	
    	console.log("user id : "+userId);
    	console.log("store id : "+storeId);
    	
    	getStoreInfo({userId:userId,storeId : storeId}, store => {
    		
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
       
    /* 리뷰 등록 폼을 보여준다.*/
    let showRevwRegForm = function (storeId,userId,waitId){
 	   
 	let strRevw = "";    			
 			
 	getStoreInfo({userId : userId, storeId : storeId}, store => {
 		
 		console.log("get store info..................");
    		
    		if(!store)
    			return;
    		
    		
    		strRevw += "<div class='modal_tit'>";
            strRevw += "<span>리뷰 작성</span>";
            strRevw += "</div>";
            strRevw += "<div class='modal_top_revw'>";
    		strRevw += "<div class='revw_reg_wrapper'>";
    		strRevw += "<div class='revw_store_info'>";
    		strRevw += "<div class='revw_store_name'>"+store.storeNm+"</div>";
    		strRevw += "<div class='revw_rsvd_id'>웨이팅 번호 : "+waitId+"</div>";
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
    		strRevw += "<input name='waitId' value='"+waitId+"' hidden>";
    		strRevw += "<input name='rating' id='rate_input' hidden>";
    		strRevw += "<input name='userId' value='"+userId+"' hidden>";
    		strRevw += "<input name='prevPage' value='wait?pageNum="+pageNum+"&amount="+amount+"' id='' hidden>";
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
       
   	let showRevwRegFormHandler =  function(e) {
       	let storeId = $(e.target).parent().parent().parent().parent().find(".store_id").text(),
	   		waitId = $(e.target).parent().parent().parent().parent().find(".wait_id").text(),
	   		revwStus = $(e.target).parent().parent().parent().parent().find(".revw_stus").text();
       	
       	console.log("store id : "+storeId);
    	console.log("wait id : "+waitId);
    	console.log("revw stus : "+revwStus);
       	
	    if(revwStus > 0) return;
		
       	showRevwRegForm(storeId,userId,waitId);
       	modal.css("display","block");
	}
   	
    let showWaitRevwHandler = function(e) {
    	
    	let waitId = $(e.target).parent().parent().parent().parent().find(".wait_id").text();
    	
    	console.log("wait id : "+waitId);
    	
    	showWaitRevw(waitId);
    	modal.css("display","block");
    	
    }
   	
	let showStoreInfoHandler = function(e) {
    	let storeId = $(e.target).parent().parent().parent().parent().find(".store_id").text(),
    		userId = '${userId}';
    		
    	console.log("store id : "+storeId);
    	console.log("user id : "+userId);
    		
    	showStoreInfo(userId,storeId);
    	modal.css("display","block");
	}
	
    let likeRemoveHandler = function(e){
    	
    	let storeId = $(e.target).parent().parent().parent().parent().parent().parent().find(".store_info_id").text(),
			userId = '${userId}';

		console.log()
		removeLike({userId:userId,storeId:storeId});
		alert("찜이 취소 되었습니다.");		
		showStoreInfo(userId, storeId);
		
    }
    
    let likeAddHandler = function(e){
    	
    	let storeId = $(e.target).parent().parent().parent().parent().parent().parent().find(".store_info_id").text(),
			userId = '${userId}';

		addLike({userId:userId,storeId:storeId});
		
		alert("찜이 추가 되었습니다.");

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

$(".btn_wait").on("click",(e) => {
	
	
	let waitId = $(e.target).parent().parent().parent().parent().find(".wait_id").text();
	
	window.open("/dealight/waiting/"+waitId);
	
});

$(".mypage_side_menu > div").on("click",(e) => {
	
	if(e.currentTarget === "div.side_noti") return;
	
	console.log(e.currentTarget);
	
	location.href = $(e.currentTarget).find("a").attr("href");
	
});

</script>
<%@include file="../../includes/mainFooter.jsp" %>
</body>
</html>