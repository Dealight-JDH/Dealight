<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../../includes/mainMenu.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/resources/css/mypage.css?ver=1" type ="text/css" />
</head>
<body>
    <main class="mypage_wrapper">
        <div class="mypage_menu_nav">
            <h2 class="tit_nav">마이 페이지</h2>
            <div class="inner_nav">
                <ul class="menu_list">
                    <li><a href="/dealight/mypage/reservation">예약 내역</a></li>
                    <li><a href="/dealight/mypage/wait">웨이팅 내역</a></li>
                    <li><a href="/dealight/mypage/myreview">나의 리뷰</a></li>
                    <li><a href="/dealight/mypage/like">찜 목록</a></li>
                    <li><a href="/dealight/mypage/modify">회원 정보 수정</a></li>
                </ul>
            </div>
        </div>
        <div class="mypage_content">
            <div class="content_head">
                <h2>리뷰 <span>리뷰 내역을 가져옵니다.</span></h2>
            </div>
            <div>
            </div>
            <div class="content_main">
            </div>
        </div>
    </main>
    
    
</body>
</html>