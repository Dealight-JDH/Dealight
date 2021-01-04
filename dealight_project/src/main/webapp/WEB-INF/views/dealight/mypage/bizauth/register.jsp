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
<main>
<div class="mypage_wrapper">
<%@include file="/WEB-INF/views/includes/custserviceSidebar.jsp" %>
	<div class="box-container flex-column">
	    <div class="mypage_main_header">
	        <div class="main_header_title">사업자등록</div>
	        <div class="main_header_subtitle">매장을 등록해주세요.</div>
	    </div>
	    <div class="mypage_content" style="padding: 10px">
			<form action="/dealight/mypage/bizauth/register" method="post" name="register" id="reg">
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
				<input type="hidden" name="userId" value="${userId }"><br>
			</form>
			<div>
			<div class="file_body uploadDiv">
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
			<div style="display: flex; justify-content: flex-end; margin:10px;">
				<button type="button" class="submit-btn css-modifyBtn regbtn">신청하기</button>
				<button type="button" class="submit-btn css-backBtn listbtn">목록으로</button>
			</div>
			</div>
		
		<div class="bigPictureWrapper">
			<div class="bigPicture">
			</div>
		</div>
		</div>
		
	</div>
</div>
<div class='pull-right panel-footer'>
</div>
</main>	   



</body>
</html>
<script>

window.onload = function(){
	(function(){
		let brPhotoSrc = "${buser.brPhotoSrc}"
		
		if(brPhotoSrc == null || brPhotoSrc == ""){
			return ;
		}
		console.log("photo :" + brPhotoSrc)
		let srcObj = subSrc(brPhotoSrc);
		console.log(srcObj)
		
		let str = "";
		
		
		let fileCallPath = encodeURIComponent( "/"+ srcObj["uploadPath"] +"/s_"+ srcObj["fileName"]);
		console.log(fileCallPath)
		str += "<li data-path='"+ srcObj["uploadPath"] +"'";
		str += "data-filename=\'"+ srcObj["fileName"] +"\'><div>";
		str += "<span>" + srcObj["realFileName"] +"</span>"
		str += " <button type='button' data-file=\'"+fileCallPath+"\'data-type='image' class='fileupload_img_btn'><i class='far fa-times-circle'></i>"
		str += "</button><br>";
		str += "<img src='/display?fileName=" + fileCallPath + "'>";
		str += "</div>";
		str += "</li>";
		
		$(".uploadResult ul").html(str);
	})();
	
	let regbtn = document.querySelector(".regbtn");
	let listbtn = document.querySelector(".listbtn");
	
	//등록버튼이벤트
	const formObj = $("form[name='register']");
	regbtn.onclick = function(){
		const uploadResult = document.getElementsByClassName("uploadResult")[0];
		let obj = (uploadResult.children[0]).children[0] || null;
		let str = "";
		//유효성 검사 필수
		let valid = true;
		$("#reg div").each(function(index, item){
			if($(item).find("input").val() ==""){
				valid=false;
				return;
			}
				
		})
		if(!valid){
			alert("모든항목을 기입해주세요")
			return
		}
		console.dir(obj);
		if(obj == null){
			alert("사진을 등록해주세요")
			return;
		}
		if(formObj.find("input[name='brPhotoSrc']").length ==0 ){
			str += "<input type='hidden' name='brPhotoSrc' value='"+obj.dataset["path"].replace(new RegExp(/\\/g),"/")+ "/" +obj.dataset["filename"] + "'>";
			
		}
		
		formObj.append(str).submit();
	}
	listbtn.onclick = function(){
		self.location = '/dealight/mypage/bizauth/list'
		return;
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
		let realFileName = uploadResult.fileName.substring(uploadResult.fileName.indexOf("_")+1);
		
		let fileCallPath = encodeURIComponent(uploadResult.uploadPath+ "/s_" + uploadResult.fileName);
		console.log(uploadResult.uuid)
		console.log(fileCallPath)
		str += "<li data-path='"+uploadResult.uploadPath+"'";
		str += " data-uuid='"+uploadResult.uuid+"' data-filename=\'"+uploadResult.fileName+"\'data-type='"+uploadResult.image+"'><div>";
		str += "<span>" + realFileName +"</span>"
		str += "<button type='button' data-file=\'"+fileCallPath+"\'data-type='image' class='fileupload_img_btn'>"
		str += "<i class='far fa-times-circle'></i></button><br>";
		str += "<img src='/display?fileName=/" + fileCallPath + "'>";
		str += "</div>";
		str += "</li>";
			
		$(".uploadResult ul").html(str);
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
	function subSrc(photoSrc){
		let srcObj = {};
		let index = photoSrc.lastIndexOf("/");
		
		srcObj["uploadPath"] = photoSrc.substring(0,index);
		srcObj["fileName"] = photoSrc.substring(index + 1);
		srcObj["realFileName"] = photoSrc.substring(photoSrc.lastIndexOf("_") + 1); 
		
		return srcObj;
	}
}
	





</script>