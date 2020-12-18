<!-- 동인 추가 -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

</head>
<body>
<h2>Rest Template Result</h2>
result : ${result}

<a href="https://kauth.kakao.com/oauth/authorize?client_id=${restKey }&redirect_uri=${redirectURI }&response_type=code">get code</a>
</br>
code : ${code}</br>
<a href="/token?code=${code}">get token</a></br>

<script>
$(document).ready(() =>{
	if(${code} === null)
		window.location.href = "https://kauth.kakao.com/oauth/authorize?client_id="+${restKey}+"&redirect_uri="+${redirectURI}+"&response_type=code"+"&storeId="+${storeId}+"&waitId="+waitId;
	if(${code} !== null)
		window.location.href = "/token?code="+${code}+"&storeId="+${storeId}+"&waitId="+waitId;
}


</script>

</body>
</html>
