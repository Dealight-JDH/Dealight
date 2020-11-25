<!-- 동인 추가 -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!-- 현중 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>Insert title here</title>
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
	#map {
		display : hidden;
	}
	</style>
</head>
<body>
<%@include file="../../includes/mainMenu.jsp" %>
<form action="/dealight/business/register" method="post" id='regForm' name="form">
===================================================</br></br>
<label>유저아이디</label> <input name="buserId" value="aaaa" readonly><br>
<label>매장코드</label> <input name="clsCd" value="B" readonly><br>
<label>좌석 상태</label> <input name="seatStusCd" value="B" hidden><br>
<input name="likeTotNum" value='0' hidden>
<input name="revwTotNum" value='0' hidden>
<input name="avgRating" value='0' hidden>
===================================================</br></br>
<label>스토어 이름</label> <input name="storeNm" required><br>
<label>지점</label> <input name="brch" required><br>
<label>전화번호</label> <input name="telno" required><br>
<label for="openTm">영업 시작 시간</label><select id="openTm" name="openTm"></select>
 -  
<label for="closeTm">영업 종료 시간</label><select id="closeTm" name="closeTm"></select></br>
<label for="breakSttm">브레이크 시작 시간</label><select id="breakSttm" name="breakSttm"></select>
 - 
<label for="breakEntm">브레이크 종료 시간</label><select id="breakEntm" name="breakEntm"></select></br>
<label>라스트 오더</label> <select id="lastOrdTm" name="lastOrdTm"></select></br>
<label>가게휴무일</label> <input name="hldy" value="연중무휴"><br>
<label>가게 소개</label> <textarea rows="3" name="storeIntro" >존맛탱</textarea><br>
<label>대표메뉴</label> <input name="repMenu" value="맛난거"><br>
<label>가게 평균 식사 시간</label> <input name="avgMealTm" value="30"><br>
<label>1인석 테이블 개수</label> <input name="n1SeatNo" value="0" type="number"><br>
<label>2인석 테이블 개수</label> <input name="n2SeatNo" value="0" type="number"><br>
<label>4인석 테이블 개수</label> <input name="n4SeatNo" value="0" type="number"><br>
<label>수용인원</label> <input name="acmPnum" value="0" type="number"><br>
===================================================</br></br>
<label>주소</label><input type="text"  style="width:500px;" id="addr"  name="addr" />
<input type="button" onClick="goPopup();" value="주소찾기"/><br>
<label>상세주소</label><input type="text"  style="width:500px;" id="addrDetail"  name="addrDetail" /><br>
<label>시도명</label><input type="text"  style="width:500px;" id="siNm"  name="siNm" /><br>
<label>시군구명</label><input type="text"  style="width:500px;" id="sggNm"  name="sggNm" /><br>
<label>읍면동명</label><input type="text"  style="width:500px;" id="emdNm"  name="emdNm" /><br>
<label>lng</label><input type="text"  style="width:500px;" id="lng"  name="lng" /><br>
<label>lat</label><input type="text"  style="width:500px;" id="lat"  name="lat" /><br>
<div id="map"></div></br>
===================================================<br>
<div class=""><h2>사진 첨부하기</h2></div>
<div class="file_body">
	<div class="form_img">
		<input type="file" name='uploadFile' multiple>
	</div> 
	<div class='uploadResult'>
		<ul></ul>
	</div> <!-- uploadResult -->
</div>
<div class='bigPictureWrapper'>
    <div class='bigPicture'>
    </div>
</div>
===================================================</br></br>
<button type="submit">등록하기</button><br>
</form>


<!-- 카카오 지도  -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=9a6bde461f2e377ce232962931b7d1ce"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=9a6bde461f2e377ce232962931b7d1ce"></script>
<script>
writeTimeBar = function () {
    timeArr = ['입력 전','09:00','09:30','10:00','10:30','11:00','11:30','12:00','12:30','13:00','13:30','14:00','14:30','15:00','15:30','16:00','16:30','17:00','17:30','18:00','18:30','19:00','19:30','20:00','20:30','21:00','21:30','22:00'];
    strTime = "";
    strTime += "<select>";
    for(let i = 1; i <= 27; i++){
        strTime += "<option value='"+i+"'>"+timeArr[i]+"</option>";
    }
    strTime += "</select>";
	document.querySelector("#openTm").innerHTML = strTime;
	document.querySelector("#closeTm").innerHTML = strTime;
	document.querySelector("#breakSttm").innerHTML = strTime;
	document.querySelector("#breakEntm").innerHTML = strTime;
	document.querySelector("#lastOrdTm").innerHTML = strTime;
}
writeTimeBar();

</script>
<script type="text/javascript">
//주소 api
function goPopup(){
	var pop = window.open("/popup/jusoPopup.jsp","pop","width=570,height=420, scrollbars=yes, resizable=yes"); 
}
function jusoCallBack(roadAddrPart1,addrDetail,siNm,sggNm,emdNm){
	document.form.addr.value = roadAddrPart1;
	document.form.addrDetail.value = addrDetail;
	document.form.siNm.value = siNm;
	document.form.sggNm.value = sggNm;
	document.form.emdNm.value = emdNm;
	//위도 경도를 가져온다.
	//kakaoApi GeoCode
	$.ajax({
           url:'https://dapi.kakao.com/v2/local/search/address.json?query='+encodeURIComponent(roadAddrPart1),
           type:'GET',
           headers: {'Authorization' : 'KakaoAK e511e2ddb9ebfda043b94618389a614c'},
	  	   success:function(data){
	       console.log(data.documents[0].x);
	       document.form.lng.value = data.documents[0].x
	       document.form.lat.value = data.documents[0].y
	       console.log(data.documents[0].y);
	       
	   	let container = document.getElementById('map');
	   	container.style.display = 'block';
	   	container.style.width = '250px';
	   	container.style.height = '200px';
		let options = {
			center: new kakao.maps.LatLng(data.documents[0].y, data.documents[0].x),
			level: 3
		};
		
		let markerPosition  = new kakao.maps.LatLng(data.documents[0].y, data.documents[0].x);

		let map = new kakao.maps.Map(container, options);
		
		let marker = new kakao.maps.Marker({
				position: markerPosition
			});
		
		marker.setMap(map);
	       
	   },
	   error : function(e){
	       console.log(e);
	   }
	})
}
</script>
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
    
    
    $(".uploadResult").on("click", "li", function(e){
        
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