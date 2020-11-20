<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>매장 관리</title>
<style>
/* The Modal (background) */
.modal {
  display: none; /* Hidden by default */
  position: fixed; /* Stay in place */
  z-index: 1; /* Sit on top */
  left: 0;
  top: 0;
  width: 100%; /* Full width */
  height: 100%; /* Full height */
  overflow: auto; /* Enable scroll if needed */
  background-color: rgb(0,0,0); /* Fallback color */
  background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
}

/* Modal Content/Box */
.modal-content {
  background-color: #fefefe;
  margin: 15% auto; /* 15% from the top and centered */
  padding: 20px;
  border: 1px solid #888;
  width: 80%; /* Could be more or less, depending on screen size */
}

/* The Close Button */
.close {
  color: #aaa;
  float: right;
  font-size: 28px;
  font-weight: bold;
}

.close:hover,
.close:focus {
  color: black;
  text-decoration: none;
  cursor: pointer;
}

</style>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
<body>

	<h1>Business Manage Main Page</h1>

	storeId : ${storeId}
	</br>

	<button id="refresh">새로고침</button>
	</br>
	
	<div class="js-clock">
		<h1>현재 날짜</h1>
		<h2 class="date"></h1>
		<h1>현재 시간</h1>
		<h2 class="time">00:00</h2>
	</div>

	<h1>매장 정보</h1>
	<ul class="store"></ul>

	<h1>현재 착석 상태</h1>
	<ul class="storeSeatStus"></ul>
	<form id="seatStusForm" action="/business/manage/board/seat"
		method="put">
		<input name="seatStusColor" id="color_value" value="" hidden>
		<input name="storeId" value="${storeId}" hidden>
		<button class="btn_seat_stus">Green</button>
		<button class="btn_seat_stus">Yellow</button>
		<button class="btn_seat_stus">Red</button>
		</br>
	</form>

	<h1>웨이팅 리스트</h1>
	<ul class="waitList"></ul>

	<button class="btn_wait_register">웨이팅 등록</button>

	<h1>예약 리스트</h1>
	<ul class="rsvdList"></ul>

	<h1>다음 웨이팅 정보</h1>
	<ul class="nextWait"></ul>

	<button class="btn_enter_wait">입장</button>
	</br>
	<button class="btn_noshow_wait">노쇼</button>

	<h1>다음 예약자 정보</h1>
	<ul class="nextRsvd"></ul>


	<h1>시간대별 예약</h1>
	<ul class="rsvdMap"></ul>

	<h1>당일 예약 결과</h1>
	<button id="btn_rsvd_rslt">예약 결과판</button>
	<ul class="rsvdRslt"></ul>


	<h2>오늘 예약 회원</h2>
	<c:if test="${not empty todayRsvdUserList}">
		<c:forEach items="${todayRsvdUserList}" var="user">
			<div>
				==========================================</br> 
				회원 아이디 : ${user.userId}</br>
				회원 이름 : ${user.name}</br> 
				회원 이메일 : ${user.email}</br> 
				회원 전화번호 : ${user.telno}</br>
				생년 월일 : ${user.brdt}</br> 
				성별 : ${user.sex }</br> 
				회원 프로필 사진 : ${user.photoSrc}</br>
				패널티 회원 여부 : ${user.pmStus}</br>
			</div>
		</c:forEach>
	</c:if>

	<!-- The Modal -->
	<div id="myModal" class="modal">

		<!-- Modal content -->
		<div class="modal-content">
			<ul class="rsvdDtls"></ul>
	
			<ul class="userRsvdList"></ul>
			
			<ul class="waiting_registerForm"></ul>
			
			<span class="close">&times;</span>
		</div>
	</div>
	
	
	<div class="row">
	<div class="col-lg-12">
	<div class="panel panel-default">
	<h2>매장 사진</h2>
	<!-- /.panel-heading -->
	<div class="panel-body">
	<div class='uploadResult'>
		<ul>
		</ul>
	</div> <!-- uploadResult -->
	</div> <!-- end panel-body  -->
	</div> <!-- end pannel -->
	</div> <!-- end col-lg-12  -->
	</div> <!-- end row  -->
	<div class='bigPictureWrapper'>
		<div class='bigPicture'>
		</div>
	</div>
<script>
	console.log("modal module.............")
	// Get the modal
	const modal = $("#myModal"),
		btn_modal = $("#myBtn"),
		close = $(".close");

// When the user clicks on the button, open the modal
btn_modal.on("click",(e) => {
	console.log("btn click........");
})

close.on("click", (e) => {
	console.log("close click........");
	modal.css("display","none");
	modal.find("ul").html("");
})

window.onclick = e => {
	if(e.target == modal){
		modal.css("display","block");
	}
}

// When the user clicks anywhere outside of the modal, close it
window.onclick = function(event) {
  if (event.target == modal) {
    modal.style.display = "none";
  }
}

</script>
	<script>

    console.log("board module........");
    
    
    /*
    REST 방식으로 서버와 통신
    
    */
    let boardService = (() => {
      
    	
        /*put 함수*/
        
        function putChangeStatusCd(params,callback,error) {
        	
        	let storeId = params.storeId,
        		seatStusCd = params.seatStusCd;
        	
            $.ajax({
                type:'put',
                url:'/business/manage/board/seat/'+storeId+'/'+seatStusCd,
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
        
        function putNoshowWaiting(waitId,callback,error) {
            $.ajax({
                type:'put',
                url:'/business/manage/board/waiting/noshow/' + waitId,
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
    
        function putEnterWaiting(waitId,callback,error) {
    
            $.ajax({
                type:'put',
                url:'/business/manage/board/waiting/enter/' + waitId,
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
    
        function putCancelWaiting(waitId,callback,error) {
    
            $.ajax({
                type:'put',
                url:'/business/manage/board/waiting/cancel/' + waitId,
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
        
        function getRsvdDtls(param,callback,error) {
        	
        	let rsvdId = param.rsvdId;
        	
        	$.getJSON("/business/manage/board/reservation/dtls/" + rsvdId + ".json",
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
        
		function getUserRsvdList(param,callback,error) {
        	
        	let storeId = param.storeId,
        		userId = param.userId;
        	
        	console.log(storeId);
        	console.log(userId);
        	
        	$.getJSON("/business/manage/board/reservation/list/" + storeId +"/" + userId + ".json",
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
        
        
		function getRsvdRslt(param,callback,error) {
            
            let storeId = param.storeId;
            
            $.getJSON("/business/manage/board/reservation/rslt/"+storeId+".json",
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
        
        function getRsvdList(param,callback,error) {
            
            let storeId = param.storeId;
            
            let rsvdList = $.getJSON("/business/manage/board/reservation/"+storeId+".json",
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
    
        function getWaitList(param,callback,error) {
            
            let storeId = param.storeId;
            
            let waitList = $.getJSON("/business/manage/board/waiting/"+storeId+".json",
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
    
        /*현재 들어온 매장 */
        function getStore(param,callback,error) {
            
            let storeId = param.storeId;
    
            $.getJSON("/business/manage/board/store/"+storeId+".json",
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
        
        function getNextWait(waitList){
            if(!waitList){
                return;
            }
                       
            return waitList.filter(wait => {return wait.waitStusCd === 'W'})
                    .sort((w1,w2) => { return w1.id - w2.id})[0];
        };
        
        function getTodayRsvdMap(param,callback,error){
      
        	let storeId = param.storeId;
        	
        	$.getJSON("/business/manage/board/reservation/map/"+ storeId +".json",
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
        
        function getNextRsvd(param,callback,error){
        	let storeId = param.storeId;
        	
        	$.getJSON("/business/manage/board/reservation/next/"+ storeId +".json",
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
    
        function regWait(wait, callback,error) {
    
            $.ajax({
                type : 'post',
                url : '/business/manage/board/waiting/new',
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
            getRsvdDtls : getRsvdDtls
        };
    })();
    
    
    /*
    	서버가 시작 되면 동작하는 코드
    */
    $(document).ready(() => {
        const storeId = ${storeId};
        
        let seatStusForm = $("#seatStusForm"),
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
        waitRegFormUL = $(".waiting_registerForm")
        ;
            
        showBoard(storeId); 
        getTime();
        setInterval(getTime, 1000);
        //showUserRsvdList(storeId,'kim'); test

        /*
        	board를 보여준다.
        	
        */
        function showBoard(storeId) {
            
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
            });
    
            
            boardService.getWaitList({storeId:storeId}, function (waitList) {
                let strWaitList = "";
                if(waitList == null){
                    waitList.html("");
                    return;
                }
                
                console.log(waitList);
                
                waitList.forEach(wait => {
                    strWaitList += "<ul>" + "<h3>웨이팅 번호 : "+wait.id+"</h3>";
                        strWaitList += "<li>웨이팅 회원 아이디 : "+ wait.userId + "</li>";
                        strWaitList += "<li>웨이팅 매장 번호"+ wait.storeId + "</li>";
                        strWaitList += "<li>웨이팅 인원"+ wait.waitPnum + "</li>";
                        strWaitList += "<li>웨이팅 등록 시간 : "+ wait.waitRegTm + "</li>";
                        strWaitList += "<li>웨이팅 상태 : "+ wait.waitStusCd + "</li>";
                        strWaitList += "<li>웨이팅 등록 시간 : "+ wait.inDate + "</li>";
                        strWaitList += "<li>웨이팅 회원 이름 : "+ wait.custNm + "</li>";
                        strWaitList += "<li>웨이팅 회원 번호 : "+ wait.custTelno + "</li>";
                    strWaitList += "</ul>"  
                });
    
              waitListUL.html(strWaitList);   
              
              
              let nextWait = boardService.getNextWait(waitList);
              
              console.log(nextWait);
              
              let strNextWait = "";
              
              if(nextWait){
              
              strNextWait += "<li> 대기자 이름 : "+nextWait.custNm+"</li>";
              strNextWait += "<li> 대기자 연락처 : "+nextWait.custTelno+"</li>";
              strNextWait += "<li> 웨이팅 번호 :"+nextWait.id+"</li>";
              strNextWait += "<li> 웨이팅 등록 날짜 :"+nextWait.inDate+"</li>";
              strNextWait += "<li> 매장 번호 : "+nextWait.storeId+"</li>";
              strNextWait += "<li> 회원 아이디 : "+nextWait.userId+"</li>";
              strNextWait += "<li> 웨이팅 인원 : "+nextWait.waitPnum+"</li>";
              strNextWait += "<li> 웨이팅 등록 시간 : "+nextWait.waitRegTm+"</li>";
              strNextWait += "<li> 웨이팅 상태 : "+nextWait.waitStusCd+"</li>";
              }
              nextWaitUL.html(strNextWait);
    
            }); 
    
            boardService.getRsvdList({storeId:storeId}, function (rsvdList) {
                let strRsvdList = "";
                if(rsvdList == null){
                    rsvdList.html("");
                    return;
                }
                rsvdList.forEach(rsvd => {
                    strRsvdList += "<ul class='btnRsvd'>" + "<h3>예약 번호 : "+rsvd.id+"</h3>"; 
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
                        strRsvdList += "<li>예약 등록 날짜"+ rsvd.inDate + "</li>";
                    strRsvdList += "</ul>"  
                });
    
              rsvdListUL.html(strRsvdList);
   
            }); 
            
            
            strRsvdMap = "";
            
            boardService.getTodayRsvdMap({storeId:storeId}, function(map){
            	let strRsvdMap = "";
            	if(!map)
            		return;
            	Object.entries(map).forEach(([key,value]) => {
            		strRsvdMap += "<li>"+key + " : " + value+"</li>";
            	})
            	
            	rsvdMapUL.html(strRsvdMap);
            	
            });
            
            boardService.getNextRsvd({storeId:storeId},function(rsvd){
        		let strNextRsvd = "";
        		if(!rsvd)
        			return;
                strNextRsvd += "<li>예약 번호 : "+rsvd.id+"</li>"; 
                strNextRsvd += "<li>매장번호 : "+ rsvd.storeId + "</li>";
                strNextRsvd += "<li>회원 아이디 : "+ rsvd.userId + "</li>";
                strNextRsvd += "<li>핫딜 번호 :"+ rsvd.htdlId + "</li>";
                strNextRsvd += "<li>승인 번호 : "+ rsvd.aprvNo + "</li>";
                strNextRsvd += "<li>예약 인원 : "+ rsvd.pnum + "</li>";
                strNextRsvd += "<li>예약 시간 : "+ rsvd.time + "</li>";
                strNextRsvd += "<li>예약 상태 : "+ rsvd.stusCd + "</li>";
                strNextRsvd += "<li>예약 총 금액 : "+ rsvd.totAmt + "</li>";
                strNextRsvd += "<li>예약 총 수량 : "+ rsvd.totQty + "</li>";
                strNextRsvd += "<li>예약 등록 날짜"+ rsvd.inDate + "</li>";
                
                nextRsvdUL.html(strNextRsvd);
        	});
  
        };
        
        function showRsvdBoard(storeId) {
        	
        	boardService.getRsvdRslt({storeId:storeId}, function(dto){
        		let strRsvdRslt = "";
        		if(!dto)
        			return;
        		
        		strRsvdRslt += "<li>오늘 총 예약 수" + dto.totalTodayRsvd  +"</li>";
        		strRsvdRslt += "<li>오늘 총 예약 인원" + dto.totalTodayRsvdPnum  +"</li>";
        		strRsvdRslt += "<li>오늘의 인기 메뉴</li>";
        		Object.entries(dto.todayFavMenuMap).forEach(([key,value]) => {
	        		strRsvdRslt += "<li>" + key +' : '+ value  +"</li>";
        		})
        		
        		rsvdRsltUL.html(strRsvdRslt);
        		
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
        			strUserRsvdList += "<li>예약 번호 : "+rsvd.id+"</li>"; 
                    strUserRsvdList += "<li>매장번호 : "+ rsvd.storeId + "</li>";
                    strUserRsvdList += "<li>회원 아이디 : "+ rsvd.userId + "</li>";
                    strUserRsvdList += "<li>핫딜 번호 :"+ rsvd.htdlId + "</li>";
                    strUserRsvdList += "<li>승인 번호 : "+ rsvd.aprvNo + "</li>";
                    strUserRsvdList += "<li>예약 인원 : "+ rsvd.pnum + "</li>";
                    strUserRsvdList += "<li>예약 시간 : "+ rsvd.time + "</li>";
                    strUserRsvdList += "<li>예약 상태 : "+ rsvd.stusCd + "</li>";
                    strUserRsvdList += "<li>예약 총 금액 : "+ rsvd.totAmt + "</li>";
                    strUserRsvdList += "<li>예약 총 수량 : "+ rsvd.totQty + "</li>";
                    strUserRsvdList += "<li>예약 등록 날짜"+ rsvd.inDate + "</li>";
        		});
        		
        		userRsvdListUL.html(strUserRsvdList);
        		
        		showRsvdDtls(userRsvdList[0].id);
        		
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
        		strRsvdDtls += "<li>예약 번호 :" + rsvd.id +"</li>";
        		strRsvdDtls += "<li>매장 번호 :" + rsvd.storeId +"</li>";
        		strRsvdDtls += "<li>회원 아이디 : " + rsvd.userId +"</li>";
        		strRsvdDtls += "<li>핫딜 번호 : " + rsvd.htdlId +"</li>";
        		strRsvdDtls += "<li>승인 번호 : " + rsvd.aprvNo +"</li>";
        		strRsvdDtls += "<li>예약 인원 : " + rsvd.pnum +"</li>";
        		strRsvdDtls += "<li>예약 시간 : " + rsvd.time +"</li>";
        		strRsvdDtls += "<li>예약 상태 : " + rsvd.stusCd +"</li>";
        		strRsvdDtls += "<li>예약 총 가격 : " + rsvd.totAmt +"</li>";
        		strRsvdDtls += "<li>예약 총 수량 : " + rsvd.totQty +"</li>";
        		strRsvdDtls += "<li>예약 등록 날짜 : " + rsvd.inDate +"</li>";
        		let cnt = 1;
        		rsvd.rsvdDtlsList.forEach(dtls => {
        			strRsvdDtls += "==============================";
        			strRsvdDtls += "<li>상세 순서[" + cnt +"]</li>";
        			strRsvdDtls += "<li>예약 상세 번호" + dtls.seq +"</li>";
        			strRsvdDtls += "<li>예약 메뉴 이름" + dtls.menuNm +"</li>";
        			strRsvdDtls += "<li>메뉴 가격" + dtls.menuPrc +"</li>";
        			strRsvdDtls += "<li>메뉴 총 개수" + dtls.menuTotQty +"</li>";
        			cnt += 1;
        		})
        		
        		rsvdDtlsUL.html(strRsvdDtls);
        		
        	})
        };
        
        function showWaitRegisterForm(storeId){
        	
        	let today = new Date();
        	strWaitRegForm = "";
        	strWaitRegForm += "<h1>오프라인 웨이팅 등록</h1>";
        	strWaitRegForm += "<form id='waitRegForm' action='/business/manage/waiting/register' method='post'>";
        	strWaitRegForm += "고객 이름<input name='custNm'></br>";
        	strWaitRegForm += "고객 전화번호<input name='custTelno'></br>";
        	strWaitRegForm += "웨이팅 인원<input name='waitPnum'></br>";
        	strWaitRegForm += "<input name='curTime' value='"+today+"' hidden>";
        	strWaitRegForm += "<input name='storeId' value='"+storeId+"' hidden>";
        	strWaitRegForm += "<button id='submit_waitRegForm' type='submit'>제출하기</button>";
        	strWaitRegForm += "</form>";
        	strWaitRegForm += "<h2>현재 시간</h2>";
        	strWaitRegForm += "<h2>"+today+"</h2>";
        	
        	waitRegFormUL.html(strWaitRegForm);
        	
        }
        
        
        /* 이벤트 처리*/
        /**/

        /*당일 예약 결과 가져오기*/
        $("#btn_rsvd_rslt").on("click", e => {
        	showRsvdBoard(${storeId});
        });

        /*새로고침*/
        $("#refresh").on("click", e => {
        	window.location = location.href;
        });

        	/*
        	let storeId = $(this).children(".btnStoreId").textContent;
        			userId = $(this).children(".btnUserId").textContent;
        	showUserRsvdList(storeId, userId);
        	*/

        /*예약리스트에 있는 내용 중, 예약 상세 보여주기*/
        /*회원의 예약 리스트 보여주기*/
        $(".rsvdList").on("click", e => {

        	let storeId = $(e.target).parent().find(".btnStoreId").text(),
        		userId = $(e.target).parent().find(".btnUserId").text();
        	
        	modal.css("display","block");

        	showUserRsvdList(storeId, userId);
        	
        });
        	
        /* 웨이팅 등록 */
        $(".btn_wait_register").on("click", e => {
        	
        	modal.css("display","block");
        	showWaitRegisterForm(${storeId});
        	
			let modalInputCustNm = modal.find("input[name='custNm']"),
				modalInputCutsTelNo = modal.find("input[name='custTelno']"),
				modalInputCurTime = modal.find("input[name='curTime']"),
				modalInputStoreId = modal.find("input[name='storeId']");
        	
        	$("#submit_waitRegForm").on("click", e => {
        		
        		e.preventDefault();
        		
        		let wait = {
        				custNm : modalInputCustNm.val(),
        				custTelno : modalInputCutsTelNo.val(),
        				curTime : modalInputCurTime.val(),
        				storeId : modalInputStoreId.val()
        		};

        		boardService.regWait(wait, result => {
        			
        			alert(result);
        			modal.find("input").val("");
        			modal.css("display","none");
        			
        			
        		});
        		
        		console.log("결과.........."+modalInputStoreId.val());
                showBoard(modalInputStoreId.val());
        		//$("#waitRegForm").submit();        		
        		
        	});
        	
        	
        });

        /* 매장 착석 상태 처리*/
        $(".btn_seat_stus").on("click", e => {

            e.preventDefault();
            
            let color = "";

            if(e.target.innerHTML === 'Red')
                color = 'R';
            if(e.target.innerHTML === 'Yellow')
                color = 'Y';
            if(e.target.innerHTML === 'Green')
                color = 'G';
            
            console.log(color);
            
            let param = {};
            param.storeId = ${storeId};
            param.seatStusCd = color;
            
            console.log(param);
            
        	boardService.putChangeStatusCd(param);
        	
            showBoard(param.storeId);
        });

        /*웨이팅 입장 처리*/
        $(".btn_enter_wait").on("click", e => {
        	
        	/*dom 코드는 변경될 가능성 있음*/
        	waitId = parseInt($(".nextWait li:eq(2)").text().split(":")[1]);

        	boardService.putEnterWaiting(waitId);
        	
        	showBoard(storeId);
        })

        /*웨이팅 노쇼 처리*/
        $(".btn_noshow_wait").on("click", e => {
        	
        	/*dom 코드는 변경될 가능성 있음*/
        	waitId = parseInt($(".nextWait li:eq(2)").text().split(":")[1]);

        	boardService.putNoshowWaiting(waitId);
        	
        	showBoard(storeId);
        });


        
        });

    $(document).ready(function() {
    	

        (function(){
            
        	let storeId = ${storeId};
            
            $.getJSON("/business/manage/getStoreImgs", {storeId:storeId}, function(imgs){
                
                console.log("즉시 함수..");
                
                console.log(imgs);
                
                let str = "";
                
                $(imgs).each(function(i, img){
                	
                	console.log(img);
                    
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

    /* 자동 새로고침 */
    /*
    function startRefresh() {
        window.location = location.href;
    }
    
    let minutes = 60;
    
    $(function() {
        setTimeout(startRefresh,minutes*5);
    });
    */

    </script>
	<!-- 
<script>
    console.log("============");
    console.log("get test");

    boardService.getStore({storeId : 101}, function(store){
        console.log(store);
    });

    boardService.getWaitList({storeId:101}, function(waitList){
        waitList.forEach(wait => {
            console.log(wait);
        });
    })

    boardService.getRsvdList({storeId:101}, function(rsvdList){
        rsvdList.forEach(rsvd => {
            console.log(rsvd);
        })
    })

    boardService.putCancelWaiting(182,function (result) {
        alert("수정 완료");
    })

</script>
 -->
 <script src="/resources/js/clock.js"></script>
</body>
</html>