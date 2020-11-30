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
</head>
<body>

<h1>사업자등록확인</h1>

<c:forEach items="${list}" var="buser">
	<div class="container">
		<label>접수번호 : </label><c:out value="${buser.brSeq }"/><br>
		<label>매장명 : </label><c:out value="${buser.storeNm }"/><br>
		<label>접수날짜 : </label><fmt:formatDate pattern="yyyy-MM-dd" value="${buser.regDate }"/><br>
		<label>진행상태 : </label><c:out value="${buser.brJdgStusCd }"/><br>
	</div>
</c:forEach>
<button id="regbtn" type="button">사업자등록하기</button>


<!-- 모달 -->


<script>
const regbtn = document.getElementById("regbtn");
window.onload = function(){
	console.log("window load");
	//게시글등록확인 메세지
	let result = '<c:out value="${brSeq}"/>';
	console.log(result)
	checkResult()
	
	//등록버튼 클릭 이벤트
	regbtn.onclick = function(){
		self.location = "/dealight/mypage/bizAuth/register"
	}
	
	//게시글 등록메세지
	function checkResult(){
		console.log("checkResult....");
		if(result === ''){
			return;
		}
		if(parseInt(result)>0){
			alert("사업자등록을 성공적으로 요청하셨습니다.\n 심사번호는 " + parseInt(result) + "번 입니다.")
		}
	}
}

</script>
</body>
</html>