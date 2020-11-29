<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!-- 현중 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사업자등록페이지</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
<body>

	<form action="/dealight/mypage/bizAuth/register" method="post" name="register">
		<label>대표자명</label><input type="text" name="userId"><br>
		-----------------><br>
		<label>대표자명</label><input type="text" name="name"><br>
		<label>매장명</label><input type="text" name="storeNm"><br>
		<label>휴대전화</label><input type="text" name="telno"><br>
		<label>사업장전화번호</label><input type="text" name="storeTelno"><br>
		<label>사업자등록번호</label><input type="text" name="brno"><br>
		<label>사업자등록증첨부</label><input type="text" name="brPhotoSrc"><input type="file" name="uploadImg">
	</form>
	<div>
		<button onclick="submit()" type="button">신청하기</button>
	</div>

</body>
</html>
<script>
window.onload = function(){
	
	
}
const registerForm = document.forms["register"];

function submit(){
	register.submit();
}
</script>