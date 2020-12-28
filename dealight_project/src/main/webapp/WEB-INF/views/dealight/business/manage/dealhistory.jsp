<!-- 동인 추가 -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@include file="../../../includes/mainMenu.jsp" %>
<!DOCTYPE html>
<html>
<head>
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic&display=swap" rel="stylesheet">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@800&display=swap" rel="stylesheet">
<script src="https://kit.fontawesome.com/0f892675ba.js" crossorigin="anonymous"></script>
<link rel="stylesheet" href="/resources/css/manage.css">
<meta charset="UTF-8">
<title>매장 핫딜 히스토리</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<style>
	        /* 핫딜 */
        #htdl_board{
            width: 100%;
            height: 95%;
            display: flex;
            flex-direction: column;
            justify-content: flex-start;
            align-items: flex-start;
            overflow-y:scroll;
            overflow-x: hidden;
        }
        .htdl_history_tit{
            height: 5%;
            width: 80%;
            font-size: 16px;
            font-weight: bold;
            margin-left: 15px;
            padding-top: 15px;
            padding-bottom:10px;
            border-bottom: 1px solid #eeeeef;
        }
        .htdl_cur_tit{
            width: 50%;
            font-weight: bold;
            margin-left: 15px;
            margin-top: 15px;
        }
        .htdl_cur_wrapper{
            width: 80%;
            height: auto;
            margin-left: 15px;
            margin-top: 15px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: flex-start;
            
        }
        .htdl_cur_row{
            width: 100%;
            height: 200px;
            margin-top: 15px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            border: 1px #eeeeef solid;
        }
        .htdl_cur_wrapper > div:last-child{
            margin-bottom: 15px;
        }
        .htdl_name {
            width: 97%;
            font-size: 20px;
            font-weight: bold;
            
        }
        .htdl_set_name {
            width: 97%;
            font-size: 14px;
            color: gray;
            
        }
        
        .htdl_intro{
            width: 97%;
            
            font-size: 14px;
        }

        .htdl_info_img{
            display:flex;
            flex-direction:row;
            justify-content:center;
            align-items:center;
            width: 100px;
            height: 100%;
        }
        .htdl_info_img > img {
        	width:100px;
        }
        
        .htdl_info_wrapper{
            display: flex;
            flex-direction: row;
            justify-items: flex-start;
            align-items: flex-start;
            width: 97%;
            height: 100px;
            
        }
        .htdl_info{
            margin-left: 20px;
            font-size: 14px;
            height: 100%;
            width: 70%;
            display: flex;
            flex-direction: column;
            justify-items: center;
            align-items: center;
        }
        .htdl_info > div {
            width: 100%;
            height: 25%;
            display: flex;
            flex-direction: row;
            justify-items: flex-start;
            align-items: center;
        }
        .htdl_info_ddct_tit{
            
            color: gray;
            margin-right: 5px;
        }

        .htdl_info_ddct_val {
            
            color: red;
            margin-right: 10px;
        }
        .htdl_info_befprice_tit{
            
            color: gray;
            margin-right: 5px;
        }
        .htdl_info_befprice_val{
            
            text-decoration: line-through;
            margin-right: 10px;
        }
        .htdl_info_aftprice_tit{
            
            color: gray;
            margin-right: 5px;
        }
        .htdl_info_aftprice_val{
            
            margin-right: 10px;
        }
        .htdl_info_period_tit{
            
            color: gray;
            margin-right: 5px;
        }
        .htdl_info_period_val{
            
            margin-right: 10px;
        }
        .htdl_info_lmt_tit{
            
            color: gray;
            margin-right: 5px;
        }
        .htdl_info_lmt_val{
            
            margin-right: 10px;
        }
        .htdl_info_cur_tit{
            
            color: gray;
            margin-right: 5px;
        }
        .htdl_info_cur_val{
            
            margin-right: 10px;
        }
        .htdl_info_stus_tit{
 
            
            color: gray;
            margin-right: 5px;
        }
        .htdl_info_stus_val{
            border: 1px #eeeeef solid;
            display: flex;
            flex-direction: row;
            align-items: center;
            justify-content: center;
            font-size: 12px;
            margin-right: 10px;
            padding: 1px 4px;
            font-weight: bold;
        }

        .htdl_bef_history_tit{
            width: 50%;
            font-weight:bold;
            margin-left: 15px;
            margin-top: 15px;
        }
        .htdl_bef_history_wrapper{
            width: 80%;
            height: auto;
            margin-left: 15px;
            margin-top: 15px;
        }
        .htdl_bef_history_row{
            width: 100%;
            height: 200px;
            margin-top: 15px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            border: 1px #eeeeef solid;
        }
        .htdl_bef_history_wrapper > div:last-child{
            margin-bottom: 15px;
        }
        .htdl_info_rate_tit{
            margin-right: 5px;

        }
        .htdl_info_rate_val{
            color: blue;
        }
        /*pagination */
        
        .panel-footer{
	        display: flex;
	        width: 100%;
	        height: 200px;
	        flex-direction: row;
	        flex-wrap: wrap;
	        justify-content: center;
	        align-content: center;
	        /* margin-top: 60px; */
	        /* left: 33px; */
	    }
	    ul{
	        display: flex;
	        flex-direction: row;
	    }
	    li{
	        /* display: flex;
	        flex-direction: row; */
	        list-style: none;
	        /* outline: 1px solid red; */
	    }
	    .pagination a{
	        color: black;
	        padding: 8px 16px;
	        border-radius : 5px;
	        text-decoration: none;
	    }
	    .pagination a.active{
	        background-color: #D32323;
	        border-radius: 5px;
	        color: white;
	    }
	    .pagination a:hover:not(.active){
	        background-color: #ddd;
	    } 
	</style>
</head>
<body>
<%@include file="../../../includes/manage_nav.jsp" %>
<div id="htdl_board">
       <div class="htdl_history_tit">핫딜 이력</div>
			<div class="htdl_cur_tit">현재 진행중인 핫딜</div>
	             <div class="htdl_cur_wrapper">
			     	<c:if test="${not empty curList}">
	                        <c:forEach items="${curList}" var="htdl">
	                            <div class="htdl_cur_row">
	                             <div class="htdl_name">${htdl.name}</div>
                                <div class="htdl_set_name">세트이름(미정)</div>
                                <div class="htdl_intro">${htdl.intro}</div>
                                <div class="htdl_info_wrapper">
                                    <div class="htdl_info_img">
                                        <img src='/display?fileName=${htdl.htdlImg}'>
                                    </div>
                                    <div class="htdl_info">
                                        <div>
                                            <span class="htdl_info_ddct_tit">할인율</span>
                                            <span class="htdl_info_ddct_val">${htdl.dcRate*100}%</span>
                                            <span class="htdl_info_befprice_tit">할인 전 가격</span>
                                            <span class="htdl_info_befprice_val">${htdl.befPrice}원</span>
                                            <span class="htdl_info_aftprice_tit">할인 후 가격</span>
                                            <span class="htdl_info_aftprice_val">${htdl.befPrice - htdl.ddct}원</span>
                                        </div>
                                        <div>
                                            <span class="htdl_info_period_tit">핫딜 기간</span>
                                            <span class="htdl_info_period_val">${htdl.startTm} - ${htdl.endTm}</span>
                                        </div>
                                        <div>
                                            <span class="htdl_info_lmt_tit">제한 인원</span>
                                            <span class="htdl_info_lmt_val">${htdl.lmtPnum}</span>
                                            <span class="htdl_info_cur_tit">현재 인원</span>
                                            <span class="htdl_info_cur_val">${htdl.curPnum}명</span>
                                        </div>
                                        <div>
                                            <c:if test="${htdl.stusCd eq 'A'}">
                                            	<span class="htdl_info_stus_val">진행중</span>
                                            </c:if>
	                                        <c:if test="${htdl.stusCd eq 'I'}">
                                            	<span class="htdl_info_stus_val">마감</span>
                                            </c:if>
                                            <c:if test="${htdl.stusCd eq 'P'}">
                                            	<span class="htdl_info_stus_val">보류</span>
                                            </c:if>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            </c:forEach>
                        </c:if>
                        </div>
                               
                        <div class="htdl_bef_history_tit">과거 핫딜 내역</div>
                        
	                        <div class="htdl_bef_history_wrapper">
                        <c:if test="${not empty htdlList}">
                        	<c:forEach items="${htdlList}" var="htdl">
	                            <div class="htdl_bef_history_row">
	                                <div class="htdl_name">${htdl.name }</div>
	                                <div class="htdl_set_name">세트이름(미정)</div>
	                                <div class="htdl_intro">${htdl.intro }</div>
	                                <div class="htdl_info_wrapper">
	                                    <div class="htdl_info_img">
	                                    	<img src='/display?fileName=${htdl.htdlImg}'>
	                                    </div>
	                                    <div class="htdl_info">
	                                        <div>
	                                            <span class="htdl_info_ddct_tit">할인율</span>
	                                            <span class="htdl_info_ddct_val">${htdl.dcRate*100}%</span>
	                                            <span class="htdl_info_befprice_tit">할인 전 가격</span>
	                                            <span class="htdl_info_befprice_val">${htdl.befPrice}원</span>
	                                            <span class="htdl_info_aftprice_tit">할인 후 가격</span>
	                                            <span class="htdl_info_aftprice_val">${htdl.befPrice - htdl.ddct }원</span>
	                                        </div>
	                                        <div>
	                                            <span class="htdl_info_period_tit">핫딜 기간</span>
	                                            <span class="htdl_info_period_val">${htdl.startTm } - ${htdl.endTm}</span>
	                                        </div>
	                                        <div>
	                                            <span class="htdl_info_lmt_tit">제한 인원</span>
	                                            <span class="htdl_info_lmt_val">${htdl.htdlRslt.htdlLmtPnum}명</span>
	                                            <span class="htdl_info_cur_tit">신청 인원</span>
	                                            <span class="htdl_info_cur_val">${htdl.htdlRslt.lastPnum}명</span>
	                                            <span class="htdl_info_rate_tit">핫딜 예약률</span>
	                                            <span class="htdl_info_rate_val">${htdl.htdlRslt.rsvdRate}%</span>
	                                        </div>
	                                        <div>
	                                        <c:if test="${htdl.stusCd eq 'A'}">
                                            	<span class="htdl_info_stus_val">진행중</span>
                                            </c:if>
	                                        <c:if test="${htdl.stusCd eq 'I'}">
                                            	<span class="htdl_info_stus_val">마감</span>
                                            </c:if>
                                            <c:if test="${htdl.stusCd eq 'P'}">
                                            	<span class="htdl_info_stus_val">보류</span>
                                            </c:if>
	                                        </div>
	                                    </div>
	                                </div>
	                            </div>
	                            </c:forEach>
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
                        <form id='actionForm' action="/dealight/business/manage/dealhistory" method='get'>
                        	<input type='hidden' name='storeId' value='${storeId}'>
                            <input type='hidden' name='pageNum' value='${pageMaker.cri.pageNum}'>
                            <input type='hidden' name='amount' value = '${pageMaker.cri.amount}'>
                        </form>
	                            </c:if>
                   </div>
                        </div>

<%@include file="../../../includes/manage_nav_bot.jsp" %>
<%@include file="../../../includes/mainFooter.jsp" %>
<script src="/resources/js/clock.js"></script>
<script>

const storeId = ${storeId};

showTime(); // 현재 시간을 보여주는 코드
setInterval(showTime, 1000); // 매초 update

// '매장'의 정보를 가져온다.
function getStore(param,callback,error) {
    
    let storeId = param.storeId;

    $.getJSON("/dealight/business/manage/board/store/"+storeId+".json",
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

function showStoreInfo (storeId){
	
	getStore({storeId : storeId}, function (store) {
        let strStoreInfo = "";
        if(store == null){
        	storeInfoDiv.html("");
            return;
        }
        
        /*착석 상태*/
        let colors = document.getElementsByClassName("btn_seat_stus");
        for(let i = 0; i < colors.length; i++){
        	if(colors[i].dataset.color[0] === store.bstore.seatStusCd)
        		colors[i].className += " curStus";
        }
	})
};

showStoreInfo(storeId);

//매장의 착석 상태 코드를 변경한다.
function putChangeStatusCd(params,callback,error) {
	
	let storeId = params.storeId,
		seatStusCd = params.seatStusCd;
	
    $.ajax({
        type:'put',
        url:'/dealight/business/manage/board/seat/'+storeId+'/'+seatStusCd,
        data : {},
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

let changeSeatStusHandler = function(e) {
	
    e.preventDefault();
    
    let color = "";

    let param = {};
    param.storeId = storeId;
    
    if(e.target.dataset.color) param.seatStusCd = e.target.dataset.color[0];
    if(e.target.parentNode.dataset.color) param.seatStusCd = e.target.parentNode.dataset.color[0];
    if(e.target.parentNode.parentNode.dataset.color) param.seatStusCd = e.target.parentNode.parentNode.dataset.color[0];
    
    //param.seatStusCd = e.target.dataset.color[0];
    $(".btn_seat_stus").removeClass("curStus");
    e.target.className += " curStus";
    
	putChangeStatusCd(param, function(result){
    	showStoreInfo(param.storeId);
	});
}
/* 매장 착석 상태 처리*/
$(".btn_seat_stus").on("click",changeSeatStusHandler);



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
</script>
</body>
</html>