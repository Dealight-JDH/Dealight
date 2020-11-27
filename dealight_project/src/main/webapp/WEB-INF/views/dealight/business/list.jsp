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
</head>
<body>
<%@include file="../../includes/mainMenu.jsp" %>
<h1>Business List Page</h1>

<h2>${userId}</h2>

<h2><a href="/dealight/business/register">등록하기</a></h2>

<c:forEach items="${storeList}" var="store">
============================================
	<a class='storeInfo' href='/dealight/business/manage/?storeId=${store.storeId}'><div>
	<h2>매장 번호 : ${store.storeId}</h2>
	<h2>매장 이름 : <c:out value="${store.storeNm}" /></h2>
	<h2>매장 전화번호 : <c:out value="${store.telno}" /></h2>
	<h2>매장 소유자 아이디 : <c:out value="${store.bstore.buserId}" /></h2>
	<h2>매장 영업 시작 시간 : <c:out value="${store.bstore.openTm}" /></h2>
	<h2>매장 영업 종료 시간 : <c:out value="${store.bstore.closeTm}" /></h2>
	<h2>매장 오늘 예약 수 : <c:out value="${store.curRsvdNum}" /></h2>
	<h2>매장 현재 웨이팅 수 : <c:out value="${store.curWaitNum}" /></h2>
	<h2>매장 사진: <c:out value="${store.bstore.repImg}" /></h2>
	<h2>대표 사진 : <img src="/display?fileName=${store.bstore.repImg}"></h2>
	</div></a>
============================================</br>
</c:forEach>
<script type="text/javascript">
$(document).ready(function() {
	
	for(let i = 0; i < storeList.size(); i++){
		storeList.get(i);
	}
	
	/*
    function getStoreImgs(storeId){
        
    	
        $.getJSON("/business/manage/getStoreImgs", {storeId:storeId}, function(imgs){
            
            let str = "";
            
            $(imgs).each(function(i, img){
            	
            	console.log(img);
            	
                // image type
                if(img.image) {
                    
                    let fileCallPath = encodeURIComponent(img.uploadPath+"/s_" +img.uuid + "_" +img.fileName);
                    str += "<li data-path='" + img.uploadPath + "'data-uuid='" + img.uuid + "'data-filename='"
                        + img.fileName +"'data-type='" + img.image+"'><div>";
                    str += "<img src='/display?fileName=" + fileCallPath+"'>";
                    str += "</li>";
                    
                } else {
                    
                    str += "<li data-path='" + img.uploadPath +"' data-uuid='" + img.uuid 
                            +"' data-filename='" + img.fileName +"' data-type='" + img.image+"'><div>";
                    str += "<span>" + img.fileName+"</span><br/>";
                    str += "<img src='/resources/img/attach.png'>";
                    str += "</div>";
                    str += "</li>";
                }
            });
            
            $(".repImg:last-child").html(str);
            
        }); // end getjson
        
    })(); // end function

    */
    
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


    var operForm = $("#operForm");
    
    $("button[data-oper='modify']").on("click", function(e){
        
        operForm.attr("action", "/board/modify").submit();
        
    });
    
    $("button[data-oper='list']").on("click",function(e){
        
        operForm.find("#bno").remove();
        operForm.attr("action","/board/list");
        operForm.submit();
        
    });
    
});
</script>
</body>
<script>

</script>
</html>