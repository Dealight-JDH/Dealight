<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>결제 실패</h1>
<p>결제가 실패되었습니다 죄송합니다.
서비스를 이용하시려면 다시 결제 해주세요.
<button><a href="/dealight/dealight">메인으로</a></button> &nbsp; <button><a href="/dealight/store?storeId=<c:out value="${storeId }"/>+&clsCd=B">돌아가기</a></button>

</body>
</html>