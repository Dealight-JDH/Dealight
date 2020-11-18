<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>매장 등록</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

	<style>
	.uploadResult {
	
		width : 100%;
		background-color : gray;
	}
	
	.uploadResult ul {
		display : flex;
		flex-flow : row;
		justify-content : center;
		align-items : center;
	}
	
	.uploadResult ul li {
		list-style : none;
		padding:10px;
		aligin-content : center;
		text-align : center;
	}
	
	.uploadResult ul li img {
		width : 100px;
	}
	
	.uploadResult ul li img {
		color:white;
	}
	
	.bigPictureWrapper {
		position : absolute;
		display : none;
		justify-content : center;
		align-items : center;
		top : 0%;
		width : 100%;
		height : 100%;
		background-color : gray;
		z-index : 100;
		background : rgba(255,255,255,0.5);
	}
	
	.bigPicture {
		position : relative;
		display : flex;
		justify-content : center;
		align-items : center;
	}
	
	.bigPicture img {
		width : 600px;
	}
	</style>
</head>
<body>

<h1>Business Store Register Form</h1>
<form id="regForm" action="/business/register" method="post">

	<label id="storeNm">매장명</label>
	<input name="storeNm"></br>
	
	<label id="telno">전화번호</label>
	<input name="telno"></br>
	
	<input name="buserId" value="${userId}" type="hidden">
	
	<label id="openTm">시작시간</label>
	<input name="openTm"></br>
	
	<label id="closeTm">마감시간</label>
	<input name="closeTm"></br>
	
	<label id="breakSttm">브레이크 타입 시작시간</label>
	<input name="breakSttm"></br>
	
	<label id="breakEntm">브레이크 타입 마감시간</label>
	<input name="breakEntm"></br>
	
	<label id="lastOrdTm">라스트 오더 시간</label>
	<input name="lastOrdTm"></br>
	
	<label id="n1SeatNo">1인 테이블 수</label>
	<input name="n1SeatNo"></br>
	
	<label id="n2SeatNo">2인 테이블 수</label>
	<input name="n1SeatNo"></br>
	
	<label id="n4SeatNo">4인 테이블 수</label>
	<input name="n4SeatNo"></br>
	
	<label id=storeIntro">매장 소개</label>
	<input name="storeIntro"></br>
	
	<label id="avgMealTm">평균 식사 시간</label>
	<input name="avgMealTm"></br>
	
	<label id="hldy">휴무일</label>
	<input name="hldy"></br>
	
	<label id="acmPnum=">수용인원</label>
	<input name="acmPnum="></br>
	
	<button type="submit">제출하기</button>
</form>

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
<script>
/* 페이지가 로드 되면 실행된다. */
$(document).ready(function(e){
    
    /* form 역할을 하는 엘리먼트를 선택한다. */
	let formObj = $("#regForm");
    
    /* submit 타입의 버튼을 제어한다.*/
    
	$("button[type='submit']").on("click", function(e){
        
        /* 기존 기능은 제한한다.*/
		e.preventDefault();
		
		console.log("submit clicked");
		
		console.log("form"+formObj);
		
		let str = "";
        
        /* 업로드 결과 화면에 업로드 결과를 작성해준다.*/
		$(".uploadResult ul li").each(function(i, obj) {
			
			let jobj = $(obj);
			
			console.dir(jobj);
			
			str += "<input type='hidden' name='imgs["+i+"].fileName' value='" + jobj.data("filename")+"'>";
			str += "<input type='hidden' name='imgs["+i+"].uuid' value='" + jobj.data("uuid")+"'>";
			str += "<input type='hidden' name='imgs["+i+"].uploadPath' value='" + jobj.data("path")+"'>";
			str += "<input type='hidden' name='imgs["+i+"].image' value='" + jobj.data("type")+"'>";
			
		});
        
		console.log(str);
		
        /*위에서 작성한 글을 form에 추가하고 제출한다. */
		formObj.attr("method", "post");
		formObj.append(str).submit();
		
	});
    
    /* 정규식으로 파일 형식을 제한한다. */
    let regex = new RegExp("(.*>)\.(exe|sh|zip|alz)$");
    
    /*최대 파일 크기를 제어한다  */
	let maxSize = 5242880; /* 5MB */
    
    /*업로드 결과를 보여준다. */
	function showUploadResult(uploadResultArr) {
        
        /**업로드 된게 없으면 그대로 반환 */
		if(!uploadResultArr || uploadResultArr.length == 0){return; }
        
        /*업로드 결과를 보여줄 ul를 선택 */
		let uploadUL = $(".uploadResult ul");
		
		let str = "";
        
        /*업로드 결과를 보여준다. */
		$(uploadResultArr).each(function(i,obj){
            
            /* 만일 파일이 이미지 형식이면 */
            /* data에 path,uuid,filename,type을 각각 저장한다. */
			if(obj.image) {
				let fileCallPath = encodeURIComponent(obj.uploadPath+"/s_"+obj.uuid+"_"+obj.fileName);
				
				let originPath = obj.uploadPath + "\\" + obj.uuid +"_" + obj.fileName;
				
				originPath = originPath.replace(new RegExp(/\\/g),"/");
				
				str += "<li data-path='" + obj.uploadPath +"'";
				str += "data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"'data-type='"+obj.image+"'";
				str += "><a href=\"javascript:showImage(" + originPath + ")\">" + "<div>";
				str += "<span>" + obj.fileName +"</span>";
				str += "<img src='/display?fileName=" + fileCallPath + "'>";
				str += "</div></a>";
				str += "<button type ='button' data-file=\'"+fileCallPath+"\' data-type='image' class='btn btn-warning btn-circle'><i class='fa fa-times'></i>삭제</button><br>";
				str += "</li>";
                /* 만일 파일이 이미지 형식이 아니면 */
                /* default img를 보여준다. */
			} else {
				let fileCallPath = encodeURIComponent(obj.uploadPath + "/" + obj.uuid + "_" + obj.fileName);
				let fileLink = fileCallPath.replace(new RegExp(/\\/g),"/");

				str += "<li "
				str += "data-path='" + obj.uploadPath + "'data-uuid='" + obj.uuid + "'data-filename='" + obj.fileName + "' data-type='" +obj.image+"'><a href='/download?fileName=" + fileCallPath + "'>" + "<div>";
				str += "<span> " + obj.fileName + "</span>";
				str += "<img src='/resources/img/attach.png'>";
				str += "</a></div>";
				str += "<button type='button' data-file=\'"+fileCallPath+"\'data-type='file' class='btn btn-warning btn-circle'><i class='fa fa-times'></i>삭제</button><br>";
				str += "</li>";
			}
		});
		uploadUL.append(str);
	}
    
    /*파일 valid check */
	function checkExtension(fileName, fileSize) {
        
        /*파일 사이즈를 체크한다. */
        if(fileSize >= maxSize){
			alert("파일 사이즈 초과");
			return false;
		}
		/*파일 형식을 체크한다. */
		if(regex.test(fileName)) {
			alert("해당 종류의 파일은 업로드 할 수 없습니다.");
			return false;
		}
		return true;
	}
	
	
    
    /* change() 해당하는 요소의 value에 변화가 생길 경우 이를 감지하여 등록된 콜백함수를 동작시킨다.  */
	$("input[type='file']").change(function(e){
		
		let cloneObj = $(".form_img").clone();
		
		let formData = new FormData();
		
		let inputFile = $("input[name='uploadFile']");
		
		let files = inputFile[0].files;
		
		for(let i = 0; i < files.length; i++){
			
			if(!checkExtension(files[i].name, files[i].size)) {
				return false;
            }
            /* uploadFile 이라는 변수명에 파일 배열(스프링에서는 MultipartFile[]로 받는다)을 달아서보낸다. */
			formData.append("uploadFile", files[i]);
		}
		
		$.ajax({
			url : '/uploadAjaxAction',
			processData : false,
            contentType : false, 
            data: formData,
            type: 'POST',
			dataType : 'json',
			success : function(result) {
			    console.log(result);
			    showUploadResult(result); // 업로드 결과 처리 함수
			    $(".form_img").html(cloneObj.html()); // 첨부파일 개수 초기화
			}
			
			
		})
		
	});
    
    /* 업로드 결과를 누르면 해당 파일을 제거한다.  */
	$(".uploadResult").on("click", "button", function(e) {
		
		let targetFile = $(this).data("file");
		
		console.log(targetFile);
		
		let type = $(this).data("type");
		
		console.log(type);
		
		let targetLi = $(this).closest("li");
		
		console.log(targetLi);
		
		$.ajax({
			url : '/deleteFile',
			data : {fileName : targetFile, type:type},
			dataType : 'text',
			type : 'POST',
			success : function(result) {
				alert(result);
				targetLi.remove();
			}
		}); // $.ajax
	});
	
	function showImage(fileCallPath) {
		
		alert(fileCallPath);
		
		$(".bigPictureWrapper").css("display","flex").show();
		
		$(".bigPicture")
		.html("<img src='/display?fileName=" +encodeURI(fileCallPath) + "'>")
		.animate({width:'100%',height:'100%'},1000);
		
		
	}// end show image
	
	$(".bigPictureWrapper").on("click",function(e){
		$(".bigPicture").animate({width:'0%',height:'0%'},1000);
		setTimeout(()=>{
			$(this).hide();
		}, 1000);
	});
}); // ready end

</script>
</body>
</html>