<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
<script src="/resources/js/Chart.js"></script>
</head>
<body>
	<div class="well">
		<h2>웨이팅 등록</h2>
		<form action="/dealight/store/wait" method="post">
			웨이팅 인원 : <input type="number" name="pnum"></br>
			매장 번호 : <input type="number" name="storeId"></br>
			<button type="submit">온라인 웨이팅 등록</button></br>
		</form>
	</div>
	
	<div class="well">
		<h2>예약 등록</h2>
		<form action="/dealight/business/test/rsvd" method="post">
			예약 인원 : <input type="number" name="pnum"></br>
			매장 번호 : <input type="number" name="storeId" value="1"></br>
			핫딜 번호 : <input type="number" name="htdlId"></br>
			결제 승인 번호 : <input type="number" name="aprvNo" value="1111"></br>
			총 수량 : <input type="number" name="totQty" value="2"></br>
			총 가격 : <input type="number" name="totAmt" value="16000"></br>
			시간 : <input name="time" value="13:00">
			==========================================</br>
			메뉴 이름 : <input type="text" name="menuNm" value="치킨"></br>
			메뉴 수량 : <input type="number" name="menuTotQty" value="2"></br>
			메뉴 가격 : <input type="number" name="menuPrc" value="16000"></br>
			<button type="submit">예약 등록</button>
		</form>
	</div>
	
	<div class="well">
		<h2>핫딜 제안</h2>
		<form action="/dealight/business/test/htdl" method="post">
			핫딜 이름 : <input type="text" name="name"></br>
			매장 번호 : <input type="number" name="storeId" value="1"></br>
			할인률 : <input type="number" name="dcRate" value="10"></br>
			시작 시간 : <input type="text" name="startTm" value="13:00"></br>
			종료 시간 : <input type="text" name="endTm" value="14:00"></br>
			<button type="submit">핫딜 제안하기</button>
		</form>
	</div>
	
    	<div id="myModal" class="modal">
		<!-- Modal content -->
		<div class="modal-content">
			<span class="close">&times;</span>
			<ul class="rsvdDtls"></ul>
			<ul class="userRsvdList"></ul>
			<ul class="waiting_registerForm"></ul>
		</div>
	</div>
	
	<div id="socketAlert" class="alert alert-success" role="alert" style="display:none;"></div>
	<div>
		<h2>메시지 로그인 상태</h2>
		${map}
	</div>
    <script>
    /* Web Socket */
    
 
 $(document).ready( function(){
		
		// input 내용을 socket에 send
		$('.btn_wait').on('click', function(evt) {
			  evt.preventDefault();
			if (socket.readyState !== 1) return;
				  let msg = $('input.msg_wait').val();
				  socket.send(msg);
			});
		
		$('.btn_rsvd').on('click', function(evt) {
			  evt.preventDefault();
			if (socket.readyState !== 1) return;
				  let msg = $('input.msg_rsvd').val();
				  socket.send(msg);
			});
		
		connectWS();
});

 const userId = '${userId}';
    
	// 모달 선택
	const modal = $("#myModal"),
		close = $(".close"),
		modalContent = $(".modal-content"),
		btn_show_board = $("#btn_show_board");

	close.on("click", (e) => {
		modal.css("display","none");
		modal.find("ul").html("");
	});
 
    

 
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
 
 function showWaitRegisterForm(storeId, userId){
 	
 	let today = new Date();
 	let strWaitRegForm = "";
 	strWaitRegForm += "<h1>오프라인 웨이팅 등록</h1>";
 	strWaitRegForm += "<form id='waitRegForm' action='/dealight/business/manage/waiting/register' method='post'>";
 	strWaitRegForm += "고객 아이디<input name='userId' id='js_wait_custNm' value='"+userId+"' readonly></br>";
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
 	    

 		regWait(wait, result => {
 			
 			//alert(result);
     		showWaitList(storeId);
     		modal.find("ul").html("");
 			modal.find("input").val("");
 			modal.css("display","none");
 			
 		});
		
		});
 	
 	
 };
    </script>
</body>
</html>