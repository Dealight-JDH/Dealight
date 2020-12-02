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
	<form action="/dealight/mypage/bizAuth/modify" method="post" name="modify">
		<label>ID</label><input type="text" name="userId" value="${buser.userId }" readonly="readonly"><br>
		<label>심사코드</label><input type="text" name="brJdgStusCd" value="${buser.brJdgStusCd }" ><br>
		<label>접수날짜</label><input type="text" name="regdate" value='<fmt:formatDate pattern="yyyy/MM/dd" value="${buser.regdate }"/>'><br>
		-----------------><br>
		<label>심사번호</label><input type="text" name="brSeq" value="${buser.brSeq }" readonly="readonly"><br>
		<label>대표자명</label><input type="text" name="repName" value="${buser.repName }" ><br>
		<label>매장명</label><input type="text" name="storeNm" value="${buser.storeNm}" ><br>
		<label>휴대전화</label><input type="text" name="telno" value="${buser.telno }" ><br>
		<label>사업장전화번호</label><input type="text" name="storeTelno" value="${buser.storeTelno }" ><br>
		<label>사업자등록번호</label><input type="text" name="brno" value="${buser.brno }" ><br>
		<label>수정날짜</label><input type="text" name="updatedate" value='<fmt:formatDate pattern="yyyy/MM/dd" value="${buser.updatedate }"/>'><br>
		<input type='hidden' name='brPhotoSrc' value='${buser.brPhotoSrc }'>
	</form>
<div>
	
	<div class="form-group uploadDiv">
		<input type="file" name="uploadFile">
	</div>
	<div class="uploadResult">
		<ul>
		</ul>
	</div>
	<div id="btn">
		<button class="modifybtn" data-oper="modify" >수정하기</button>
		<button class="removebtn" data-oper="remove">삭제하기</button>
		<button class="listbtn" data-oper="list" >목록으로</button>
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
		str += " <button type='button' data-file=\'"+fileCallPath+"\'data-type='image'>"
		str += "(X)</button><br>";
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
			formObj.attr("action", "/dealight/mypage/bizAuth/remove");
		}else if(operation === 'list'){
			formObj.attr("action", "/dealight/mypage/bizAuth/list").attr("method", "get");
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
		str += "<span>" + realFileName +"</span>"
		str += " <button type='button' data-file=\'"+fileCallPath+"\'data-type='image'>"
		str += "(X)</button><br>";
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