<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<!-- 다울 -->
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link rel="stylesheet" href="/resources/store.css">
</head>
<body>

	<div class="container">
	
		<div class="left">
			<div class="column">
				<h1 >${store.storeNm }</h1>
				<button type="button">하트</button>
				<br>
			</div>
			<div class="column">
				<h1>매장정보</h1>
				<c:if test="${store.telno!= null}">
					<p>전화번호 : ${store.telno }</p>
				</c:if>
				<c:if test="${store.nstore.bizTm!= null}">
					<p>영업시간 : ${store.nstore.bizTm }</p>
				</c:if>
				<c:if test="${store.nstore.menu!= null}">
					<p>메뉴 : ${store.nstore.menu }</p>
				</c:if>

			</div>
			<div class="column">
				<h1>평점</h1>
				<label>좋아요수:${store.eval.likeTotNum } </label>
			</div>
		</div>

	</div>
</body>
</html>