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
    
    .gender-input{
    	margin-bottom: 14px;
    }

/* 보류*/
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
        /* background-color:  red; */
        border-radius: 3px;
        color: #fff;
        outline: none;
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
        
        background: url(/resources/img/check_circle_small.png) no-repeat 50% 50%;
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
        background: url(/resources/img/check_circle_small.png) no-repeat 50% 50%;
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

    /* modal css */
    /*  The Modal (background) */
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
	        background-color: rgba(0, 0, 0, 0.219); /* Black w/ opacity */
	        animation: fadeEffect 0.8s;

        }
        /* Modal Content/Box */
        .modal-content {
            position: relative;
	        background-color: #fefefe;
	        margin: 5% auto; /* 15% from the top and centered */
	        display: flex;
            flex-direction: column;
            justify-content: flex-start;
            align-self: start;
            border-radius: 3px;
            box-shadow: 3px 3px 7px rgba(44, 36, 36, 0.342);
	        width: 30%; /* Could be more or less, depending on screen size */
            height: 590px;
	        animation: fadeEffect 0.3s;
            overflow: hidden;
        }
        .modal_header{
            display: flex;
            /* padding: 0 0; */
            width: 100%;
            height: 70px;
            padding: 25px 0 2px 12px;
            /* padding: 20px; */
            /* padding-bottom: 25px; */
            /*border: 1px black solid;*/
            background-color: white;
            /* border: 1px solid red; */
            /* color: white; */
            justify-content: flex-start;
            align-items: center;
            /* font-size: 24px;
            font-weight: 700; */
            border-radius: 3px 3px 0 0;
        }
        .modal_wrapper_regwait{
            margin: 10px;
            padding: 0 25px 50px 25px;
            /*display: flex;*/
            flex-direction: column;
            justify-content: center;
            align-items: center;
            display:none;
        }
        .modal_tit{
            /*border: 1px black solid;*/
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            font-size: 24px;
            font-weight: bold;
            width: 100%;
            height: 50px;
            color: #d32323;
            text-shadow: 1px 1px 6px rgba(44, 36, 36, 0.171);
        }
        .modal_top{
            width: 100%;
            height: 250px;
            /*border: 1px black solid;*/
            display: flex;
            flex-direction: row;
            justify-content: center;
            align-items: center;
        }
        .modal_bot{
            width: 100%;
            height: 100px;
            /*border: 1px black solid;*/
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
        }
        .modal_bot > div{
            font-weight: bold;
            font-size: 18px;
            margin: 5px 0;
        }
         .modal-content ul{
         	margin : 0 0;
         	display : inline-block;
        }
        /* The Close Button */
        .close_modal {
            position : absolute;
            right : 40px;
            top : 35px;
            display : inline-block;
            margin : 0 0;
            color: #999;
            font-size: 24px;
            font-weight: 300;
        }
        .close_modal:hover,
        .close_modal:focus {
            /* color: black; */
            text-decoration: none;
            cursor: pointer;
        }

        .css-agreeTitle{
            color: black;
            font-weight: 700;
            font-size: 24px;
            margin-left: 24px;
        }

        .css-agreecontent{
            width: 100%;
            height: 720px;
            overflow: scroll;
            font-size: 14px;
            resize: none;
        }

        .txt_view{
            /* border: 1px solid red; */
            margin: 20px 35px 6px;
            /* margin-bottom: 6px; */
            padding: 0 0 10px;
            color: #666;

        }

        .agree_view{
            /* border: 1px solid red; */
            margin: 20px 35px 6px;
            margin-top: 0;
            padding: 0 0 20px;
            color: #666;
        }

        .btn_ok{
            display: block;
            width: 100%;
            height: 80px;
            border: 0;
            border-top: 1px solid #f7f7f7;
            border-radius: 6px;
            background-color: #fff;
            font-weight: 700;
            font-size: 16px;
            color: #d32323;
            outline: none;
            cursor: pointer;
        }
        
    .nav_reg_brno>a{
    	color:white;
    }
    #nav_user_id{
    color:white;
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

                            <p>아이디
                            <span class="ico">*</span>
                            </p>

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
                            <p>비밀번호
                            <span class="ico">*</span>
                            </p>
                            <input type="password" name="pwd" id="pwd" placeholder="비밀번호를 입력해주세요">
                        </div>

                        <p class='msg' id="pwdmsg"></p>
                        <div class="css-input">
                            <p>비밀번호 확인
                            <span class="ico">*</span>
                            </p>
                            <input type="password" name="repwd" id="repwd" placeholder="비밀번호룰 한번 더 입력해주세요"
                                onblur="checkPwd()">
                        </div>

                        <p class='msg' id="repwdmsg"></p>
                         
                        <div class="css-input">
                            <p>이름
                            <span class="ico">*</span>
                            </p>
                            <input type="text" name="name" id="name" placeholder="이름을 입력해 주세요">
                        </div>
                
                        <div class="css-input sendEmail">
                            <p>이메일
                            <span class="ico">*</span>
                            </p><input type="email" name="email" id="email"
                                placeholder="이메일을 입력하여 주세요">
                            <button type="button" class="btn" name="sendBtn" id="sendEmailbtn">발송</button>
                        </div>
						
						<div class="css-input authEmail">
						</div>
						
						
						<div class="css-input">
							<div class="alertMsg" style="margin-left: 120px;">
							<p class="msg"></p>
							</div>
						</div>
						
                        <div class="css-input gender-input">
                        
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
                            <p>생년월일
                            <span class="ico">*</span>
                            </p>
                            
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
                            <p>휴대폰
                            <span class="ico">*</span>
                            </p>
                            <input type="text" name="telno" id="telno"
                            placeholder="숫자만 입력해주세요">
                        </div>

                        <!-- <p class='msg' id="telnomsg">-빼고 숫자만 입력해주세요</p> -->

                        <div class="form-footer">
                            <button class="regbtn" type="submit" id="reg">가입하기</button>    
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
                                <input type="checkbox" value="n" id="allcheck" name="agree_allcheck">
                                <span class="ico"></span>
                                전체 동의합니다.
                            </label>
                                <p class="sub-check">선택항목에 동의하지 않은 경우도 회원가입 및 일반적인 서비스를 이용할 수 있습니다.</p>
                            </div>

                            <div class="check-view">
                            <label>
                                <input type="checkbox" id="agree" name="agree_box" required label="이용약관 동의" >
                                <span class="ico"></span>
                                이용약관 동의
                                <span class="sub">(필수)</span>
                            </label>
                                <a href="#none" class="link btn-link btn-agreement js-agree">약관보기</a>
                            </div>
                            
                            <div class="check-view">
                                <label>
                                    <input type="checkbox" name="agree_box" id="private1" required label="개인정보처리방침 동의">
                                    <span class="ico"></span>
                                    개인정보처리방침 동의
                                    <span class="sub">(필수)</span>
                                </label>
                                    <a href="#none" class="link btn-link btn-agreement js-agree">약관보기</a>
                            </div>

                            <div class="check-view">
                                <label>
                                    <input type="checkbox" name="agree_box" id="hiddenCheck">
                                     <span class="ico"></span>
                                    개인정보처리방침 동의
                                    <span class="sub">(선택)</span>
                                </label>
                                    <a href="#none" class="link btn-link btn-agreement js-agree">약관보기</a>
                            </div>

                            <div class="check-view">
                                <label>
                                    <input type="checkbox"  name="agree_box" id="marketing" required>
                                    <span class="ico"></span>
                                    이벤트, 할인쿠폰 등 혜택/정보 수신 동의
                                    <span class="sub">(선택)</span>
                                </label>
                                
                            </div>

                            <div class="check-view">
                                <label>
                                    <input type="checkbox" name="agree_box" id="fourteen_check" required>
                                    <span class="ico"></span>
                                    본인은 만 14세 이상입니다.
                                    <span class="sub">(필수)</span>
                                </label>
                                    <!-- <a href="#" class="link btn-link btn-agreement js-agree">약관보기</a> -->
                            </div>

                        </div>
                        
                        
                    </div>
                </div>                
            </div>
	        <!--main-container-->
        </div>    
    <!--main-container-wrap-->
    
     <div id="myModal" class="modal">
		<!-- Modal content -->
		<div class="modal-content">
			<span class="close_modal"><i class="fas fa-times"></i></span>
	        <div class="modal_header">
                <h4 class="css-agreeTitle" id="js-agreeTitle"></h4>

                <!-- <div class="close_modal">x</div> -->
            </div>
		
            <div class="css-agreecontent">
                <div class="txt_view">
                    <h3 style="font-weight: 400;">총칙</h3>
                </div>
                
                <div class="agree_view" id="js-agreeContent">
                    
                </div>

            </div>
            
            <button type="button" class="btn_ok">확인</button>
            

		</div>
    </div>
    
    <!-- modal end-->
    


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
	
	let formObj = $("form");
    let authChecked = false;
	let email = $("#email");
	let msg = $(".alertMsg");
	let authNum = null;
	let showAuthBtnChecked = false;
	let showModifyBtnChecked = false;
	
    $(document).ready(function(){
    	
	    	
		
		let len = $(".js-agree").length;
        closeModalListener();
		
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
				
		});
		
	  //이용약관 모두 동의 체크박스
        $(".label-all-check").on("click", function(){
        
        console.log("click");
        
        //체크 되어있을 시 전체 해제
        if($(this).hasClass("checked")) {
			
            $(this).removeClass("checked");
            $("#allcheck").removeAttr("checked");

            //모든 체크박스 체크
            allBoxCheck();
            return;
        }

        $(this).addClass("checked");
        $("#allcheck").attr("checked","checked");
        allBoxCheck("checked");
        
    });
	    
		 

      //이용약관 이벤트 등록
      for(let i=0; i<len; i++){
          $(".js-agree").eq(i).on("click", function(){
              let closetDiv = $(this).closest("div");
              let title = closetDiv.find("label").text();
              let content = chooseContent(i);
              console.log(content);
              // console.log($(this).closest("div").find("label").text());
              
              writeModal(title, content);
              $(".modal").show();

          });
      }


      //모달 x버튼 클릭시 닫기
      
      
	        
   	 $("#sendEmailbtn").on("click", sendEmailHandler);
   	 
   	 
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
   		
   	 });
   	 
    });
    
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
   	 
  	//x || 확인 클릭시 모달 닫기
   	function closeModalListener(){
   	    //확인 버튼
   	    $(".btn_ok").on("click", function(){
   	        $(".modal").hide();
   	    })

   	    //x버튼
   	    $(".close_modal").on("click", function(){
   	        $(".modal").hide();
   	    });

   	}
  	
  	//이용약관 모달 content
   	function writeModal(title, content){
   	    $("#js-agreeTitle").text(title);
   	    $("#js-agreeContent").html(content);
   	}

  
  //모든 박스 체크
   	function allBoxCheck(){
   	    const isallBox = document.getElementById("allcheck").checked;
   	        
   	        //agree 체크박스 요소들 가져오기
   	        const agreeBox = document.getElementsByName("agree_box");
   	        console.log(agreeBox);
   	        console.log("isallBox : "+isallBox);
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
    
    
  //해당 이용약관 내용
    function chooseContent(idx){

        let str = '';
        if(idx === 0){

        str += `
        제 1 조 (목적)</br>
            본 약관은 딜라이트(이하 "회사")가 제공하는 위치기반서비스에 대해 회사와 위치기반서비스를 이용하는 개인위치정보주체(이하 "이용자")간의 권리·의무 및 책임사항,
            기타 필요한 사항 규정을 목적으로 합니다.</br></br>
            
        제 2 조 (이용약관의 효력 및 변경)</br>
            ① 본 약관은 이용자가 본 약관에 동의하고 회사가 정한 절차에 따라 위치기반서비스의 이용자로 등록됨으로써 효력이 발생합니다.</br>
            ② 회사는 법률이나 위치기반서비스의 변경사항을 반영하기 위한 목적 등으로 약관을 수정할 수 있습니다.</br>
            ③ 약관이 변경되는 경우 회사는 변경사항을 최소 7일 전에 회사의 홈페이지 등 기타 공지사항 페이지를 통해 게시합니다.</br>
            ④ 단, 개정되는 내용이 이용자 권리의 중대한 변경이 발생하는 경우에는 30일 전에 게시하도록 하겠습니다.</br></br>

        제 3 조 (약관 외 준칙)</br>
            이 약관에 명시되지 않은 사항에 대해서는 위치 정보의 보호 및 이용 등에 관한 법률, 전기통신사업법, 정보통신망 이용 촉진및 보호 등에 관한 법률 등 관계법령 및 회사가
            정한 지침 등의 규정에 따릅니다.</br></br>
            
        제 4 조 (서비스의 내용)</br>
            회사는 직접 수집하거나 위치정보사업자로부터 수집한 이용자의 현재 위치 또는 현재 위치가 포함된 지역을 이용하여 아래와 같은 위치기반서비스를 제공합니다.</br>
            ① 위치정보를 활용한 정보 검색결과 및 콘텐츠를 제공하거나 추천</br>
            ② 생활편의를 위한 위치 공유, 위치/지역에 따른 알림, 경로 안내</br>
            ③ 위치기반의 컨텐츠 분류를 위한 콘텐츠 태깅(Geotagging)</br>
            ④ 위치기반의 맞춤형 광고</br></br>

        제 5 조 (서비스 이용요금)</br>
            회사가 제공하는 위치기반서비스는 무료입니다.
            단, 무선 서비스 이용 시 발생하는 데이터 통신료는 별도이며, 이용자가 가입한 각 이동통신사의 정책에 따릅니다.</br></br>
            
        제 6 조 (서비스 이용의 제한·중지)</br>
            ① 회사는 위치기반서비스사업자의 정책변경 등과 같이 회사의 제반사정 또는 법률상의 이유로 위치기반서비스를 유지할 수 없는 경우 위치기반서비스의 전부 또는 일부를 
              제한·변경·중지할 수 있습니다.</br>
            ② 단, 위 항에 의한 위치기반서비스 중단의 경우 회사는 사전에 회사 홈페이지 등 기타 공지사항 페이지를 통해 공지하거나 이용자에게 통지합니다.</br></br>
        
        제 7 조 (개인위치정보주체의 권리)</br>
            ① 이용자는 언제든지 개인위치정보의 수집·이용·제공에 대한 동의 전부 또는 일부를 유보할 수 있습니다.</br>
            ② 이용자는 언제든지 개인위치정보의 수집·이용·제공에 대한 동의 전부 또는 일부를 철회할 수 있습니다. 이 경우 회사는 지체 없이 철회된 범위의 개인위치정보 및
              위치정보 수집·이용·제공사실 확인자료를 파기합니다.</br>
            ③ 이용자는 개인위치정보의 수집·이용·제공의 일시적인 중지를 요구할 수 있으며, 이 경우 회사는 이를 거절할 수 없고 이를 충족하는 기술적 수단을 마련합니다.</br>
            ④ 이용자는 회사에 대하여 아래 자료에 대한 열람 또는 고지를 요구할 수 있으며, 해당 자료에 오류가 있는 경우에는 정정을 요구할 수 있습니다. 이 경우 정당한 사유 없이
              요구를 거절하지 않습니다.</br>
            1. 이용자에 대한 위치정보 수집·이용·제공사실 확인자료</br>
            2. 이용자의 개인위치정보가 위치정보의 보호 및 이용 등에 관한 법률 또는 다른 법령의 규정에 의하여 제3자에게 제공된 이유 및 내용</br>
            ⑤ 이용자는 권리행사를 위해 본 약관 제14조의 연락처를 이용하여 회사에 요청할 수 있습니다.</br></br>

        제 8 조 (개인위치정보의 이용 또는 제공)</br>
            ① 회사는 개인위치정보를 이용하여 위치기반서비스를 제공하는 경우 본 약관에 고지하고 동의를 받습니다.</br>
            ② 회사는 이용자의 동의 없이 개인위치정보를 제3자에게 제공하지 않으며, 제3자에게 제공하는 경우에는 제공받는 자 및 제공목적을 사전에 이용자에게
              고지하고 동의를 받습니다.</br>
            ③ 회사는 개인위치정보를 이용자가 지정하는 제3자에게 제공하는 경우 개인위치정보를 수집한 통신단말장치로 매회 이용자에게 제공받는 자, 제공일시 및 제공목적을 즉시
              통지합니다.</br>
            ④ 단, 아래의 경우 이용자가 미리 특정하여 지정한 통신단말장치 또는 전자우편주소, 온라인게시 등으로 통지합니다.</br>
            1. 개인위치정보를 수집한 당해 통신단말장치가 문자, 음성 또는 영상의 수신기능을 갖추지 아니한 경우</br>
            2. 이용자의 개인위치정보를 수집한 통신단말장치 외의 통신단말장치 또는 전자우편주소, 온라인게시 등으로 통보할 것을 미리 요청한 경우</br>
            ⑤ 회사는 위치정보의 보호 및 이용 등에 관한 법률 제16조 제2항에 근거하여 개인위치정보 수집·이용·제공사실 확인자료를 자동으로 기록·보존하며,
              해당 자료는 6개월간 보관합니다.</br></br>

        제 9 조 (법정대리인의 권리)</br>
            회사는 14세 미만의 이용자에 대해서는 개인위치정보를 이용한 위치기반서비스 제공 및 개인위치정보의 제3자 제공에 대한 동의를 이용자 및 이용자의 법정대리인으로부터
            동의를 받아야 합니다. 이 경우 법정대리인은 본 약관 제7조에 의한 이용자의 권리를 모두 가집니다.</br></br>
            
        제 10 조 (8세 이하의 아동 동의 보호의무자의 권리)</br>
            ① 회사는 아래의 경우에 해당하는 자(이하 “8세 이하의 아동 등”)의 위치정보의 보호 및 이용 등에 관한 법률 제26조2항에 해당하는 자(이하 “보호의무자”)가
              8세 이하의 아동 등의 생명 또는 신체보호를 위하여 개인위치정보의 이용 또는 제공에 동의하는 경우에는 본인의 동의가 있는 것으로 봅니다.</br>
            1. 8세 이하의 아동</br>
            2. 피성년후견인</br>
            3. 장애인복지법 제2조제2항제2호에 따른 정신적 장애를 가진 사람으로서 장애인고용촉진 및 직업재활법 제2조제2호에 따른 중증장애인에 해당하는 사람
              (장애인복지법 제32조에 따라 장애인 등록을 한 사람만 해당한다)</br>
            ② 8세 이하의 아동 등의 생명 또는 신체의 보호를 위하여 개인위치정보의 이용 또는 제공에 동의를 하고자 하는 보호의무자는 서면동의서에 보호의무자임을 증명하는
              서면을 첨부하여 회사에 제출하여야 합니다.</br>
            ③ 보호의무자는 8세 이하의 아동 등의 개인위치정보 이용 또는 제공에 동의하는 경우 본 약관 제7조에 의한 이용자의 권리를 모두 가집니다.</br></br>
            `;

            return str;

        }else if(idx === 1){
            str+=`
            딜라이트(이하 ‘회사’라고 합니다)는 이용자의 개인정보를 안전하게 관리하고 있으며, 이용자가 언제든지 쉽게 확인할 수 있도록 개인정보 처리방침을 공개하고 있습니다.</br></br>
            1. 개인정보의 수집 ∙ 이용</br>
            2. 개인정보 보유 ∙ 이용 기간</br>
            3. 개인정보 제3자 제공</br>
            4. 이용자 및 법정대리인의 권리 · 의무 및 행사방법</br>
            5. 아동의 개인정보보호</br>
            6. 개인정보 자동 수집 장치의 설치 · 운영 및 거부</br>
            7. 개인정보의 파기</br>
            8. 개인정보보호를 위한 기술적 ∙ 관리적 보호조치</br></br>
                
        1. 개인정보의 수집 ∙ 이용</br>
          ① 개인정보의 수집 ∙ 이용 목적 및 항목</br>
            회사가 제공하는 서비스는 별도의 회원가입 절차 없이 자유롭게 컨텐츠에 접근할 수 있습니다. 회사의 회원제 서비스 이용을 위해 수집 ∙ 이용하는 개인정보는
            다음의 목적 이외의 용도로는 이용되지 않으며, 목적 변경 시 별도의 동의를 받는 등 필요한 조치를 이행합니다.</br></br>
            가. 회원가입 및 관리</br>
                -회원 가입의사 확인, 회원제 서비스 이용을 위한 제한적 본인확인, 불만 처리 등 원활한 의사소통 경로의 확보,
                 서비스 부정이용 방지, 계약이행을 위한 각종 고지 ∙ 통지 ∙ 안내, 통계 ∙ 분석
                 [e-mail 가입](필수) 이메일 주소, 비밀번호, 휴대전화번호, 닉네임, 생일, 연령대, 성별
                 [SNS 회원가입 – 카카오톡](필수) 이메일 주소, 비밀번호, 휴대전화번호, 닉네임, 생일, 연령대, 성별</br>
            나. 비회원 서비스 제공</br>
                -주변 맛집 검색</br>
                (필수) 휴대전화번호, 주소</br>
            다. 주변 맛집 검색</br>
                -주변 맛집 검색 서비스 제공</br>
                (선택) 개인위치정보</br>
            라. 서비스 이용 시 자동생성되는 정보</br>
                -서비스 부정이용 방지, 개인정보유효기간제 적용</br>
                서비스 이용 기록, 접속 로그, 쿠키, 접속 IP 주소, 기기고유번호(디바이스 아이디 또는 IMEI)</br></br>
        
          ② 개인정보 수집 방법</br>
             a. 회원가입 및 서비스 이용 과정에서 이용자가 개인정보 수집에 대해 동의를 하고 직접 정보를 입력하는 경우, 해당 개인정보를 수집합니다.</br>
             b. 고객센터를 통한 상담 과정에서 웹 페이지, 메일, 팩스, 전화 등을 통해 이용자의 개인정보가 수집될 수 있습니다.</br>
             c. 회사와 제휴한 외부 기업이나 단체로부터 개인정보를 제공받을 수 있으며, 이러한 경우에는 제휴사에서 이용자에게 개인정보 제공 동의를 받은 후 수집합니다.</br></br>
        
        2. 개인정보 보유 ∙ 이용 기간</br>
          ① 회사는 이용자로부터 개인정보 수집 시에 동의 받은 보유 · 이용기간 내에서 개인정보를 처리·보유합니다.</br>
             a. 회원 정보: 회원탈퇴 후 90 일까지</br>
             b. 비회원 정보: 업무 목적 달성 시까지</br>
             c. 식품 이물 발견 신고: 이물 통보 완료 시까지</br>
             d. 법령 위반에 따른 수사 ∙조사 등이 진행중인 경우에는 해당 건 종료 시까지</br>
             e. 서비스 이용에 따른 채권·채무관계 정산 시까지</br>
          ② 1 년 간 회원의 서비스 이용 기록이 없는 경우, 『정보통신망 이용촉진 및 정보보호등에 관한 법률』 제 29 조에 근거하여 회원에게 사전 통지하고, 개인정보를 파기합니다.</br>
          ③ 회원 탈퇴 또는 회원 자격 정지 후 회원 재가입, 임의 해지 등을 반복적으로 행하여 회사가 제공하는 할인쿠폰, 이벤트 혜택 등으로 경제상의 이익을 취하거나 이 과정에서
            명의를 무단으로 사용하는 등 편법 행위 또는 불법행위를 하는 회원을 차단하고자 회사는 회원 탈퇴 후 90 일 간 회원의 정보를 보유합니다.</br>
          ④ 단, 전자상거래 등에서의 소비자보호에 관한 법률 등 관련 법령의 규정에 따라 거래 관계 확인을 위해 개인정보를 일정기간 보유 할 수 있습니다.</br>
            가. 전자상거래 등에서의 소비자보호에 관한 법률</br>
             -계약 또는 청약철회 등에 관한 기록(5년)</br>
             -대금결제 및 재화 등의 공급에 관한 기록(5년)</br>
             -소비자의 불만 또는 분쟁 처리에 관한 기록(3년)</br>
            나. 위치정보의 보호 및 이용등에 관한 법률</br>
             -개인위치정보에 관한 기록(6개월)</br>
            다. 전자금융거래법</br>
             -전자금융 거래에 관한 기록(5년)</br>
            라. 통신비밀보호법</br>
             -서비스 이용 관련 개인정보(로그기록)(3개월)</br></br>
        3. 개인정보 제3자 제공</br>
          ① 회사는 이용자의 개인정보를 명시한 범위 내에서만 처리하며, 정보주체의 동의, 법률의 특별한 규정에 해당하는 경우에만 개인정보를 제 3 자에게 제공합니다.</br>
          ② 회사는 다음과 같이 개인정보를 제 3 자에게 제공하고 있습니다.</br>
             -개인정보를 제공받는 자 : 제휴음식점</br>
             -개인정보를 제공받는 자의 개인정보 이용목적 : 제휴 서비스 제공</br>
             -제공하는 개인정보의 항목 : 예약 내역, 주소, 휴대전화번호(안심번호 적용 시 제외)</br>
             -개인정보보유 및 이용기간 : 서비스 제공 완료 후 6개월</br></br>
        4. 이용자 및 법정대리인의 권리 · 의무 및 행사방법</br>
          ① 이용자는 회사에 대해 언제든지 다음 각 호의 개인정보 보호 관련 권리를 행사할 수 있습니다.</br>
             a. 개인정보 열람 요구</br>
             b. 오류 등이 있을 경우 정정 요구</br>
             c. 삭제 요구</br>
             d. 처리 정지 요구</br>
          ② 위 권리 행사는 회사에 대해 서면, 전화, 전자우편, 모사전송(FAX) 등을 통하여 하실 수 있으며 회사는 내부 절차에 따라 영업일 10 일 이내 처리하도록 하겠습니다.</br>
          ③ 이용자가 개인정보의 오류 등에 대한 정정 또는 삭제를 요구한 경우에는 회사는 정정 또는 삭제를 완료할 때까지 당해 개인정보를 이용하거나 제공하지 않습니다.</br>
          ④ 위 권리 행사는 이용자의 법정대리인이나 위임을 받은 자 등 대리인을 통하여 하실 수 있습니다. 이 경우, 법정대리인은 이용자의 모든 권리를 가집니다.</br>
          ⑤ 이용자는 정보통신망법, 개인정보보호법 등 관계법령을 위반하여 회사가 처리하고 있는 이용자 본인이나 타인의 개인정보 및 사생활을 침해하여서는 안됩니다.</br>
          ⑥ 이용자의 개인정보 열람, 정정, 탈퇴는 『마이요기요』를 통해서도 언제든 가능합니다.</br>
          ⑦ 회원탈퇴는 『마이페이지』 > 『회원탈퇴』를 클릭하거나 개인정보보호책임자에게 팩스, 우편, 고객센터, 전화 등으로 연락하시면 회원탈퇴 신청 시점으로부터
            90 일 동안 재가입 방지를 위한 개인정보 보유 이후 개인정보의 삭제 등 필요한 조치를 하겠습니다.</br>
          ⑧ 이용자는 개인정보를 최신의 상태로 정확하게 입력 또는 회사에 통보하여 불의의 사고가 발행하지 않도록 예방해야 합니다.</br>
          ⑨ 이용자가 제공 또는 입력한 정보가 부정확함으로 인해 발생하는 사고의 책임은 이용자에게 있으며, 타인 정보의 도용 등 허위정보를 입력할 경우
            딜라이트 서비스 제공이 중단될 수 있습니다.</br>
          ⑩ 이용자는 개인정보를 보호받을 권리와 함께 스스로를 보호하고 타인의 정보를 침해하지 않을 의무를 가지고 있으며, 이용자의 개인정보가 유출되지 않도록 조심하고,
            타인의 개인정보를 훼손하지 않도록 유의해야 합니다. 만약 이 같은 책임을 다하지 못하고 타인의 정보 및 존엄성을 훼손할 시에는
           「정보통신망 이용촉진 및 정보보호 등에 관한 법률」, 개인정보보호법」 등에 의해 처벌받을 수 있습니다.</br></br>
        5. 아동의 개인정보보호</br>
          회사는 만 14세 미만 아동의 개인정보를 보호하기 위하여, 만 14세 미만 아동의 회원가입은 제한합니다.</br></br>
        6. 개인정보 자동 수집 장치의 설치 · 운영 및 거부</br>
          ① 회사 서비스 이용 시 자동적으로 쿠키, IP 주소 등 서비스 이용 기록 및 접속 기기 정보가 생성되어 수집될 수 있습니다.</br>
          ② 쿠키의 사용 목적</br>
            a. 접속빈도 또는 머문 시간 등을 분석하여 이용자의 취향과 관심분야를 파악하여 타겟(target) 마케팅에 활용</br>
            b. 회원들의 습관을 분석하여 서비스 개편 등의 척도</br>
            c. 게시판 글 등록 쿠키는 브라우저의 종료시나 로그 아웃 시 만료</br>
          ③ 쿠키 설정 거부 방법</br>
            a. 이용자는 쿠키 설치에 대해 거부할 수 있습니다. 단, 쿠키 설치를 거부하였을 경우 로그인이 필요한 일부 서비스의 이용이 어려울 수 있습니다.</br>
            b. 설정방법(IE 기준): 웹 브라우저 상단의 도구 > 인터넷 옵션 > 개인정보 > 사이트 차단</br></br>
        7. 개인정보의 파기</br>
          ① 회사는 개인정보 보유기간의 경과, 처리 목적 달성 등 개인정보가 불필요하게 되었을 때에는 지체없이 개인정보를 파기합니다.</br>
            a. 회원 정보: 회원탈퇴 후 90 일 후 파기</br>
            b. 비회원 정보: 업무 목적 달성 후 파기</br>
            c. 식품 이물 발견 신고: 이물 통보 완료 후 파기</br>
          ② 이용자로부터 동의 받은 개인정보 보유기간이 경과하거나 처리 목적이 달성되었음에도 불구하고 다른 법령에 따라 개인정보를 계속 보존하여야 하는 경우에는,
            해당 개인정보를 별도의 데이터베이스(DB)로 옮기거나 보관장소를 달리하여 보존합니다.</br>
          ③ 회사는 전자적 파일 형태로 기록 ∙ 저장된 개인정보는 기록을 재생할 수 없도록 파기하며, 종이 문서에 기록 ∙ 저장된 개인정보는 분쇄기로 분쇄하거나
            소각하여 파기합니다.</br></br>
        8. 개인정보보호를 위한 기술적 ∙ 관리적 보호조치</br>
          ① 회사는 이용자의 개인정보를 취급함에 있어 개인정보가 분실, 도난, 누출, 변조 또는 훼손되지 않도록 안전성 확보를 위하여 다음과 같은 보호조치를 이행하고 있습니다.</br>
          ② 기술적 보호조치</br>
            a. 이용자의 개인정보는 비밀번호에 의해 보호되며 파일 및 전송데이터를 암호화하거나 파일 잠금 기능(Lock)을 사용하여 중요한 데이터는 별도의 보안기능을 통해
               보호되고 있습니다.</br>
            b. 회사는 백신프로그램을 이용하여 컴퓨터바이러스에 의한 피해를 방지하기 위한 조치를 취하고 있습니다. 백신프로그램은 주기적으로 업데이트되며 갑작스런
               바이러스가 출현할 경우 백신이 나오는 즉시 이를 제공함으로써 개인정보가 침해되는 것을 방지하고 있습니다.</br>
            c. 회사는 암호알고리즘을 이용하여 네트워크 상의 개인정보를 안전하게 전송할 수 있는 보안장치(SSL)를 채택하고 있습니다.</br>
            d. 해킹 등 외부침입에 대비하여 각 서버마다 침입차단시스템 및 취약점 분석시스템 등을 이용하여 보안에 만전을 기하고 있습니다.</br>
          ③ 관리적 보호조치</br>
            a. 회사는 이용자의 개인정보에 대한 접근권한을 최소한의 인원으로 제한하고 있습니다. 그 최소한의 인원에 해당하는 자는 다음과 같습니다.</br>
             - 이용자를 직접 상대로 하여 마케팅 업무를 수행하는 자</br>
             - 고객의 불만 및 이용문의 처리 업무를 수행하는 자</br>
             - 개인정보보호책임자 및 담당자 등 개인정보관리업무를 수행하는 자</br>
             - 기타 업무상 개인정보의 취급이 불가피한 자</br>
            b. 입사 시 전 직원의 보안서약서를 통하여 사람에 의한 정보유출을 사전에 방지하고 개인정보 처리방침에 대한 이행사항 및 직원의 준수여부를 감사하기 위한
               내부절차를 마련하고 있습니다.</br>
            c. 개인정보 관련 취급자의 업무 인수인계는 보안이 유지된 상태에서 철저하게 이뤄지고 있으며 입사 및 퇴사 후 개인정보 사고에 대한 책임을 명확화하고 있습니다.</br>
            d. 회사는 이용자 개인의 실수나 기본적인 인터넷의 위험성 때문에 일어나는 일들에 대해 책임을 지지 않습니다. 회원 개개인이 본인의 개인정보를 보호하기 위해서
               자신의 ID 와 비밀번호를 적절하게 관리하고 여기에 대한 책임을 져야 합니다.</br>
            e. 그 외 내부 관리자의 실수나 기술관리 상의 사고로 인해 개인정보의 상실, 유출, 변조, 훼손이 유발될 경우 회사는 즉각 이용자에게 사실을 알리고
               적절한 대책과 보상을 강구할 것입니다.
            `;
            return str;
        }else if(idx === 2){
            str+=`제 1 조 (목적)</br>
           회사는 귀하로부터 수집한 개인정보는 "개인정보처리방침"에서 고지한 범위내에서만 사용하며, 회원의 동의 없이는 해당 범위를 초과하여 이용하거나 제3자에게
           제공하지않습니다. 다만, 양질의 서비스제공을 위하여 회원의 개인정보를 협력업체에게 제공하거나 공유할 필요가 있는 경우에는 제공 또는 공유할 정보의 항목 및
           제공받는 자, 제공목적, 이용 및 보유기간 등을 귀하에게 고지하여 동의를 구합니다.</br></br>
        
           제 2 조 (목적 외 사용 및 제3자에 대한 제공 및 공유)</br>
           ① 회사는 귀하의 개인정보를 「개인정보의 수집목적 및 이용목적」에서 고지한 범위 내에서 사용하며, 동 범위를 초과하여 이용하거나 타인 또는 타기업,
             기관에 제공하지 않습니다. 특히 다음의 경우는 주의를 기울여 개인정보를 이용 및 제공할 것입니다.</br></br>
             1. 제휴관계: 제휴서비스 제공을 위하여 귀하의 개인정보를 아래와 같이 제3자에게 제공할 수 있습니다.</br>
                가. 개인정보를 제공받는 자</br>
                  -제휴 음식점</br>
                나. 개인정보를 제공받는 자의 개인정보 이용목적</br>
                  -제휴 서비스제공</br>
                다. 제공하는 개인정보의 항목</br>
                  -예약내역, 주소, 휴대전화번호(안심번호 적용 시 제외)</br>
                라. 개인정보보유 및 이용기간</br>
                  -서비스제공 완료 후 6개월</br>
                  * 회사 서비스의 특성 상 수시로 발생하는 서비스 제공업체와의 제휴로 인하여 “제공 받는 자” 관련 개인정보처리방침 개정에 어려움이 있습니다.
                    따라서 서비스 제공 업체를 위 표 내 제휴사 리스트 부분에 링크하여 안내합니다.</br></br>

             2. 매각, 인수합병 등: 서비스제공자의 권리와 의무가 완전 승계 이전되는 경우 반드시 사전에 정당한 사유와 절차에 대해 상세하게 고지할 것이며
                이용자의 개인정보에 대한 동의 철회의 선택권을 부여합니다.</br>
           ② 고지 및 동의방법은 온라인 홈페이지 초기화면의 공지사항을 통해 최소 10일 이전부터 고지함과 동시에 이메일 등을 이용하여 1회 이상 개별적으로 고지합니다.
           ③ 다음은 예외로 합니다.</br>
             1. 관계법령에 의하여 수사상의 목적으로 관계기관으로부터의 요구가 있을 경우</br>
             2. 통계작성, 학술연구나 시장조사를 위하여 특정 개인을 식별할 수 없는 형태로 광고주 협력사나 연구단체 등에 제공하는 경우</br>
             3. 기타 관계법령에서 정한 절차에 따른 요청이 있는 경우</br>
             4. 그러나 예외 사항에서도 관계법령에 의하거나 수사기관의 요청에 의해 정보를 제공한 경우에는 이를 당사자에게 고지하는 것을 원칙으로 운영하고 있습니다.</br>
                법률상의 근거에 의해 부득이하게 고지를 하지 못할 수도 있습니다. 본래의 수집목적 및 이용목적에 반하여 무분별하게 정보가 제공되지 않도록 최대한 노력하겠습니다.</br>`;
            
            return str;
        }




    }
  
    
    </script>
</body>
</html>