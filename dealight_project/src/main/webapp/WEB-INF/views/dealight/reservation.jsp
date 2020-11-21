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
			<a href='/dealight/store?storeId=<c:out value="${store.storeId}"/>'> < </a> 
			<!--  <input type="button" value="<" onClick="history.go(-1)">-->	
				<h1>매장정보</h1>
				${store.storeNm }
				<c:if test="${store.imgs[0].imgUrl != null}">
						<img class="imgCon"
							src='/resources/image/<c:out value="${store.imgs[0].imgUrl}" />'>
				</c:if>


			</div>
			<div class="column">
				<h1>예약정보</h1>
				시간 : ${time } <br> 인원수 : ${pnum }
				<p>요금세부정보</p>
				<c:forEach items="${selMenuList.menu }" var="menu">
	${menu.name} (${menu.price}) X ${menu.quan} =   ${menu.price*menu.quan}<br>
					<c:set var="total" value="${total + menu.price*menu.quan}" />
				</c:forEach>
				총합계 :
				<c:out value="${total}" />
				<h1>결제 요청</h1>
				<button class="payment" onclick="myFunction()">결제 수단 선택</button>

				<div id="myDIV">
					<button class="payment2">신용카드</button>
					<button class="payment2">카카오 페이</button>
				</div>
			</div>


		</div>


	</div>


	<script>
		function myFunction() {
			const x = document.getElementById("myDIV");
			if (x.style.display === "block") {
				x.style.display = "none";
			} else {
				x.style.display = "block";
			}
		}
	</script>
</body>
</html>

