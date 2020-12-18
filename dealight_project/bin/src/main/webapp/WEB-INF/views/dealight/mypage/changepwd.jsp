<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../../includes/mainMenu.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호변경</title>
<link rel="stylesheet" href="/resources/css/mypage.css?ver=1" type ="text/css" />
</head>
<body>
    <main class="mypage_wrapper">
        <%@include file="/WEB-INF/views/includes/mypageSidebar.jsp" %>
        <div class="mypage_content">
            <div class="content_head">
                <h2>비밀번호 변경<span>비밀번호를 변경합니다.</span></h2>
            </div>
            <div>
                
            </div>
            <div class="content_main">
				<h1>마이페이지 비밀번호변경</h1>
				<h2>${msg}</h2>
				<div>
					<form action="/dealight/mypage/changepwd" method="post" onsubmit="return validate()">
						<p>현재 비밀번호 <input type = 'password' id='pwd' name='pwd'></p>
						<p>변경할 비밀번호<input type = 'password' id='changepwd' name='changepwd'></p>
						<p>비밀번호 확인 <input type = 'password' id='repwd' onblur="checkPwd()"></p> 
						<p class = 'msg' id="repwdmsg">비밀번호를 다시 한 번 입력해주세요</p>
						<button type="submit" id="btn">비밀번호 변경</button>
					</form>
				</div>
            </div>
        </div>
    </main>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
const jPwd = /^(?=.*?[a-zA-Z])(?=.*?[#?!@$%^&*-]).{8,16}$/; // 대문자/소문자/특수문자 1개씩은 포함해서 8자리~16자리
const blank = /\s/g;

//1. 비밀번호와 비밀번호 확인이 일치하는지 확인
function checkPwd(){
	if($("#repwd").val() == ""){
		 document.getElementById("repwdmsg").innerHTML = "비밀번호 확인을 입력해주세요";
	     document.getElementById("repwdmsg").style.color = 'red'; 
	}else{
		
		
		if($("#changepwd").val() == $("#repwd").val()){
			document.getElementById("repwdmsg").innerHTML = "비밀번호가 일치합니다.";
    		document.getElementById("repwdmsg").style.color = 'red'; 
		} 
	
		if($("#changepwd").val() != $("#repwd").val()){
			document.getElementById("repwdmsg").innerHTML = "비밀번호가 일치하지 않습니다 다시 입력해주세요";
    		document.getElementById("repwdmsg").style.color = 'red'; 
		}
	}//else end
}//fun end

//2. 비밀번호 유효성검사
function validate() {	
	
	
	if($("#pwd").val() === ""){
		alert('비밀번호를 입력하여 주세요');
		$("#pwd").focus();
		return false;
	}
	
	if(!jPwd.test($("#changepwd").val()) || blank.test($("#changepwd").val())){
		alert('비밀번호 형식에 맞지 않습니다');
		$("#changepwd").val("");
		$("#changepwd").focus();
		return false;
	}
	
	return true;
}
</script>

<%@include file="../../includes/mainFooter.jsp" %>
</body>
</html>