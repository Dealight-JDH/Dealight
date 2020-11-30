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
		<input type="text" class="msg_wait" value='{"sendUser":"${userId}","waitId":"100","cmd":"wait","storeId":"1"}' class="form-control" />
		<button class="btn btn-primary btn_wait">Send Message</button>
	</div>
	
	<div class="well">
		<h2>예약 등록</h2>
		<input type="text" class="msg_rsvd" value='{"sendUser":"${userId}","rsvdId":"100","cmd":"rsvd","storeId":"1"}' class="form-control" />
		<button class="btn btn-primary btn_rsvd">Send Message</button>
	</div>
	
	<div id="socketAlert" class="alert alert-success" role="alert" style="display:none;"></div>
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

 let socket = null;
 
 function connectWS() {
	// 전역변수 socket을 선언한다.
	// 다른 페이지 어디서든 소켓을 불러올 수 있어야 하기 때문이다.
	
 	// 소켓을 ws로 연다.
 	let ws = new WebSocket("ws://localhost:8080/manageSocket");
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
 	    
 	    
 	    let socketAlert = $('#socektAlert');
 	    socketAlert.html(event.data);
 	    socketAlert.css('display','block');
 	   	showWaitList(storeId);
 	    
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
    </script>
</body>
</html>