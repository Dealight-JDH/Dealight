<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>카카오 결제 성공!!!</h1>

<h2>결제 일시</h2> <fmt:formatDate value="${info.approved_at}" pattern="yyyy-MM-dd HH:mm:ss"/>
<h2>예약 번호</h2> <c:out value="${info.partner_order_id}"/>
<h2>상품명</h2> <c:out value="${info.item_name}"/>
<h2>상품수량</h2> <c:out value="${info.quantity}"/>
<h2>결제금액</h2> <c:out value="${info.amount.total}"/>
<h2>결제방법</h2> <c:out value="${info.payment_method_type}"/>
</body>
</html>