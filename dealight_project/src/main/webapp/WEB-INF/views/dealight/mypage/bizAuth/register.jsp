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
<style type="text/css">
.container {
  border: 2px solid #ccc;
  background-color: #eee;
  border-radius: 5px;
  padding: 16px;
  margin: 16px 0;
}
</style>
</head>
<body>
<div class="container">
	<form action="/dealight/mypage/bizAuth/register" method="post" name="register">
		<label>ID</label><input type="text" name="userId"><br>
		-----------------><br>
		<label>대표자명</label><input type="text" name="name"><br>
		<label>매장명</label><input type="text" name="storeNm"><br>
		<label>휴대전화</label><input type="text" name="telno"><br>
		<label>사업장전화번호</label><input type="text" name="storeTelno"><br>
		<label>사업자등록번호</label><input type="text" name="brno"><br>
		<label>첨부파일경로</label><input type="text" name="brPhotoSrc"><br>
	</form>
	<div>
		<label>사업자등록증첨부</label><input type="file" name="uploadImg">
		<button type="button" class="regbtn">신청하기</button>
	</div>
	<div class="uploadDiv">
		<input type="file" name="uploadFile" multiple>
	</div>

	<div class="uploadResult">
		<ul>
		</ul>
	</div>
</div>

<div class="bigPictureWrapper">
	<div class="bigPicture">
	</div>
</div>


</body>
</html>
<script>

window.onload = function(){
	
	
	let regbtn = document.querySelector(".regbtn");
	
	//등록버튼이벤트
	regbtn.onclick = function(){
		const registerForm = document.forms["register"];
		registerForm.submit()
	}

}





</script>