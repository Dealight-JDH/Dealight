<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

 <link rel="stylesheet" href="/resources/store.css">
</head>
<body>

	<div class="container">
		<div class="nav"><h1>메뉴바~~~~~~~~~~~~~~~</h1></div>
		<div class="left">
			<div class="column">
				<h1>${store.storeNm }</h1>
			</div>
			<div class="column">
				<h1>매장정보</h1>
				<p>전화번호 : ${store.telno }</p>
				<p>영업시간 : ${store.nstore.bizTm }</p>
				<c:if test="${store.nstore.menu!= null}">
					<p>메뉴 : ${store.nstore.menu }</p>
				</c:if>

			</div>
			<div class="column">
				<h1>평점</h1>
				<label>좋아요수:${store.eval.likeTotNum } </label>
			</div>
		</div>
			<div class="right">
			<h1>---우리사이트에 등록되지않은 일반매장 페이지---<br>여긴 광고넣을까?</h1>
		</div>
	</div>
</body>
</html>