<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <%-- <%@ include file="/dealight/src/main/webapp/WEB-INF/views/includes/mainMenu.jsp" %> --%> 
    <%@include file="../../includes/mainMenu.jsp" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
	<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="/resources/css/mypage.css?ver=1" type ="text/css" />
<link rel="stylesheet" href="/resources/css/manage.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<title>딜라이트</title>
<style type="text/css">
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
    
    .telno{
    	display: flex;
        /* padding: 3px; */
        align-items: center; 
        margin-left: 10px;
        border: 1px solid rgb(139, 139, 139);
        border-radius: 3px;
        /* box-sizing: border-box; */
    }
    
    .telno>input{
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
                        <div class="main_header_title">회원정보</div>
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
                            <input type="text" name="name" id="name" value="<c:out value = "${user.name }"/>" readonly>
                        </div>

						
                        
                        <c:set var="brdtValue" value="${user.brdt }"/>
                         
                        <div class="css-input">
                            <p>생년월일
                                <span class="ico">*</span>
                            </p>
                            
                            <div class="birthday">
                             
                                <input type="text" name="brdt" id="brdt1"
                                
                                value="<c:out value = "${fn:substring(brdtValue,0,4) }"/>" size="4" maxlength="4" readonly>
                                <span class="bar">/</span>
                                
                                <input type="text" name="brdt" id="brdt2"
                                    value="<c:out value = "${fn:substring(brdtValue,4,6) }"/>" size="2" maxlength="2" readonly>

                                <span class="bar">/</span>    
                                

                                <input type="text" name="brdt" id="brdt3"
                                    value="<c:out value = "${fn:substring(brdtValue,6,9) }"/>" size="2" maxlength="2" readonly>
                            </div>
                        </div>
                
                        <!-- <div class="form-wrapper"> -->

                        
                        <div class="css-input sendEmail">
                            <p>이메일<span class="ico">*</span></p>
                            <input type="email" name="email" id="email"
                                value="${user.email }" readonly>
                        </div>
                        
						
                    <!-- </div> -->

                        <div class="css-input">                            
                            
                            <p>성별
                            </p>
                            <c:if test="${user.sex eq 'M' }">
                                <input type="text" name="gender" id="gender" value="남자" readonly>
                            </c:if>
                            
                            <c:if test="${user.sex eq 'W' }">
                                <input type="text" name="gender" id="gender" value="여자" readonly>
                            </c:if>
                              
                        </div>

						<c:set var="telnoValue" value="${user.telno }"/>
                        <div class="css-input">
                            <p>휴대폰
                                <span class="ico">*</span>
                            </p>
                            <div class="telno">
                            
                                <input type="text" name="telno" id="telno1"
                                value="<c:out value = "${fn:substring(telnoValue,0,3)}"/>" size="4" maxlength="4" readonly>
                                <span class="bar">-</span>
                                
                                <input type="text" name="telno" id="telno2"
                                    value="<c:out value = "${fn:substring(telnoValue,3,7)}"/>" size="2" maxlength="2" readonly>

                                <span class="bar">-</span>    
                                
                                <input type="text" name="telno" id="telno3"
                                    value="<c:out value = "${fn:substring(telnoValue,7,11)}"/>" size="2" maxlength="2" readonly>
                             </div>

                        </div>
                        
                        <div class="css-input">
                            <p>페널티 횟수</p>
                            <input type="text" name="pmCnt" id="pmCnt" value="<c:out value = "${user.pmCnt }"/>" readonly>
                        </div>
                        
                        

                    <div class="form-footer">
                        <button type="submit" class="submit-btn css-modifyBtn" data-oper="modify">회원수정</button>
                        <button type="submit" class="submit-btn css-backBtn" data-oper="home" >뒤로가기</button>
                    </div>
                    </form>
                </div>

                    </div>
                </div>
    
            </main>

<!-- 수정이 성공했는지 실패했는지 메세지를 받아옴 -->
<%-- <input type="hidden"  id = msg2 value='<c:out value="${msg2}"/>'> --%>

<script type="text/javascript">
let s = "<c:out value='${user.telno }'/>";
$(document).ready(function(){
	console.log(s);
	//1. 성별 정보 불러오기, 수정 불가함
	/* let sexCheck =  document.getElementsByName('sex'); */	
	let sex = '${user.sex}';

	if(sex == 'W'){
		/* sexCheck[0].checked = true; */
	/* 	$("[name=sex]:not(:checked)").attr('disabled', 'disabled'); */
	 	$(".js-sex").val("여자");
	}
	else if(sex == 'M'){
		/* sexCheck[1].checked = true; */
		/* $("[name=sex]:not(:checked)").attr('disabled', 'disabled'); */
		$(".js-sex").val("남자");
	}

	/* //2. sns 연동 정보 불러오기, 수정 가능
	let snsCheck = document.getElementsByName('snsLginYn');
	let sns = '${user.snsLginYn}';

	if(sns == 'Y'){
		snsCheck[0].checked = true;
	}
	else if(sns == 'N'){
		snsCheck[1].checked = true;
	} */
	
	$("button").on("click", function(e){
		e.preventDefault();
		let operation = $(this).data("oper");
		
		if(operation === 'modify'){
			location.href="/dealight/mypage/modify";
		}else if(operation === 'home'){
			location.href="/dealight/dealight";
			}
		}
	
	);
});

/* //로그인이 안된 상태면 메인페이지로 넘어가게
let msg = '${msg}';
	if(msg != ""){
		alert(msg);
		location.href = '/dealight/dealight';
	} */




//입력필드 유효성 검사

/* //정규식

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
	}) */
	
/* function sussecc(){
    	alert("회원 정보 수정이 완료되었습니다.");
    	location.href = '/dealight/mypage/reservation'; 
    } */
    $(".mypage_side_menu > div").on("click",(e) => {
    	
    	if(e.currentTarget === "div.side_noti") return;
    	
		console.log(e.currentTarget);
		
		location.href = $(e.currentTarget).find("a").attr("href");
		
	});
</script>
</body>
</html>