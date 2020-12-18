<%@page import="com.dealight.domain.UserVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%-- <%@include file="../includes/mypageMenubar.jsp" %> --%>
    <%@include file="../includes/loginmodalHeader.jsp" %>
    <%@include file="../includes/mainMenu.jsp" %>
    <%@include file="../includes/loginModal.jsp" %>
<body>
<div class="middleDiv">
            <div class="imgContainer">
                <img src="../../../../../resources/img/main.jpg">

                <form action="search" class="searchBarDiv" method="get">
                    <div class="topRow">
                        <input type="text" class="topRowBar" name="pNum" placeholder="인원">
                        <input type="text" class="topRowBar" name="region" placeholder="지역">
                        <input type="text" class="topRowBar" name="time" placeholder="시간">
                    </div>
                    <div class="bottomRow">
                        <input type="text" class="bottomRowBar" placeholder="가게명 검색, 해시태그를 입력하세요">
                        <button class="searchbtn">매장보기</button>
                    </div>
                </form>
                <!-- imgContainer -->
            </div>
            <!-- middleDiv -->
        </div>

        <div class="dealTitleDiv">
            <div class="dealTitle">실시간핫딜</div>
        </div>

        <div class="dealDiv">
            <div class="dealContainer">
                <div class="dealImg">
                </div>
                <div class="dealText">
                </div>
            </div>
            <div class="dealContainer">
                <div class="dealImg"></div>
                <div class="dealText"></div>
            </div>
            <div class="dealContainer">
                <div class="dealImg"></div>
                <div class="dealText"></div>
            </div>
            <div class="dealContainer">
                <div class="dealImg"></div>
                <div class="dealText"></div>
            </div>
            <div class="dealContainer">
                <div class="dealImg"></div>
                <div class="dealText"></div>
            </div>
            <div class="dealContainer">
                <div class="dealImg"></div>
                <div class="dealText"></div>
            </div>
            <div class="dealContainer">
                <div class="dealImg"></div>
                <div class="dealText"></div>
            </div>
            <div class="dealContainer">
                <div class="dealImg"></div>
                <div class="dealText"></div>
            </div>
            <div class="dealContainer">
                <div class="dealImg"></div>
                <div class="dealText"></div>
            </div>
        </div>

        <div class="footer"></div>
<%@include file="../includes/mainFooter.jsp" %>
<script type="text/javascript">
let socket = null;

function connectWS() {
	// 전역변수 socket을 선언한다.
	// 다른 페이지 어디서든 소켓을 불러올 수 있어야 하기 때문이다.
	
	// 소켓을 ws로 연다.
	let ws = new WebSocket("ws://localhost:8181/manageSocket");
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
</script>
</body>
</html>