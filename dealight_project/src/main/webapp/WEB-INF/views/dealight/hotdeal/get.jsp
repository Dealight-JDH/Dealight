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

<div>
	
<%-- 		<label>핫딜 제목</label> <input class="form-control" name='title'
		 value='<c:out value="${vo.name}"/>' readonly='readonly'><br>
		
		<label>핫딜 메뉴</label> 
		<c:forEach items = "${vo.dtlsList }" var = "menu">
		<input class="form-control" name='title'
		 value='<c:out value="${menu.menuName}"/>' readonly='readonly'>
		</c:forEach><br>
		
		<label>할인율</label> <input class="form-control" name='dcRate' size='15'
		 value='<fmt:formatNumber value="${vo.dcRate * 100}" type="number"/>%' readonly='readonly'><br>
		
		<label>할인 적용전 가격</label> <input class="form-control" name='beforePrice'
		value='<c:out value="${vo.befPrice}"/>' readonly = 'readonly'><br>
		
		<label>할인 적용된 가격</label> <input class="form-control" name='afterPrice'
		value='<c:out value="${vo.befPrice - vo.ddct}"/>' readonly='readonly'><br>
		
	 	<label>핫딜 기간</label>
      	<fmt:parseDate var = "startDate" pattern="yy/MM/dd HH:mm" value="${vo.startTm }"></fmt:parseDate>
		<fmt:parseDate var = "endDate" pattern="yy/MM/dd HH:mm" value="${vo.endTm }"></fmt:parseDate>
		 
		 <input type="text" name="startTime" size = '30'
		value='<fmt:formatDate pattern = "yyyy/MM/dd a HH:mm " value="${startDate }"/> - <fmt:formatDate pattern = "a HH:mm" value="${endDate }"/>' readonly='readonly'><br>
      	 
		<label>핫딜 예약 손님 인원</label> <input class="form-control" name='rsvdPnum' 
		value='<c:out value="${vo.curPnum}"/>'readonly='readonly'><br>
		
		<label>핫딜마감인원:</label> <c:out value="${vo.lmtPnum}"/><br>
		<label>매장 평점:</label> <c:out value="${vo.storeEval.avgRating}"/><br>
		<label>리뷰 수:</label> <c:out value="${vo.storeEval.revwTotNum} "/><br>
		
    	<c:if test="${vo.intro ne null }">
		<label>핫딜 소개</label><br> 
		<textarea rows="3" cols="33" name='content' readonly="readonly">
    	<c:out value="${vo.intro }"/>
    	</textarea>
		</c:if>
		 --%>
</div>
</body>
</html>