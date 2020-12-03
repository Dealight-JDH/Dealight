<%@page import="com.dealight.domain.UserVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%-- <%@include file="../includes/mypageMenubar.jsp" %> --%>
    <%@include file="../includes/loginmodalHeader.jsp" %>
    <%@include file="../includes/mainMenu.jsp" %>
    <%@include file="../includes/loginModal.jsp" %>
    
<body>
<c:out value="${snsUser }">ffdasfasd</c:out> 
<div class="middleDiv">
            <div class="imgContainer">
                <img src="../../../../../resources/img/main.jpg">

                <form action="search" class="searchBarDiv" method="get">
                    <div class="topRow">
                        <input type="text" class="topRowBar" name="pNum" placeholder="인원">
                        <input type="text" class="topRowBar" name="region" placeholder="지역">
                        <input type="text" class="topRowBar" name="time" placeholder="시간">
                    </div>
                    <div class="bottomRow">
                        <input type="text" class="bottomRowBar" placeholder="가게명 검색, 해시태그를 입력하세요">
                        <button class="searchbtn">매장보기</button>
                    </div>
                </form>
                <!-- imgContainer -->
            </div>
            <!-- middleDiv -->
        </div>

        <div class="dealTitleDiv">
            <div class="dealTitle">실시간핫딜</div>
        </div>

        <div class="dealDiv">
            <div class="dealContainer">
                <div class="dealImg">
                </div>
                <div class="dealText">
                </div>
            </div>
            <div class="dealContainer">
                <div class="dealImg"></div>
                <div class="dealText"></div>
            </div>
            <div class="dealContainer">
                <div class="dealImg"></div>
                <div class="dealText"></div>
            </div>
            <div class="dealContainer">
                <div class="dealImg"></div>
                <div class="dealText"></div>
            </div>
            <div class="dealContainer">
                <div class="dealImg"></div>
                <div class="dealText"></div>
            </div>
            <div class="dealContainer">
                <div class="dealImg"></div>
                <div class="dealText"></div>
            </div>
            <div class="dealContainer">
                <div class="dealImg"></div>
                <div class="dealText"></div>
            </div>
            <div class="dealContainer">
                <div class="dealImg"></div>
                <div class="dealText"></div>
            </div>
            <div class="dealContainer">
                <div class="dealImg"></div>
                <div class="dealText"></div>
            </div>
        </div>

        <div class="footer"></div>

</body>
</html>