<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!-- 현중 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사업자등록목록</title>
<style type="text/css">
.container {
  border: 2px solid #ccc;
  background-color: #eee;
  border-radius: 5px;
  padding: 16px;
  margin: 16px 0;
}

/* Clear floats after containers */
.container::after {
  content: "";
  clear: both;
  display: table;
}
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
<body>

<h1>사업자등록확인</h1>

<c:forEach items="${list}" var="buser">
	<div class="container">
		<div class="buserText">
			<a class="move" href="<c:out value='${buser.brSeq }'/>">
				<label>접수번호 : </label><c:out value="${buser.brSeq }"/><br>
				<label>매장명 : </label><c:out value="${buser.storeNm }"/><br>
				<label>접수날짜 : </label><fmt:formatDate pattern="yyyy-MM-dd" value="${buser.regdate }"/><br>
				<label>진행상태 : </label><c:out value="${buser.brJdgStusCd }"/><br>
			</a>
		</div>
		<div class="buserBtn">
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
</c:forEach>
<button id="regbtn" class="registerbtn" data-oper="register" >사업자등록하기</button>
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
		formObj.find("input[name='brSeq']").val($(this).attr('href'))
		formObj.attr("action", "/dealight/mypage/bizauth/get").attr("method", "get");
		
		formObj.submit();
	});
		
	$('button').on("click",function(e){
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
		self.location = "/dealight/mypage/bizauth/register"
	}
	
}

</script>
</body>
</html>