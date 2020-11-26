<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@include file="../includes/mainMenu.jsp"%>
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
				<a
					href='/dealight/store?clsCd=B&storeId=<c:out value="${store.storeId}"/>'>
					< </a>
				<!--  <input type="button" value="<" onClick="history.go(-1)">-->
				<h1>매장정보</h1>
				${store.storeNm }
				<c:if test="${store.imgs[0].fileName != null}">
						<img class="imgCon"
							src='/resources/images/store/<c:out value="${store.imgs[0].fileName}" />'>
				</c:if>


			</div>
			<div class="column">
				<h1>예약정보</h1>
				시간 : ${time } <br> 인원수 : ${pnum }
				<p>요금세부정보</p>
				<c:forEach items="${rsvdMenuList.menu }" var="menu" varStatus="status">
				
					${menu.name} (${menu.price}) X ${menu.qty} =   ${menu.price*menu.qty}<br>
				<c:set var="totAmt"  value="${totAmt + menu.price*menu.qty}" />
				<c:set var="totQty"  value="${totQty + menu.qty}" />
				</c:forEach>
				총합계 :
				<c:out value="${totAmt}" />
				<h1>결제 요청</h1>
				<button class="payment" onclick="myFunction()">결제 수단 선택</button>

				<div id="myDIV">

					<button class="payment2">신용카드</button>
					<form id="kakaoPayForm" action="/dealight/reservation/kakaoPay" method="post">
						<input type="hidden" name="storeId"
							value="${store.storeId }">
						<c:if test="${store.bstore.htdl.htdlId ne null }">
							<input type="hidden" name="htdlId" value="${store.bstore.htdl.htdlId}">
						</c:if>

						<%-- ${status.index} 따옴표안에 넣지말고 그냥 써줘야함 --%>
						<c:forEach items="${rsvdMenuList.menu}" var="menu" varStatus="status">
							<input type="hidden" name="menu[${status.index}].name" value="${menu.name}">
							<input type="hidden" name="menu[${status.index}].price" value="${menu.price}">
							<input type="hidden" name="menu[${status.index}].qty" value="${menu.qty}">
							
						</c:forEach>
						<input type="hidden" name="pnum" value="${pnum}">
						<input type="hidden" name="time" value="${time}">
						<input type="hidden" name="totAmt" value="${totAmt}">
						<input type="hidden" name="totQty" value="${totQty}">
						<button class="payment2">카카오 페이</button>
					</form>
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

