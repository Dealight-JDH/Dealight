<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!-- 현중 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사업자등록목록</title>
</head>
<body>

<h1>사업자등록확인</h1>
<table>
	<thead>
		<tr>
			<th>접수번호</th>
			<th>매장명</th>
			<th>접수날짜</th>
			<th>진행상태</th>
			<th></th>
		</tr>
	</thead>
	<c:forEach items="${list}" var="buser">
		<tr>
			<td><c:out value="${buser.brSeq }"></c:out></td>
			<td><c:out value="${buser.storeNm }"></c:out></td>
			<td><fmt:formatDate pattern="yyyy-MM-dd" value="${buser.regDate }"/></td>
			<td><c:out value="${buser.brJdgStusCd }"></c:out></td>
		</tr>
	</c:forEach>
</table>


<!-- 모달 -->


</body>
</html>