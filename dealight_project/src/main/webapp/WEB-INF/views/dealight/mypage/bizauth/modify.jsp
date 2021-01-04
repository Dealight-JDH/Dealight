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
<div class="mypage_wrapper">
<%@include file="/WEB-INF/views/includes/custserviceSidebar.jsp" %>
	<div class="box-container flex-column" >
	    <div class="mypage_main_header">
	        <div class="main_header_title">사업자등록</div>
	        <div class="main_header_subtitle">수정해주세요.</div>
	    </div>
        <div class="mypage_content" style="padding: 10px">
			<form action="/dealight/mypage/bizauth/modify" method="post" name="modify">
				<div class="css-id css-input">
					<p>대표자명</p>
                 	<input type="text" name="repName" value="<c:out value = "${buser.repName }"/>" required="required">
                 </div>
				<div class="css-id css-input">
					<p>매장명</p>
                 	<input type="text" name="storeNm" value="<c:out value = "${buser.storeNm }"/>" required="required">
                 </div>
				<div class="css-id css-input">
					<p>휴대전화</p>
                 	<input type="text" name="telno" value="<c:out value = "${buser.telno }"/>" required="required">
                 </div>
				<div class="css-id css-input">
					<p>사업장전화번호</p>
                 	<input type="text" name="storeTelno" value="<c:out value = "${buser.storeTelno }"/>" required="required">
                 </div>
				<div class="css-id css-input">
					<p>사업자등록번호</p>
                 	<input type="text" name="brno" value="<c:out value = "${buser.brno }"/>" required="required">
                 </div>
				<div class="css-id css-input">
					<p>접수날짜</p>
                 	<input type="text" name="regdate" value='<fmt:formatDate pattern="yyyy/MM/dd" value="${buser.regdate }"/>' required="required">
                 </div>
				<input type="hidden" name="userId" value="${userId }"><br>
				<input type="hidden" name="updatedate" value='<fmt:formatDate pattern="yyyy/MM/dd" value="${buser.updatedate }"/>'><br>
				<input type='hidden' name='brPhotoSrc' value='${buser.brPhotoSrc }'>
				<input type="hidden" name="brJdgStusCd" value="${buser.brJdgStusCd }" ><br>
			</form>
			<div class="form-group uploadDiv file_body">
				<div class="form_img">
		            <label for="label_uploadfile">
				         <i class="fas fa-arrow-circle-up"></i> 사진 첨부하기
				    </label>
	             	<input style='display:none;' type="file" id='label_uploadfile' name='uploadFile' multiple hidden='hidden'>
	        	</div> 
			</div>
			<div class="uploadResult">
				<ul>
				</ul>
			</div>
			<div id="btn" style="margin: 20px">
				<button class="modifybtn submit-btn css-modifyBtn" data-oper="modify" >수정하기</button>
				<button class="removebtn submit-btn css-removeBtn" data-oper="remove">삭제하기</button>
				<button class="listbtn submit-btn css-backBtn" data-oper="list" >목록으로</button>
			</div>
		</div>
	</div>

	

</div>
<div class="bigPictureWrapper">
	<div class="bigPicture">
	</div>
</div>



</body>
</html>
<script>

window.onload = function(){
	(function(){
		let brPhotoSrc = "${buser.brPhotoSrc}"
		console.log(brPhotoSrc)
		let srcObj = subSrc(brPhotoSrc);
		console.log(srcObj)
		
		let str = "";
		
		
		let fileCallPath = encodeURIComponent( "/"+ srcObj["uploadPath"] +"/s_"+ srcObj["fileName"]);
		console.log(fileCallPath)
		str += "<li data-path='"+ srcObj["uploadPath"] +"'";
		str += "data-filename=\'"+ srcObj["fileName"] +"\'><div>";
		str += "<span>" + srcObj["realFileName"] +"</span>"
		str += " <button type='button' data-file=\'"+fileCallPath+"\'data-type='image' class='fileupload_img_btn'>"
		str += "<i class='far fa-times-circle'></i></button><br>";
		str += "<img src='/display?fileName=" + fileCallPath + "'>";
		str += "</div>";
		str += "</li>";
		
		$(".uploadResult ul").html(str);
	})();

	//버튼 클릭 이벤트
	
	const formObj = $("form");
	$('#btn  button').on("click",function(e){
		let operation = $(this).data('oper');
		if(operation ==='remove'){
			formObj.attr("action", "/dealight/mypage/bizauth/remove");
		}else if(operation === 'list'){
			formObj.attr("action", "/dealight/mypage/bizauth/list").attr("method", "get");
			formObj.empty();
		}else if(operation === 'modify'){
			const uploadResult = document.getElementsByClassName("uploadResult")[0];
			let obj = (uploadResult.children[0]).children[0];
			if(obj == null){
				alert("첨부파일을 등록해주세요")
			 	return;
			}
			formObj.find("input[name='brPhotoSrc']").val(obj.dataset["path"]+ "/" +obj.dataset["filename"]);
		}
		formObj.submit();
	});
	//================================ 파일첨부 ============================
	//이미지파일만 저장가능하게 변경
	const regex = new RegExp("(.*?)\.(jpg|jpeg|png|gif|bmp|pdf)$"); //파일확장자 검사 정규식
	const maxSize = 5242880; //5MB
	
	//파일 용량 체크 
	function checkExtension(fileName, fileSize){
		
		if(fileSize >= maxSize){
			alert("파일 사이즈 초과");
			return false;
		}
		
		if(regex.test(fileName)){
			return true;
		}
		alert("해당 종류의 파일은 업로드할 수 없습니다.");
		return false;
	}
	
	
	
	$("input[type='file']").change(function(e){
		
		let formData = new FormData();
		
		const inputFile = document.getElementsByName("uploadFile")[0];
		
		let file = inputFile.files;
		
		if(!checkExtension(file[0].name, file[0].size)){
			return false;
		}
		
		formData.append("uploadFile", file[0]);
		//카테고리를 추가해줘야한다.
		formData.append("category", "brnoImg");
		
		$.ajax({
			url: '/uploadImgAjaxAction',
			processData: false,
			contentType: false, 
			data: formData,
			type: 'POST',
			dataType: 'json',
			success: function(result){
				console.log(result);
				showUploadResult(result);//업로드 결과 처리 함수
			}
	});
		
	function showUploadResult(uploadResult){
		if(!uploadResult || uploadResult == null){return;}
		
		const uploadUL = $(".uploadResult ul");
		console.log("result : " +uploadResult.fileName)
		
		let str = "";
		let realFileName = uploadResult.fileName.substring(uploadResult.fileName.indexOf("_")+1);
		console.log("realFileName : " +realFileName)
		
		let fileCallPath = encodeURIComponent(uploadResult.uploadPath+ "/s_" + uploadResult.fileName);
		console.log(uploadResult.uuid)
		console.log(fileCallPath)
		str += "<li data-path='"+uploadResult.uploadPath+"'";
		str += " data-uuid='"+uploadResult.uuid+"' data-filename=\'"+uploadResult.fileName+"\'data-type='"+uploadResult.image+"'><div>";
		str += " <button type='button' data-file=\'"+fileCallPath+"\'data-type='image' class='fileupload_img_btn'>"
		str += "<i class='far fa-times-circle'></i></button>";
		str += "<img src='/display?fileName=/" + fileCallPath + "'>";
		str += "</div>";
		str += "</li>";
			
		$(".uploadResult ul").html(str);
	}	
	});
	//파일 삭제
	$(".uploadResult").on("click","button", function(e){
		console.log("delete file");
		
		if(confirm("Remove this file?")){
			let targetLi = $(this).closest("li");
			targetLi.remove();
		}
	});
	
	const uploadUL = $(".uploadResult ul");
	//썸네일 클릭 이벤트
	$(".uploadResult img").on("click", function(e){
		
		console.log("view image");
		
		var liObj = $(".uploadResult li");
		
		let path = encodeURIComponent( "/" + liObj.data("path")+"/" + liObj.data("filename"));
		
		
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

//img 경로를 잘라주는 함수
function subSrc(photoSrc){
	let srcObj = {};
	let index = photoSrc.lastIndexOf("/");
	
	srcObj["uploadPath"] = photoSrc.substring(0,index);
	srcObj["fileName"] = photoSrc.substring(index + 1);
	srcObj["realFileName"] = photoSrc.substring(photoSrc.lastIndexOf("_") + 1); 
	
	return srcObj;
}
	
</script>