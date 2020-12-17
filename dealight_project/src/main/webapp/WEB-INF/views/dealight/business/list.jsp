<!-- 동인 추가 -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@include file="../../includes/mainMenu.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>매장 리스트</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<style>
	main{
		margin : 30px auto;
		width:1050px;
		height:auto;
	}
	.buser_wrapper{
		border:1px black solid;
	}
</style>
    <style>
        /*@import url(//fonts.googleapis.com/earlyaccess/nanumgothic.css); 
        .nanum { font-family: 'Nanum Barun Gothic'; }*/
        .store_box{
            
            width:80%;
            min-width:1050px;
            height: auto;
            
            min-width: 1025px;
            min-height: 800px;

            border-radius: 10px;
            display: flex;
            flex-direction: column;
            justify-content: flex-start;
            align-items: center;
            background-color: #f4f5f7;
            padding-bottom : 25px;
        }
        .store_box_tit{
            font-size: 24px;
            font-weight: bold;
            color: white;
            align-self: start;
            margin-top: 30px;
            margin-left: 25px;
            padding: 7px 15px;
            border-radius: 15px;
            background-color: rgba(128, 128, 128, 0.575);
            text-shadow: 2px 2px 8px rgba(0,0,0,0.3);
        }
        .store_card{
            cursor: pointer;
            display: flex;
            font-size: 12px;
            
            width: 600px;
            height: 280px;
            background: white;
            /*border: 1px solid #9090900e;*/
            border-radius: 10px;
            margin-top: 25px;
            margin-bottom : 25px;
            box-shadow: 2px 2px 8px rgba(0,0,0,0.3);
        }
        
        .store_card:hover{
           opacity: 0.7;
            /*box-shadow: 7px 7px 8px rgba(247, 44, 78, 0.233);*/
        }
        .store_card:hover .brno_content_wrapper{
            filter: blur(0);
        }
        .store_info_wrapper{
            margin: auto auto;
            /*border: 1px solid black;*/
            width: 90%;
            height: 80%;
            display: flex;
            flex-direction: row;
        }
        .store_info_i{
            height: 50%;
            width: 100%;
            /*border: black 1px solid;*/
            display: flex;
            flex-direction: row;
            justify-content: flex-start;
        }
        .store_info_i.left{
            position: relative;
            /*border: 1px solid black;*/
            width: 100%;
            height: 100%;
        }
        .store_info_i.left.top{
            width: 70%;
        }
        .store_info_i.right.top{
            width: 30%;
        }
        .store_info_i.left span{
            position: absolute;
            left: 5px;
            bottom: 5px;
        }
        
        .store_name{
            position: absolute;
            top: 15px;
            font-size: 28px;
            color: rgba(26, 19, 19, 0.767);
            font-weight: bold;
            
        }
        .store_brch{
            position: absolute;
            top: 60px;
            opacity: 40%;
            left: 7px;
            font-weight: bold;
            font-size: 12px;
        }
        
        .store_info_i.right{
            width: 100%;
            height: 100%;
        }
        .store_info_i_r{
            /*border: 1px black solid;*/
            border-radius: 10px;
            margin: 5px;
        }
        .store_info_wrapper_inner{
            display: flex;
            flex-direction: column;
            justify-content: flex-start;
            width: 60%;
            height: 100%;
        }
        .store_info_wrapper_right{
            height: 100%;
            width: 40%;
            /*border: 1px solid black;*/
            display: flex;
        }
        .store_img_box{
            display: flex;
            flex-direction: row;
            justify-content: center;
            width: 100%;
            height: 80%;
            margin: 20px 0 20px 40px;
            border-radius: 10px;
            box-shadow: 2px 2px 8px rgba(0,0,0,0.3);
            overflow: hidden;
        }
        .store_img_box > img{
            
            max-width: 100%;
            
            text-align: center;
        }

        .store_info_i.right{
            position: relative;
        }
        .store_stus{
            position: absolute;
            top: 20px;
            right: 5px;
            /*border: 1px red solid;*/
            background-color:#eac2d6;
            border-radius: 20px;
            padding: 3px 7px;
            font-size: 12px;
            font-weight: bold;
            color: white;
            text-shadow: 1px 1px 3px rgba(0,0,0,0.3);
            box-shadow: 1px 1px 3px rgba(0,0,0,0.3);
        }
        .store_telno{
            position: absolute;
            color: gray;
            font-weight: bold;
            top : 60px;
            right: 5px;
        }
        .bar{
            padding: 0 4px 0 3px;
        }
        .store_info_i.left{
            position: relative;
        }
        .store_open_tit{
            position: absolute;
            font-size: 14px;
            font-weight: bold;
            left: 3px;
            bottom: 60%;
            color: white;
            border-radius: 20px;
            padding: 3px 7px;
            background-color: gray;
            box-shadow: 1px 1px 3px rgba(0,0,0,0.3);
            text-shadow: 1px 1px 3px rgba(0,0,0,0.3);
        }
        .store_open_tm{
            position: absolute;
            font-size: 24px;
            font-weight: bold;
            bottom: 20%;
            left: 3px;
        }
        .store_cur_rsvd{
            position: absolute;
            font-size: 14px;
            font-weight: bold;
            top: 25%;
            left: 10px;
        }
        .store_cur_wait{
            position: absolute;
            font-size: 14px;
            font-weight: bold;
            left: 10px;
            bottom: 25%;
        }
        .store_plus{
            position: relative;
            margin:auto auto; 
            text-align: center; 
            font-size: 128px; 
            font-weight: lighter;
        }
        .plus_box{
            width: 40%; 
            height: 60%; 
            margin: auto auto; 
            color: green;
            /*border: 1px solid black; */
            text-align: center;
        }
        .store_plus:hover{
            margin:auto auto; 
            text-align: center; 
            font-size: 128px; 
            font-weight: lighter;
            opacity: 0.4;
        }

        .brno_content_wrapper{
            position: absolute;
            display: inline;
            font-size: 12px;
            line-height: 20px;
            padding-top: 70px;
            padding-left: 40px;
            color: gray;
            font-weight: bold;
            filter: blur(1.5px);
        }
    </style>
</head>
<body>
<!-- 
<main>
<c:if test="${not empty buserList}">
	<c:forEach items="${buserList}" var="buser">
		<a href="/dealight/business/register?brSeq=${buser.brSeq}">
			<div class="buser_wrapper">
				<h5>사업자 상세 일련번호 : ${buser.brSeq}</h5>			
				<h5>회원 아이디 : ${buser.userId}</h5>
				<h5>매장 번호 : ${buser.storeId}</h5>
				<h5>사업자등록번호 : ${buser.brno}</h5>
				<h5>사업자등록증사본사진 : ${buser.brPhotoSrc}</h5>
				<h5>사업자 등록 심사 상태 코드 : ${buser.brJdgStusCd}</h5>
				<h5>매장명 : ${buser.storeNm}</h5>
				<h5>휴대전화번호 : ${buser.telno}</h5>
				<h5>매장전화번호 : ${buser.storeTelno}</h5>
				<h5>대표자명 : ${buser.repName}</h5>
			</div>
		</a>
	</c:forEach>	
</c:if>

<c:if test="${empty storeList}">
	<h2>등록하신 매장이 없습니다.🤣</h2>
</c:if>	
<c:if test="${not empty storeList}">
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
</c:if>
</main>
 -->
<main class="store_box">
	<c:if test="${not empty buserList}">
		<c:forEach items="${buserList}" var="buser">
        <div class="store_box_tit">${userId}님의 매장 관리 화면 페이지</div>
        <div class="store_card">
            <div class="brno_content_wrapper">
                <span>사업자 등록 번호 : ${buser.brno}</span><br>
                <span>사업자 등록 심사 상태 코드 : ${buser.brJdgStusCd}</span>
            </div>
            <div class="plus_box">
            	<a href="/dealight/business/register?brSeq=${buser.brSeq}">
                	<i  class="far fa-plus-square store_plus"></i>
                </a>
            </div>
        </div>
     </c:forEach>
   </c:if>
        <c:if test="${empty storeList}">
			<h2>등록하신 매장이 없습니다.🤣</h2>
		</c:if>	
		<c:if test="${not empty storeList}">
		<c:forEach items="${storeList}" var="store">
		<a class='storeInfo' href='/dealight/business/manage/?storeId=${store.storeId}'>
        <div class="store_card">
            <div class="store_info_wrapper">
                <div class="store_info_wrapper_inner">
                    <div class="store_info_i">
                        <div class="store_info_i left top">
                            <span class="store_name">${store.storeNm}</span>
                            <div class="store_brch">${store.bstore.brch}</div>
                        </div>
                        <div class="store_info_i right top">
                            <span class="store_stus">영업중</span>
                            <span class="store_telno">${store.telno}</span>
                        </div>
                    </div>
                    <div class="store_info_i">
                        <div class="store_info_i left">
                            <div class="store_open_tit">영업시간</div>
                            <div class="store_open_tm">${store.bstore.openTm} - ${store.bstore.closeTm}</div>
                        </div>
                        <div class="store_info_i right">
                            <div class="store_cur_rsvd">오늘 예약 수 : ${store.curRsvdNum}</div>
                            <div class="store_cur_wait">현재 웨이팅 수 : ${store.curWaitNum}</div>
                        </div>
                    </div>
                </div>
                <div class="store_info_wrapper_right">
                    <div class="store_img_box">
                        <img src="/display?fileName=${store.bstore.repImg}" alt="">
                    </div> <!-- end img box -->
                </div><!-- end store_info_wrapper_right  -->
            </div> <!--end store_info_wrapper_inner -->
        </div>
        </a>
        </c:forEach>
        </c:if>
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
<%@include file="../../includes/mainFooter.jsp" %>
</body>
<script>

</script>
</html>