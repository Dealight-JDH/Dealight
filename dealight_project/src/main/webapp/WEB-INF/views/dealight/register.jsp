<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@include file="../includes/registerHeader.jsp" %>
  <%@include file="../includes/mainMenu.jsp" %>
  
  <!-- 현수현수현수 -->
  
<body>
    

    <form action="/dealight/register" method="POST" onsubmit="return validate()">
    <div class = "register-content">
        <h2>회원가입</h2>
    <p> 아이디 : <input type="text" name="userId" id = "userId" >  <button type="button" class="overlapCheck">중복확인</button> </p>
	<p class = 'msg' id="idmsg">영문 대문자 또는 소문자 또는 숫자로 시작하는 아이디, 길이는 5~15자</p>
    <p> 비밀번호 : <input type="password" name="pwd" id="pwd" >  </p>
    <p class = 'msg' id="pwdmsg">비밀번호는 영문 대소문자,특수문자 1개씩은 포함해서 8자리~16자리 이내</p>
    <p> 비밀번호 확인 : <input type="password" name="repwd" id="repwd" onblur="checkPwd()">  </p>
    <p class = 'msg' id="repwdmsg">비밀번호 확인을 위하여 다시 한 번 입력해주세요</p>
    <p> 이름 : <input type="text" name="name" id="name" >  2~8자리</p>
    <p> 성별 : 여자<input type="radio" class="sex" name="sex" value="W" >남자<input type="radio" class="sex" name="sex" value="M">  </p>
    <p> 생년월일 : <input type="text" name="brdt" id="brdt" placeholder="19900101" >  </p>
    <p>핸드폰번호 : <input type="text" name="telno" id="telno" placeholder = "01012345678" >
    <p class ='msg' id="telnomsg">-빼고 숫자만 입력해주세요</p>
    <p> 이메일 : <input type="email" name="email" id = "email"value='${email }' readonly="readonly">  </p>
    <p> SNS연동 : <input type="radio" name="snsLginYn" value="Y">yes<input type="radio" name="snsLginYn" value="N">no  </p> 
    <div class="btn">
    <button class="regbtn" type="submit" disabled="disabled" id="reg">회원가입</button> 
    <button class="regbtn" type="button" onclick="location.href='/dealight/dealight' ">취소</button>
    <!-- 인증번호 받고 넘어온건지 확인하기 위해 -->
    <input type="hidden" id="num"  value='<c:out value="${num}"/>'>
    <input type="hidden" id="authNum"  value='<c:out value="${authNum}"/>'>
    </div>
    </div>
    </form>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script type="text/javascript">
  //인증번호가 일치하지 않는다면 접근불가
    let num = document.getElementById("num");
    let authNum = document.getElementById("authNum");

    if(num.value == "" || authNum.value == ""){
    	alert("잘 못 된 접근입니다.");
    	location.href = '/dealight/prove/authemail';
    }

    if(num.value != authNum.value){
    	alert("인증번호가 일치하지 않습니다.");
    	location.href = '/dealight/prove/authemail';
    }
    
    
    
  //정규식
	const jId = /^[A-za-z0-9]{5,15}$/; //영문 대문자 또는 소문자 또는 숫자로 시작하는 아이디, 길이는 5~15자, 끝날때 제한 없음
	const jPwd = /^(?=.*?[a-zA-Z])(?=.*?[#?!@$%^&*-]).{8,16}$/; // 대문자/소문자/특수문자 1개씩은 포함해서 8자리~16자리
	const jName = /^[\w\Wㄱ-ㅎㅏ-ㅣ가-힣]{2,8}$/; // 닉네임은 문자 제한없이 2~8자리
	const jEmail = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i; // 이메일
	const jBirth = /^(19[0-9][0-9]|20\d{2})(0[0-9]|1[0-2])(0[1-9]|[1-2][0-9]|3[0-1])$/; // 19901010 
	const jTelno = /^\d{3}\d{3,4}\d{4}$/; //전화번호 정규식 '-'빼고 숫자만 01063517402
	const blank = /\s/g;
    
    //아이디 중복체크 확인
    $(function(){
		
		$(".overlapCheck").click(function(){
			
			let btn = document.getElementById("reg");
			let userId = $("#userId").val();
			//정규식으로 형식검사 +공백체크
			if(!jId.test(userId) || blank.test(userId)){
				document.getElementById("idmsg").innerHTML = "아이디 형식에 맞지 않습니다";
				document.getElementById("idmsg").style.color = 'red'; 
				btn.disabled = "disabled";
			}
			//입력했는지 검사
			if(userId == ""){
				document.getElementById("idmsg").innerHTML = "아이디를 입력하여 주세요";
	    		document.getElementById("idmsg").style.color = 'red';
	    		btn.disabled = "disabled";
			}
			//객제에 담아서
			let send = {'userId' : userId}
			
			$.ajax({
				async : true,
				type : 'post',
				data : send,
				url : "/dealight/overlapCheck",
				success : function(data){
					
					if(userId != ""){
						if(data > 0){
							   document.getElementById("idmsg").innerHTML = "중복된 아이디가 존재합니다.";
					    	   document.getElementById("idmsg").style.color = 'red';
					    	   btn.disabled = "disabled";
						}else{
							if(jId.test(userId)){
							 		document.getElementById("idmsg").innerHTML = "사용 가능한 아이디입니다.";
							    	   document.getElementById("idmsg").style.color = 'red';
							    	   btn.disabled = false;
							 	 }
						}
						
					}
					
			}
		
	})
	})
	})
    
   	//비밀번호와 비밀번호 확인이 일치하는지 확인
    function checkPwd(){
    	if($("#repwd").val() == ""){
    		 document.getElementById("repwdmsg").innerHTML = "비밀번호 확인을 입력해주세요";
    	     document.getElementById("repwdmsg").style.color = 'red'; 
    	}else{
    		
    	if($("#pwd").val() == $("#repwd").val()){
    			document.getElementById("repwdmsg").innerHTML = "비밀번호가 일치합니다.";
        		document.getElementById("repwdmsg").style.color = 'red'; 
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
    		alert('비밀번호를 입력하여 주세요');
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
    	if($("#brdt").val() == ""){
    		alert('생년월일를 입력하여 주세요');
    		$("#brdt").focus();
    		return false;
    	}
    	
    	if(!jBirth.test($("#brdt").val())){
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
        
        //8.sns연동 체크 여부 검사
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
        }
        
    	return true;
    }
    
    
    </script>
</body>
</html>