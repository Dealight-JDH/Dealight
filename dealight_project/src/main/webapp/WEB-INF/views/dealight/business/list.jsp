<!-- 동인 추가 -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>매장 리스트</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<style>
	main{
		margin : 30px auto;
		width:1050px;
	}
</style>
</head>
<body>
<%@include file="../../includes/mainMenu.jsp" %>
<main>
<h1>Business List Page</h1>

<h2>${userId}</h2>

<h2><a href="/dealight/business/register">등록하기</a></h2>

<c:forEach items="${storeList}" var="store">
============================================
	<a class='storeInfo' href='/dealight/business/manage/?storeId=${store.storeId}'><div>
	<h5>매장 번호 : ${store.storeId}</h5>
	<h5>매장 이름 : <c:out value="${store.storeNm}" /></h5>
	<h5>매장 전화번호 : <c:out value="${store.telno}" /></h5>
	<h5>매장 소유자 아이디 : <c:out value="${store.bstore.buserId}" /></h5>
	<h5>매장 영업 시작 시간 : <c:out value="${store.bstore.openTm}" /></h5>
	<h5>매장 영업 종료 시간 : <c:out value="${store.bstore.closeTm}" /></h5>
	<h5>매장 오늘 예약 수 : <c:out value="${store.curRsvdNum}" /></h5>
	<h5>매장 현재 웨이팅 수 : <c:out value="${store.curWaitNum}" /></h5>
	<h5>매장 사진: <c:out value="${store.bstore.repImg}" /></h5>
	<h5>대표 사진 : <img src="/display?fileName=${store.bstore.repImg}"></h5>
	</div></a>
============================================</br>
</c:forEach>
</main>
<script type="text/javascript">
$(document).ready(function() {
    
    $(".uploadResult").on("click", "li", function(e){
        
        console.log("view image");
        
        let liObj = $(this);
        
        let path = encodeURIComponent(liObj.data("path")+ "/" + liObj.data("uuid") +"_" +liObj.data("filename"));
        
        if(liObj.data("type")){
            
            showImage(path.replace(new RegExp(/\\/g), "/"));
        } else {
            //download
            self.location = "/download?fileName=" + path
        }
    });
    
    function showImage(fileCallPath) {
        
        alert(fileCallPath);
        
        $(".bigPictureWrapper").css("display", "flex").show();
        
        $(".bigPicture")
        .html("<img src='/display?fileName=" + fileCallPath +"'>")
        .animate({width:'100%',height:'100%'},1000);
        
    }
    
    $(".bigPictureWrapper").on("click",function(e){
        $(".bigPicture").animate({width : '0%', height : '0%'}, 1000);
        setTimeout(function(){
            $('.bigPictureWrapper').hide();
        },1000);
    })
    
});
</script>
</body>
<script>

</script>
</html>