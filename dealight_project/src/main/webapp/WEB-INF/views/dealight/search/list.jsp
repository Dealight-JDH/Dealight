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
<%@include file="../../includes/mainMenu.jsp" %> 
<style>
.row {
  display: -webkit-flex;
  display: flex;
}
.column {
  -webkit-flex: 1;
  -ms-flex: 1;
  flex: 1;
}

/*       거리바      */
.level {
    width: 200px;
    margin: 10px auto;
}
.level input {
    width: 100%;
}
datalist {
    width: 121%;
    display: -webkit-box;
    display: -webkit-flex;
    display: -ms-flexbox;
    display: flex;
}

datalist option {
    -webkit-box-flex: 1;
    -webkit-flex-grow: 1;
        -ms-flex-positive: 1;
            flex-grow: 1;
    -webkit-flex-basis: 0;
        -ms-flex-preferred-size: 0;
            flex-basis: 0;
}
a:link { color: black; text-decoration: none;}
a:visited { color: black; text-decoration: none;}
a:hover { color: black; text-decoration: none;}
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
<body>
<div class="row">
  <div class="column" style="background-color:#bbb;">
  	<form action="#" id="searchForm">
  		<label>인원</label><input type="text" value="${search.PNum }">
  		<label>시간</label><input type="text" value="${search.time }">
  		<label>지역</label><input type="text" value="${search.region }">
  		<label>검색어</label><input type="text" value="${search.hashTag }">
  		<label>검색어</label><input type="text" value="${search.storeNm }">
  	</form>
	<form id="searchFilter" action="#" >
		<label>정렬순서
		<select name="sortType">
			<option value="D">거리순</option>
			<option value="H">좋아요순</option>
			<option value="R">평점순</option>
			<option value="T">리뷰순</option>
		</select></label>
		<label>우선순위
		<select name="sortPriority">
			<option value="">--</option>
			<option value="H">핫딜매장우선보기</option>
			<option value="S">식사가능매장우선보기</option>
			<option value="W">웨이팅있는매장보기</option>
			<option value="R">예약가능매장보기(아직 미구현)</option>
		</select></label><br>
		<label><input name="openStore" type="checkbox" name="openStore" checked="checked"> 영업중인매장만보기</label>
		<div class="level">
		<input type="range" min="0" max="4" list="num" name="distance" />
            <datalist id="num">
                <option value="0.3" label="0.3km"/>
                <option value="0.5" label="0.5km"/>
                <option value="1" label="1km"/>
                <option value="3" label="3km"/>
                <option value="5" label="5km"/>
            </datalist>
		</div>
		<!-- 데이터중복 없에는 방향을 생각해보자....... -->
		<button onclick="search()" type="button">필터 적용하기</button>
	</form>
	<div class="list"style="width:750px;height:700px;overflow: scroll;">
	</div>
	<!-- 페이징처리 -->
	<div id="pagination">
	
	</div>
	
	</div>
	<div class="column" style="background-color:#aaa;position:sticky;top: 0;">
	<div id="map" style="width:750px;height:700px;" ></div>
	 <button onclick="moveToUser()">내위치보기</button> 
	 <button onclick="searchMap()">현재위치애서 검색하기</button>
	MAP API
	
	
	 
	</div>
 </div> 
 
<!-- 파라미터 목록~ -->
<form action="/search/" method="get" id="actionForm">
	<input type="text" name="pageNum" value="1">
	<input type="text" name="amount" value="20">
	<input type="text" name="lat" value="37.570414">
	<input type="text" name="lng" value="126.985320">
	<input type="text" name="distance" value="1">
	<input type="text" name="sortType" value="D">
	<input type="text" name="sortPriority" value="">
	<input type="text" name="openStore" value="true">
	
	
</form>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=0e7b9cd1679ce3dedf526e66a6c1a860"></script>
<!-- 리스트 불러오기 -->
<script type="text/javascript">
	//페이지가 시작된다.
let searchButton = document.getElementById("#searchButton");
let searchFilter = document.forms["searchFilter"];
const actionForm = document.forms["actionForm"];
window.onload = function(){
	
	//메인에서 넘어오는 정보들 날짜, 인원, 검색어, 해시태그
	//검색정보를 받아온다. ( 인원, 시간, 지역, 해시태그)
	//매장메인을 보여준다.
	showMain();
	
}

//searchButton에 click이벤트를 등록한다.
function search(){
		console.log("searchBtn Click");
		let distance = searchFilter["distance"];
		//button의 submit을 막는다.
		//e.preventDefault();
		//searchFilter의 내용을 actionForm에 적용시킨다.
		//정렬조건 적용
		actionForm.elements["sortType"].value = searchFilter["sortType"].value
		//우선순위 적용
		actionForm.elements["sortPriority"].value = searchFilter["sortPriority"].value;
		//검색반경 적용
		actionForm.elements["distance"].value = distance.list.options[distance.value].value;
		//오픈매장보기 적용
		actionForm.elements["openStore"].value = searchFilter["openStore"].checked;
		//paging의 pageNum을 1로 변경
		actionForm.elements["pageNum"].value = 1;

		//showMain(); 호출
		showMain();
		
	
}
	

//mainPage를 불러오는 함수
function showMain(){
	
		//ajax통신을 한다.
		getList(function(pageDTO){
			//페이지 목록을 출력한다.
			showList(pageDTO.storeList);
			//페이징 처리를 한다.
			showPaging(pageDTO);
			//지도에 마커표시를한다.
			showMap(pageDTO.storeList);
			//actionForm을 업데이트한다.
			actionFormUpdate(pageDTO.cri);
			//searchFilter를 업데이트한다.
			searchFilterUpdate(pageDTO.cri);
			//-------------------------스크롤을 맨위로 올려주는 함수필요!!!!!!!!!!!!!!!
			let scroll = document.getElementsByClassName("list");
			scroll[0].scrollTop = 0;
		})
}

//ajax로 리스트를 불러온다. cri,storeList ,paging관련 변수들이 다 넘어온다.
function getList(callback,error){
	$.ajax({
		type : 'get',
		url : '/list/',
		contentType : "application/json; charset=utf-8",
		data : createObj(actionForm),
		success : function(result, status, xhr){
			if(callback){
				callback(result);
			}
		},
		error : function(xhr, status, er){
			if(error){
				error(er);
			}
			
		}
	});
	
}
//form data를 obj로 바꿔준다.
function createObj(form){
	let obj = Object();
	for(let i = 0 ; i < form.length ; i++){
		obj[form[i].name] = form[i].value;
	}
	
	return obj;
}

//매장목록을 출력하는 함수
function showList(storeList){
	let str = "";
	let list = $(".list");
	if(storeList==null || storeList.length==0){
		//alert를 띄워준다.
		list.html("검색결과가 없습니다.");
		return;
	}
		console.log(storeList)
	for( let i=0, len=storeList.length||0; i<len; i++){
		
		str += "<div class='"+storeList[i].storeId+"'>--------------";
		str += "<h5>매장번호 : " + storeList[i].storeId + "</h5>";
		str += "<div>매장거리 : " + storeList[i].dist + "</div>";
		str += "<div>위치 : " + storeList[i].addr + "</div>";
		str += "<div>위치 : " + storeList[i].lng + "</div>";
		str += "<div>위치 : " + storeList[i].lat + "</div>";
		str += "-----------------------------------------------------";
		str += "<a href='/dealight/store?clsCd=B&storeId="+storeList[i].storeId+" '>"
		str += "<div>매장사진 : " + storeList[i].repImg + "</div>";
		str += "<div>매장이름 : " + storeList[i].storeNm + "</div></a>";
		str += "<div>좋아요 : " + storeList[i].likeTotNum + "</div>";
		str += "<div>매장평점 : " + storeList[i].avgRating +"(" +storeList[i].revwTotNum + ")</div>";
		str += "<div>매장 영업시간 : " + storeList[i].openTm + "-" + storeList[i].closeTm +"</div>";
		str += "<div>대표메뉴 : " + storeList[i].repMenu + "</div>";
		str += "<div>대기중인 인원 : </div>";
		str += "<div>오늘 예약중인 인원 : </div>";
		str += "<div>식사가능 여부 : " + storeList[i].seatStusCd + "</div>";
		if(storeList[i].htdlStusCd == "A"){
			str += "<button style='background-color:red;'>핫딜 여부</button>"; 
		}
		if(storeList[i].htdlStusCd == "P"){
			str += "<button style='background-color:blue;'>핫딜 여부</button>"; 
		}
		if(storeList[i].seatStusCd == "R"){
			str += "<button style='background-color:green;' onclick='showHtdl()'>줄서기</button>"; 
		}
		str += "<button>예약하기</button>";
		str += "<div>핫딜 상세 정보</div>";
		str += "</div>";
	}
	list.html(str);
}

//페이징 처리를 하는 함수.
function showPaging(pageDTO){
	
	let str = "";
	const paging = document.getElementById("pagination");
	
	if(pageDTO.prev){
		str += "<a href='"+(pageDTO.startPage -1)+"'>Previous </a>"
	}
	for(let i = pageDTO.startPage;i<pageDTO.endPage+1;i++){
		str += (pageDTO.cri.pageNum == i ?"<":"");
		str += "<a href='"+ i +"' >"+i+" </a> ";
		str += (pageDTO.cri.pageNum == i ?">":"");
	}
	if(pageDTO.next){
		str += "<a href='"+(pageDTO.endPage + 1)+"'>Next </a>";
	}
	
	paging.innerHTML = str;
	//a태그 관련 이벤트는 a태그가 생성될때 등록해준다.
	$("#pagination a").on("click", addPageEventHandler);
	
}

//actionForm을 업데이트를 하는 함수.
function actionFormUpdate(cri){
	//console.log(cri[actionForm.elements[0].name]);
	for(let i = 0 ; i < actionForm.length; i++){
		actionForm.elements[i].value = cri[actionForm.elements[i].name];
	}
}
//let searchFilter = document.forms["searchFilter"];
//search filter를 업데이트 하는 함수
function searchFilterUpdate(cri){
	
	for(let i = 0 ; i < searchFilter.length; i++){
		
		let name = searchFilter[i].name;
		//distance를 update
		if(name == "distance"){
			const range = searchFilter["distance"].list.options;
			for(let j = 0; j<range.length; j++){
				if(cri.distance == range[j].value){
					searchFilter[name].value = j;
					break;
				}
			}//end of for
		} else if(name == "openStore"){
			//openStore update
			searchFilter[name].checked = cri[name];
			
		} else {
			
			searchFilter.elements[i].value = cri[searchFilter.elements[i].name];

		}
	}//for
	
}

//페이지 번호클릭시 발생이벤트
function addPageEventHandler(e){
	
	e.preventDefault();
	console.log('click');
	
	//actionForm에 내용을 업데이트한다.
	//actionForm.find("input[name='pageNum']").val($(this).attr("href"));
	actionForm.elements["pageNum"].value = this.attributes["href"].value;
	//해당페이지에 해당하는 ajax통신을 요청한다.
	showMain();	

}

//-------------------------------------------------------------------------------------
//map관련 함수
		let lat = actionForm.elements["lat"]
		let lng = actionForm.elements["lng"]
		let container = document.getElementById('map');
		let options = {
			center: new kakao.maps.LatLng(lat.value, lng.value),
			level: 5
		};
		//지도생성
		let map = new kakao.maps.Map(container, options);
		
		function searchMap(){
			var latlng = map.getCenter(); 
		   
			lat.value = latlng.getLat();
			lng.value = latlng.getLng();
			
		    showMain();
		}
		//마커들을 가지고있는 배열
		let markers=[];
		function showMap(storeList){
			//기존마커 삭제
			for(let i =0; i<markers.length; i++){
				markers[i].setMap(null);
			}
			
			if(storeList.length==0 || storeList == null){
				return;				
			}
			//지도의 레벨과 범위를 정해주는 변수
			let bounds = new kakao.maps.LatLngBounds();
			//
			let positions = [];
			
			for(let i = 0; i<storeList.length; i++) {
				let storeLatLng =new kakao.maps.LatLng(storeList[i].lat, storeList[i].lng)
				var imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png"; 
				
				var marker =new kakao.maps.Marker({
			        map: map, // 마커를 표시할 지도
			        position: storeLatLng, // 마커를 표시할 위치
			        title : storeList[i].storeId, // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
			        image : new kakao.maps.MarkerImage(imageSrc, new kakao.maps.Size(24, 35))// 마커 이미지
			    });
				
			    var infoStore = new kakao.maps.InfoWindow({
			        content: "<div class='"+ storeList[i].storeId +"'>"+storeList[i].storeNm+"</div>" // 인포윈도우에 표시할 내용
			    });
			    
				addMarkerEvent(marker,infoStore,i);
			    markers.push(marker);
				bounds.extend(storeLatLng);
			}
			map.setBounds(bounds);
		}
		
		
		function addMarkerEvent(marker,infoStore,i){
			//console.log(i);
	        let store = document.getElementsByClassName("list")[0];
			
			kakao.maps.event.addListener(marker, 'mouseover', function() {

				infoStore.open(map, marker);
	            store.childNodes[i].style.backgroundColor="white";
		        
		    });
			
			kakao.maps.event.addListener(marker, 'mouseout', function() {

	            store.childNodes[i].style.backgroundColor="#bbb";
	            infoStore.close();
		        
		    });
			
			kakao.maps.event.addListener(marker, 'click', function() {
				
				let scroll = document.getElementsByClassName("list")[0];
				console.log(marker.Fb)
		        let storeId = marker.Fb
				let target = document.getElementsByClassName(storeId)[0]
				scroll.scrollTop = target.offsetTop - 300;
				

		    });

		    
		}
		
		function moveToUser() {
		    // 이동할 위도 경도 위치를 생성합니다 
		    // 현재 내위치로가 경로필요
		    var moveLatLon = new kakao.maps.LatLng(37.570414, 126.98532);
		    map.setLevel(3);
		    map.panTo(moveLatLon);            
		}        
		
		//지도위에 컨트롤러 생성하기
		map.addControl( new kakao.maps.ZoomControl(), kakao.maps.ControlPosition.TOPRIGHT);
		
		// 마커를 생성합니다
		var user = new kakao.maps.Marker({
		    position: new kakao.maps.LatLng(lat.value, lng.value)
		});

		// 마커가 지도 위에 표시되도록 설정합니다
		user.setMap(map);
		
		
</script>



</body>
</html>