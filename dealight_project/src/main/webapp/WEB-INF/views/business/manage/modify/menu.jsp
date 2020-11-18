<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메뉴 수정</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
<body>

<h1>Business Menu Page</h1>

<h2>메뉴 등록</h2> 
<form action="/business/manage/menu/register" method="post">
	============================================================</br>
	<input name="storeId" value="${storeId}" hidden>
	
	<label for="name">메뉴 이름 : </label>
	<input name="name"> </br>
	
	<label for="price">메뉴 가격 : </label>
	<input name="price"> </br>
	
	<label for="recoMenu">메뉴 추천 여부 : </label>
	<input name="recoMenu" type="checkbox"> </br>
	
	<div class=""><h2>파일 첨부하기</h2></div>
	<div class="file_body">
		<div class="form_img">
			<input type="file" name='uploadFile' multiple>
		</div> 
		<div class='uploadResult'>
			<ul>
			</ul>
		</div> <!-- uploadResult -->
	</div> 
	
	<button type="submit">제출하기</button></br>
	============================================================
</form>
<button>메뉴 수정</button>

<h2>메뉴 리스트</h2>
<c:if test="${empty menus }">
<h2>현재 등록하신 메뉴가 없습니다!🤣</h2>
</c:if>


<c:if test="${not empty menus }">
	<c:forEach items="${menus }" var="menu">
		<div class="menu">
			=========================================
			<h4>매장 번호 : ${menu.storeId }</h4>
			<h4>메뉴 번호 : ${menu.menuSeq }</h4>
			<h4>메뉴 이름 : ${menu.name }</h4>
			<h4>메뉴 가격 : ${menu.price }</h4>
			<h4>메뉴 사진 : ${menu.imgUrl }</h4>
			<h4>메뉴 추천 여부 : ${menu.recoMenu }</h4>
		</div>
	</c:forEach>
</c:if>
<script src="/resources/js/reg_upload_menu.js?ver=1"></script>
</body>
</html>