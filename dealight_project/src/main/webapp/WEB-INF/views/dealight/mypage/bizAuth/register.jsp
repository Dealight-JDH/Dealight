<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!-- 현중 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사업자등록페이지</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<style type="text/css">
.container {
  border: 2px solid #ccc;
  background-color: #eee;
  border-radius: 5px;
  padding: 16px;
  margin: 16px 0;
  .uploadResult{
	width:100%;
	background-color: gray;
}
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
}
}
</style>
</head>
<body>
<div class="container">
	<form action="/dealight/mypage/bizAuth/register" method="post" name="register">
		<label>ID</label><input type="text" name="userId"><br>
		-----------------><br>
		<label>대표자명</label><input type="text" name="name"><br>
		<label>매장명</label><input type="text" name="storeNm"><br>
		<label>휴대전화</label><input type="text" name="telno"><br>
		<label>사업장전화번호</label><input type="text" name="storeTelno"><br>
		<label>사업자등록번호</label><input type="text" name="brno"><br>
	</form>
	<div>
	<div class="uploadDiv">
		<input type="file" name="uploadFile">
	</div>
	<div class="uploadResult">
		<ul>
		</ul>
	</div>
		<button type="button" class="regbtn">신청하기</button>
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
	
	let regbtn = document.querySelector(".regbtn");
	
	//등록버튼이벤트
	regbtn.onclick = function(){
		const formObj = $("form[name='register']");
		const uploadResult = document.getElementsByClassName("uploadResult")[0];
		let obj = (uploadResult.children[0]).children[0];
		let str = "";
		
		
		console.dir(obj);
		
		str += "<input type='hidden' name='brPhotoSrc' value='"+obj.dataset["path"]+ "/" +obj.dataset["filename"] + "'>";
		
		formObj.append(str).submit();
	}
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
		console.log("123123123")
		if(!uploadResult || uploadResult == null){return;}
		
		const uploadUL = $(".uploadResult ul");
		
		let str = "";
		let realFileName = uploadResult.fileName.substring(uploadResult.fileName.indexOf("_"+1));
		
		let fileCallPath = encodeURIComponent(uploadResult.uploadPath+ "/s_" + uploadResult.fileName);
		console.log(uploadResult.uuid)
		console.log(fileCallPath)
		str += "<li data-path='"+uploadResult.uploadPath+"'";
		str += " data-uuid='"+uploadResult.uuid+"' data-filename=\'"+uploadResult.fileName+"\'data-type='"+uploadResult.image+"'><div>";
		str += "<span>" + realFileName +"</span>"
		str += " <button type='button' data-file=\'"+fileCallPath+"\'data-type='image'>"
		str += "(X)</button><br>";
		str += "<img src='/display?fileName=/" + fileCallPath + "'>";
		str += "</div>";
		str += "</li>";
			
		uploadUL.append(str);
	}	
	});
	//삭제버튼클릭이벤트
	$(".uploadResult").on("click", "button", function(e){
		
		console.log("delete file");
		
		let targetFile = $(this).data("file");
		let type = $(this).data("type");
		
		let targetLi = $(this).closest("li");
		
		$.ajax({
			url: '/deleteFile',
			data: {fileName: targetFile, type:type},
			dataType: 'text',
			type: 'POST',
			success: function(result){
				alert(result);
				targetLi.remove();
			}
		});//ajax
		
	});
}
	





</script>