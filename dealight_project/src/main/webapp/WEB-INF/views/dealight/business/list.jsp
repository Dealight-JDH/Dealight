<!-- 동인 추가 -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@include file="../../includes/mainMenu.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>딜라이트</title>
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic&display=swap" rel="stylesheet">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@800&display=swap" rel="stylesheet">
<script src="https://kit.fontawesome.com/0f892675ba.js" crossorigin="anonymous"></script>
<link rel="stylesheet" href="/resources/css/manage.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<style>
	main{
		margin : 30px auto;
		width:1050px;
		height:auto;
	}
	.buser_wrapper{
		border:1px black solid;
	}
</style>
    <style>
        /*@import url(//fonts.googleapis.com/earlyaccess/nanumgothic.css); 
        .nanum { font-family: 'Nanum Barun Gothic'; }*/
        .store_box{
            
            width:80%;
            min-width:1050px;
            height: auto;
            
            min-width: 1025px;
            min-height: 800px;

            border-radius: 10px;
            display: flex;
            flex-direction: column;
            justify-content: flex-start;
            align-items: center;
            background-color: #f4f5f7;
            padding-bottom : 25px;
        }
        .store_box_tit{
            font-size: 24px;
            font-weight: bold;
            color: white;
            align-self: start;
            margin-top: 30px;
            margin-left: 25px;
            padding: 7px 15px;
            border-radius: 15px;
            background-color: rgba(128, 128, 128, 0.575);
            text-shadow: 2px 2px 8px rgba(0,0,0,0.3);
        }
        .store_card{
            cursor: pointer;
            display: flex;
            font-size: 12px;
            border-left: 14px solid black;
            width: 600px;
            height: 250px;
            background: white;
            border: 1px solid #e6e6e6;
            
            border-radius: 5px;
            margin-bottom : 25px;
            /*box-shadow: 2px 2px 8px rgba(0,0,0,0.3);*/
        }
        
        .store_card:hover{
           opacity: 0.7;
           box-shadow: 2px 2px 8px rgba(0,0,0,0.3);
        }
        .store_card:hover .brno_content_wrapper{
            filter: blur(0);
        }
        .store_info_wrapper{
            margin: auto auto;
            
            width: 90%;
            height: 80%;
            display: flex;
            flex-direction: row;
        }
        .store_info_i{
            height: 50%;
            width: 100%;
            /*border: black 1px solid;*/
            display: flex;
            flex-direction: row;
            justify-content: flex-start;
            margin-bottom: 30px;
        }
        .store_info_i.left{
            position: relative;
            /*border: 1px solid black;*/
            width: 100%;
            height: 100%;
        }
        .store_info_i.left.top{
            width: 70%;
        }
        .store_info_i.right.top{
            width: 30%;
        }
        .store_info_i.left span{
            
        }
        
        .store_name{
            position: absolute;
            top: 15px;
            font-size: 28px;
            color: rgba(26, 19, 19, 0.767);
            font-weight: bold;
            
        }
        .store_brch{
            position: absolute;
            top: 60px;
            opacity: 40%;
            left: 7px;
            font-weight: bold;
            font-size: 12px;
        }
        
        .store_info_i.right{
            width: 100%;
            height: 100%;
            display:flex;
            flex-direction: column;
            justify-content: center;
            align-items: flex-end;
        }
        .store_info_i_r{
            /*border: 1px black solid;*/
            border-radius: 10px;
            margin: 5px;
        }
        .store_info_wrapper_inner{
            display: flex;
            flex-direction: column;
            justify-content: flex-start;
            width: 60%;
            height: 100%;
        }
        .store_info_wrapper_right{
            height: 100%;
            width: 40%;
            
            display: flex;
        }
        .store_img_box{
            display: flex;
            flex-direction: row;
            justify-content: center;
            width: 100%;
            height: 80%;
            margin: 20px 0 20px 40px;
            border-radius: 10px;
            border: 1px solid #e6e6e6;
            /*box-shadow: 2px 2px 8px rgba(0,0,0,0.3);*/
            overflow: hidden;
            align-items: center;
        }
        .store_img_box > img{
            
            width:200px;
            height:200px;
            
            text-align: center;
        }

        .store_info_i.right{
            position: relative;
        }
        .store_stus{
            position: absolute;
            top: 20px;
            right: 5px;
            /*border: 1px red solid;*/
            background-color: #ED5650;
            border-radius: 20px;
            padding: 3px 7px;
            font-size: 12px;
            font-weight: bold;
            color: white;
            text-shadow: 1px 1px 3px rgba(0,0,0,0.3);
            box-shadow: 1px 1px 3px rgba(0,0,0,0.3);
        }
        .store_telno{
            position: absolute;
            color: gray;
            font-weight: bold;
            top : 60px;
            right: 5px;
        }
        .bar{
            padding: 0 4px 0 3px;
        }
        .store_info_i.left{
            display: flex;
            flex-direction: column;
            justify-content: flex-end;
           	align-items: flex-start;
        }
        .store_open_tit{
            font-size: 14px;
            font-weight: bold;
            color: white;
            border-radius: 20px;
            padding: 3px 7px;
            background-color: gray;
            box-shadow: 1px 1px 3px rgba(0,0,0,0.3);
            text-shadow: 1px 1px 3px rgba(0,0,0,0.3);
            margin-bottom: 10px;
        }
        .store_open_tm{
            font-size: 24px;
            font-weight: bold;
        }
        .store_cur_rsvd{
            font-size: 14px;
            font-weight: bold;
        }
        .store_cur_wait{
            font-size: 14px;
            font-weight: bold;
        }
        .store_plus{
            position: relative;
            margin:auto auto; 
            text-align: center; 
            font-size: 64px; 
            font-weight: lighter;
        }
        .plus_box{
            width: 40%; 
            height: 60%; 
            margin: auto auto; 
            color: green;
            /*border: 1px solid black; */
            display: flex;
            flex-direction: row;
            align-items: center;
            justify-content: center;
        }
        .store_plus:hover{
            margin:auto auto; 
            text-align: center; 
            font-weight: lighter;
            opacity: 0.4;
        }

        .brno_content_wrapper{
            position: absolute;
            display: inline;
            font-size: 12px;
            line-height: 20px;
            padding-top: 70px;
            padding-left: 40px;
            color: gray;
            font-weight: bold;
        }
        #store_cur_info{
        	display: flex;
        	flex-direction:column;
        	justify-content: flex-end;
        	align-items: flex-end;
        }
        
        .board_left_bot > div{
        	display: none;
        }
        #btn_wait_register_id{
        	display: flex;
        	height: 20%;
        }
        #store_info_box{
        	display: flex;
        }
        
        
        /**/
        #list_board{
        	position:relative;
        	width: 100%;
            height: 95%;
            display: flex;
            flex-direction: column;
            justify-content: flex-start;
            align-items: flex-start;
            overflow-y:scroll;
            overflow-x: hidden;
        }
        #list_board > a{
        	
        	margin : 10px 0 0 30px;
        }
        #list_board > a:first-child {
        	marign-top : 20px;
        }
        #list_board > .store_card	{
        	
        	margin : 10 0 0 30px;
        }
        .store_card{
        	position: relative;
        }
        .store_list_tit{
        	width : 80%;
        	font-size: 24px;
        	font-weight: bold;
        	margin : 20px 30px;
        	padding-bottom : 20px;
        	border-bottom: 1px solid #eeeeef;
        }
        #fixed_img {
        	position: absolute;
        	
        }
        #get_auth{
        	margin-left:10px;
        	font-weight: bold;
        }
    </style>
</head>
<body>
<main class="store_board" id="store_board_main">
<div class="main_box"><!-- main box -->
            <div class="board"> <!-- board -->
                <div class="board_left_wrapper">
                    <div class="board_left_top">
                        <div class="nav_date js-clock">
                        	<span class="date">2020-12-18</span><span style="color:white;">_</span><span class="time">00:00</span>
                        </div>
                    </div>
                    <div class="board_left_bot">
                        <div class="btn_wait_register">매장 리스트</div>
                        <div></div>
                        <div></div>
                        <div></div>
                        <div></div>
                        <div id="store_info_box">
                        </div>
                    </div>
                </div>
				<div class="board_right_wrapper">
                    <div class="board_wrapper"> <!-- board wrapper -->
                        <div class="board_top_box"> <!-- top box -->
                            <div class="top_box_items light"> 
                                <span>영업 상태</span>
                                <form id="seatStusForm" action="/dealight/business/manage/board/seat"
                                        method="put">
                                        <input name="seatStusColor" id="color_value" value="" hidden>
                                        <input name="storeId" value="${storeId}" hidden>
                                        <button class="btn_seat_stus green" data-color="Green"><i class="fas fa-circle"></i></button>
                                        <button class="btn_seat_stus yellow" data-color="Yellow"><i class="fas fa-circle"></i></button>
                                        <button class="btn_seat_stus red" data-color="Red"><i class="fas fa-circle"></i></button>
                                </form>
                                <c:if test="${code == null && isSnsLogin && isMsgAval == false}"><a href="https://kauth.kakao.com/oauth/authorize?client_id=dba6ebc24e85989c7afde75bd48c5746&redirect_uri=http://localhost:8181/dealight/business/&response_type=code&scope=talk_message,friends" id='get_auth'><i class='fas fa-comment-dots'></i></a></c:if>
                                <c:if test="${code != null || isMsgAval}"><span id='get_auth' style='color:orange;'><i class='fas fa-comment-dots'></i></span></c:if>
                            </div> 
                       </div>
	                       <!-- board start -->
	                       <div id="list_board">
	                       		<div class="store_list_tit">매장 리스트</div>
	                       		<c:if test="${not empty buserList}">
								<c:forEach items="${buserList}" var="buser">
							        <div class="store_card">
							            <div class="brno_content_wrapper">
							                <span>사업자 등록 번호 : ${buser.brno}</span><br>
							            </div>
							            <div class="plus_box">
							            	<a href="/dealight/business/register?brSeq=${buser.brSeq}">
							                	<i  class="far fa-plus-square store_plus"></i>
							                </a>
							            </div>
							        </div>
							     </c:forEach>
						   		</c:if>
						   		<c:if test="${empty storeList}">
			<h2>등록하신 매장이 없습니다.🤣</h2>
		</c:if>	
		<c:if test="${not empty storeList}">
			<c:forEach items="${storeList}" var="store">
				<a class='storeInfo' href='/dealight/business/manage/?storeId=${store.storeId}'>
		        <div class="store_card">
		            <div class="store_info_wrapper">
		                <div class="store_info_wrapper_inner">
			                    <div class="store_info_i">
			                        <div class="store_info_i left top">
			                            <span class="store_name">${store.storeNm}</span>
			                            <div class="store_brch">${store.bstore.brch}</div>
			                        </div>
			                        <div class="store_info_i right top">
			                            <span class="store_stus">영업중</span>
			                            <span class="store_telno">${store.telno}</span>
			                        </div>
			                    </div>
			                    <div class="store_info_i">
			                        <div class="store_info_i left">
			                            <div class="store_open_tit">영업시간</div>
			                            <div class="store_open_tm" data-openTm="${store.bstore.openTm}" data-closeTm="${store.bstore.closeTm}">
			                            	${store.bstore.openTm} - ${store.bstore.closeTm}
			                            </div>
			                        </div>
			                        <div class="store_info_i right" id="store_cur_info">
			                            <div class="store_cur_rsvd">오늘 예약 수 : ${store.curRsvdNum}</div>
			                            <div class="store_cur_wait">현재 웨이팅 수 : ${store.curWaitNum}</div>
			                        </div>
			                    </div>
		                	</div>
		                <div class="store_info_wrapper_right">
		                    <div class="store_img_box">
		                        <img src="/display?fileName=${store.bstore.repImg}" alt="">
		                    </div> <!-- end img box -->
		                </div><!-- end store_info_wrapper_right  -->
		            </div> <!--end store_info_wrapper_inner -->
		        	</div>
		        	</a>
		        </c:forEach>
	        </c:if>
	                       </div>
	                       <!-- board end -->
                       </div>
                </div>
                </div>
            </div> <!-- end main box -->
        </main>
<script type="text/javascript">
$(document).ready(function() {
	
	let date = new Date();
	
	let curMil = date.getHours()*60 + date.getMinutes();
	
	for(let i = 0; i < document.getElementsByClassName("store_open_tm").length;i++){
		
		console.log(i+"번째 작업"+i);
		let openTm = document.getElementsByClassName("store_open_tm")[i].dataset.opentm;
		let closeTm = document.getElementsByClassName("store_open_tm")[i].dataset.closetm;
		
		console.log("openTm : "+openTm);
		console.log("closeTm : "+closeTm);
		
		let open = parseInt(openTm.split(":")[0]*60) + parseInt(openTm.split(":")[1]);
		let close = parseInt(closeTm.split(":")[0]*60) + parseInt(closeTm.split(":")[1]);
		
		console.log("open : "+open);
		console.log("close : "+close);
		
		if(open <= curMil && curMil <= close) document.getElementsByClassName("store_stus")[i].innerText = "영업중"; 
		else {
			document.getElementsByClassName("store_stus")[i].innerText = "마감";
			document.getElementsByClassName("store_stus")[i].style.backgroundColor ="gray";
		}
	}
    
    $(".uploadResult").on("click", "li", function(e){
        
        console.log("view image");
        
        let liObj = $(this);
        
        let path = encodeURIComponent(liObj.data("path")+ "/" + liObj.data("uuid") +"_" +liObj.data("filename"));
        
        if(liObj.data("type")){
            
            showImage(path.replace(new RegExp(/\\/g), "/"));
        } else {
            //download
            self.location = "/download?fileName=" + path
        }
    });
    
    /**
    function showImage(fileCallPath) {
        
        alert(fileCallPath);
        
        $(".bigPictureWrapper").css("display", "flex").show();
        
        $(".bigPicture")
        .html("<img src='/display?fileName=" + fileCallPath +"'>")
        .animate({width:'100%',height:'100%'},1000);
        
    }
    
    $(".bigPictureWrapper").on("click",function(e){
        $(".bigPicture").animate({width : '0%', height : '0%'}, 1000);
        setTimeout(function(){
            $('.bigPictureWrapper').hide();
        },1000);
    })
    **/
    
});
</script>
<%@include file="../../includes/mainFooter.jsp" %>
<script src="/resources/js/clock.js"></script>
<script>

showTime(); // 현재 시간을 보여주는 코드
setInterval(showTime, 1000); // 매초 update

const reg_result = '${regResult}';

if(reg_result !==null && reg_result.length > 1){
	alert(reg_result);
};

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
</script>
</body>

</html>