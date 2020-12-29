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
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic&display=swap" rel="stylesheet">
<title>매장 등록 하기</title>
	<style>
	    *{
            font-family: 'Nanum Gothic', sans-serif;
        }
        .store_box{
            
            width:80%;
            min-width:1050px;
            height: auto;
            
            min-width: 1025px;
            min-height: 800px;
            display: flex;
            flex-direction: row;
            justify-content: center;
            align-items: center;
            /*box-shadow: 2px 2px 8px rgba(0,0,0,0.3);*/
            
        }
        .store_right_wrapper{
        	height:100%;
        	width:100%;
        	display: flex;
            flex-direction: column;
            justify-content: flex-start;
            align-items: center;
            background-color: #f4f4f4;
            padding-bottom : 25px;
            border : 1px solid #eeeeef; 
            border-radius: 10px;
        }
        .register_tit{
            font-size: 24px;
            font-weight: 700;
            margin-bottom: 25px;
            color: black;
            text-align: left;
            width: 80%;
            display: flex;
            flex-direction: column;
            justify-content: flex-start;
            align-items: flex-start;
        }
        .register_tit > span {
        	padding-left : 10px;
        }
        #regForm{
            margin-top: 50px;
            width: 100%;
            height: auto;
            display: flex;
            flex-direction: column;
            justify-content: flex-start;
            align-items: center;
            
        }
        #regForm input{
            display: inline-block;
            border-radius: 3px;
            padding: 5px ;
            padding-left: 20px;
            margin: 5px;
            height: 40px;
            margin-left : 10px;
        }
        .reg_form div{
            padding: 30px;
            background-color: #f4f5f7;;
        }
        .reg_form > div{
            padding: 30px;
            border-radius: 20px;
            margin-bottom: 30px;
            background-color: white;
            box-shadow: 3px 3px 8px rgba(0,0,0,0.3);
        }

        .fixed_info_wrapper{ 
            padding: 5px;
            width: 80%; 
            height: 20%;
            /*border: 1px solid black;*/
            }
        .bstore_info_wrapper{
            padding: 5px;
            width: 80%;
            height: 50%;
            /*border: 1px solid black;*/
        }
        .location_wrapper{
            padding: 5px;
            width: 80%;
            height: 20%;
            /*border: 1px solid black;*/
        }
        .upload_wrapper{
            padding: 5px;
            width: 80%;
            height: 20%;
            /*border: 1px solid black;*/
        }
        .label_input{
        	margin-top:10px;
            display: flex;
            flex-direction: column;
            justify-content: flex-start;
            align-items: flex-start;
            /*border: 1px solid black;*/
        }
        .label_input label{
            padding: 5px;
            margin: 5px;
            width: 300px;
            color: rgba(46, 45, 45, 0.767);
            margin-right: 10px;
            font-size: 14px;
            font-weight: 600;
            letter-spacing: 2px;
        }
        .label_input input{
            padding: 3px;
            width: 60%;
            outline: none;
            border: 1px solid #d5dbd9;
        }
        .label_input .input_textarea{
            padding: 3px;
            width: 60%;
            outline: none;
            border: 1px solid #d5dbd9;
            transition: all 0.2s ease;
            resize: none;
            height: 125px;
            border-radius: 3px;
            padding: 15px;
            margin:5px
        }
        .label_input input:focus,
        .label_input .input_textarea:focus
        {
            
            box-shadow: 2px 2px 6px rgba(76, 109, 255, 0.157);
        }
        .label_input .custom_select:focus{
            border: blue 1px solid;
            box-shadow: 2px 2px 6px rgba(76, 109, 255, 0.157);
        }
        .label_input .custom_select {
            position: relative;
            width: 100%;
            height: 37px;
            padding: 0 0 5px 0;
            border-radius: 20px;
            padding-left: 10px 10px 0 0;
        }
        .label_input .custom_select select{
            cursor: pointer;
            padding: 5px;
            margin: 5px;
            -webkit-appearance: none;
            -moz-appearance:   none;
            appearance:        none;
            outline: none;
            width: 100%;
            height: 100%;
            border: 0px;
            padding: 8px 10px;
            font-size: 15px;
            border: 1px solid #d5dbd9;
            border-radius: 3px;
        }
        .label_input .custom_select:before{
            content: "";
            position: absolute;
            top: 42%;
            right: 2%;
            border: 8px solid;
            border-color: #d5dbd9 transparent transparent transparent;
            pointer-events: none;
        }
        .form_label{
            
            text-align: center;
            width: 20%;
            /*border: 1px solid black;*/
        }
        .form_input_items{
            margin: auto auto;
            width: 80%;
            /*border: 1px solid black;*/
        }
        .label_input.terms{
        	display: flex;
        	flex-direction: row;
        	justify-content:flex-start;
        	align-items: center;
        	margin-bottom : 20px;
        }
        .label_input.terms span{
            font-size: 14px;
            color: #757575;
        }
        .checkbox_wrapper{
            padding: 5px;
            width: 80%; 
            height: 20%;
            /*border: 1px solid black;*/
        }
        .label_input.terms .form_check{
            width: 15px;
            height: 15px;
            position: relative;
            display: inline-block;
            cursor: pointer;
        }
        .label_input.terms input[type="checkbox"] {
            position: absolute;
            top:0;
            left:0;
            opacity: 0;
        }
        .label_input.terms .checkmark{
            width: 15px;
            height: 15px;
            border: 1px solid gray;
            display: block;
            position: relative;
            
        }
        .label_input.terms .checkmark:before{
            content: "";
            position: absolute;
            top: 3px;
            left: 3px;
            width: 5px;
            height: 2px;
            border: 2px solid;
            border-color: transparent transparent #fff #fff; 
            transform: rotate(-45deg);
            display: none;
        }
        .label_input.terms .checkmark:hover{
            background-color: gray;
            opacity: 0.7;
        }
        
        .label_input.terms input[type="checkbox"]:checked ~ .checkmark{
            background-color: gray;
        }
        .label_input.terms input[type="checkbox"]:checked ~ .checkmark:before{
            display: block;
        }
        #btnSubmit{
            width: 25%;
            height: 40px;
            border: 0;
            font-size: 18px;
            font-weight: bold;
            color: white;
            background-color: #f43939;
            cursor: pointer;
            border-radius: 3px;
        }
        #btnSubmit:hover{
            opacity: 0.7;
        }
        #store_basic_info{
        	padding-top:20px;
        	padding-left:10px;
        	padding-bottom:10px;
            /*border-top: 32px #d323239d solid;*/
            font-size: 18px;
            font-weight: bold;
            background-color: #f4f5f788; 
        }
        #basic_info_tit{
            letter-spacing: 2px;
            font-size: 24px;
        }
        #store_bstore_info {
        	padding-top:20px;
        	padding-left:10px;
        	padding-bottom:10px;
            /*border-top: 32px #d323239d solid;*/
            font-size: 18px;
            font-weight: bold;
            background-color: #f4f5f788;
        }
        #bstore_info_tit{
            letter-spacing: 2px;
            font-size: 24px;
        }
        #store_loc_find{
        	padding-top:20px;
        	padding-left:10px;
        	padding-bottom:10px;
            /*border-top: 32px #d323239d solid;*/
            font-size: 18px;
            font-weight: bold;
            background-color: #f4f5f788;
        }
        #loc_find_tit{
        	
            letter-spacing: 2px;
            font-size: 24px;
        }
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
            align-content : center;
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
        	margin-top:20px;
        	margin-left:10px;
        	align-self: flex-start;
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
        .label_input.select_box{
        	width:60%;
            /*border: 1px solid black;*/
            display: flex;
            flex-direction: row;
            justify-content: space-between;
            align-items: center;
        }
        #breakSttm{
        	
        }
        #openTm_tit{
        	margin-right:25px;
        }
        #breakSttm_tit{
        	margin-right:25px;
        }
        #btn_find_loc{
        	width:10%;
        	padding: 0 0;
        	padding-left:0;
        }
        .btn_box{
        	display: flex;
        	flex-direction: row;
        	justify-content: flex-start;
        	align-items: center;
        	width:80%;
        }
        .reg_description{
        	font-size: 11px;
        	margin-top: 20px;
        	color: gray;
        }
        input{
        	margin-left: 5px;
        }
        .custom_select.last{
        	width: 60%;
        }
	</style>
	<style>
	main{
		margin : 30px auto;
		width:1050px;
	}
	#breakEntm_label,#closeTm_label{
		margin-left:10px;
		margin-right:-;
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
    <main class="store_box">
    	<div class="store_left_wrapper"></div>
    	<div class="store_right_wrapper">
	        <form action="/dealight/business/register" method="post" id='regForm' name="form">
	                <div class="register_tit">
	                    <span>매장 등록 신청서</span>
	                    <span class="reg_description">아래 신청서의 항목을 모두 작성해주세요.</span>
	                </div>
	                <div class="fixed_info_wrapper">
	                    <div id="store_basic_info">
	                        <span id="basic_info_tit">매장 기본 정보</span>
	                    </div>
	                    <div class="label_input">
	                        <label>유저아이디</label>
	                        <input name="buserId" value="${userId }" readonly>
	                    </div>
	                    <div class="label_input">
	                        <label>매장코드</label>
	                        <input name="clsCd" value="B" readonly>
	                    </div>
	                    <input name="seatStusCd" value="B" type='hidden'>
	                    <input name="likeTotNum" value='0' type='hidden'>
	                    <input name="revwTotNum" value='0' type='hidden'>
	                    <input name="avgRating" value='0' type='hidden'>
	                </div><!-- end fixed info -->
	                <div class="bstore_info_wrapper">
	                    <input name="brSeq" value="${brSeq}" type='hidden'>
	                    <div id="store_bstore_info">
	                        <span id="bstore_info_tit">사업자 매장 정보</span>
	                    </div>
	                    <div class="label_input">
	                        <label>지점</label>
	                        <input name="brch" required>
	                    </div>
	                    <div class="label_input">
	                            <label>스토어 이름</label>
	                            <input name="storeNm" value="${storeName}" required>
	                    </div>
	                    <div class="label_input">
	                        <label>전화번호</label>
	                        <input name="telno" value="${storeTelno}" required><br>
	                    </div>
	                    <div class="label_input select_box">
	                        <label for="openTm" id="openTm_tit">영업 시작</label>
	                        <div class='custom_select'>
	                            <select id="openTm" name="openTm">
	                                <option value="09:00">09:00</option>		
	                                <option value="10:30">09:30</option>
	                            </select>
	                        </div>
	                        <label for="closeTm" id="closeTm_label">영업 마감</label>
	                        <div class='custom_select'>
	                            <select id="closeTm" name="closeTm">
	                                <option value=""></option>
	                            </select>
	                        </div>
	                    </div>
	                    <div class="label_input select_box">
	                        <label for="breakSttm" id="breakSttm_tit">브레이크 타임 시작</label>
	                        <div class='custom_select'>
	                            <select id="breakSttm" name="breakSttm">
	                                <option value=""></option>
	                            </select>
	                         </div>
	                        <label for="breakEntm" id="breakEntm_label">브레이크 타임 종료</label>
	                        <div class='custom_select'>
	                            <select id="breakEntm" name="breakEntm">
	                                <option value=""></option>
	                            </select>
	                        </div>
	                    </div>
	                    <div class="label_input">
	                        <label>라스트 오더</label>
	                        <div class='custom_select last'>
	                            <select id="lastOrdTm" name="lastOrdTm">
	                                <option value=""></option>
	                            </select>
	                        </div>
	                    </div>
	                    <div class="label_input">
	                        <label>가게휴무일</label>
	                        <input name="hldy" value="연중무휴">
	                    </div>
	                    <div class="label_input">
	                        <label>가게 소개</label>
	                        <textarea class="input_textarea" rows="3" name="storeIntro" >존맛탱</textarea>
	                    </div>
	                    <div class="label_input">
	                        <label>대표 메뉴</label>
	                        <input name="repMenu" value="맛난거">
	                    </div>
	                    <div class="label_input">
	                        <label>가게 평균 식사 시간(분)</label>
	                        <input name="avgMealTm" value="30">
	                    </div>
	                        <input name="n1SeatNo" value="0" type="hidden">
	                        <input name="n2SeatNo" value="0" type="hidden">
	                        <input name="n4SeatNo" value="0" type="hidden" >
	                    <div class="label_input">
	                        <label>수용인원</label>
	                        <input name="acmPnum" value="30" type="number">
	                    </div>
	                </div><!-- end bstore info -->
	                <div class="location_wrapper">
	                    <div id="store_loc_find">
	                        <span id="loc_find_tit">주소 찾기</span>
	                    </div>
	                    <div class="label_input">
	                        <label>주소</label>
	                        <input type="text"  style="width:500px;" id="addr"  name="addr" />
	                        <input type="button" onClick="goPopup();" id="btn_find_loc" style="padding-left:0; padding:0 0;" value="주소찾기"/>
	                    </div>
	                    <div class="label_input">
	                        <label>상세주소</label>
	                        <input type="text"  style="width:500px;" id="addrDetail"  name="addrDetail" />
	                    </div>
	                    <div class="label_input">
	                        <label>시도명</label>
	                        <input type="text"  style="width:500px;" id="siNm"  name="siNm" />
	                    </div>
	                    <div class="label_input">
	                        <label>시군구명</label>
	                        <input type="text"  style="width:500px;" id="sggNm"  name="sggNm" />
	                    </div>
	                    <div class="label_input">
	                        <label>읍면동명</label>
	                        <input type="text"  style="width:500px;" id="emdNm"  name="emdNm" />
	                    </div>
	                    <div class="label_input">
	                        <label>위도</label>
	                        <input type="text"  style="width:500px;" id="lat"  name="lat" />
	                    </div>
	                    <div class="label_input">
	                        <label>경도</label>
	                        <input type="text"  style="width:500px;" id="lng"  name="lng" />
	                    </div>
	                    <div id="map"></div>
	                </div> <!-- end location_wrapper -->
	                <div class="upload_wrapper">
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
	                </div> <!-- end upload_wrapper -->
	                <div class="checkbox_wrapper">
	                    <div class="label_input terms">
	                        <label class="form_check">
	                            <input type="checkbox">
	                            <span class="checkmark"></span>
	                        </label>
	                        <span>딜라이트 이용약관, 개인정보 수집 및 이용, 위치정보 이용약관(선택), 프로모션 정보 수신(선택)에 모두 동의합니다.</span>
	                    </div>
	                </div>
	            <div class="btn_box">
					<button type="submit" id="btnSubmit">등록하기</button><br>            
	            </div>
	        </form>
	     </div>
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
        strTime += "<option value='"+timeArr[i]+"'>"+timeArr[i]+"</option>";
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