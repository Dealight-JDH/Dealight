<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/resources/css/store.css">
</head>
<body>

	<div class="container">
		<div class="nav"></div>
		<div class="left">
			<div class="column">
				<%-- <input type="button" value="<" onClick="history.go(-1)"> --%>
			 <a href='/dealight/store?storeId=<c:out value="${store.storeId}"/>'> < </a> 
				<h1>매장정보</h1>
				${store.storeNm }
				<c:if test="${store.imgs[0].imgUrl != null}">
						<img class="imgCon"
							src='/resources/image/<c:out value="${store.imgs[0].fileName}" />'>
				</c:if>


			</div>
			<div class="column">
				<h1>줄서기정보</h1>
				인원수 : ${pnum }
		
				<h1>줄서기 요청</h1>
			<button type="submit">줄서기</button>

			</div>

		</div>
	</div>

</body>
</html>

