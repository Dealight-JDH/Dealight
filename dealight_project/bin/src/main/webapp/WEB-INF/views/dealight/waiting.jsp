<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@include file="../includes/mainMenu.jsp" %>
<!DOCTYPE html>
<html>
<head>
<script>
// 로그인이 안된 상태면 메인페이지로 넘어가게
let msg = '${msg}';
	if(msg != ""){
        alert(msg);
        location.href = '/dealight/store?clsCd=B&storeId='+${storeId};
     }
	
	
</script>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/resources/css/store.css">
</head>
<body>

	<div class="container">
		<div class="left">
			<div class="column">
				<%-- <input type="button" value="<" onClick="history.go(-1)"> --%>
			 <a href='/dealight/store?clsCd=B&storeId=<c:out value="${store.storeId}"/>'> < </a> 
				<h1>매장정보</h1>
				${store.storeNm }
				<c:if test="${store.imgs[0].fileName != null}">
						<img class="imgCon"
							src='/resources/images/store/<c:out value="${store.imgs[0].fileName}" />'>
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

