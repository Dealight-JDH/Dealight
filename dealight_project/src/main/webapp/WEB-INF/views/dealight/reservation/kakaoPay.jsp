<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>딜라이트</title>
</head>
<body>

<h1> kakaoPay api</h1>


<form method="post" action="/dealight/reservation/kakaoPay">
    <button>카카오 결제</button>	
	<input type="hidden" name = "storeId" value = "${requestDto.storeId }">
	
	<c:if test="${requestDto.htdlId ne null }">
		<input type="hidden" name = "htdlId" value = "${requestDto.htdlId}">
	</c:if>
	
	<c:forEach items="${requestDto.menu}" var="menu" varStatus="status">
		<input type="hidden" name = "menu["+${ status.index}+"].name" value = "${menu.name}">
		<input type="hidden" name = "menu["+${ status.index}+"].price" value = "${menu.price}">
		<input type="hidden" name = "menu["+${ status.index}+"].qty" value = "${menu.qty}">
	</c:forEach>
	
	<input type="hidden" name = "pum" value = "${requestDto.pnum} }">
	<input type="hidden" name = "time" value = "${requestDto.time}">
	<input type="hidden" name = "totAmt" value = "${requestDto.totAmt}">
	<input type="hidden" name = "totQty" value = "${requestDto.totQty}">
</form>



</body>
</html>

<script>
	

</script>