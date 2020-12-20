<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@include file="../includes/registerHeader.jsp"%>
<%@include file="../includes/mainMenu.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<style>
    * { /* CSS초기화. 이거 없으면 div태그 사이에 공백 생김*/

        margin  : 0;   /* 값이 0일 때는 단위 안씀. */
        border  : 0;
        padding : 0;
        /* font-family: 'Nanum Gothic', sans-serif; */
    }

	/* div{
            border: 2px solid red;
    } */

/*     .nav-bar{
        display: flex;
        height: 60px;
        justify-content: center;
        border: 2px solid red;
        align-items: center;
        background-color: #d32323;
    }
 */
 	.main_nav{
    	background-color: #d32323;
    }
    
    .main-container-wrap{
        min-width: 1050px;
    }
    .main-container{
        display: flex;
        min-height: 720px;
        width: 1050px;
        margin: 0 auto;
        /* padding: 0 15px; */
        /* padding-top: 0px; */
        padding-bottom: 36px;
    }

    .signup-container{
        display: inline-flex;
        flex-direction: column;
        margin: 30px;
        margin-right: 15px;
        width: 500px;
        height: 720px;
        padding: 0px 15px;
    }

    .signup-form{
        display: flex;
        width: 100%;
        margin-top: 40px;
        flex-direction: column;
        justify-content: center;
    }

    .header>h1{
        display: flex;
        justify-content: center;
    }

    .css-input{
        display: flex;
        flex-direction: row;
        /* flex-wrap: wrap; */
        position: relative;
        /* padding: 3px; */
        margin-bottom: 8px;
        align-items: center;
    }

    .birthday{
		display: flex;
        flex-direction: row;
        /* padding: 3px; */
        align-items: center; 
        margin-left: 10px;
        /* margin-top: 20px; */
        border: 1px solid rgb(139, 139, 139);
        border-radius: 3px;
        /* box-sizing: border-box; */
    }

    .birthday>input{
        width: 83px;
        height: 40px;
        text-align: center;
        outline: none;
    }

    .css-input>input{
        padding: 12px 20px;
        width: 60%;
        height: 40px;
        margin: 6px 0;
        margin-left: 20px;
        border: 1px solid rgb(139, 139, 139);
        border-radius: 3px;
        box-sizing: border-box;
    }

    .label{
        display: inline-block;
        width: 40%;
        font-weight: 500;
    }


    .css-input>p{
        width: 20%;
        font-weight: 500;
        margin-left: 8px;
    }

    .woman{
        margin-left: 16px;
    }

    .gender-man{
        position: absolute;
        margin-left: 120px;
    }

    .gender-woman{
        position: absolute;
        margin-left: 200px;
    }

    .gender-normal{
        position: absolute;    
        margin-left: 300px;
    }


    #pwd{
        margin-left: 10px;
        width: 275px;
    }

    #repwd{
        margin-left: 10px;
        width: 275px;
    }
    #name{
        margin-left: 10px;
        width: 275px;
    }
    #email{
        margin-left: 20px;
        width: 300px;
    }
    .css-man{
        width: 10%;
    }

    #telno{
        margin-left: 10px;
        width: 277px;
    }
    
    input[type='radio']{
        width: 18px
    }

    .regbtn{
        width: 220px;
        height: 80%;
        font-size: 16px;
        border: 1px solid #d32323;
        background-color:  #d32323;
        border-radius: 3px;
        color: #fff;
    }

    .form-footer{
        display: flex;
        height: 60px;
        justify-content: center;
        align-items: center;
    }
    .btn{
        width: 20%;
        height: 40px;
        margin-left: 16px;
        font-weight: bold;
        border: 1px solid #d32323;
        color: #d32323;
        outline: 0;
        background-color: white;
        border-radius: 4px;
    }


    .login-separator{
        display: flex;
        justify-content: center;
        margin: 8px 0px 0px;
        padding: 8px 0px;
    }
    .line{
        margin-top: 8px;
        width: 100%;
        height: 0px;
        border: 1px solid black;

    }
    .hr-line1{
        width: 100%;
        /* border: 1px solid gray; */
        display: flex;
        justify-content: flex-start;
    }

    .check-container{
        display: inline-flex;
        margin-left: 8px;
        margin-top: 30px;
        width: 420px;
        height: 720px;
        padding: 0px 6px;
    }

    .check{
        display: flex;
        flex-direction: column;
        margin: 40px 0px 0px 20px;
        width: 400px;
        height: auto;
    }

    .check-header>h1{
        display: flex;
        width: 100%;
        height: 40px;
        justify-content: center;
    }

    .css-agree{
        display: flex;
        flex-direction: row;
        align-items: center;
        margin: 8px;
        height: 40px;

    }

    input[type=checkbox]+.ico{
        display: inline-block;
        position: relative;
        width: 24px;
        height: 24px;
        margin-right: 12px;
        border: 0;
        background: url(https://res.kurly.com/pc/service/common/2006/ico_checkbox.svg) no-repeat 50% 50%;
        background-size: 24px 24px;
        vertical-align: -7px;
    }

    input[type=checkbox]:checked+.ico{
        /* background: url(https://res.kurly.com/pc/service/common/2006/ico_checkbox_checked.svg) no-repeat 50% 50%;
         */
        background: url(/resources/img/checkbox-icon.jpg) no-repeat 50% 50%;
        background-size: 24px 24px;
    }

    input[type=radio]+.ico{
        display: inline-block;
        position: relative;
        width: 24px;
        height: 24px;
        margin-right: 6px;
        border: 0;
        background: url(https://res.kurly.com/pc/service/common/2006/ico_checkbox.svg) no-repeat 50% 50%;
        background-size: 24px 24px;
        vertical-align: -7px;
    }

    input[type=radio]:checked+.ico{
        /* background: url(https://res.kurly.com/pc/service/common/2006/ico_checkbox_checked.svg) no-repeat 50% 50%;
         */
        background: url(/resources/img/checkbox-icon.jpg) no-repeat 50% 50%;
        background-size: 30px 30px;
    }


    .sub{
        color: #999;
    }

    label>input[type="checkbox"]{
        display: none;
    }

    label>input[type="radio"]{
        display: none;
    }

    .agree-content{
        display: flex;
        flex-direction: column;
        margin: 20px 0px 0px 40px;
    }

    .ico{
        color: #ee6a7b;

    }
    .sub-check{
        margin: 6px 0px 0px 40px;
        padding-right: 6px;
        font-size: 12px;
        color: #666;
    }

    .check-view{
    	position: relative;
        margin: 16px 0px;
    }

    .btn-link{
        position: absolute;
        right: 22px;
        top: 0;
        font-size: 14px;
        color: #d32323;
        text-decoration: none;
    }
    .check-title{
        display: flex;
        flex-direction: row;
    }

    .label-all-check{
        font-weight: 650;
        font-size: 18px;
    }
    
    .msg{
    	margin-left: 120px;
    }
    
    .alertMsg{
    	margin-left: 120px;
    	margin-bottom: 8px;
    }
    
	.btn-agreement::after{
        content: '>';
        display: inline-block;
        color: ee6a7b;
        width: 2px;
        /* margin-top: 1px; */
        /* height: 12px; */
        /* background: url(right-arrow2.png) no-repeat 50% 0; */
        /* background-size: 6px 9px; */
        /* vertical-align: top; */
    }
</style>
 
</head>   
<body>

	<c:if test="${result ne null}">

	</c:if>

    <div class="main-container-wrap">
        <div class="main-container">
            <div class="signup-container">
                <div class="signup-form">

                    <div class="header">
                            <h1>회원가입</h1>
                    </div>


                    <div class="login-separator">
                        <div class="hr-line1"><div class="line"></div></div>
                    </div>


                    <form role="form" action="/dealight/register" method="post"
                    onsubmit="return validate()">
                        <div class="css-id css-input"> 

                            <p>아이디</p>

                            <input type="text" name="userId" id="userId" placeholder="6자 이상의 영문 혹은 영문과 숫자 조합">
                            <button type="button" class="btn overlapCheck">중복확인</button>
                            
                            <!-- <span class="txt_case1">

                                "6자 이상의 영문 혹은 영문과 숫자를 조합"
                            </span>

                            <span class="txt_case2">

                                "아이디 중복확인"
                            </span> -->
                            
                        </div>
                        
                        <p class='msg' id="idmsg"></p> 

                        <p class='msg' id="idmsg"></p>

                        <div class="css-input">
                            <p>비밀번호</p>
                            <input type="password" name="pwd" id="pwd" placeholder="비밀번호를 입력해주세요">
                        </div>

                        <p class='msg' id="pwdmsg"></p>
                        <div class="css-input">
                            <p>비밀번호 확인</p>
                            <input type="password" name="repwd" id="repwd" placeholder="비밀번호룰 헌번 더 입력해주세요"
                                onblur="checkPwd()">
                        </div>

                        <p class='msg' id="repwdmsg"></p>
                         
                        <div class="css-input">
                            <p>이름</p>
                            <input type="text" name="name" id="name" placeholder="이름을 입력해 주세요">
                        </div>
                
                        <div class="css-input sendEmail">
                            <p>이메일</p><input type="email" name="email" id="email"
                                placeholder="이메일을 입력하여 주세요">
                            <button type="button" class="btn" name="sendBtn" id="sendEmailbtn">발송</button>
                        </div>
						
						<div class="css-input authEmail">
						</div>
						
						
						<div class="css-input">
							<div class="alertMsg">
							<p class="msg"></p>
							</div>
						</div>
						
                        <div class="css-input">         
                        
	                            <p>성별<p>
	                            <div class="gender-man">
	                                <label class="gender" for="man">
	                                    <input type="radio" class="sex" name="sex" value="M" id="man">
	                                    <span class="ico"></span>
	                                    남자
	                                </label>
	                            </div>
	
	                            <div class="gender-woman">
	                                <label class="gender woman" for="woman">
	                                    <input type="radio" class="sex" name="sex" value="W" id="woman">
	                                    <span class="ico"></span>
	                                    여자
	                                </label>
	                            </div>
	
	                            <div class="gender-normal">
	                                <label id="woman" class="gender" for="normal">
	                                    <input type="radio" class="sex" name="sex" value="n" id="normal">
	                                    <span class="ico"></span>
	                                    선택안함
	                                </label>
	                            </div>
                        </div>
                        
		                 <div class="css-input">
                            <p>생년월일</p>
                            
                            <div class="birthday"> 
                                <input type="text" name="brdt" id="brdt1"
                                placeholder="YYYY" size="4" maxlength="4">
                                <span class="bar">/</span>
                                
                                <input type="text" name="brdt" id="brdt2"
                                    placeholder="MM" size="2" maxlength="2">

                                <span class="bar">/</span>    
                                
                                <input type="text" name="brdt" id="brdt3"
                                    placeholder="DD" size="2" maxlength="2">
                            </div>
		                 </div>
		                 
                        <div class="css-input">
                            <p>휴대폰</p>
                            <input type="text" name="telno" id="telno"
                            placeholder="숫자만 입력해주세요">
                        </div>

                        <!-- <p class='msg' id="telnomsg">-빼고 숫자만 입력해주세요</p> -->

                        <div class="form-footer">
                            <button class="regbtn" type="submit" id="reg">회원가입</button>    
                        </div>
                                        
                		</form>
                	</div>
                    <!-- signup-form end-->
                </div>
                    <!-- signup-container end-->
                <!-- signup-form end-->

                <div class="check-container">
                    <div class="check">
                        <div class="check-header">
                            <h1>이용약관</h1>
                        </div>

                        <div class="login-separator">
                            <div class="hr-line1"><div class="line"></div></div>
                        </div>

                        
                        <div class="css-agree">
                                <h4>이용약관동의</h4>
                                <span class="ico">*</span>
                        </div>

                        <div class="agree-content">
                            <div class="check-all">
                            <label class="label-all-check" for="">
                                <input type="checkbox" value="n" id="allcheck" name="agree_allcheck" required>
                                <span class="ico"></span>
                                전체 동의합니다.
                            </label>
                                <p class="sub-check">선택항목에 동의하지 않은 경우도 회원가입 및 일반적인 서비스를 이용할 수 있습니다.</p>
                            </div>

                            <div class="check-view">
                            <label>
                                <input type="checkbox" id="agree" name="agree_box" required>
                                <span class="ico"></span>
                                이용약관 동의
                                <span class="sub">(필수)</span>
                            </label>

                            	<a href="#" class="link btn-link btn-agreement">약관보기</a>
                            </div>
                            
                            <div class="check-view">
                                <label>
                                    <input type="checkbox"  name="agree_box" id="private1" required>
                                    <span class="ico"></span>
                                    개인정보처리방침 동의
                                    <span class="sub">(필수)</span>
                                </label>
                                
                                <a href="#" class="link btn-link btn-agreement">약관보기</a>
                            </div>

                            <div class="check-view">
                                <label>
                                    <input type="checkbox"  name="agree_box" id="hiddenCheck">
                                     <span class="ico"></span>
                                    개인정보처리방침 동의
                                    <span class="sub">(선택)</span>
                                </label>
                                
                                <a href="#" class="link btn-link btn-agreement">약관보기</a>
                                
                            </div>

                            <div class="check-view">
                                <label>
                                    <input type="checkbox"  name="agree_box" id="marketing">
                                    <span class="ico"></span>
                                    이벤트, 할인쿠폰 등 혜택/정보 수신 동의
                                    <span class="sub">(선택)</span>
                                </label>
                            </div>

                            <div class="check-view">
                                <label>
                                    <input type="checkbox"  name="agree_box" id="fourteen_check" required>
                                    <span class="ico"></span>
                                    본인은 만 14세 이상입니다.
                                    <span class="sub">(필수)</span>
                                </label>
                                
                                <a href="#" class="link btn-link btn-agreement">약관보기</a>
                            </div>

                        </div>
                    </div>
                </div>                
            </div>
	        <!--main-container-->
        </div>    
    <!--main-container-wrap-->
    


	<script type="text/javascript">
  //인증번호가 일치하지 않는다면 접근불가
  
    /* let num = document.getElementById("num");
    let authNum = document.getElementById("authNum");

    if(num.value == "" || authNum.value == ""){
    	alert("잘 못 된 접근입니다.");
    	location.href = '/dealight/policies';
    }

    if(num.value != authNum.value){
    	alert("인증번호가 일치하지 않습니다.");
    	location.href = '/dealight/prove/authemail';
    }
    
     */
  //정규식
	const jId = /^[A-za-z0-9]{5,15}$/; //영문 대문자 또는 소문자 또는 숫자로 시작하는 아이디, 길이는 5~15자, 끝날때 제한 없음
	const jPwd = /^(?=.*?[a-zA-Z])(?=.*?[#?!@$%^&*-]).{8,16}$/; // 대문자/소문자/특수문자 1개씩은 포함해서 8자리~16자리
	const jName = /^[\w\Wㄱ-ㅎㅏ-ㅣ가-힣]{2,8}$/; // 닉네임은 문자 제한없이 2~8자리
	const jEmail = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i; // 이메일
	const jBirth = /^(19[0-9][0-9]|20\d{2})(0[0-9]|1[0-2])(0[1-9]|[1-2][0-9]|3[0-1])$/; // 19901010 
	const jTelno = /^\d{3}\d{3,4}\d{4}$/; //전화번호 정규식 '-'빼고 숫자만 01063517402
	const blank = /\s/g;
	
    $(document).ready(function(){
    	
	    let formObj = $("form");
	    let authChecked = false;
		let email = $("#email");
		let msg = $(".alertMsg");
		let authNum = null;
		let showAuthBtnChecked = false;
		let showModifyBtnChecked = false;
		
	    //아이디 중복체크 확인		
		$(".overlapCheck").click(function(){
				
				let btn = document.getElementById("reg");
				let userId = $("#userId").val();
				//정규식으로 형식검사 +공백체크
				if(!jId.test(userId) || blank.test(userId)){
					document.getElementById("idmsg").innerHTML = "아이디 형식에 맞지 않습니다";
					document.getElementById("idmsg").style.color = 'red'; 
					/* btn.disabled = "disabled"; */
				}
				//입력했는지 검사
				if(userId == ""){
					document.getElementById("idmsg").innerHTML = "아이디를 입력하여 주세요";
		    		document.getElementById("idmsg").style.color = 'red';
		    		/* btn.disabled = "disabled"; */
				}
				//객제에 담아서
				let send = {'userId' : userId}
				
				$.ajax({
					async : true,
					type : 'post',
					data : send,
					url : "/dealight/overlapCheck",
					success : function(data){
						console.log("=========data 1 : " + data);
						if(userId != ""){
							if(data > 0){
								   document.getElementById("idmsg").innerHTML = "중복된 아이디가 존재합니다.";
						    	   document.getElementById("idmsg").style.color = 'red';
						    	   /* btn.disabled = "disabled"; */
							}else{
								if(jId.test(userId)){
								 		document.getElementById("idmsg").innerHTML = "사용 가능한 아이디입니다.";
								    	   document.getElementById("idmsg").style.color = 'green';
								    	   btn.disabled = false;
								 	 }
							}
							
						}
						
				}});
				
				
				
		})
		
	  //이용약관 전체 동의		
	  $(".label-all-check").on("click", function(){
        
        console.log("click");

        if($(this).hasClass("checked") === true) {

            $(this).removeClass("checked");
            $("#allcheck").removeAttr("checked");
            allBoxCheck();
            return;
        }

        $(this).addClass("checked");
        $("#allcheck").attr("checked","checked");
        allBoxCheck("checked");
        
	 });
	
   	 $("#sendEmailbtn").on("click", sendEmailHandler);
   	 
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
   	 
   	//모든 박스 체크
     function allBoxCheck(){
         const isallBox = document.getElementById("allcheck").checked;
             
             //sports 체크박스 요소들 가져오기
             const agreeBox = document.getElementsByName("agree_box");
             
             if(isallBox){
                 for(let i=0; i< agreeBox.length; i++){
                     if(!agreeBox[i].checked){
                         agreeBox[i].checked = true; 
                     } 
                 }
             }else{
                 for(let i=0; i< agreeBox.length; i++){
                     if(agreeBox[i].checked)
                         agreeBox[i].checked = false;
                 }   
             }

         // for(let i=0; i<5; i++){
         //     if($("input[name='agree_box']").eq(i).is(":checked") === true){
         //         $("input[name='agree_box']").eq(i).removeAttr("checked");
         //     }else{
         //         $("input[name='agree_box']").eq(i).attr("checked", "checked");
         //     }
             
         // }
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
   	 
   	 //회원가입 버튼 클릭 시 유효성 검사 및 인증번호 체크
   	 $("#reg").on("click", function(e){
   		 e.preventDefault();
   		
   		let valid = validate();
   		
   		if(valid && authChecked){
   			formObj.submit();
   			return;
   		}
   		
   		
   		if(valid){
   			alert('이메일 인증 및 회원정보를 확인해 주세요');
   			
   		}
   		
   		 
   	 })
    });
    
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
    	
    	let brdt1 = $("#brdt1").val();
    	let brdt2 = $("#brdt2").val();
    	let brdt3 = $("#brdt3").val();
    	
    	let birthday = brdt1 + brdt2 + brdt3;
    	console.log(birthday);
    	
        let agreeChecked = $("#agree").is(":checked");
        let privateChecked = $("#private1").is(":checked");
        let fourteenChecked = $("#fourteen_check").is(":checked");

		
        //아이디 유효성
       if($("#userId").val() === ""){
    	    alert('아이디를 입력해 주세요');
	   		$("#pwd").focus();
	   		return false;
       }
    	
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
    	
    	
    	//3. 이름 유효성 검사
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
    	
    	//4.생년월일 유효성검사
    	if(birthday == ""){
    		alert('생년월일를 입력하여 주세요');
    		$("#brdt").focus();
    		return false;
    	}
    	
    	if(!jBirth.test(birthday)){
    		alert('생년월일 형식에 맞지 않습니다');
    		$("#brdt").val("");
    		$("#brdt").focus();
    		return false;
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

    	
    	
    	//7.성별 체크 여부 검사
        let sexCheck =  document.getElementsByName('sex');
        let sexType = null;
        
        for(let i =0; i<sexCheck.length; i++){
        	if(sexCheck[i].checked == true){
        		sexType = sexCheck[i].value;
        	}
        }
        
        if(sexType == null){
        	alert('성별을 선택하세요');
        	return false;
        }
        
        /* //8.sns연동 체크 여부 검사
        let snsCheck = document.getElementsByName('snsLginYn');
        let snsType = null;
        
        for(let i =0; i<snsCheck.length; i++){
        	if(snsCheck[i].checked == true){
        		snsType = snsCheck[i].value;
        	}
        }
        
        if(snsType == null){
        	alert('sns연동 여부를 선택하세요');
        	return false;
        } */
        
        //이용약관
        if(!agreeChecked){

            alert('이용약관에 동의해주세요');
            return false;
        }
        
        //개인정보처리방침
        if(!privateChecked){

            alert('개인정보처리방침에 동의해주세요');
            return false;
        }

        if(!fourteenChecked){
            alert('만 14세 이상에 동의해주세요');
            return false;
        }
        
        
    	return true;
    }
    
  
    
    </script>
</body>
</html>