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
<!-- 
<h2>나에게 메시지 보내기</h2>
<form action="/message" method="get">
<input name='access_token' value='${access_token }' hidden>

<label for="title">제목</label></br>
<input name='title' type='text' value="[딜라이트 웨이팅 안내 메시지]"> </br>

<label for="description">설명</label> </br>
<input name='description' type='textarea' value=""> </br></br>

<label for="web_url">전송 URL</label></br>
<input name='web_url' type='text' value="http://localhost:8080/dealight/business/waiting/">

<button type='submit'>제출</button>

</form>

<h2>Rest Template Result</h2>
result : ${result}</br></br>
access_token : ${access_token}</br>

<h2>내 정보 확인하기</h2>

유저 정보 : ${profile}</br>

<h2>친구 리스트 확인하기</h2>

친구 목록 : ${frList}</br>

<h2>나의 카톡 프로필</h2>

카카오톡 프로필 : ${talkProfile}</br>

<h2>친구 리스트 받기</h2>

allow : ${allow}

<a href="https://kauth.kakao.com/oauth/authorize?client_id=dba6ebc24e85989c7afde75bd48c5746&redirect_uri=http://localhost:8080/message&response_type=code&scope=friends">동의 받으러 가기</a>


친구 리스트 : ${talkFriendsList }
 -->
 
<h2>친구한테 보내기</h2>

<form action="/message/friends?storeId+${storeId}" method="get">

<input name='access_token' value='${access_token }' hidden>

<label for="title">제목</label></br>
<input name='title' type='text' value="[딜라이트 웨이팅 안내 메시지]"> </br>

<label for="description">설명</label> </br>
<input name='description' type='textarea' value=""> </br></br>

<label for="web_url">전송 URL</label></br>
<input name='web_url' type='text' value="http://localhost:8080/dealight/business/waiting/"+${waitId}></br></br>

<label for="uuid">UUID</label></br>
<input name='uuid' type='text' value='${requestUuid}'>

<button type='submit'>제출</button>

</form>

</body>
</html>
