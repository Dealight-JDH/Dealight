<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.1.5/sockjs.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <!-- <script src="https://cdnjs.jsdelivr.net/sockjs/1/sockjs.min.js"></script> -->
<script type="text/javascript">

// websocket을 지정한 URL로 연결
let sock = new SockJS("<c:url value="/echo"/>");
//websocket 서버에서 메시지를 보내면 자동으로 실행된다.
sock.onmessage = onMessage;
//websocket과 연결을 끊고 싶을 때 실행하는 메소드.
sock.oncloes = onClose;

$(function () {
    $("#sendBtn").click(function(){
        console.log('send message...');
        sendMessage();
    });
});

function sendMessage() {
    //websocket으로 메시지를 보내겠다.
    sock.send($("#message").val());
}

// evt 파라미터는 websocket이 보내준 데이터다.
function onMessage(evt) {
    let data = evt.data;
    let sessionid = null;
    let message = null;

    // 문자열을 splite
    let strArray = data.split("|");

    for(let i = 0; i < strArray.length; i++){
        console.og('str[' + i + ']: ' + strArray[i]);
    }

    // current session id
    let currentuser_session = $('#sessionuserid').val();
    console.log('current session id : ' + currentuser_session);

    sessionid = strArray[0]; // 현재 메시지를 보낸 사람의 세션 등록
    message = strArray[1]; // 현재 메시지를 저장

    // 나와 상대방이 보낸 메시지를 구분하여 영역을 나눈다.
    if(sessionid == currentuser_session) {
        let printHTML = "<div class='well'>";
            printHTML += "<div class='alert alert-info'>";
            printHTML += "<strong["+sessionid+"] -> " + message + "</strong>";
            printHTML += "</div>";
            printHTML += "</div>";

            $("#chatdata").append(printHTML);
    } else{
        let printHTML = "<div class='well'>";
            printHTML += "<div class='alert alert-warning'>";
            printHTML += "<strong>[" +sessionid+"] -> " +message +"</strong>";
            printHTML += "</div>";
            printHTML += "</div>";

            $("#chatdata").append(printHTML);

    }
    console.log('chatting data : ' + data);

    /* sock.close(); */
     
}

function onClose(evt) {
    $("#data").append("연결 끊김");
}

</script>
</body>
</html>
