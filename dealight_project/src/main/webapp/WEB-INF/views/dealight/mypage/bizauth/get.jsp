<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
    <%@include file="../../../includes/mainMenu.jsp" %>

<!-- 현중 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>딜라이트</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link rel="stylesheet" href="/resources/css/mypage.css?ver=1" type ="text/css" />
<link rel="stylesheet" href="/resources/css/custservice.css" type ="text/css" />
<link rel="stylesheet" href="/resources/css/fileupload.css">

<style type="text/css">
* { /* CSS초기화. 이거 없으면 div태그 사이에 공백 생김*/
    margin : 0;  /* 값이 0일 때는 단위 안씀. */
    border : 0;
    padding : 0;
    /* font-family: 'Nanum Gothic', sans-serif; */
}
    .mypage_wrapper{
    	padding-bottom: 20px;
    } 
  .form-wrapper{
    display: flex;
    width: 750px;
  }
  .css-input{
    display: flex;
    flex-direction: row;
    position: relative;
    /* padding: 3px; */
    margin-bottom: 8px;
    width: 100%;
    align-items: center;
    /* border: 1px solid black; */
  }
  .css-input>input{
    padding: 12px 20px;
    width: 30%;
    height: 40px;
    margin: 12px 0 6px;
    margin-left: 10px;
    padding-right: 3px;
    border: 1px solid rgb(139, 139, 139);
    border-radius: 3px;
    box-sizing: border-box;
  }
  .css-input>p{
    width: 20%;
    font-weight: 500;
    margin-left: 40px;
  }
  .ico{
    color: #EE6A7B;
  }
  .css-modify{
    display: flex;
    /* border: 1px solid black; */
    flex-direction: column;
    width: 100%;
    margin-top: 16px;
  }
	.form-footer{
    /* border: 1px solid black; */
    display: flex;
    width: 50%;
    height: 60px;
    margin-top: 40px;
    margin-left: 35px;
    justify-content: center;
    align-content: flex-start;
    /* align-items: center; */
  }
  .birthday{
    display: flex;
    /* padding: 3px; */
    align-items: center; 
    margin-left: 10px;
    border: 1px solid rgb(139, 139, 139);
    border-radius: 3px;
    /* box-sizing: border-box; */
  }
  .birthday>input{
    width: 65px;
    height: 40px;
    text-align: center;
    outline: none;
  }
  .css-modifyBtn{
    border: 1px solid orange;
    color: orange;
  }
  .css-backBtn{
    border: 1px solid black;
    color: black;
  }
  .css-removeBtn{
    border: 1px solid #D32323;
    color: #D32323;
  }
  .btn{
    width: 13%;
    height: 40px;
    margin-left: 16px;
    font-weight: bold;
    border: 1px solid #D32323;
    color: #D32323;
    outline: 0;
    background-color: white;
    border-radius: 4px;
  }
  .submit-btn{
    width: 20%;
    height: 40px;
    margin-left: 16px;
    font-weight: bold;
    /* border: 1px solid #D32323;
    color: #D32323; */
    outline: 0;
    background-color: white;
    border-radius: 4px;
    cursor: pointer;
    outline: none;
  }
  #sendEmailbtn{
  	cursor: pointer;
  	outline: none;
  }
  /**
  .uploadResult{
	width:100%;
	background-color: gray;}
.uploadResult ul{
	display: flex;
	flex-flow: row;
	justify-content: center;
	align-items: center;
}
.uploadResult ul li{
	list-style: none;
	padding: 10px;
	align-content: center;
	text-align: center;
}
.uploadResult ul li img{
	width: 100px;
}
.uploadResult ul li span{
	color:white;
}
**/
.uploadResult > ul {
	display: flex;
	flex-flow: row;
	justify-content: flex-start;
	align-items: flex-start;
}
.uploadResult > ul > li > div > img {
	margin:0 20px;
}
.form_img label {
	margin-left: 40px;
}
.uploadResult > ul li{
	margin-left: 40px;
}
.fileupload_img_btn{
	right:-4px;
	top:6px;
}

.bigPictureWrapper{
	position: absolute;
	display: none;
	justify-content: center;
	align-items: center;
	top: 0%;
	width: 100%;
	height: 100%;
	background-color: gray;
	z-index: 100;
	background: rgba(255,255,255,0.5);
}
.bigPicture{
	position: relative;
	display: flex;
	justify-content: center;
	align-items: center;
}
.bigPicture img {
	width: 600px;
}.mypage_main_sub > div{
	width : 100%;
}
.btn_like_cancel{
	color : tomato;
	cursor: pointer;
}
.btn_like_cancel:hover{
	opacity: 0.7;
}

</style>
</head>
<body>
<div class="mypage_wrapper" style="min-height: 900px">
<%@include file="/WEB-INF/views/includes/custserviceSidebar.jsp" %>
	<div class="box-container flex-column" >
	    <div class="mypage_main_header">
	        <div class="main_header_title">사업자등록</div>
	        <div class="main_header_subtitle">사업자등록증을 등록해주세요</div>
	    </div>
	    <div class="mypage_content" style="padding: 10px">
			<div class="css-id css-input">
				<p>심사번호</p>
               	<input type="text" name="brSeq" value="<c:out value = "${buser.brSeq }"/>" readonly="readonly">
            </div>
			<div class="css-id css-input">
				<p>대표자명</p>
               	<input type="text" name="repName" value="<c:out value = "${buser.repName }"/>" readonly="readonly">
           	</div>
			<div class="css-id css-input">
				<p>매장명</p>
               	<input type="text" name="storeNm" value="<c:out value = "${buser.storeNm }"/>" readonly="readonly">
           	</div>
			<div class="css-id css-input">
				<p>휴대전화</p>
               	<input type="text" name="telno" value="<c:out value = "${buser.telno }"/>" readonly="readonly">
            </div>
			<div class="css-id css-input">
				<p>사업장전화번호</p>
               	<input type="text" name="storeTelno" value="<c:out value = "${buser.storeTelno }"/>" readonly="readonly">
            </div>
			<div class="css-id css-input">
				<p>사업자등록번호</p>
               	<input type="text" name="brno" value="<c:out value = "${buser.brno }"/>" readonly="readonly">
            </div>
			<input type="hidden" name="userId" value="${userId }"><br>
			<input type="hidden" name="brPhotoSrc" value="${buser.brPhotoSrc }" readonly="readonly"><br>
			<div>
				<div class="uploadDiv">
				</div>
				<div class="uploadResult">
					<ul>
					</ul>
				</div>
				<div style="display: flex; justify-content: flex-end; margin: 20px">
				<c:choose>
					<c:when test="${buser.brJdgStusCd eq 'C'}">
						<button class="managebtn submit-btn css-modifyBtn" data-oper="manage" data-brseq="<c:out value='${buser.brSeq }'/>">
							매장관리
						</button>
					</c:when>
					<c:when test="${buser.brJdgStusCd eq 'F'}">
						<button class="requestbtn submit-btn css-removeBtn" data-oper="request" data-brseq="${buser.brSeq }">
							재심사요청하기
						</button>
					</c:when>
				</c:choose>
					<button data-oper="modify" class="submit-btn css-backBtn">수정하기</button>
					<button data-oper="list " class="submit-btn css-backBtn">목록으로</button>
					
					<form action="/dealight/mypage/bizauth/modify" id="operForm">
						<input type="hidden" id="brSeq" name="brSeq" value="${buser.brSeq }" > 
					</form>
				</div>
			
				<div class="bigPictureWrapper">
					<div class="bigPicture">
					</div>
				</div>
			</div>
	    </div>
	</div>
</div>

</html>
<%@include file="/WEB-INF/views/includes/mainFooter.jsp" %>
<script>

window.onload = function(){
	(function(){
		let brPhotoSrc = (document.getElementsByName("brPhotoSrc")[0]).value;
		let srcObj = subSrc(brPhotoSrc);
		console.log(srcObj)
		
		let str = "";
		
		
		let fileCallPath = encodeURIComponent( "/"+ srcObj["uploadPath"] +"/s_"+ srcObj["fileName"]);
		console.log(fileCallPath)
		str += "<li data-path='"+ srcObj["uploadPath"] +"'";
		str += "data-filename=\'"+ srcObj["fileName"] +"\'><div>";
		str += "<span>" + srcObj["realFileName"] +"</span><br>"
		str += "<img src='/display?fileName=" + fileCallPath + "'>";
		str += "</div>";
		str += "</li>";
		
		$(".uploadResult ul").html(str);
	})();
	
	//버튼 클릭 이벤트----
	const operForm = $("#operForm");
	
	$("button[data-oper='manage']").on("click", function(e){
		self.location = "/dealight/business/"
	})
	
	$("button[data-oper='request']").on("click", function(e){
		operForm.attr("action", "/dealight/mypage/bizauth/request").attr("method", "get").submit();
	})
	
	$("button[data-oper='modify']").on("click", function(e){
		operForm.attr("action","/dealight/mypage/bizauth/modify").submit();	
	})
	
	$("button[data-oper='list']").on("click", function(e){
		operForm.find("#brSeq").remove();
		operForm.attr("action","/dealight/mypage/bizauth/list")
		operForm.submit();
	})
	//--------------

	const uploadUL = $(".uploadResult ul");
	
	$(".uploadResult").on("click","li", function(e){
		
		console.log("view image");
		
		var liObj = $(this);
		
		let path = encodeURIComponent( "/" + liObj.data("path")+"/" + liObj.data("filename"));
		path.replace(new RegExp(/\\/g), "/")
		
		showImage(path.replace(new RegExp(/\\/g), "/"));
		
	});
	
	//이미지창 닫기
	$(".bigPictureWrapper").on("click", function(e){
		
		$(".bigPicture").animate({width: '0%', height: '0%'}, 1000);
		setTimeout(function(){
			$(".bigPictureWrapper").hide();
		},1000);
		
	});
	
	function showImage(fileCallPath){
		alert(fileCallPath);
		
		$(".bigPictureWrapper").css("display", "flex").show();
		
		$(".bigPicture")
		.html("<img src='/display?fileName="+fileCallPath+"'>")
		.animate({width:'100%', height:'100%'}, 1000);
	}
	
}
function subSrc(photoSrc){
	let srcObj = {};
	let index = photoSrc.lastIndexOf("/");
	
	srcObj["uploadPath"] = photoSrc.substring(0,index);
	srcObj["fileName"] = photoSrc.substring(index + 1);
	srcObj["realFileName"] = photoSrc.substring(photoSrc.lastIndexOf("_") + 1); 
	
	return srcObj;
}
</script>