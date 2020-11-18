<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>매장 수정</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
<body>

<h1>Business Modify Page</h1>

${msg}

<form id="modifyForm" action="/business/manage/modify" method="post">

	<input name="storeId" value="${store.storeId}" hidden>

	<label id="storeNm">매장명</label>
	<input name="storeNm" value="${store.storeNm}" readonly></br>
	
	<label id="telno">전화번호</label>
	<input name="telno" value="${store.telno}"></br>
	
	<label id="openTm">시작시간</label>
	<input name="openTm" value="${store.openTm}"></br>
	
	<label id="closeTm">마감시간</label>
	<input name="closeTm" value="${store.closeTm}"></br>
	
	<label id="buserId">사업자 회원 아이디</label>
	<input name="buserId" value="${store.buserId}" readonly></br>
	
	<label id="breakSttm">브레이크타임시작시간</label>
	<input name="breakSttm" value="${store.breakSttm}"></br>
	
	<label id="breakEntm">브레이크타임마감시간</label>
	<input name="breakEntm" value="${store.breakEntm}"></br>
	
	<label id="lastOrdTm">라스트오더 시간</label>
	<input name="lastOrdTm" value="${store.lastOrdTm}"></br>
	
	<label id="n1SeatNo">1인 테이블 개수</label>
	<input name="n1SeatNo" value="${store.n1SeatNo}"></br>
	
	<label id="n2SeatNo">2인 테이블 개수</label>
	<input name="n2SeatNo" value="${store.n2SeatNo}"></br>
	
	<label id="n4SeatNo">4인 테이블 개수</label>
	<input name="n4SeatNo" value="${store.n4SeatNo}"></br>
	
	<label id="storeIntro">매장소개</label>
	<input name="storeIntro" value="${store.storeIntro}"></br>
	
	<label id="avgMealTm">매장평균식사시간</label>
	<input name="avgMealTm" value="${store.avgMealTm}" readonly></br>
	
	<label id="hldy">매장휴무일</label>
	<input name="hldy" value="${store.hldy}"></br>
	
	<label id="acmPnum">매장수용인원</label>
	<input name="acmPnum" value="${store.acmPnum}"></br>
	
	<button id="btn_modifyForm" type="submit">제출하기</button>
	
	<input name="addr" value="${store.addr }" hidden>
	<input name="lt" value="${lti}" hidden>
	<input name="lo" value="${store.lo}" hidden>
	<input name="avgRating" value="${store.avgRating }" hidden>
	<input name="revwTotNum" value="${store.revwTotNum }" hidden>
	<input name="likeTotNum" value="${store.likeTotNum }" hidden>
	
	<c:if test="${not empty menuList}">
<c:forEach items="${menuList}" var="menu">
<input name="menuSeq" value="${menu.menuSeq}" hidden>
	<input name="price" value="${menu.price }" hidden>
	<input name="imgUrl" value="${menu.imgUrl}" hidden>
	<input name="name" value="${menu.name }" hidden>
	<input name="recoMenu" value="${menu.recoMenu }" hidden>
</c:forEach>
</c:if>

<c:if test="${not empty revwList}">
<c:forEach items="${revwList}" var="revw">
<input name="rsvdId" value="${revw.rsvdId }" hidden>
<input name="waitSeq" value="${revw.waitSeq }" hidden>
<input name="userId" value="${revw.userId }" hidden>
<input name="cnts" value="${revw.cnts }" hidden>
<input name="regDt" value="${revw.regDt }" hidden>
<input name="rating" value="${revw.rating }" hidden>
<input name="replyCnts" value="${revw.replyCnts }" hidden>
<input name="replyRegDt" value="${revw.replyRegDt }" hidden>
</c:forEach>
</c:if>

<c:if test="${not empty tagList}">
<c:forEach items="${tagList}" var="tag">
<input name="tagNm" value="tag.tagNm" hidden>
</c:forEach>
</c:if>

</form>

매장 주소 : ${store.addr } </br>
매장 위도 : ${lti}</br>
매장 경도 : ${store.lo}</br>

평균 평점 : ${store.avgRating }</br>
리뷰 수 : ${store.revwTotNum }</br>
좋아요 합계 : ${store.likeTotNum }</br>

<h2>메뉴 리스트</h2>
<c:if test="${not empty menuList}">
<c:forEach items="${menuList}" var="menu">
=====================================</br>
메뉴 일련번호 : ${menu.menuSeq}</br>
메뉴 가격 : ${menu.price }</br>
메뉴사진주소 : ${menu.imgUrl}</br>
메뉴이름 : ${menu.name }</br>
메뉴추천여부 : ${menu.recoMenu }</br>
</c:forEach>
</c:if>

<h2>사진 리스트</h2>
<c:if test="${not empty imgs}">
<c:forEach items="${imgs}" var="img">
=====================================</br>
사진 일련번호 : ${img.imgSeq }</br>
uuid : ${img.uuid }</br>
매장 사진 주소 : ${img.uploadPath }</br>
파일 이미지 여부 : ${img.image }</br>
파일 이름 : ${img.fileName }</br>
</c:forEach>
</c:if>

<h2>리뷰 리스트</h2>
<c:if test="${not empty revwList}">
<c:forEach items="${revwList}" var="revw">
=====================================</br>
예약 번호 : ${revw.rsvdId }</br>
웨이팅 번호 : ${revw.waitSeq }</br>
회원 아이디 : ${revw.userId }</br>
리뷰 내용 : ${revw.cnts }</br>
리뷰 작성 날짜 : ${revw.regDt }</br>
리뷰 평점 : ${revw.rating }</br>
답글 내용 : ${revw.replyCnts }</br>
답글 등록 날짜 : ${revw.replyRegDt }</br>
</c:forEach>
</c:if>

<h2>태그 리스트</h2>
<c:if test="${not empty tagList}">
<c:forEach items="${tagList}" var="tag">
=====================================</br>
해시 태그 이름 : ${tag.tagNm }</br>
</c:forEach>
</c:if>
<div class=""><h2>파일 첨부하기</h2></div>
<div class="file_body">
	<div class="form_img">
		<input type="file" name='uploadFile' multiple>
	</div> 
	<div class='uploadResult'>
		<ul>
		</ul>
	</div> <!-- uploadResult -->
</div> 
	<div class='bigPictureWrapper'>
		<div class='bigPicture'>
		</div>
	</div>
	
	
<h2><a href="/business/manage/menu?storeId=${store.storeId}" }>메뉴수정</a></h2>
<script>
$(document).ready(function(){
    
    let regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
    let maxSize = 5242880; // 5mb
    
function showUploadResult(uploadResultArr) {
        
        if(!uploadResultArr || uploadResultArr.length == 0){return; }
        
        let uploadUL = $(".uploadResult ul");
        
        let str = "";
        
        $(uploadResultArr).each(function(i,obj){
            
            if(obj.image) {
                let fileCallPath = encodeURIComponent(obj.uploadPath+"/s_"+obj.uuid+"_"+obj.fileName);
                str += "<li data-path='" + obj.uploadPath +"'";
                str += "data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"'data-type='"+obj.image+"'";
                str += "><div>";
                str += "<span>" + obj.fileName +"</span>";
                str += "<button type ='button' data-file=\'"+fileCallPath+"\'data-type='image' class='btn btn-warning btn-circle'>X</button><br>";
                str += "<img src='/display?fileName=" + fileCallPath + "'>";
                str += "</div>";
                str += "</li>";
                
            } else {
                let fileCallPath = encodeURIComponent(obj.uploadPath + "/" + obj.uuid + "_" + obj.fileName);
                let fileLink = fileCallPath.replace(new RegExp(/\\/g),"/");

                str += "<li "
                str += "data-path='" + obj.uploadPath + "'data-uuid='" + obj.uuid + "'data-filename='" + obj.fileName + "' data-type='" +obj.image+"'><div>";
                str += "<span> " + obj.fileName + "</span>";
                str += "<button type='button' data-file=\'"+fileCallPath+"\'data-type='file' class='btn btn-warning btn-circle'>X</button><br>";
                str += "<img src='/resources/img/attach.png'></a>";
                str += "</div>";
                str += "</li>";
            }
        });
        uploadUL.append(str);
    }
    
    function checkExtension(fileName, fileSize) {
        if(fileSize >= maxSize){
            alert("파일 사이즈 초과");
            return false;
        }
        
        if(regex.test(fileName)) {
            alert("해당 종류의 파일은 업로드 할 수 없습니다.");
            return false;
        }
        return true;
    }
    
    $("input[type='file']").change(function(e){
        
        let formData = new FormData();
        
        let inputFile = $("input[name='uploadFile']");
        
        let files = inputFile[0].files;
        
        for(let i = 0; i < files.length; i++){
            
            if(!checkExtension(files[i].name, files[i].size)) {
                return false;
            }
            formData.append("uploadFile", files[i]);
        }
        
        $.ajax({
            url : '/uploadAjaxAction',
            processData : false,
            contentType : false, data:
                formData, type: 'POST',
                dataType : 'json',
                success : function(result) {
                console.log(result);
                showUploadResult(result); // 업로드 결과 처리 함수
                }
            
            
        })
        
    });
    
    (function(){
        
        let storeId = ${store.storeId};
        
        $.getJSON("/business/manage/getStoreImgs", {storeId:storeId}, function(imgs){
            
            console.log("즉시 함수..");
            
            console.log(imgs);
            
            let str = "";
            
            $(imgs).each(function(i, img){
                
                // image type
                if(img.image) {
                    
                    let fileCallPath = encodeURIComponent(img.uploadPath+"/s_" +img.uuid + "_" +img.fileName);
                    
                    str += "<li data-path='" + img.uploadPath + "'data-uuid='" + img.uuid + "'data-filename='"
                        + img.fileName +"'data-type='" + img.image+"'><div>";
                    str += "<span> " + img.fileName + "</span>";
                    str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='image'";
                    str += "class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
                    str += "<img src='/display?fileName=" + fileCallPath+"'>";
                    str += "</div></li>";
                    
                } else {
                    
                    str += "<li data-path='" + img.uploadPath +"' data-uuid='" + img.uuid 
                            +"' data-filename='" + img.fileName +"' data-type='" + img.image+"'><div>";
                    str += "<span>" + img.fileName+"</span><br/>";
                    str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='file'";
                    str += "class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
                    str += "<img src='/resources/img/attach.png'>";
                    str += "</div>";
                    str += "</li>";
                }
            });
            
            $(".uploadResult ul").html(str);
            
        }); // end json
        
    })(); // end function
    
    
    var formObj = $("#modifyForm");
    
    $('#btn_modifyForm').on("click",function(e){
        
        e.preventDefault();
        
            
            console.log("submit clicked");
            
            let str ="";
            
            $(".uploadResult ul li").each(function(i, obj) {
                
                let jobj = $(obj);
                
                console.dir(jobj);
                
                str += "<input type='hidden' name='imgs["+i+"].fileName' value='" + jobj.data("filename")+"'>";
                str += "<input type='hidden' name='imgs["+i+"].uuid' value='" + jobj.data("uuid")+"'>";
                str += "<input type='hidden' name='imgs["+i+"].uploadPath' value='" + jobj.data("path")+"'>";
                str += "<input type='hidden' name='imgs["+i+"].image' value='" + jobj.data("type")+"'>";
            });
            formObj.append(str).submit();
        formObj.attr("method", "post");
        formObj.submit();
        
    });
    
    $(".uploadResult").on("click", "button", function(e){
    
        console.log("delete file");
        
        if(confirm("Remove this file?")) {
            
            let targetLi = $(this).closest("li");
            targetLi.remove();
        }
        
    });
    
    
});

</script>
</body>
</html>