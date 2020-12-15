<!-- 동인 추가 -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@include file="../../includes/mainMenu.jsp" %>
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
	#rep_img_box{
		border:1px solid black;
		width:200px;
		height:200px;
	}
	.selected_img{
		border : 4px red solid;
	}
	</style>
	<style>
	main{
		margin : 30px auto;
		width:1050px;
	}
</style>
        <script>
        function allowDrop(ev) {
            ev.preventDefault();
        }
     
        function drag(ev) {
            ev.dataTransfer.setData("text", ev.target.id);
        }
     
        function drop(ev) {
            ev.preventDefault();
            var data = ev.dataTransfer.getData("text");
            ev.target.appendChild(document.getElementById(data));
        }
        </script>
</head>
<body>
<main>
	<form action="/dealight/business/register" method="post" id='regForm' name="form">
	===================================================</br></br>
	<label>유저아이디</label> <input name="buserId" value="${userId }" readonly><br>
	<label>매장코드</label> <input name="clsCd" value="B" readonly><br>
	<label>좌석 상태</label> <input name="seatStusCd" value="B" hidden><br>
	<input name="likeTotNum" value='0' hidden>
	<input name="revwTotNum" value='0' hidden>
	<input name="avgRating" value='0' hidden>
	===================================================</br></br>
	<input name="brSeq" value="${brSeq}" hidden>
	<c:if test="${storeName != null}">< <label>스토어 이름</label> <input name="storeNm" value="${storeName}" required><br></c:if>
	<c:if test="${storeName == null}">< <label>스토어 이름</label> <input name="storeNm" required><br></c:if>
	<label>지점</label> <input name="brch" required><br>
	<c:if test="${storeTelno != null}"><label>전화번호</label> <input name="telno" value="${storeTelno}" required><br></c:if>
	<c:if test="${storeTelno == null}"><label>전화번호</label> <input name="telno" required><br></c:if>
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
	<label>위도</label><input type="text"  style="width:500px;" id="lat"  name="lat" /><br>
	<label>경도</label><input type="text"  style="width:500px;" id="lng"  name="lng" /><br>
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
	<!-- 
	<div id="rep_img_box" ondrop="drop(event)" ondragover="allowDrop(event)">
	</div>
	 -->
	===================================================</br></br>
	<button type="submit" id="btnSubmit">등록하기</button><br>
	</form>

</main>
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
    /* form 역할을 하는 엘리먼트를 선택한다. */
	const formObj = $("#regForm");
    /* 정규식으로 파일 형식을 제한한다. */
    const regex = new RegExp("(.*>)\.(exe|sh|zip|alz)$");
    /*최대 파일 크기를 제어한다  */
	const maxSize = 5242880; /* 5MB */
	// add category ***페이지마다 변경 필요
	const category = 'storeImgs';
	// page type
	const pageType = "register";
	// btn id
	const btnSubmit = "#btnSubmit";
	// isModal
	const isModal = false;
	let storeId = null;
</script>
<script type="text/javascript" src="/resources/js/reg_file.js?ver=1"></script>
<%@include file="../../includes/mainFooter.jsp" %>
</body>
</html>