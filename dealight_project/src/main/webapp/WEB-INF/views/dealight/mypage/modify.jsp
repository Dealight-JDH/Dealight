<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <%-- <%@ include file="/dealight/src/main/webapp/WEB-INF/views/includes/mainMenu.jsp" %> --%> 
    <%@include file="../../includes/mainMenu.jsp" %>
   
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!--  -->

     <script>
    //로그인이 안된 상태면 메인페이지로 넘어가게
	let msg = '${msg}';
		if(msg != ""){
			alert(msg);
			location.href = '/dealight/dealight';
		}
</script>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
.modify-content{
border: 1px solid;
width: 400px;
height: 500px;
margin: 20px;
padding: 20px;
}

</style>
</head>
<body>
<h1>회원정보 수정/ 회원탈퇴</h1>
<div class="modify-content">
<form action ="/dealight/mypage/modify" method="post" onsubmit="return validate()">
<p>아이디 : <input type = "text" name="userId" id="userId"value="<c:out value = "${user.userId }"/>" readonly="readonly">
<p>이름 : <input type = "text" name="name" id="name" value="<c:out value = "${user.name }"/>" >
<p>이메일 : <input type = "email" name="email" id="email" value="<c:out value = "${user.email }"/>" >
<p>핸드폰번호 : <input type = "text" name="telno" id="telno"value="<c:out value = "${user.telno }"/>" >
<p>생년월일 : <input type = "text" name="brdt" id="brdt" value="<c:out value = "${user.brdt }"/>" readonly="readonly">
<p>성별 : 여자<input type="radio" name="sex" value="W">남자<input type="radio" name="sex" value="M">  </p>
<p>프로필사진 : <input type = "text" name="photoSrc" id="photoSrc"value="<c:out value = "${user.photoSrc }"/>" >
<p> SNS연동 : <input type="radio" name="snsLginYn" value="Y">yes<input type="radio" name="snsLginYn" value="N">no  </p>

<div><button type="submit" onclick="alert('회원정보수정이 완료되었습니다.')">회원수정</button>
<button type="submit" id="remove" >회원탈퇴</button></div>
</form>
</div>
<!-- 수정이 성공했는지 실패했는지 메세지를 받아옴 -->
<%-- <input type="hidden"  id = msg2 value='<c:out value="${msg2}"/>'> --%>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">


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

	const jPwd = /^(?=.*?[a-zA-Z])(?=.*?[#?!@$%^&*-]).{8,16}$/; // 대문자/소문자/특수문자 1개씩은 포함해서 8자리~16자리
	const jName = /^[\w\Wㄱ-ㅎㅏ-ㅣ가-힣]{2,8}$/; // 닉네임은 문자 제한없이 2~8자리
	const jEmail = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i; // 이메일
	const jTelno = /^\d{3}\d{3,4}\d{4}$/; //전화번호 정규식 '-'빼고 숫자만 01063517402
	const blank = /\s/g;
	
	
    function validate() {	
	
	//1. 이름 유효성 검사
	if($("#name").val() == ""){
		alert('이름을 입력하여 주세요');
		$("#name").focus();
		return false;
	}
	
	if(!jName.test($("#name").val()) || blank.test($("#name").val())){
		alert('이름 형식에 맞지 않습니다');
		$("#name").val("");
		$("#name").focus();
		return false;
	}
	
	//2. 전화번호 유효성검사
	if($("#telno").val() == ""){
		alert('전화번호를 입력하여 주세요');
		$("#telno").focus();
		return false;
	}
	
	if(!jTelno.test($("#telno").val())){
		alert('전화번호 형식에 맞지 않습니다');
		$("#telno").val("");
		$("#telno").focus();
		return false;
	}
	
	//3. 이메일 유효성검사
	if($("#email").val() == ""){
		alert('이메일을 입력하여 주세요');
		$("#email").focus();
		return false;
	}
	
	if(!jEmail.test($("#email").val())){
		alert('이메일 형식에 맞지 않습니다');
		$("#email").val("");
		$("#email").focus();
		return false;
	} 
    }
    
//4. 회원탈퇴 
$(function(){
	$("#remove").on("click", function(){
		
		let userId = $("#userId").val();
		let send = {'userId' : userId}
		$.ajax({
			type:"post",
			url: "/dealight/mypage/remove",
			data: send,
			success : function(data){
					if(data){
						alert("정상적으로 회원 탈퇴 되었습니다.");
						//탈퇴 완료되면 로그인 세션 삭제되도록
						location.href = '/dealight/logout';
					}else{
						alert("탈퇴실패!");
						return false;
					}
					
				}
		}) //ajax end
	})
	})
	
/* function sussecc(){
    	alert("회원 정보 수정이 완료되었습니다.");
    	location.href = '/dealight/mypage/reservation'; 
    } */
</script>
</body>
</html>