<!-- 동인 추가 -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>매장 관리</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
<script src="/resources/js/Chart.js"></script>
<link rel="stylesheet" href="/resources/css/manage.css?ver=1" type ="text/css" />
</head>
<body>
<%@include file="../../../includes/mainMenu.jsp" %>
    <div class="main_box"><!-- main box -->
        <h2>Business Manage Main Page</h2>
        <div class="board"> <!-- board -->
            <div class="board_top_box"> <!-- top box -->

                <div class="cur_time"> <!-- cur time -->
                
                <div class="js-clock clock">
                        <h6>현재 날짜🗓</h6>
                        <h3 class="date"></h3>
                        <h6>현재 시간⏰</h6>
                        <h3 class="time" style="color : blue">00:00</h3>
                </div>

                </div> <!-- end time -->
                <div class="light"> <!-- light -->
                    <h4>현재 착석 상태💺</h4>
                    <ul class="storeSeatStus"></ul>
                    <form id="seatStusForm" action="/dealight/business/manage/board/seat"
                            method="put">
                            <input name="seatStusColor" id="color_value" value="" hidden>
                            <input name="storeId" value="${storeId}" hidden>
                            <button class="btn_seat_stus">Green</button>
                            <button class="btn_seat_stus">Yellow</button>
                            <button class="btn_seat_stus">Red</button>
                            </br>
                    </form>
                </div> <!-- end light -->
                <div class="top_box_blank"></div>
                <div class="toggle"> <!-- toggle -->
                    <label class="switch">
                        <button>매장관리</button>
                      </label>
                </div> <!-- end toggle -->
				
         </div> <!-- end top box -->

         <div id="rsvd_rslt_baord" style="display : none">
            <h1>당일 예약 결과💵</h1>
            <ul class="rsvdRslt"></ul>
            <h1>최근 7일 Trend📈</h1>
            <canvas id="rsvd_chart"></canvas>
            <h1>최근 7일 예약 현황</h1>            
            <ul class="last_week_rsvd"></ul>
        </div>

        <div id="board">

            <div class="next_wait"> <!-- next wait -->
                <h4>다음 웨이팅 정보👉</h4>
	            <ul class="nextWait"></ul>
                <div class="btn_wait_wrapper">
                    <button class="btn_wait_stus btn_enter_wait">입장</button>
                    <button class="btn_wait_stus btn_noshow_wait">노쇼</button>
                </div>
            </div> <!-- end next wait -->
            <div class="next_rsvd"> <!-- next rsvd -->
                <h4>다음 예약자 정보👉</h4>
                <ul class="nextRsvd"></ul>
            </div> <!-- end next rsvd -->
            <div class="wait_board"> <!-- wait board -->
            <div class="rsvd_wrapper">
                    <div class="rsvd"> <!-- wait  -->
                        <h1>예약 리스트🗒</h1>
                        <ul class="rsvdList"></ul>
                    </div> <!-- end wait -->
            </div>
            <div class="wait_wrapper">
                <h1>웨이팅 리스트🗒</h1>
	            <ul class="waitList">
	            
	            </ul>
            </div>
                <di class="wait_register_wrapper">
                    <button class="btn_wait_register">오프라인 웨이팅 등록</button>
                </div><!-- end wait board -->
                <p id="dealhistory"><a href="/dealight/business/manage/dealhistory?storeId=${storeId}">핫딜 히스토리</a></p>
                <p id="modify"><a href="/dealight/business/manage/modify?storeId=${storeId}">매장 정보 수정</a></p>
            </div> <!-- end board -->
        </div>
            <div class="rsvd_time_bar"><!-- rsvd time bar -->
      		</div> <!-- end rsvd time bar -->
        </div> <!-- end main box -->
        <div class="info_box"> <!--  info box -->
        
                    <h1>매장 정보🏪</h1>
            <ul class="store"></ul>

            <h2>매장 사진</h2>
            <div class='uploadResult'>
                <ul>
                </ul>
            </div> <!-- uploadResult -->
            
            <div class='bigPictureWrapper'>
                <div class='bigPicture'>
                </div>
            </div>
            
            <h2>오늘 예약 회원</h2>
	<c:if test="${empty todayRsvdUserList}">
		<h2>오늘 예약하신 손님이 없습니다.🤣</h2>
	</c:if>
	
	<c:if test="${not empty todayRsvdUserList}">
		<c:forEach items="${todayRsvdUserList}" var="user">
			
			<div class="tooltip">
				==========================================</br>
				회원 아이디 : ${user.userId}</br>
				회원 이름 : ${user.name}</br> 
				회원 이메일 : ${user.email}</br> 
				회원 전화번호 : ${user.telno}</br>
				생년 월일 : ${user.brdt}</br> 
				성별 : ${user.sex }</br> 
				회원 프로필 사진 : ${user.photoSrc}</br>
				패널티 회원 여부 : ${user.pmStus}</br>
  				<div class="tooltiptext">
  					예약 번호 : ${user.rsvdId}</br>
					매장 번호 : ${user.storeId }</br>
					핫딜 번호 : ${user.htdlId }</br>
					예약 인원 : ${user.pnum}</br>
					예약 상태 : ${user.stusCd }</br>
					등록 날짜 : ${user.inDate }</br>
					총 가격 : ${user.totAmt }</br>
					총 주문 수량 : ${user.totQty }</br>
  				</div>
			</div>
		</c:forEach>
	</c:if>
	
	<div>
        </div> <!-- end info box -->
        	<!-- The Modal -->
	<div id="myModal" class="modal">
		<!-- Modal content -->
		<div class="modal-content">
			<span class="close">&times;</span>
			<ul class="rsvdDtls"></ul>
			<ul class="userRsvdList"></ul>
			<ul class="waiting_registerForm"></ul>
		</div>
	</div>
    
<script>

const storeId = ${storeId};

/*시간바 만들기*/
/*현재시간으로 스크롤 고정*/
writeTimeBar = function (curTime) {
    timeArr = ['','09:00','09:30','10:00','10:30','11:00','11:30','12:00','12:30','13:00','13:30','14:00','14:30','15:00','15:30','16:00','16:30','17:00','17:30','18:00','18:30','19:00','19:30','20:00','20:30','21:00','21:30','22:00'];
    let strTime = "";
    let curPos = 0; 
    for(let i = 1; i <= 27; i++){
    	if(curTime === timeArr[i])
    		curPos = i - 1;
        strTime += "<div class='rsvd_time tooltip' id='slide-"+i+"'><h6>"+timeArr[i]+"</h6><div class='time_table'></div></div>";
    }
	document.querySelector(".rsvd_time_bar").innerHTML = strTime;
    // 예약 상태바 초기 스크롤 고정
    document.querySelector(".rsvd_time_bar").scrollLeft = ((parseInt(curPos)*150) - 150);
	}
	
/* 시간 파싱 */
let curToday = new Date();
let curHour = curToday.getHours(),
	curMinutes = curToday.getMinutes();
	
	if(curMinutes >= 30)
		curMinutes = '30';
	else
		curMinutes = '00';
	
	let curTime = curHour + ":" + curMinutes;

	// TimeBar 작성
	writeTimeBar(curTime);
	
	// 모달 선택
	const modal = $("#myModal"),
		close = $(".close"),
		modalContent = $(".modal-content"),
		btn_show_board = $("#btn_show_board");

	close.on("click", (e) => {
		modal.css("display","none");
		modal.find("ul").html("");
	});
	
	/*
	 모달이 아닌 화면을 클릭하면 모달이 종료가 되어야 하는데 그렇지 않음.
	*/
	window.onclick = function(event) {
		  if (event.target == modal) {
			  modal.css("display","none");
			  modal.find("ul").html("");
		  }
	}

</script>
	<script>

    /*
    REST 방식으로 서버와 통신
    	비동기로 board를 바꿔주는 서비스
    */
    let boardService = (() => {
      
    	
        /*put 함수*/
        // 매장의 착석 상태 코드를 변경한다.
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
    	 // 매장의 웨이팅 상태를 '노쇼'로 변경한다.
        function putNoshowWaiting(waitId,callback,error) {
            $.ajax({
                type:'put',
                url:'/dealight/business/manage/board/waiting/noshow/' + waitId,
                data : {waitId:waitId},
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
    
     	// 매장의 웨이팅 상태를 '입장'으로 변경한다.
        function putEnterWaiting(waitId,callback,error) {
    
            $.ajax({
                type:'put',
                url:'/dealight/business/manage/board/waiting/enter/' + waitId,
                data : {waitId:waitId},
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
    	
     	// 매장의 웨이팅 상태를 '취소'로 변경한다.
        function putCancelWaiting(waitId,callback,error) {
    
            $.ajax({
                type:'put',
                url:'/dealight/business/manage/board/waiting/cancel/' + waitId,
                data : {waitId:waitId},
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
        	
        }
        
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
        	
        }
        
        // 매장의 '예약 현황판' 내용을 가져온다.
		function getRsvdRslt(param,callback,error) {
            
            let storeId = param.storeId;
            
            $.getJSON("/dealight/business/manage/board/reservation/rslt/"+storeId+".json",
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
        
        // '해당 매장'의 '예약 리스트'를 가져온다.
        function getRsvdList(param,callback,error) {
            
            let storeId = param.storeId;
            
            let rsvdList = $.getJSON("/dealight/business/manage/board/reservation/"+storeId+".json",
                function(data){
                        if(callback){
                            callback(data);
                        }
                    }).fail(function(xhr,status,err){
                        if(error){
                            error();
                        }
            });
    	
            
            return rsvdList;
        }
    
        // '해당 매장'의 '웨이팅 리스트'를 가져온다.
        function getWaitList(param,callback,error) {
            
            let storeId = param.storeId;
            
            let waitList = $.getJSON("/dealight/business/manage/board/waiting/"+storeId+".json",
                function(data){
                        if(callback){
                            callback(data);
                        }
                    }).fail(function(xhr,status,err){
                        if(error){
                            error();
                        }
            });
            
            return waitList;
        }
    
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
        
        // '웨이팅 리스트'에서 '다음 웨이팅'을 가져온다.
        function getNextWait(waitList){
            if(!waitList){
                return;
            }
                       
            return waitList.filter(wait =>  wait.waitStusCd === 'W')
                    .sort((w1,w2) =>  w1.waitId - w2.waitId)[0];
        };
        
        // 오늘의 예약을 '시간대 별'로 가져온다.
        function getTodayRsvdMap(param,callback,error){
      
        	let storeId = param.storeId;
        	
        	$.getJSON("/dealight/business/manage/board/reservation/map/"+ storeId +".json",
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
        
        // 해당 매장의 다음 웨이팅을 가져온다.
        function getNextRsvd(param,callback,error){
        	
        	
        	let storeId = param.storeId;
        	
        	
        	$.getJSON("/dealight/business/manage/board/reservation/next/"+ storeId +".json",
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
    
        // 웨이팅 정보를 등록한다.
        function regWait(wait, callback,error) {
    
            $.ajax({
                type : 'post',
                url : '/dealight/business/manage/board/waiting/new',
                data : JSON.stringify(wait),
                contentType : "application/json; charset=utf-8",
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
            })
        }
        
        // '해당 매장'의 지난주 예약 정보를 가져온다.
        function getLastWeekRsvd(param, callback,error) {
        	
			let storeId = param.storeId;
        	
        	$.getJSON("/dealight/business/manage/board/reservation/rslt/"+ storeId +"/list.json",
                    function(data){
        					console.log(data);
                        if(callback){
                            callback(data);
                        }
                    }).fail(function(xhr,status,err){
                        if(error){
                            error();
                        }
            });
        	
        	
        }
    
        return {
            regWait:regWait,
            getStore : getStore,
            getWaitList : getWaitList,
            getRsvdList : getRsvdList,
            putCancelWaiting : putCancelWaiting,
            putNoshowWaiting : putNoshowWaiting,
            putEnterWaiting : putEnterWaiting,
            putChangeStatusCd : putChangeStatusCd,
            getNextWait : getNextWait,
            getNextRsvd : getNextRsvd,
            getTodayRsvdMap : getTodayRsvdMap,
            getRsvdRslt : getRsvdRslt,
            getUserRsvdList : getUserRsvdList,
            getRsvdDtls : getRsvdDtls,
            getLastWeekRsvd : getLastWeekRsvd
        };
    })();
    
    
    /*
    	서버가 시작 되면 동작하는 코드
    */
    $(document).ready(() => {
    	/* 변수 설정*/
        
        /* HTML 태그 변수 설정*/
        const seatStusForm = $("#seatStusForm"),
	        colorVal = $("#color_value"),
	        storeUL = $(".store"),
	        rsvdListUL = $(".rsvdList"),
	        waitListUL = $(".waitList"),
	        nextWaitUL = $(".nextWait"),
	        nextRsvdUL = $(".nextRsvd"),
	        rsvdMapUL = $(".rsvdMap"),
	        storeSeatUL = $(".storeSeatStus"),
	        rsvdRsltUL = $(".rsvdRslt"),
	        userRsvdListUL = $(".userRsvdList"),
	        rsvdDtlsUL = $(".rsvdDtls"),
	        waitRegFormUL = $(".waiting_registerForm"),
	        lastWeekRsvdUL = $(".last_week_rsvd")
        ;
        
        function init(storeId){
            showBoard(storeId); // 현재 '매장'의 'board'를 보여주는 코드
            showTime(); // 현재 시간을 보여주는 코드
            setInterval(showTime, 1000); // 매초 update
            console.log("get rsvd list...............");
        }
            
        init(storeId);
        
        /*
        	매장의
        	board를 보여준다.
        	매장 정보
        	웨이팅 리스트
        	예약 리스트
        	시간대별 예약 리스트
        	다음 예약, 다음 웨이팅
        */
        
        function showStoreInfo (storeId){
        	
        	boardService.getStore({storeId : storeId}, function (store) {
                let str = "";
                if(store == null){
                    storeUL.html("");
                    return;
                }
                
                str += "<li>매장번호 : " + store.storeId + "</li>";
                str += "<li>매장이름 : " + store.storeNm + "</li>";
                str += "<li>매장 연락처 : " + store.telno + "</li>";
                str += "<li>매장 수용인원 : " + store.bstore.acmPnum + "</li>";
                str += "<li>매장 평균식사시간 : " + store.bstore.avgMealTm + "</li>";
                str += "<li>매장 브레이크종료시간 : " + store.bstore.breakEntm + "</li>";
                str += "<li>매장 브레이크시작시간 : " + store.bstore.breakSttm + "</li>";
                str += "<li>매장 관리자 아이디 : " + store.bstore.buserId + "</li>";
                str += "<li>매장 영업종료시간 : " + store.bstore.closeTm + "</li>";
                str += "<li>매장 휴무일 : " + store.bstore.hldy + "</li>";
                str += "<li>매장 라스트오더시간 : " + store.bstore.lastOrdTm + "</li>";
                str += "<li>매장 메뉴 : " + store.bstore.menus + "</li>";
                str += "<li>매장 1인석 : " + store.bstore.n1SeatNo + "</li>";
                str += "<li>매장 2인석 : " + store.bstore.n2SeatNo + "</li>";
                str += "<li>매장 4인석 : " + store.bstore.n4SeatNo + "</li>";
                str += "<li>매장 시작시간 : " + store.bstore.openTm + "</li>";
                str += "<li>매장 착석상태 : " + store.bstore.seatStusCd + "</li>";
                str += "<li>매장 소개 : " + store.bstore.storeIntro + "</li>";
                
                storeUL.html(str);
                
                /*착석 상태*/
                storeSeatUL.html("<li>"+ store.bstore.seatStusCd +"</li>")
        	})
        };
        
        function showWaitList(storeId){
        	
        	console.log("show wait list.........." + storeId);
        	
        	boardService.getWaitList({storeId:storeId}, function (waitList) {
                let strWaitList = "";
                if(waitList == null){
                    waitList.html("");
                    return;
                }
                
                waitList.forEach(wait => {
                	strWaitList += "<div class='wait'>";
                    strWaitList += "<ul>" + "<a href='/dealight/business/waiting/"+wait.waitId+"'><h3>웨이팅 번호 : "+wait.waitId+"</h3></a>";
                        strWaitList += "<li>웨이팅 회원 아이디 : "+ wait.userId + "</li>";
                        strWaitList += "<li>웨이팅 매장 번호 : "+ wait.storeId + "</li>";
                        strWaitList += "<li>웨이팅 인원 : "+ wait.waitPnum + "</li>";
                        strWaitList += "<li>웨이팅 등록 시간 : "+ wait.waitRegTm.toString() + "</li>";
                        strWaitList += "<li>웨이팅 상태 : "+ wait.waitStusCd + "</li>";
                        strWaitList += "<li>웨이팅 회원 이름 : "+ wait.custNm + "</li>";
                        strWaitList += "<li>웨이팅 회원 번호 : "+ wait.custTelno + "</li>";
                    strWaitList += "</ul>"
                    strWaitList += "<button class='btn_wait_call'><a href='/oauth?storeId="+wait.storeId+"&waitId="+wait.waitId+"'>호출</a></button>";
                    strWaitList += "</div>";
                });
    
              waitListUL.html(strWaitList);   
              
              let nextWait = boardService.getNextWait(waitList);
              
              let strNextWait = "";
              
              if(nextWait){
              
              strNextWait += "<li> 대기자 이름 : "+nextWait.custNm+"</li>";
              strNextWait += "<li> 대기자 연락처 : "+nextWait.custTelno+"</li>";
              strNextWait += "<li> 웨이팅 번호 :"+nextWait.waitId+"</li>";
              strNextWait += "<li> 매장 번호 : "+nextWait.storeId+"</li>";
              strNextWait += "<li> 회원 아이디 : "+nextWait.userId+"</li>";
              strNextWait += "<li> 웨이팅 인원 : "+nextWait.waitPnum+"</li>";
              strNextWait += "<li> 웨이팅 등록 시간 : "+nextWait.waitRegTm+"</li>";
              strNextWait += "<li> 웨이팅 상태 : "+nextWait.waitStusCd+"</li>";
              }
              nextWaitUL.html(strNextWait);
    
            }); 
        }
        
        function showRsvdList(storeId){
        	
        	console.log("show rsvd list..........." + storeId);
        	
        	boardService.getRsvdList({storeId:storeId}, function (rsvdList) {
                let strRsvdList = "";
                if(rsvdList == null){
                    rsvdList.html("");
                    return;
                }
                rsvdList.forEach(rsvd => {
                	strRsvdList += "<div class='rsvd rsvd_i'>" ;
                    strRsvdList += "<ul class='btnRsvd'>" + "<h3>예약 번호 : "+rsvd.rsvdId+"</h3>"; 
                        strRsvdList += "<li hidden class='btnStoreId'>"+rsvd.storeId+"</li>";
                        strRsvdList += "<li hidden class='btnUserId'>"+rsvd.userId+"</li>";
                        strRsvdList += "<li>매장번호 : "+ rsvd.storeId + "</li>";
                        strRsvdList += "<li>회원 아이디 : "+ rsvd.userId + "</li>";
                        strRsvdList += "<li>핫딜 번호 :"+ rsvd.htdlId + "</li>";
                        strRsvdList += "<li>승인 번호 : "+ rsvd.aprvNo + "</li>";
                        strRsvdList += "<li>예약 인원 : "+ rsvd.pnum + "</li>";
                        strRsvdList += "<li>예약 시간 : "+ rsvd.time + "</li>";
                        strRsvdList += "<li>예약 상태 : "+ rsvd.stusCd + "</li>";
                        strRsvdList += "<li>예약 총 금액 : "+ rsvd.totAmt + "</li>";
                        strRsvdList += "<li>예약 총 수량 : "+ rsvd.totQty + "</li>";
                        strRsvdList += "<li>예약 등록 날짜 : "+ rsvd.regdate + "</li>";
                    strRsvdList += "</ul>" 
                    strRsvdList += "</div>" ;
                });
    
              rsvdListUL.html(strRsvdList);
   
            }); 
        }
        
        function showRsvdMap(storeId){
        	
			strRsvdMap = "";
            
            boardService.getTodayRsvdMap({storeId:storeId}, function(map){
            	let strRsvdMap = "";
            	
            	console.log("map.............................."+map);
            	
            	if(!map)
            		return;
            	Object.entries(map).forEach(([key,value]) => {
            		strRsvdMap += "<li class='tooltip'>"+key + " : 예약번호[" + value+"] <span class='tooltiptext'>"+value+"번호 안녕?</span></li></br>";
            		for(let i = 1; i < 28; i ++){
            			// debug
            			//console.log(key+' : '+i+ ' : '+document.querySelector('#slide-'+i+' h6').textContent);
            			//console.log(key === document.querySelector('#slide-'+i+' h6').textContent);
            			if(key === document.querySelector('#slide-'+i+' h6').textContent){
            				document.querySelector('#slide-'+i+' .time_table').innerHTML = "<span class='tooltiptext'>"+value+" 번호 예약</span>";
            				document.querySelector('#slide-'+i+' .time_table').style.backgroundColor = 'rgba(251, 255, 41, 0.898)';
            			}
            		}
            	})
            	
            	rsvdMapUL.html(strRsvdMap);
            	
            });
            
            boardService.getNextRsvd({storeId:storeId},function(rsvd){
            	
        		let strNextRsvd = "";
        		if(!rsvd)
        			return;
                strNextRsvd += "<li>예약 번호 : "+rsvd.rsvdId+"</li>"; 
                strNextRsvd += "<li>매장번호 : "+ rsvd.storeId + "</li>";
                strNextRsvd += "<li>회원 아이디 : "+ rsvd.userId + "</li>";
                strNextRsvd += "<li>핫딜 번호 :"+ rsvd.htdlId + "</li>";
                strNextRsvd += "<li>승인 번호 : "+ rsvd.aprvNo + "</li>";
                strNextRsvd += "<li>예약 인원 : "+ rsvd.pnum + "</li>";
                strNextRsvd += "<li>예약 시간 : "+ rsvd.time + "</li>";
                strNextRsvd += "<li>예약 상태 : "+ rsvd.stusCd + "</li>";
                strNextRsvd += "<li>예약 총 금액 : "+ rsvd.totAmt + "</li>";
                strNextRsvd += "<li>예약 총 수량 : "+ rsvd.totQty + "</li>";
                strNextRsvd += "<li>예약 등록 날짜 : "+ rsvd.regdate + "</li>";
                
                nextRsvdUL.html(strNextRsvd);
        	});
        	
        }
        
        function showBoard(storeId) {

        	showStoreInfo(storeId);
            
        	showWaitList(storeId);
    
        	showRsvdList(storeId);
            
            showRsvdMap(storeId);
  
        };
        
        // 예약 현황판을 보여준다.
        function showRsvdBoard(storeId) {
        	
        	boardService.getRsvdRslt({storeId:storeId}, function(dto){
        		let strRsvdRslt = "";
        		if(!dto)
        			return;
        		
        		strRsvdRslt += "<li>오늘 총 예약 수 : " + dto.totalTodayRsvd  +"</li>";
        		strRsvdRslt += "<li>오늘 총 예약 인원 : " + dto.totalTodayRsvdPnum  +"</li>";
        		strRsvdRslt += "<li>[오늘의 인기 메뉴]</li>";
        		Object.entries(dto.todayFavMenuMap).forEach(([key,value]) => {
	        		strRsvdRslt += "<li>" + key +' : '+ value  +"</li>";
        		})
        		
        		rsvdRsltUL.html(strRsvdRslt);
        		
        	});
        	
        	let dateArr = new Array();
        	
        	let today = new Date();
        	let year, month, date;
        	
        	for(let i = 0; i < 7; i++) {
        		year =  today.getFullYear();
        		month = (today.getMonth() + 1);
        		date = today.getDate();
        		dateArr[i] =    year + '/' + month + '/' + date;
        		today.setDate(today.getDate() - 1);
        	}
        	
        	
    		let pnumArr = [0,0,0,0,0,0,0];
    		let amountArr = [0,0,0,0,0,0,0];
        	
        	boardService.getLastWeekRsvd({storeId:storeId}, function(list){
        		
        		let strLastWeekRsvd = "";
        		if(!list)
        			return;
				
        		list.forEach(rsvd => {
        			
        			pnumArr[dateArr.indexOf(rsvd.strRegDate)] += rsvd.pnum;
        			amountArr[dateArr.indexOf(rsvd.strRegDate)] += rsvd.totAmt;
        			
        			//pnumArr[dateArr.indexOf(rsvd.strInDate)].push(rsvd)
        			
        			strLastWeekRsvd += "<li hidden class='btnStoreId'>"+rsvd.storeId+"</li>";
        			strLastWeekRsvd += "<li hidden class='btnUserId'>"+rsvd.userId+"</li>";
        			strLastWeekRsvd += "<li>매장번호 : "+ rsvd.storeId + "</li>";
        			strLastWeekRsvd += "<li>회원 아이디 : "+ rsvd.userId + "</li>";
        			strLastWeekRsvd += "<li>핫딜 번호 :"+ rsvd.htdlId + "</li>";
        			strLastWeekRsvd += "<li>승인 번호 : "+ rsvd.aprvNo + "</li>";
        			strLastWeekRsvd += "<li>예약 인원 : "+ rsvd.pnum + "</li>";
        			strLastWeekRsvd += "<li>예약 시간 : "+ rsvd.time + "</li>";
        			strLastWeekRsvd += "<li>예약 상태 : "+ rsvd.stusCd + "</li>";
        			strLastWeekRsvd += "<li>예약 총 금액 : "+ rsvd.totAmt + "</li>";
        			strLastWeekRsvd += "<li>예약 총 수량 : "+ rsvd.totQty + "</li>";
        			strLastWeekRsvd += "<li>예약 등록 날짜 : "+ rsvd.strRegDate + "</li>";
        			strLastWeekRsvd += "===========================================";
        		});
        		
        		// test
        		//console.log(dateArr);
        		//console.log(pnumArr);
        		//console.log(amountArr);
        		
	        	lastWeekRsvdUL.html(strLastWeekRsvd);
	        	let chart = document.getElementById('rsvd_chart');
	        	let context = chart.getContext('2d'),
	           	rsvdChart = new Chart(context, {
	           		type : 'line',
	           		data : {
	           			labels : [dateArr[6], dateArr[5], dateArr[4], dateArr[3], dateArr[2], dateArr[1], dateArr[0]],
	           			datasets : [{
	           				label : '예약 인원',
	           				lineTension : 0,
	           				data : [pnumArr[6], pnumArr[5], pnumArr[4], pnumArr[3], pnumArr[2], pnumArr[1], pnumArr[0]],
	           				backgroundColor : "rgba(153,255,51,0.4)"
	           			}, {
	           				label : "예약 금액",
	           				data : [amountArr[6],amountArr[5],amountArr[4],amountArr[3],amountArr[2],amountArr[1],amountArr[0]],
	           				backgroundColor: "rgba(255,153,0,0.4)"
	           			}]
	           		}
	           	});
        	});
        	
         
        	
        	
        };
        
        /*
        	유저의 예약 히스토리를 보여준다.
        
        */
        function showUserRsvdList(storeId,userId){
        	
        	boardService.getUserRsvdList({storeId:storeId,userId:userId}, function(userRsvdList){
        		
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
        		
        		showRsvdDtls(userRsvdList[0].rsvdId);
        		
        	})
        };
        
        /*
        	예약 상세를 보여준다.
        
        */
        function showRsvdDtls(rsvdId){
        	
        	boardService.getRsvdDtls({rsvdId:rsvdId}, function(rsvd){
        		
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
        /*
        
        	오프라인 웨이팅 등록 폼을 보여준다.
        
        */
        
        function showWaitRegisterForm(storeId){
        	
        	let today = new Date();
        	let strWaitRegForm = "";
        	strWaitRegForm += "<h1>오프라인 웨이팅 등록</h1>";
        	strWaitRegForm += "<form id='waitRegForm' action='/dealight/business/manage/waiting/register' method='post'>";
        	strWaitRegForm += "고객 이름<input name='custNm' id='js_wait_custNm'> <span id='name_msg'></span></br>";
        	strWaitRegForm += "고객 전화번호<input name='custTelno' id='js_wait_custTelno'> <span id='phoneNum_msg'></span></br>";
        	strWaitRegForm += "웨이팅 인원<input name='waitPnum' id='js_wait_pnum'> <span id='pnum_msg'></span></br>";
        	strWaitRegForm += "<input name='waitRegTm' value='"+today+"' hidden>";
        	strWaitRegForm += "<input name='storeId' value='"+storeId+"' hidden>";
        	strWaitRegForm += "<button id='submit_waitRegForm' type='submit'>제출하기</button>";
        	strWaitRegForm += "</form>";
        	strWaitRegForm += "<h2>현재 시간</h2>";
        	strWaitRegForm += "<h2>"+today+"</h2>";
        	
        	waitRegFormUL.html(strWaitRegForm);
        	
        	/* wait register valid check*/
        	const wait_custNm = document.querySelector("#js_wait_custNm"),
	        	wait_phoneNum = document.querySelector("#js_wait_custTelno"),
	        	wait_pnum = document.querySelector("#js_wait_pnum"),
	        	btn_submit = document.querySelector("#submit_waitRegForm"),
	        	name_msg = document.querySelector("#name_msg"),
	        	phoneNum_msg = document.querySelector("#phoneNum_msg"),
	        	pnum_msg = document.querySelector("#pnum_msg"),
	        	waitRegForm = document.querySelector('#waitRegForm');
        	
        	const inputList = [wait_custNm,wait_phoneNum,wait_pnum];

        	// 웨이팅 등록의 valid check를 진행한다.
        	nameLenCheck = function () {
        		if(1 <= wait_custNm.value.length && wait_custNm.value.length <= 5)
        			return true;
        		return false;
        	}

        	phoneNumLenCheck = function () {
        		if(1 <= wait_phoneNum.value.length && wait_phoneNum.value.length <= 13)
        			return true;
        		return false;
        	}

        	pnumSizeCheck = function () {
        		if(isNaN(wait_pnum.value))
        			return false;
        		if(1 <= parseInt(wait_pnum.value) && parseInt(wait_pnum.value) <= 10)
        			return true;
        		return false;
        	}

        	wait_custNm.addEventListener("focusout", () => {
        		if(1 <= wait_custNm.value.length){
        		    if(nameLenCheck()){
        		        name_msg.innerText = "🙆‍♂️ 이름 형식이 적당하네요.";
        		    }
        		    else {
        		    	name_msg.innerText = "🙅‍♂️ 이름 길이를 다시 확인해 주세요. (5자 이내)";
        		    }
        		}
        	})

        	wait_phoneNum.addEventListener("focusout", () => {
        		if(1 <= wait_phoneNum.value.length){
        		    if(phoneNumLenCheck()){
        		        phoneNum_msg.innerText = "🙆‍♂️ 전화번호 형식이 적당하네요!";
        		    }
        		    else {
        		    	phoneNum_msg.innerText = "🙅‍♂️ 전화번호 길이를 다시 확인해 주세요. (13자 이내)";
        		    }
        		}
        	})

        	wait_pnum.addEventListener("focusout", () => {
        		if(1 <= wait_pnum.value.length){
        		    if(pnumSizeCheck()){
        		        pnum_msg.innerText = "🙆‍♂️ 인원이 적당합니다.";
        		    }
        		    else {
        		    	pnum_msg.innerText = "🙅‍♂️ 인원이 너무 많거나 형식이 적당하지 않아요! (10명 이내)";
        		    }
        		}
        	})

        	// null이면  true
        	nullCheck = function(inputList) {
        	    for(let i = 0; i < inputList.length; i++)
        	        if(inputList[i].value == "")
        	            return true;
        	    
        	    return false;
        	}
        	
        	let modalInputCustNm = modal.find("input[name='custNm']"),
				modalInputCutsTelNo = modal.find("input[name='custTelno']"),
				modalInputWaitPnum = modal.find("input[name='waitPnum']"),
				modalInputCurTime = modal.find("input[name='curTime']"),
				modalInputStoreId = modal.find("input[name='storeId']");
    	
        	btn_submit.addEventListener("click", (e) => {
    		
	    		e.preventDefault();
	    		
	    		let wait = {
	    				custNm : modalInputCustNm.val(),
	    				custTelno : modalInputCutsTelNo.val(),
	    				curTime : modalInputCurTime.val(),
	    				waitPnum : modalInputWaitPnum.val(),
	    				storeId : modalInputStoreId.val()
	    		};
	    		
	    		
	    	    if(nullCheck(inputList)){
	    	        alert("필드가 비었어요")
	    	        return;
	    	    }
	    	    
	    	    if(!nameLenCheck()){
	    	    	alert("🙅이름을 형식에 맞게 입력해주세요");
	    	        return;
	    	    }
	    	    
	    	    if(!phoneNumLenCheck()){
	    	        alert("🙅전화번호를 형식에 맞게 입력해주세요");
	    	        return;
	    	    }
	    	    
	    	    if(!pnumSizeCheck()){
	    	        alert("🙅예약인원을 형식에 맞게 입력해주세요");
	    	        return;
	    	    }
	    	    
	
	    		boardService.regWait(wait, result => {
	    			
	    			//alert(result);
	        		showWaitList(storeId);
	        		modal.find("ul").html("");
	    			modal.find("input").val("");
	    			modal.css("display","none");
	    			
	    		});
    		
    		});
        };
        
        /* 이벤트 처리*/
        
        /*현황판 토글*/

		let toggle = $(".switch");
		
		toggle.on("click", (e) => {
			
			let storeId = ${storeId};
			
			e.preventDefault();
			
			if($("#board").css("display") === 'none'){
				// debug
				//console.log("board none => block");
				$(".switch > button").text('매장관리');
				showBoard(storeId);
				$("#board").css("display", "block");
			} else if($("#board").css("display") === 'block'){
				// debug
				//console.log("board block => none");				
				$("#board").css("display", "none");
			}
			
			if($("#rsvd_rslt_baord").css("display") === 'none'){
				// debug
				//console.log("rsvd rslt board none => block");
				$(".switch > button").text('현황판');
				showRsvdBoard(storeId);
				$("#rsvd_rslt_baord").css("display", "block");
			} else	if($("#rsvd_rslt_baord").css("display") === 'block'){
				// debug
				//console.log("rsvd rslt board block => none");
				$("#rsvd_rslt_baord").css("display", "none");
			}
		});
		
        /*당일 예약 결과 가져오기*/
        $("#btn_rsvd_rslt").on("click", e => {
        	showRsvdBoard(storeId);
        });

        /*새로고침*/
        $("#refresh").on("click", e => {
        	// debug
        	//console.log("show board...")
        	showBoard(storeId);
        });

        /*예약리스트에 있는 내용 중, 예약 상세 보여주기*/
        /*회원의 예약 리스트 보여주기*/
        $(".rsvdList").on("click", e => {

        	let rstoreId = $(e.target).parent().find(".btnStoreId").text(),
        		ruserId = $(e.target).parent().find(".btnUserId").text();
        	
        	modal.css("display","block");

        	showUserRsvdList(rstoreId, ruserId);
        	
        });
        	
        /* 웨이팅 등록 */
        $(".btn_wait_register").on("click", e => {
        	
        	modal.css("display","block");
        	showWaitRegisterForm(storeId);
        	
        	//$("#waitRegForm").submit();        		
        	
        });

        /* 매장 착석 상태 처리*/
        $(".btn_seat_stus").on("click", e => {

            e.preventDefault();
            
            let color = "";

            let param = {};
            param.storeId = storeId;
            param.seatStusCd = e.target.innerHTML[0];
            
            // debug
            //console.log("seat stus cd...................."+e.target.innerHTML[0]);
            
        	boardService.putChangeStatusCd(param, function(result){
        		//alert(result);
            	showStoreInfo(param.storeId);
        	});
        	
        });

        /*웨이팅 입장 처리*/
        $(".btn_enter_wait").on("click", e => {
        	
        	/*dom 코드는 변경될 가능성 있음*/
        	waitId = parseInt($(".nextWait li:eq(2)").text().split(":")[1]);

        	boardService.putEnterWaiting(waitId, function(result){
        		//alert(result);
        		showWaitList(storeId);
        	});
        	
        });

        /*웨이팅 노쇼 처리*/
        $(".btn_noshow_wait").on("click", e => {
        	
        	/*dom 코드는 변경될 가능성 있음*/
        	waitId = parseInt($(".nextWait li:eq(2)").text().split(":")[1]);

        	boardService.putNoshowWaiting(waitId, function(result){
        		//alert(result);
	        	showWaitList(storeId);
        	});
        });
        
        
        /* web socket!!!!!!!!!!!!!!!!!!!!*/
        /* 	<div id="socketAlert" class="alert alert-success" role="alert"">알림!!!</div> */
        let socket = null;
   	 
	   	 function connectWS() {
	   		// 전역변수 socket을 선언한다.
	   		// 다른 페이지 어디서든 소켓을 불러올 수 있어야 하기 때문이다.
	   		
	   	 	// 소켓을 ws로 연다.
	   	 	var ws = new WebSocket("ws://localhost:8080/manageSocket");
	   	 	socket = ws;
	
	   	 	// 커넥션이 연결되었는지 확인한다.
	   	 	ws.onopen = function () {
	   	 	    console.log('Info: connection opened.');
	   	 	};
	
	   	 	
	   	 	// 받은 메시지를 출력한다.
	   	 	// 메시지를 수신한 이벤트 핸들러와 같다.
	   	 	ws.onmessage = function (event) {
	   	 	    console.log("ReceiveMessage : ", event.data+'\n');
	   	 	    
	   	 	    // 추후에 message 형식을 JSON으로 변환해서 message type을 지정해줘야 한다.
	   	 	    //if()
	   	 	    	
	   	 	   	//alert(event.data);
	   	 	    console.log(typeof event.data);
	   	 	    
	   	 	    let data = JSON.parse(event.data);
	   	 	    
	   	 	    console.log(typeof data);
	   	 	    console.log("cmd : "+data.cmd);
	   	 		console.log("sendUser : "+data.sendUser);
	   	 	    console.log("storeId : "+data.storeId);
	   	 	    
	   	 	    
				if(data.cmd === 'rsvd'){
		   	 		showRsvdList(storeId);
		   	 		console.log("rsvd...... : " + data.rsvdId);
		   	 		console.log(data.msg);
				} else if (data.cmd === 'wait'){
		   	 		showWaitList(storeId);
		   	 		console.log("wait...... : " + data.waitId);
		   	 		console.log(data.msg);
				}	   	 	    
	   	 	    
	   	 	    //let socketAlert = $('#socektAlert');
	   	 		//socketAlert.html(event.data);
	   	 	    //socketAlert.css('display','block');
			    
			    // 메시지가 3초 있다가 자동으로 사라지게
			    /*
			    setTimeout( function(){
			    	
			    	$socketAlert.css('display','none');
			    },3000);
	   	 	    */
			    
			    /*
	   	 	    let socketAlert = $('#socektAlert');
	   	 		socketAlert.innerHTML = event.data;
	   	 	    socketAlert.style.display = "block";
	   	 	   	showWaitList(storeId);
	   	 	    */
	   	 	   	
	   	 	    // 메시지가 3초 있다가 자동으로 사라지게
	   	 	    /*
	   	 	    setTimeout( function(){
	   	 	    	
	   	 	    	$socketAlert.css('display','none');
	   	 	    },3000);
	   	 	    */
	   	 	};
	
	
	   	 	// connection을 닫는다.
	   	 	ws.onclose = function (event) {
	   	 		console.log('Info: connection closed.');
	   	 		//setTimeout( function(){ connect(); }, 1000); // retry connection!!
	   	 	};
	   	 	ws.onerror = function (event) { console.log('Error'); };
	   	 	
	   	 }
	   		
	   		// input 내용을 socket에 send
	   		$('#btnSend').on('click', function(evt) {
	   			  evt.preventDefault();
	   			if (socket.readyState !== 1) return;
	   				  let msg = $('input#msg').val();
	   				  socket.send(msg);
	   			});
	   		
	   		connectWS();
   });
	
    /* get store img (즉시실행함수)*/
    $(document).ready(function() {
    	

        (function(){
            
        	let storeId = ${storeId};
            
            $.getJSON("/dealight/business/manage/getStoreImgs", {storeId:storeId}, function(imgs){
                
            	// debug
                //console.log("즉시 함수..");
                //console.log(imgs);
                
                let str = "";
                
                $(imgs).each(function(i, img){
                	
                	// debug
                	//console.log(img);
                    
                    // image type
                    if(img.image) {
                        
                        let fileCallPath = encodeURIComponent(img.uploadPath+"/s_" +img.uuid + "_" +img.fileName);
                        
                        str += "<li data-path='" + img.uploadPath + "'data-uuid='" + img.uuid + "'data-filename='"
                            + img.fileName +"'data-type='" + img.image+"'><div>";
                        str += "<img src='/display?fileName=" + fileCallPath+"'>";
                        str += "</li>";
                        
                    } else {
                        
                        str += "<li data-path='" + img.uploadPath +"' data-uuid='" + img.uuid 
                                +"' data-filename='" + img.fileName +"' data-type='" + img.image+"'><div>";
                        str += "<span>" + img.fileName+"</span><br/>";
                        str += "<img src='/resources/img/attach.png'>";
                        str += "</div>";
                        str += "</li>";
                    }
                });
                
                $(".uploadResult ul").html(str);
                
            }); // end getjson
            
        })(); // end function

        
        $(".uploadResult").on("click", "li", function(e){
            
        	// debug
            // console.log("view image");
            
            let liObj = $(this);
            
            let path = encodeURIComponent(liObj.data("path")+ "/" + liObj.data("uuid") +"_" +liObj.data("filename"));
            
            if(liObj.data("type")){
                
                showImage(path.replace(new RegExp(/\\/g), "/"));
            } else {
                //download
                self.location = "/download?fileName=" + path
            }
        });
        
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


        var operForm = $("#operForm");
        
        $("button[data-oper='modify']").on("click", function(e){
            
            operForm.attr("action", "/board/modify").submit();
            
        });
        
        $("button[data-oper='list']").on("click",function(e){
            
            operForm.find("#bno").remove();
            operForm.attr("action","/board/list");
            operForm.submit();
            
        });
        
        
    });

    </script>
 <script src="/resources/js/clock.js"></script>
</body>
</html>