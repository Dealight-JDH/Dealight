<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../../includes/mainMenu.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>딜라이트</title>
<link rel="stylesheet" href="/resources/css/mypage.css?ver=1" type ="text/css" />
<link rel="stylesheet" href="/resources/css/manage.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<style>

* { /* CSS초기화. 이거 없으면 div태그 사이에 공백 생김*/

        margin  : 0;   /* 값이 0일 때는 단위 안씀. */
        border  : 0;
        padding : 0;
        /* font-family: 'Nanum Gothic', sans-serif; */
}
        
        .mypage_wrapper{
        	padding-bottom: 20px;
        } 
      
            
    .form-wrapper{
        display: flex;
        width: 750px;
    }

    .css-input{
        display: flex;
        flex-direction: row;
        position: relative;
        /* padding: 3px; */
        margin-bottom: 8px;
        width: 100%;
        align-items: center;
        /* border: 1px solid black; */
    }

    .css-input>input{
        padding: 12px 20px;
        width: 30%;
        height: 40px;
        margin: 12px 0 6px;
        margin-left: 10px;
        padding-right: 3px;
        border: 1px solid rgb(139, 139, 139);
        border-radius: 3px;
        box-sizing: border-box;
    }

    .css-input>p{
        width: 20%;
        font-weight: 500;
        margin-left: 40px;
    }

    .ico{
        color: #ee6a7b;

    }

    .css-modify{
        display: flex;
        /* border: 1px solid black; */
        flex-direction: column;
        width: 100%;
        margin-top: 16px;
        
        
        
    }

	.form-footer{
        /* border: 1px solid black; */
        display: flex;
        width: 50%;
        height: 60px;
        margin-top: 40px;
        margin-left: 35px;
        justify-content: center;
        align-content: flex-start;
        /* align-items: center; */
    }

    .birthday{
        display: flex;
        /* padding: 3px; */
        align-items: center; 
        margin-left: 10px;
        border: 1px solid rgb(139, 139, 139);
        border-radius: 3px;
        /* box-sizing: border-box; */
    }

    .birthday>input{
        width: 65px;
        height: 40px;
        text-align: center;
        outline: none;
    }

    

    .css-modifyBtn{
        border: 1px solid orange;
        color: orange;
    }
    .css-backBtn{
        border: 1px solid black;
        color: black;
    }
    .css-removeBtn{
        border: 1px solid #d32323;
        color: #d32323;
    }

    .btn{
        width: 13%;
        height: 40px;
        margin-left: 16px;
        font-weight: bold;
        border: 1px solid #d32323;
        color: #d32323;
        outline: 0;
        background-color: white;
        border-radius: 4px;
    }

    .submit-btn{
        width: 20%;
        height: 40px;
        margin-left: 16px;
        font-weight: bold;
        /* border: 1px solid #d32323;
        color: #d32323; */
        outline: 0;
        background-color: white;
        border-radius: 4px;
        cursor: pointer;
        outline: none;
    }
    
    #sendEmailbtn{
    	cursor: pointer;
    	outline: none;
    }
    


</style>
</head>
<body>

	 <main>
        <div class="mypage_wrapper">

            
                
                	<%@include file="/WEB-INF/views/includes/mypageSidebar.jsp" %>
            
            
                <div class="mypage_right">
                    <div class="mypage_main_header">
                        <div class="main_header_title">회원정보수정</div>
                        <div class="main_header_subtitle">회원님의 정보를  수정할 수 있습니다.</div>
                    </div>
                    
                    <div class="css-modify">
                    <form role="form" action ="/dealight/mypage/modify" method="post">
                        
                        <div class="css-id css-input">

                            <p>아이디<span class="ico">*</span></p>
                            

                            <input type="text" name="userId" id="userId" value="<c:out value = "${user.userId }"/>" readonly>
                            
                            
                            <!-- <span class="txt_case1">

                                "6자 이상의 영문 혹은 영문과 숫자를 조합"
                            </span>

                            <span class="txt_case2">

                                "아이디 중복확인"
                            </span> -->
                            
                        </div>

                        <!-- <p class='msg' id="idmsg">영문 대문자 또는 소문자 또는 숫자로 시작하는 아이디, 길이는
                            5~15자</p> -->

                        <div class="css-input">
                            <p>이름<span class="ico">*</span></p>
                            <input type="text" name="name" id="name" value="<c:out value = "${user.name }"/>">
                        </div>

                        <div class="css-input">
                            <p>비밀번호<span class="ico">*</span></p>
                            <input type="password" name="pwd" id="pwd" placeholder="비밀번호를 입력해주세요">
                        </div>

                        <!-- <p class='msg' id="pwdmsg">비밀번호는 영문 대소문자,특수문자 1개씩은 포함해서 8자리~16자리
                            이내</p> -->
                        <div class="css-input">
                            <p>비밀번호 확인<span class="ico">*</span></p>
                            <input type="password" name="repwd" id="repwd" placeholder="비밀번호를 한번 더 입력해주세요"
                                onblur="checkPwd()">
                        </div>

						<p class='msg' id="repwdmsg" style='margin-left: 200px; margin-bottom:8px;'></p>
						
                        <!-- <div>
                        <p class='msg' id="repwdmsg">비밀번호 확인을 위하여 다시 한 번 입력해주세요</p>
                        <div> -->
                        
                        <c:set var="brdtValue" value="${user.brdt }"/>
                         
                        <div class="css-input">
                            <p>생년월일
                                <span class="ico">*</span>
                            </p>
                            
                            <div class="birthday">
                             
                                <input type="text" name="brdt" id="brdt1"
                                
                                value="<c:out value = "${fn:substring(brdtValue,0,4) }"/>" size="4" maxlength="4">
                                <span class="bar">/</span>
                                
                                <input type="text" name="brdt" id="brdt2"
                                    value="<c:out value = "${fn:substring(brdtValue,4,6) }"/>" size="2" maxlength="2">

                                <span class="bar">/</span>    
                                

                                <input type="text" name="brdt" id="brdt3"
                                    value="<c:out value = "${fn:substring(brdtValue,6,9) }"/>" size="2" maxlength="2">
                            </div>
                        </div>
                
                        <!-- <div class="form-wrapper"> -->

                        
                        <div class="css-input sendEmail">
                            <p>이메일<span class="ico">*</span></p>
                            <input type="email" name="email" id="email"
                                placeholder="이메일을 입력하여 주세요">
                            <button type="button" class="btn" name="sendBtn" id="sendEmailbtn">발송</button>
                        </div>
                        <div class="css-input authEmail">
						</div>
						
						<div class="css-input">
							<div class="alertMsg" style="margin-left: 200px;">
							<p class="msg"></p>
							</div>
						</div>
						
                    <!-- </div> -->

                        <div class="css-input">                            
                            
                            <p>성별</p>
                            <c:if test="${user.sex eq 'M' }">
                                <input type="text" name="email" id="gender" value="남자" readonly>
                            </c:if>
                            
                            <c:if test="${user.sex eq 'W' }">
                                <input type="text" name="email" id="gender" value=여자" readonly>
                            </c:if>
                              
                        </div>


                        <div class="css-input">
                            <p>휴대폰
                                <span class="ico">*</span>
                            </p>
                            <input type="text" name="telno" id="telno"
                            placeholder="숫자만 입력해주세요">

                        </div>

                    <div class="form-footer">
                        <button type="submit" class="submit-btn css-modifyBtn" data-oper="modify">회원수정</button>
                        <button type="submit" class="submit-btn css-removeBtn" data-oper="remove" >회원탈퇴</button>
                        <button type="submit" class="submit-btn css-backBtn" data-oper="get" >뒤로가기</button>
                    </div>
                    </form>
                </div>

                    </div>
                </div>
    
            </main>
		
		

<!-- 수정이 성공했는지 실패했는지 메세지를 받아옴 -->
<%-- <input type="hidden"  id = msg2 value='<c:out value="${msg2}"/>'> --%>

<script type="text/javascript">

const jPwd = /^(?=.*?[a-zA-Z])(?=.*?[#?!@$%^&*-]).{8,16}$/; // 대문자/소문자/특수문자 1개씩은 포함해서 8자리~16자리
const jEmail = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i; // 이메일
const jTelno = /^\d{3}\d{3,4}\d{4}$/; //전화번호 정규식 '-'빼고 숫자만 01063517402
const blank = /\s/g;

let email = $("#email");
let msg = $(".alertMsg");
let authNum = null;
let showAuthBtnChecked = false;
let showModifyBtnChecked = false;

$(document).ready(function(){
	
	let formObj = $("form");
	
	$("#sendEmailbtn").on("click", sendEmailHandler);
	
	$("button").on("click", function(e){
		
		e.preventDefault();
		let operation = $(this).data("oper");
		
		if(operation === 'remove'){
			formObj.empty();
			formObj.attr("action", "/dealight/mypage/remove");
			let userId =  "<c:out value='${user.userId}'/>";
			let str = "<input type='hidden' name='userId' value='"+userId+"'>";
			
			console.log(userId);
			formObj.append(str);
			formObj.submit();
			/* return; */
		}else if(operation === 'get'){
			self.location = "/dealight/mypage/get";
			return;
		}else if(operation === 'modify'){
			
			console.log("click");
			let valid = validate();
	  		
	  		if(valid && authChecked){
	  			formObj.submit();
	  			return;
	  		}
	  		
	  		if(valid){
	  			alert('이메일 인증 및 회원정보를 확인해 주세요');
	  			
	  		}
	  		
		}
		
		//formObj.submit();
		
	});
	
	
	//회원가입 수정 버튼 클릭 시 유효성 검사 및 인증번호 체크
  	/*  $("#reg").on("click", function(e){
  		 e.preventDefault();
  		
  		let valid = validate();
  		
  		if(valid && authChecked){
  			formObj.submit();
  			return;
  		}
  		
  		
  		if(valid){
  			alert('이메일 인증 및 회원정보를 확인해 주세요');
  			
  		}
  		
  	 });
	 */
	
	
})

//이메일 발송 핸들러
   	function sendEmailHandler(e){
   		e.preventDefault();
   		
   		//유효성 검사
   		let emailValue = $("#email").val();
   		let checked = validEmail();
   		console.log("===================");
   		//이메일 인증번호 발송
   		if(checked){
   			
   			let data = {email : emailValue};
   			
   			//인증번호 발송하기
   			sendMail(data, function(result){
   				console.log("========" + result);
   				authNum = result;
   			});
   			
   			if(!showAuthBtnChecked){
   				
	   			let str = "<p>인증번호</p><input type='text' placeholder='인증번호를 입력해 주세요' name='authInput'>";
	   			str +=" <button class='btn' id='authEmail'>인증</button>";
	   			$(".authEmail").append(str);
	   			authEmailListner();
	   			showAuthBtnChecked = true;
   			}
   			
   			
   		}
   	}
   	
function authEmailListner(){
		 
   	$("#authEmail").on("click", function(e){
			
   		e.preventDefault();
			
		/* console.log("authNum : " + authNum);
		console.log("input value : " + $("input[name=authNum]").val());
		console.log(authNum == $("input[name=authNum]").val());
		console.log(typeof(authNum)+", " + typeof($("input[name=authNum]").val())); */
		
		
		let inputAuthValue = Number($("input[name='authInput']").val());
		console.log(inputAuthValue);
		
		
		
		//이메일 번호와 입력번호가 일치할 때
		if(authNum === inputAuthValue){
			
			
			console.log("authNum : " + authNum);
			console.log("input value : " + $("input[name=authInput]").val());
			
			
			msg.css("color", "green");
			msg.text("인증되었습니다.");
			
			//인증된 이메일 수정 불가
			email.attr("readonly", "readonly");
			$("input[name='authInput']").attr("readonly","readonly");
			authChecked = true;
			
   			$("#sendEmailbtn").off();
   			$("#sendEmailbtn").attr("id", "modifyEmailbtn");
   			$("#modifyEmailbtn").html("변경");
   			$("#modifyEmailbtn").css("color", "#F29F05");
				$("#modifyEmailbtn").css("border-color", "#F29F05");
   			modifyEmailListener();
   			
/* 				if(!showModifyBtnChecked){	
				let btnStr ="<button id='modifyEmail'>"+"이메일 변경"+"</button>";
	   			$(".sendEmail").append(btnStr);
	   			
	   			

	   			$("button[name='sendBtn']").attr("name","modifyBtn");
	   			$("button[name='modifyBtn']").html("변경");
	   			$("button[name='modifyBtn']").css("color", "#F29F05");
	   			$("button[name='modifyBtn']").css("border-color", "#F29F05");
	   			
	   			modifyEmailListener();
	   			showModifyBtnChecked = true;
			} */
			
		}else{
			
			console.log("입력하신 인증번호가 틀렸습니다");
			msg.css("color", "red");
			msg.text("인증번호가 일치하지 않습니다");
		}
   			
	   		/* self.location="/prove/authemail"; */ 
   	 });
	 }
	 
function modifyEmailListener(){
   	//이메일 변경 버튼 클릭 시
 		$("#modifyEmailbtn").on("click", function(e){
 			e.preventDefault();
 			
 			email.removeAttr("readonly"); //읽기 전용 제거
 			$("input[name='authInput']").removeAttr("readonly");
 			email.val(""); //input 초기화
 			$("input[name=authInput]").val("");
 			
 			authChecked = false; 
 			msg.css("color", "orange");
 			msg.text("다시 인증해 주세요");
 			
 			$("#modifyEmailbtn").off();
 			$("#modifyEmailbtn").attr("id", "sendEmailbtn");
 			$("#sendEmailbtn").html("발송");
   			$("#sendEmailbtn").css("color", "#d32323");
				$("#sendEmailbtn").css("border-color", "#d32323");
				$("#sendEmailbtn").on("click", sendEmailHandler);
 		});
				
	 }
	 
function sendMail(data, callback, error){
	
	$.ajax({
			type: 'post',
			url : '/dealight/prove/authemail',
			dataType : 'json',
			contentType : 'application/json; charset=utf-8',
			data: JSON.stringify(data),
			success: function(result, status, xhr){
				if(callback){
					callback(result);
				}
			}
		}).done(function(){
			alert('인증번호가 발송 되었습니다.');
			
		}).fail(function(error){
			alert(JSON.stringify(error));
		});
	
}

function validEmail(){
	//이메일 유효성검사
	let jEmail = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i; // 이메일
	let msg = $(".alertMsg");
	
		if($("#email").val().length === 0){
			/* alert('이메일을 입력하여 주세요'); */    			
			msg.css("color", "red");
			msg.text("이메일을 입력해 주세요");
			$("#email").focus();
			
			return false;
		}else if(!jEmail.test($("#email").val())){
			/* alert('이메일 형식에 맞지 않습니다'); */
			msg.css("color", "red");
			msg.text("이메일 형식에 맞지 않습니다");
			$("#email").val("");
			$("#email").focus();
			return false;
		}
		
		msg.text("");
		return true;
	}
	
	
	
//비밀번호와 비밀번호 확인이 일치하는지 확인
function checkPwd(){
	if($("#repwd").val() == ""){
		 document.getElementById("repwdmsg").innerHTML = "비밀번호 확인을 입력해주세요";
	     document.getElementById("repwdmsg").style.color = 'red'; 
	}else{
		
	if($("#pwd").val() == $("#repwd").val()){
			document.getElementById("repwdmsg").innerHTML = "비밀번호가 일치합니다.";
    		document.getElementById("repwdmsg").style.color = 'green'; 
		} 
	
		if($("#pwd").val() != $("#repwd").val()){
			document.getElementById("repwdmsg").innerHTML = "비밀번호가 일치하지 않습니다 다시 입력해주세요";
    		document.getElementById("repwdmsg").style.color = 'red'; 
		}
	}//else end
}//fun end

//회원가입 버튼 클릭시 유효성 검사 한 번 더!!
function validate() {
	

	//1. pwd 유효성검사
	if($("#pwd").val() == ""){
		alert('비밀번호를 입력해 주세요');
		$("#pwd").focus();
		return false;
	}
	
	if(!jPwd.test($("#pwd").val()) || blank.test($("#pwd").val())){
		alert('비밀번호 형식에 맞지 않습니다');
		$("#pwd").val("");
		$("#pwd").focus();
		return false;
	}
	
	
	//2. 비밀번호와 비밀번호 확인이 일치하는지 확인
	if($("#repwd").val() == ""){
		alert('비밀번호 확인을 입력해주세요');
		
		return false;
	}else{
		if($("#pwd").val() != $("#repwd").val()){
			alert('비밀번호가 일치하지 않습니다 다시 입력해주세요');
			return false;
		}
	}
	
	
	//5. 전화번호 유효성검사
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
	
	//6. 이메일 유효성검사
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


    
    
	return true;
}



	 
   	


//로그인이 안된 상태면 메인페이지로 넘어가게
/* let msg = '${msg}';
	if(msg != ""){
		alert(msg);
		location.href = '/dealight/dealight';
	} */

//1. 성별 정보 불러오기, 수정 불가함
/* let sexCheck =  document.getElementsByName('sex');
let sex = '${user.sex}'; */

/* if(sex == 'W'){
	sexCheck[0].checked = true;
	$("[name=sex]:not(:checked)").attr('disabled', 'disabled');
}
else if(sex == 'M'){
	sexCheck[1].checked = true;
	$("[name=sex]:not(:checked)").attr('disabled', 'disabled');
} */

//2. sns 연동 정보 불러오기, 수정 가능
/* let snsCheck = document.getElementsByName('snsLginYn');
let sns = '${user.snsLginYn}';

if(sns == 'Y'){
	snsCheck[0].checked = true;
}
else if(sns == 'N'){
	snsCheck[1].checked = true;
} */
	//입력필드 유효성 검사
	
	//정규식
            $(".mypage_side_menu > div").on("click",(e) => {
	
				console.log(e.currentTarget);
				
				location.href = $(e.currentTarget).find("a").attr("href");
				
			});
</script>
<%@include file="../../includes/mainFooter.jsp" %>
</body>
</html>