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
<style>
.mypage_main_sub > div{
	width : 100%;
}
.btn_like_cancel{
	color : tomato;
	cursor: pointer;
}
.btn_like_cancel:hover{
	opacity: 0.7;
}
</style>
</head>
<body>
<main>
        <div class="mypage_wrapper">
        <%@include file="/WEB-INF/views/includes/mypageSidebar.jsp" %>
        
        <div class="mypage_right">
                <div class="mypage_main_header">
                    <div class="main_header_title">찜 목록</div>
                    <div class="main_header_subtitle">찜한 매장 목록을 가져옵니다.</div>
                </div>
                <div class="mypage_main_content">
                    <div class="mypage_main_sub">
                        <div>
                            <span class="main_tit">총 찜 횟수</span>
                            <span class="main_value total">${total} 회</span>
                        </div>
                    </div>
                    <div class="mypage_main_board">
	                    <c:if test="${empty storeList}">
							<h2>찜을 한 이력이 없습니다.</h2>
						</c:if>
						
						<c:if test="${not empty storeList}">
							<c:forEach items="${storeList}" var="store">
	                        <div class="rsvd_wrapper">
	                            <div class="css_rsvd_box">
	                                <div class="rsvd_tit">
	                                    <div>
	                                    	<div class="btn_like_cancel">
	                                    	 	<i class='fas fa-heart'></i>
	                                        </div>
	                                    	<span style='display:none;' class="store_id">${store.storeId}</span>
	                                    </div>
	                                    <div><button class="btn_store_dtls"><i class="fas fa-angle-right"></i></button></div>
	                                </div>
	                                <div class="rsvd_cnts">
	                                    <div class="rsvd_cnts_wrapper">
	                                        <div class="rsvd_cnts_img">
	                                        <img src='/display?fileName=${store.bstore.repImg}'>
	                                        </div>
	                                        <div class="cnts">
	                                        	<div>
	                                        		<span class="rsvd_cnts_tit">매장이름</span>
	                                                <span class="rsvd_cnts_val">${store.storeNm}</span>
	                                        	</div>
	                                            <div>
	                                                <span class="rsvd_cnts_tit">영업시간</span>
	                                                <span class="rsvd_cnts_val">${store.bstore.openTm} - ${store.bstore.closeTm}</span>
	                                            </div>
	                                        </div>
	                                    </div>
	                                    <div class="rsvd_btn_box">
	                                        <button class="btn_store_info">매장 정보 보기</button>
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
			<form id='actionForm' action="/dealight/mypage/like" method='get'>
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
			<div class="modal_wrapper_store_info content_div"></div>
		</div>
	</div>
	
	
<script type="text/javascript" src="/resources/js/modal.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	
    const userId = '${userId}',
	    storeInfoUL = $(".store_info"),
	    likeListDiv = $(".mypage_main_board"),
	    paginationUL = $(".pagination"),
	    totalDiv = $(".total"),
	    btn_show_board = $("#btn_show_board"),
	    storeInfoDiv = $(".modal_wrapper_store_info"),
	    pageNum = ${pageMaker.cri.pageNum},
	    amount = ${pageMaker.cri.amount}
	    
	    ;
	    
    let container,options,map,mapContainer,mapOption,markerPosition,marker;

    function getStoreInfo(params,callback,error){
       	
    	let storeId = params.storeId,
		userId = params.userId;
       	
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
	
    /* 출력 로직*/
    function showStoreInfo(userId,storeId) {
    	
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
    	
    }
    
	    /*delete 함수*/
	    function removeLike(params,callback,error) {
	    	
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
	    
	    function getLikeList(params,callback,error) {
	    	
	    	let pageNum = params.pageNum,
	    		amount = params.amount,
	    		userId = params.userId
	    	;
	    	
	    	$.getJSON("/dealight/mypage/like/list/"+ pageNum +"/"+ amount+ "/" + userId + ".json",
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
	    
	    function showLikeList(pageNum,amount,userId) {
	    	
	    	getLikeList({pageNum:pageNum,amount:amount,userId : userId}, dto => {
	    		
                let strLikeList = "",
                	strPagination = "",
                	strTotal = "";
                
                if(!dto.storeList){
                	likeListDiv.html("<h2>찜을 한 이력이 없습니다.</h2>");
                	paginationUL.html("");
                    return;
                }
                
                if(dto.storeList)
                dto.storeList.forEach(store => {
                	strLikeList += "<div class='rsvd_wrapper'>";
                	strLikeList += "<div class='css_rsvd_box'>";
                	strLikeList += "<div class='rsvd_tit'>";
                	strLikeList += "<div>";
                	strLikeList += "<div class='btn_like_cancel'>";
                	strLikeList += "<i class='fas fa-heart'></i>";
                	strLikeList += "</div>";
                	strLikeList += "<span style='display:none;' class='store_id'>"+store.storeId+"</span>";
                	strLikeList += "</div>";
                	strLikeList += "<div><button class='btn_store_dtls'><i class='fas fa-angle-right'></i></button></div>";
                	strLikeList += "</div>";
                	strLikeList += "<div class='rsvd_cnts'>";
                	strLikeList += "<div class='rsvd_cnts_wrapper'>";
                	strLikeList += "<div class='rsvd_cnts_img'>";
                	strLikeList += "<img src='/display?fileName="+store.bstore.repImg+"'>";
                	strLikeList += "</div>";
                	strLikeList += "<div class='cnts'>";
                	
                	strLikeList += "<div>";
                	strLikeList += "<span class='rsvd_cnts_tit'>매장이름</span>";
                	strLikeList += "<span class='rsvd_cnts_val'>"+store.storeNm+"</span>";
                	strLikeList += "</div>";
                	strLikeList += "<div>";
                	strLikeList += "<span class='rsvd_cnts_tit'>영업시간</span>";
                	strLikeList += "<span class='rsvd_cnts_val'>"+store.bstore.openTm+ "-" +store.bstore.closeTm+"</span>";
                	strLikeList += "</div>";
                	
                	strLikeList += "</div>";
                	strLikeList += "</div>";
                	
                	strLikeList += "<div class='rsvd_btn_box'>";
                	strLikeList += "<button class='btn_store_info'>매장 정보 보기</button>";
                	strLikeList += "</div>";
                	
                	strLikeList += "</div>";
                	strLikeList += "</div>";
                	strLikeList += "</div>";
                	
                });
                
                likeListDiv.html(strLikeList);
                
                if(dto.pageMaker.prev){
                	strPagination += "<li class='paginate_button previous'>";
                	strPagination += "<a href='" + (dto.pageMaker.startPage -1) +"'>Previous</a></li>";
                }
				for(let i = dto.pageMaker.startPage; i < dto.pageMaker.endPage + 1; i++) {
					console.log("dto.pageMaker.cri.pageNum "+i+" :" + dto.pageMaker.cri.pageNum);
					strPagination += "<li class='paginate_button' "+ (dto.pageMaker.cri.pageNum === i ? 'active' : '') +">";
					strPagination += "<a href='"+i+"'>"+i+"</a></li>";
				}				
			
				if(dto.pageMaker.next){
                	strPagination += "<li class='paginate_button next'>";
                	strPagination += "<a href="+(dto.pageMaker.endPage+1)+">Next</a>";
                }
					
				paginationUL.html(strPagination);
				
            	strTotal = dto.total + " 회";
            	
				totalDiv.html(strTotal);
				
		    	let strForm = '';
		    	
		    	strForm += "<input type='hidden' name='pageNum' value='"+pageNum+"'>";
		    	strForm += "<input type='hidden' name='amount' value = '"+amount+"'>";
		    	
		    	$(".paginate_button a").on("click", pagingHandler);
		    	
		        $(".btn_store_info").on("click", storeInfoHandler);
		        
		        $(".btn_remove").on("click", likeRemoveHandler);
		        
		        $(".btn_like_cancel").on("click", likeRemoveHandler);
				
	    	}); //end get like list
	    	
	    } // end show like list
	    
	let actionForm = $("#actionForm");
	
	let pagingHandler = function (e) {
		
		e.preventDefault();
		
		console.log("page click");
		
		actionForm.find("input[name='pageNum']").val($(this).attr("href"));
		actionForm.submit();
	}
    
    let storeInfoHandler = function (e) {
    	let storeId = $(e.target).parent().parent().parent().parent().find(".store_id").text(),
    		userId = '${userId}';
    	
    	showStoreInfo(userId, storeId);
    	modal.css("display","block");
    };
    
    let likeRemoveHandler = function(e){
    	
    	let storeId = $(e.target).parent().parent().parent().parent().parent().find(".store_id").text(),
			userId = '${userId}';
		
		removeLike({userId:userId,storeId:storeId}, function(){
			location.reload();
		});
		//showLikeList($("input[name='pageNum']").val(),$("input[name='amount']").val(),userId);
		
		
		alert('찜이 취소 되었습니다.');
    }
    
    // 페이징 이벤트 등록
	$(".paginate_button a").on("click", pagingHandler);
	
    /* 매장 상세 */
    $(".btn_store_info").on("click", storeInfoHandler);
    
    /* like 삭제 */
    $(".btn_like_cancel").on("click", likeRemoveHandler);
    
    $(".btn_store_dtls").on("click", (e) => {
    	console.log("store dtls btn click....................")
    	location.href = "/dealight/store/" + $(e.target).parent().parent().parent().parent().find(".store_id").text();
    });
    
	
}); /* document ready end*/
$(".mypage_side_menu > div").on("click",(e) => {
	
	if(e.currentTarget === "div.side_noti") return;
	
	console.log(e.currentTarget);
	
	location.href = $(e.currentTarget).find("a").attr("href");
	
});
</script>
<%@include file="../../includes/mainFooter.jsp" %>
</body>
</html>