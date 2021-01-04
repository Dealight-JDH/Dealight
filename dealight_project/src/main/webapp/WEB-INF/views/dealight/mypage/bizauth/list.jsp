<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
    <%@include file="../../../includes/mainMenu.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>딜라이트</title>
<link rel="stylesheet" href="/resources/css/custservice.css" type ="text/css" />
<link rel="stylesheet" href="/resources/css/mypage.css?ver=1" type ="text/css" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<style>
.mypage_main_sub > div{
	width : 100%;
}
.btn_like_cancel{
	color : tomato;
	cursor: pointer;
}
.btn_like_cancel:hover{
	opacity: 0.7;
}

.rsvd_wrapper:hover{
	opacity: 0.7;
	cursor:pointer;
}
</style>
</head>
<body>
<main>
	<div class="mypage_wrapper">
<%@include file="/WEB-INF/views/includes/custserviceSidebar.jsp" %>
		<div class="box-container flex-column" >
		    <div class="mypage_main_header">
		        <div class="main_header_title">사업자등록</div>
		        <div class="main_header_subtitle">매장을 등록해주세요.</div>
		    </div>
        		<button id="regbtn" class="registerbtn" data-oper="register" style="align-self: flex-start; margin:20px;">사업자등록하기</button>
		     <div class="contents-wrapper flex-column" style="margin: 10px 0;">
			     <c:forEach items="${list}" var="buser">
			     	<div class="rsvd_wrapper move" data-seq="${buser.brSeq }" style="height:100px; padding:0;">
	                    <div class="css_rsvd_box">
	                        <div class="rsvd_cnts">
	                            <div class="rsvd_cnts_wrapper">
	                                
	                                <div class="cnts">
	                                	<div>
	                                		<span class="rsvd_cnts_tit">접수번호</span>
	                                        <span class="rsvd_cnts_val">${buser.brSeq }</span>
	                                	</div>
	                                    <div>
	                                        <span class="rsvd_cnts_tit">매장명</span>
	                                        <span class="rsvd_cnts_val">${buser.storeNm }</span>
	                                    </div>
	                                </div>
	                                <div class="cnts">
	                                	<div>
	                                		<span class="rsvd_cnts_tit">접수날짜</span>
	                                        <span class="rsvd_cnts_val"><fmt:formatDate pattern="yyyy-MM-dd" value="${buser.regdate }"/></span>
	                                	</div>
	                                    <div>
	                                        <span class="rsvd_cnts_tit">진행상태</span>
	                                        <span class="rsvd_cnts_val">${buser.brJdgStusCd }</span>
	                                    </div>
	                                </div>
	                            </div>
	                            <div class="rsvd_btn_box">
	                                <c:choose>
										<c:when test="${buser.brJdgStusCd eq 'C'}">
											<button class="managebtn" data-oper="manage" data-brseq="<c:out value='${buser.brSeq }'/>">
												매장관리
											</button>
										</c:when>
										<c:when test="${buser.brJdgStusCd eq 'F'}">
											<button class="requestbtn" data-oper="request" data-brseq="${buser.brSeq }">
												재심사요청하기
											</button>
										</c:when>
									</c:choose>
	                            </div>
	                        </div>
	                    </div>
	            	</div>
	        	</c:forEach>
            </div>
		</div>
	</div>
	<div class='pull-right panel-footer'>
	</div>
</main>


<!-- 버튼제어 폼 -->
<form action="/dealight/mypage/bizauth/modify" id="operForm" method="post">
	<input type="hidden" id="brSeq" name="brSeq" value="" >
</form>

<!-- 모달 -->


<script>

window.onload = function(){
	console.log("window load");

	const regbtn = document.getElementById("regbtn");
	let result = '<c:out value="${result}"/>';
	let formObj = $("#operForm")
	//게시글 클릭 이벤트
	$('.move').on("click", function(e){
		e.preventDefault();
		formObj.find("input[name='brSeq']").val($(this).data('seq'))
		formObj.attr("action", "/dealight/mypage/bizauth/get").attr("method", "get");
		
		formObj.submit();
	});
		
	$('button').on("click",function(e){
		e.stopPropagation();
		let operation = $(this).data('oper');
		console.log(operation);
		
		formObj.find("input[name='brSeq']").val($(this).data('brseq'))
		
		//재심사요청
		if(operation === 'request'){
			formObj.attr("action", "/dealight/mypage/bizauth/request").attr("method", "get");
		//매장관리
		}else if(operation === 'manage'){
			self.location = "/dealight/business/"
			return;
		}
		formObj.submit();
	})
	
	//게시글등록확인 메세지
	checkResult()
	history.replaceState({},null,null);
	//게시글 등록메세지
	function checkResult(){
		console.log("checkResult....");
		if(result === '' || history.state){
			return;
		}
		if(parseInt(result)>0){
			alert("사업자등록을 성공적으로 요청하셨습니다.\n 심사번호는 " + parseInt(result) + "번 입니다.")
		}
		if(result == "success"){
			alert("처리가 완료되었습니다.")
		}
	}
	
	//등록버튼 클릭 이벤트
	regbtn.onclick = function(){
		self.location = "/dealight/mypage/bizauth/register";
	}
	
}

</script>
<%@include file="/WEB-INF/views/includes/mainFooter.jsp" %>

</body>
</html>