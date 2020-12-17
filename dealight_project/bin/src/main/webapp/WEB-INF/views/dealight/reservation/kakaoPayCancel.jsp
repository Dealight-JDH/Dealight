<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>결제가 취소되었습니다.</h1>

<p> 서비스를 이용하시려면 다시 결제 해주세요.

<button><a href="/dealight/dealight">메인으로</a></button> &nbsp; <button><a href="/dealight/store?storeId=<c:out value="${storeId }"/>+&clsCd=B">돌아가기</a></button>

</body>
</html>