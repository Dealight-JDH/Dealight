<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="../../includes/mainMenu.jsp" %>
    
    <!-- 현수현수현수 -->
    
    <script>
    //로그인이 안된 상태면 메인페이지로 넘어가게
	let msg = '${msg}';
		if(msg != ""){
			alert(msg);
			location.href = '/dealight/dealight';
		}
</script>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>여기는 마이페이지 홈 (예약내역리스트 나오는 페이지~~!!)</h1>


</body>
</html>