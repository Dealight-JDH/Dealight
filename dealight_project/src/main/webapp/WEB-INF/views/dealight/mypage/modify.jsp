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
    <main class="mypage_wrapper">
        <div class="mypage_menu_nav">
            <h2 class="tit_nav">마이 페이지</h2>
            <div class="inner_nav">
                <ul class="menu_list">
                    <li><a href="/dealight/mypage/reservation">예약 내역</a></li>
                    <li><a href="/dealight/mypage/wait">웨이팅 내역</a></li>
                    <li><a href="/dealight/mypage/myreview">나의 리뷰</a></li>
                    <li><a href="/dealight/mypage/like">찜 목록</a></li>
                    <li><a href="/dealight/mypage/modify">회원 정보 수정</a></li>
                </ul>
            </div>
        </div>
        <div class="mypage_content">
            <div class="content_head">
                <h2>회원 정보 수정<span>회원 정보를 수정합니다.</span></h2>
            </div>
            <div>
                
            </div>
            <div class="content_main">
				<h1>회원정보 수정/ 회원탈퇴</h1>
				<h2>${msg}</h2>
				<div class="modify-content">
					<form id="form_modify" action ="" method="">
						<p>아이디 : <input type = "text" name="userId" id="userId"value="${user.userId }" readonly="readonly"> <span id="id_msg"></span>
						<p>이름 : <input type = "text" name="name" id="name" value="${user.name }" > <span id="name_msg"></span>
						<p>이메일 : <input type = "email" name="email" id="email" value="${user.email}" > <span id="email_msg"></span>
						<p>핸드폰번호 : <input type = "text" name="telno" id="telno"value="${user.telno }" > <span id="telno_msg"></span>
						<p>생년월일 : <input type = "text" name="brdt" id="brdt" value="${user.brdt }" readonly="readonly"> <span id="brdt_msg"></span>
						<p>성별 : 여자<input type="radio" name="sex" value="W">남자<input type="radio" name="sex" value="M">  </p> <span id="sex_msg"></span>
						<p>프로필사진 : <input type = "text" name="photoSrc" id="photoSrc" value="${user.photoSrc }" > <span id="photoSrc_msg"></span>
						<p> SNS연동 : <input type="radio" name="snsLginYn" value="Y">yes<input type="radio" name="snsLginYn" value="N">no  </p> <span id="snsLginYn_msg"></span>
					</form>
					<div>
						<button class='btn_modify' data-oper='modify'>회원수정</button>
						<button class='btn_withdrawal' data-oper='withdrawal' >회원탈퇴</button>
						<a href="/dealight/mypage/changepwd"><button>비밀번호 변경</button></a>
					</div>
				</div>
            </div>
        </div>
    </main>

<script type="text/javascript">


	//1. 성별 정보 불러오기, 수정 불가함
	let sexCheck =  document.getElementsByName('sex');
	let sex = '${user.sex}';
	
	if(sex === 'W'){
		sexCheck[0].checked = true;
		$("[name=sex]:not(:checked)").attr('disabled', 'disabled');
	}
	else if(sex === 'M'){
		sexCheck[1].checked = true;
		$("[name=sex]:not(:checked)").attr('disabled', 'disabled');
	}
	
	//2. sns 연동 정보 불러오기, 수정 가능
	let snsCheck = document.getElementsByName('snsLginYn');
	let sns = '${user.snsLginYn}';
	
	if(sns === 'Y'){
		snsCheck[0].checked = true;
	}
	else if(sns === 'N'){
		snsCheck[1].checked = true;
	}


	//입력필드 유효성 검사
	
	//정규식

	const jPwd = /^(?=.*?[a-zA-Z])(?=.*?[#?!@$%^&*-]).{8,16}$/; // 대문자/소문자/특수문자 1개씩은 포함해서 8자리~16자리
	const jName = /^[\w\Wㄱ-ㅎㅏ-ㅣ가-힣]{2,8}$/; // 닉네임은 문자 제한없이 2~8자리
	const jEmail = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i; // 이메일
	const jTelno = /^\d{3}\d{3,4}\d{4}$/; //전화번호 정규식 '-'빼고 숫자만 01063517402
	const blank = /\s/g;
	
    const idInput = document.querySelector("#userId"),
		nameInput = document.querySelector("#name"),
		emailInput = document.querySelector("#email"),
	    telnoInput = document.querySelector("#telno"),
	    brdtInput = document.querySelector("#brdt"),
	    id_msg = document.querySelector("#id_msg"),
	    name_msg = document.querySelector("#name_msg"),
	    telno_msg = document.querySelector("#telno_msg"),
	    email_msg = document.querySelector("#email_msg"),
	    brdt_msg = document.querySelector("#brdt_msg");
    
    var inputList = [idInput, emailInput, nameInput, telnoInput, brdtInput];
    
 // valid check 함수 선언
    let idValidCheck = function () {
        if($("#name").val() == "")
            return false;
        return true;
    }

    let nameValidCheck = function () {
        if(!jName.test($("#name").val()) || blank.test($("#name").val()))
            return false;
        return true;
    }

    let telnoValidCheck = function () {
        if($("#telno").val() == "" || !jTelno.test($("#telno").val()))
            return false;
        return true;
    }

    let emailValidCheck = function () {
        if($("#email").val() == "" || !jEmail.test($("#email").val()))
            return false;
        return true;
    }

    // null이면  true
    let nullCheck = function(inputList) {
        for(let i = 0; i < inputList.length; i++)
            if(inputList[i].value == "")
                return true;
        
        return false;
    }
    
    /* focus out event 등록 */
    idInput.addEventListener("focusout", () => {
        if(1 <= idInput.value.length){
            if(idValidCheck()){
                id_msg.innerText = "🙆‍♂️ 아이디 형식이 적당하네요.";
            }
            else {
                id_msg.innerText = "🙅‍♂️ 아이디 형식을 다시한 번 작성해 주세요";
            }
        }
    })

    nameInput.addEventListener("focusout", () => {
        if(1 <= nameInput.value.length){
            if(nameValidCheck()){
                name_msg.innerText = "🙆‍♂️ 이름 형식이 적당하네요!";
            }
            else {
                name_msg.innerText = "🙅‍♂️ 이름 형식을 다시 한 번 작성해주세요.";
            }
        }
    })

    telnoInput.addEventListener("focusout", () => {
        if(1 <= telnoInput.value.length){
            if(telnoValidCheck()){
                telno_msg.innerText = "🙆‍♂️ 전화번호 형식이 적당하네요!";
            }
            else {
                telno_msg.innerText = "🙅‍♂️ 전화번호 형식을 다시 한 번 작성해주세요.";
            }
        }
    })

    emailInput.addEventListener("focusout", () => {
        if(1 <= emailInput.value.length){
            if(emailValidCheck()){
                email_msg.innerText = "🙆‍♂️ 이메일 형식이 적당하네요!";
            }
            else {
                email_msg.innerText = "🙅‍♂️ 이메일 형식을 다시 한 번 작성해주세요.";
            }
        }
    })
	
    let validate = function () {	
    
	   	//0. 필드 null 체크
	    if(nullCheck(inputList)){
	        alert("필드가 비었어요")
	        return false;
	    }
	   	
	    if(!idValidCheck()){
	        alert("🙅아이디를 형식에 맞게 입력해주세요");
	        return false;
	    }
		
	    if(!nameValidCheck()){
	        alert("🙅이름을 형식에 맞게 입력해주세요");
	        return false;
	    }
	    
	    if(!telnoValidCheck()){
	        alert("🙅전화번호를 형식에 맞게 입력해주세요");
	        return false;
	    }
	    
	    if(!emailValidCheck()){
	        alert("🙅이메일을 형식에 맞게 입력해주세요");
	        return false;
	    }
	    
	    return true;
    } // end validate() 
    

	
	let userInfoForm = $("#form_modify");
	
	$("button[data-oper='modify']").on("click", function(e){
		
		if(!validate()){
			console.log("너니...?");
			return;
		}
			
		userInfoForm.attr("method", "post");
		userInfoForm.attr("action", "/dealight/mypage/modify").submit();
	});
		
	$("button[data-oper='withdrawal']").on("click", function(e){
		if(confirm("정말로 탈퇴하시겠습니까???")){
			userInfoForm.attr("method", "post");
			userInfoForm.attr("action", "/dealight/mypage/withdrawal").submit();
		} 
		else
			return;
	});
		
</script>
</body>
</html>