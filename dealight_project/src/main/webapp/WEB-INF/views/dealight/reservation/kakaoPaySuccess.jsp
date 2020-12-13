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

<h2>결제 일시</h2> <fmt:formatDate value="${kakaoPayInfo.approved_at}" pattern="yyyy-MM-dd HH:mm:ss"/>
<h2>예약 번호</h2> <c:out value="${kakaoPayInfo.partner_order_id}"/>
<h2>상품명</h2> <c:out value="${kakaoPayInfo.item_name}"/>
<h2>상품수량</h2> <c:out value="${kakaoPayInfo.quantity}"/>
<h2>결제금액</h2> <c:out value="${kakaoPayInfo.amount.total}"/>
<h2>결제수단</h2> <c:out value="${kakaoPayInfo.payment_method_type}"/>
</body>


<script>
	const rsvdId = '${rsvdId}';
	const userId = '${userId}';
	const storeId = '${storeId}';
	console.log(rsvdId);
	console.log(userId);
	console.log(storeId);
	
	let sendObj = "{\"sendUser\":\""+userId+"\",\"rsvdId\":\""+rsvdId+"\",\"cmd\":\"rsvd\",\"storeId\":\""+storeId+"\"}";
	console.log(sendObj);
	/* if(socket != null){
		socket.send(sendObj);
	} */

</script>
</html>