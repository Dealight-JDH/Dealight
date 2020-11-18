<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>Insert title here</title>
</head>
<body>
<form action="/business/register" method="post" name="form">
테스트코드용----------------------<br>
<label>유저아이디</label> <input name="buserId" value="aaaa"><br>
<label>매장코드</label> <input name="clsCd" value="B"><br>
<label>좌석 상태</label> <input name="seatStusCd" required="required"><br>
<label>좋아요</label> <input name="likeTotNum" required="required"><br>
<label>리뷰개수</label> <input name="revwTotNum" required="required"><br>
<label>평점</label> <input name="avgRating" required="required"><br>
--------------------------------------<br>
<label>스토어 이름</label> <input name="storeNm" required="required"><br>
<label>지점</label> <input name="brch" value="종로본"><br>
<label>전화번호</label> <input name="telno" value="222-2222"><br>
<label>영업시간</label> <input name="openTm" value="10:00">-<input name="closeTm" value="22:00"><br>
<label>브레이크타임</label> <input name="breakSttm" value="15:00">-<input name="breakEntm" value="17:00"><br>
<label>라스트 오더</label> <input name="lastOrdTm" value="21:00"><br>
<label>가게휴무일</label> <input name="hldy" value="연중무휴"><br>
<label>가게 소개</label> <textarea rows="3" name="storeIntro" >존맛탱</textarea><br>
<label>대표메뉴</label> <input name="repMenu" value="맛난거"><br>
<label>가게 평균 식사 시간</label> <input name="avgMealTm" value="30"><br>
<label>1인석 테이블 개수</label> <input name="n1SeatNo" value="10"><br>
<label>2인석 테이블 개수</label> <input name="n2SeatNo" value="5"><br>
<label>4인석 테이블 개수</label> <input name="n4SeatNo" value="10"><br>
<label>수용인원</label> <input name="acmPnum" value="60"><br>
---------------------------------------<br>
<label>주소</label><input type="text"  style="width:500px;" id="addr"  name="addr" />
<input type="button" onClick="goPopup();" value="주소찾기"/><br>
<label>상세주소</label><input type="text"  style="width:500px;" id="addrDetail"  name="addrDetail" /><br>
<label>시도명</label><input type="text"  style="width:500px;" id="siNm"  name="siNm" /><br>
<label>시군구명</label><input type="text"  style="width:500px;" id="sggNm"  name="sggNm" /><br>
<label>읍면동명</label><input type="text"  style="width:500px;" id="emdNm"  name="emdNm" /><br>
<label>lng</label><input type="text"  style="width:500px;" id="lng"  name="lng" /><br>
<label>lat</label><input type="text"  style="width:500px;" id="lat"  name="lat" /><br>
<div id="map" style="width:250px;height:200px;"></div>
----------------------------------------<br>
<button type="submit">등록하기</button><br>
</form>


<!-- 카카오 지도  -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=0e7b9cd1679ce3dedf526e66a6c1a860"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=0e7b9cd1679ce3dedf526e66a6c1a860&libraries=services"></script>
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
	       document.form.lo.value = data.documents[0].x
	       document.form.lt.value = data.documents[0].y
	       console.log(data.documents[0].y);
	   },
	   error : function(e){
	       console.log(e);
	   }
	})
}
	var container = document.getElementById('map');
	var options = {
		center: new kakao.maps.LatLng(37.5007351675912, 126.958669749605),
		level: 3
	};

	var map = new kakao.maps.Map(container, options);
</script>

</body>
</html>