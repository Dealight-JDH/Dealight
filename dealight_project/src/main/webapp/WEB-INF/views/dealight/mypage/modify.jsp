<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../../includes/mainMenu.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 정보 수정</title>
<link rel="stylesheet" href="/resources/css/mypage.css?ver=1" type ="text/css" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
<body>
<div id="container">
	<main class="mypage_wrapper">
		<%@include file="/WEB-INF/views/includes/mypageSidebar.jsp" %>
			<div class="mypage_content">
                <h1>회원정보수정</h1>
                
                <form role="form" action ="/dealight/mypage/modify" method="post" onsubmit="return validate()">
                <p>아이디 : <input type = "text" name="userId" id="userId"value="<c:out value = "${user.userId }"/>" readonly="readonly">
               	<p>이름 : <input type = "text" name="name" id="name" value="<c:out value = "${user.name }"/>" >
                <p>이메일 : <input type = "email" name="email" id="email" value="<c:out value = "${user.email }"/>" >
                <p>핸드폰번호 : <input type = "text" name="telno" id="telno" value="<c:out value = "${user.telno }"/>" >
                <p>생년월일 : <input type = "text" name="brdt" id="brdt" value="<c:out value = "${user.brdt }"/>" readonly="readonly">
                <p>성별 : 여자<input type="radio" name="sex" value="W">남자<input type="radio" name="sex" value="M">  </p>
                <p>프로필사진 : <input type = "text" name="photoSrc" id="photoSrc" value="<c:out value = "${user.photoSrc }"/>" >
                <p> SNS연동 : <input type="radio" name="snsLginYn" value="Y">yes<input type="radio" name="snsLginYn" value="N">no  </p>
                
                <div>
                <button type="submit" data-oper="modify">회원수정</button>
                <button type="submit" data-oper="remove" >회원탈퇴</button>
                <button type="submit" data-oper="get" >뒤로가기</button>
                </div>
                </form>
                </div>
          </main>
</div>
<!-- 수정이 성공했는지 실패했는지 메세지를 받아옴 -->
<%-- <input type="hidden"  id = msg2 value='<c:out value="${msg2}"/>'> --%>

<script type="text/javascript">
$(document).ready(function(){
	
	let formObj = $("form");
	$("button").on("click", function(e){
		
		e.preventDefault();
		let operation = $(this).data("oper");
		
		if(operation === 'remove'){
			formObj.attr("action", "/dealight/mypage/remove");
			
		}else if(operation === 'get'){
			self.location = "/dealight/mypage/get";
			return;
		}
		
		formObj.submit();
		
	});
	
})
//로그인이 안된 상태면 메인페이지로 넘어가게
let msg = '${msg}';
	if(msg != ""){
		alert(msg);
		location.href = '/dealight/dealight';
	}

//1. 성별 정보 불러오기, 수정 불가함
let sexCheck =  document.getElementsByName('sex');
let sex = '${user.sex}';

if(sex == 'W'){
	sexCheck[0].checked = true;
	$("[name=sex]:not(:checked)").attr('disabled', 'disabled');
}
else if(sex == 'M'){
	sexCheck[1].checked = true;
	$("[name=sex]:not(:checked)").attr('disabled', 'disabled');
}

//2. sns 연동 정보 불러오기, 수정 가능
let snsCheck = document.getElementsByName('snsLginYn');
let sns = '${user.snsLginYn}';

if(sns == 'Y'){
	snsCheck[0].checked = true;
}
else if(sns == 'N'){
	snsCheck[1].checked = true;
}
	//입력필드 유효성 검사
	
	//정규식

</script>
<%@include file="../../includes/mainFooter.jsp" %>
</body>
</html>