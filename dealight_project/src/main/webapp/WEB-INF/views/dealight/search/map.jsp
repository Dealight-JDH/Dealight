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
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic&display=swap" rel="stylesheet">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link rel="stylesheet" href="/resources/css/map.css" type ="text/css" />
<link rel="preconnect" href="https://fonts.gstatic.com">
<script src="/resources/js/Rater.js"></script>
</head>
<body>
    <div class="map-main-container">

        <div class="child-left left-container flex-column">
            <div class="child-full search-container flex-column">
                <div class="search-header-container flex">
                    <div class="search-header">
                        내 주변 음식점
                    </div>
                    <div class="selectbox flex">
                        <div class="label center">정렬 : </div>
                        <div class="custom_select center">
                            <select name="sortType" id="sortType">
                                <option value="D">거리순</option>
                                <option value="H">좋아요순</option>
                                <option value="R">평점순</option>
                                <option value="T">리뷰순</option>
                            </select>
                        </div>
                    </div>
                </div>
                <div class="filter-container">
                    <div class="searchtype-container">
                        <div class="searchtype flex m-r16">
                            <div class="p-l16">
                                줄서기
                            </div>
                            <div class="searchtype-img">
                                <i class='fas fa-user-plus fa-4x' style='color:#f43939;'></i>
                            </div>
                        </div>
                        <div class="searchtype flex">
                            <div class="p-l16">
                                예약하기
                            </div>
                            <div class="searchtype-img">
                                <i class='fas fa-utensils fa-4x' style='color:#f43939; padding-left: 20px;'></i>
                            </div>
                        </div>
                    </div>
                    <div class="m-b16">

                        <div class="filter flex">
                            <div class="filter-item filter-select"  id="filter">
                                <i class="fas fa-sliders-h"></i> Filter
                            </div>
                            <div class="filter-item filter-select" name="openStore" data-select="true">
                                <i class="fas fa-store-alt"></i> 영업중인매장
                            </div>
                        </div>

                        <form id="searchFilter" action="#" class="filter-items flex-column"style="display:none;">
                            <div class="column flex">
                                <div class="selectbox flex">
                                    <div class="label center">우선순위 : </div>
                                    <div class="custom_select center">
                                        <select name="sortPriority">
                                            <option value="">--</option>
                                            <option value="H">핫딜매장우선보기</option>
                                            <option value="S">식사가능매장우선보기</option>
                                            <option value="W">웨이팅있는매장보기</option>
                                            <option value="R">예약가능매장보기(아직 미구현)</option>
                                        </select>
                                    </div>
                                </div>
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
                            </div>
                            <div class="column flex start">
                                <div class="filter-item">
                                    분위기 있는 곳
                                </div>
                                <div class="filter-item">
                                    밥먹는곳
                                </div>
                                <div class="filter-item filter-select">
                                    모임하기 좋은곳
                                </div>
                            </div>
                            <div class="cloumn flex end">
                                <button class="btn confirm" type="button" onclick="search()">
                                    적용하기
                                </button>
                                <button class="btn cancle" type="button" onclick="closeFilter()">
                                    닫기
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
                <form>
                    <div class="search-bar flex">
                        <div class="reserve-input flex">
                            <div class="selectbox flex">
                                <div class="custom_select center">
                                    <select>
                                        <option>13시30분</option>
                                        <option>14:00</option>
                                        <option>14:30</option>
                                        <option>리뷰순</option>
                                    </select>
                                </div>
                            </div>
                            <div class="selectbox flex">
                                <div class="custom_select center">
                                    <select>
                                        <option>2명</option>
                                        <option>3명</option>
                                        <option>평점순</option>
                                        <option>리뷰순</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <button class="btn-big">
                            검색하기
                        </button>
                    </div>
                    </form>
            </div>
            <div class="child-full" id="storeList">
                
            </div>
            <div id="pagination">
			</div>
        </div>
        <div class="child-right">
            <div class="map-container">
                <diV>
                    <div>
                        <div class="map" id="map">
                            지도화면
                        </div>
						<button onclick="moveToUser()">내위치보기</button> 
	 					<button onclick="searchMap()">현재위치애서 검색하기</button>
                    </div>
                </diV>
            </div>
        </div>
    </div>
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
</body>

<!-- 리스트 불러오기 -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=0e7b9cd1679ce3dedf526e66a6c1a860"></script>
<script type="text/javascript">

	//ajax로 리스트를 불러온다. cri, storeList ,paging관련 변수들이 다 넘어온다.
	//많아진다면 모듈로 뺴자
	function getList(callback,error){
		$.ajax({
			type : 'get',
			url : '/dealight/getlist',
			contentType : "application/json; charset=utf-8",
			data : getObjToForm(actionForm),
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
	function getObjToForm(form){
		let obj = Object();
		for(let i = 0 ; i < form.length ; i++){
			obj[form[i].name] = form[i].value;
		}
		
		return obj;
	}
	
	//페이지가 시작된다.
	const searchButton = document.getElementById("#searchButton");
	const searchFilter = document.forms["searchFilter"];
	const list = document.getElementById("storeList");
	let actionForm = document.forms["actionForm"];
	let lat = actionForm.elements["lat"]
	let lng = actionForm.elements["lng"]
	let userLatLng = new kakao.maps.LatLng(lat.value, lng.value)
	let map = "";
	let markers=[];
	
	window.onload = function(){
		//지도생성
		initMap();
		console.log("init")
		//메인에서 넘어오는 정보들 날짜, 인원, 검색어, 해시태그
		//검색정보를 받아온다. ( 인원, 시간, 지역, 해시태그)
		//매장메인을 보여준다.
		showMain();
		
		 //filter 토글버튼 이벤트
	    $("#filter").on("click", function(e){
	        console.log("click");
	        $(".filter-items").toggle('slow');
	    });

	    //아이템 클릭 이벤트
	    $(".filter-items .filter-item").on("click",function(e){
	        if($(this).attr("id")){
	            return;
	        }
	        if($(this).data("select")===true){
	            $(this).removeClass("filter-select");
	            $(this).data("select", false)
	        }else{
	            $(this).addClass("filter-select");
	            $(this).data("select", true)
	        }

	    });
	    $("#sortType").on("change", function(e){
			actionForm.elements["sortType"].value = $(this).val()
			showMain();
	    })
	}
	
	function initMap(){
		let container = document.getElementById('map');
		let options = { center: userLatLng, level: 5 };
		map = new kakao.maps.Map(container, options);
		
		
		//지도위에 컨트롤러 생성하기
		map.addControl( new kakao.maps.ZoomControl(), kakao.maps.ControlPosition.TOPRIGHT);
		
		// 마커를 생성합니다
		let user = new kakao.maps.Marker({
		    position: userLatLng
		});
		
		// 마커가 지도 위에 표시되도록 설정합니다
		user.setMap(map);
	}
	
	//searchButton에 click이벤트를 등록한다.
	function search(){
			let distance = searchFilter["distance"];
			console.log("searchBtn Click");
			
			//searchFilter의 내용을 actionForm에 적용시킨다.
			//정렬조건 적용
			//actionForm.elements["sortType"].value = searchFilter["sortType"].value
			//오픈매장보기 적용
			//actionForm.elements["openStore"].value = searchFilter["openStore"].checked;
			//우선순위 적용
			actionForm.elements["sortPriority"].value = searchFilter["sortPriority"].value;
			//검색반경 적용
			actionForm.elements["distance"].value = distance.list.options[distance.value].value;
			//paging의 pageNum을 1로 변경
			actionForm.elements["pageNum"].value = 1;
	
			//showMain(); 호출
			showMain();
	}
	
	function searchMap(){
		var latlng = map.getCenter(); 
	   	console.log()
		lat.value = latlng.getLat();
		lng.value = latlng.getLng();
		
	    showMain();
	    
	}
		
			//ajax통신을 한다.데이터만 받아오고 끝낸다.
			//확인하고 
			//처리하고 
			//하나씩 처리
			//분리시킨다.
			//문서를 계속 업데이트하면서 고쳐라
			//최대한 쪼개라 다시합쳐라!!!!! 급하게하는 습관없에자
			
			
	//mainPage를 불러오는 함수
	function showMain(){
		//let scroll = document.getElementById("storeList");
		//scroll.scrollTop = 0;
		console.log("showMain")
		//입력 작업 출력(응집) 
		getList(function(pageDTO){
			//페이지 목록을 출력한다.
			showList(pageDTO);
			
			//지도에 마커표시를한다.
			showMap(pageDTO.storeList);
		});
		
	}
	
	function showMap(storeList){
		
		//기존마커 삭제
		deleteMaker();
		//검색결과 체크
		if(storeList.length==0 || storeList == null){
			return;				
		}
		//지도의 레벨과 범위를 정해주는 변수
		//이거 잘 생각해보자 뭔가 어색해 이방법.......(모든 마커가 보이게 하려고 하는 방법인데 뭔가 더 좋은 방법이 없을까??)
		const bounds = new kakao.maps.LatLngBounds();
		const imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png"; 
		
		let positions = [];
		
		for(let i = 0; i<storeList.length; i++) {
			let storeLatLng =new kakao.maps.LatLng(storeList[i].lat, storeList[i].lng)
			
			let marker =new kakao.maps.Marker({
		        map: map, // 마커를 표시할 지도
		        position: storeLatLng, // 마커를 표시할 위치
		        title : storeList[i].storeId, // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
		        image : new kakao.maps.MarkerImage(imageSrc, new kakao.maps.Size(24, 35))// 마커 이미지
		    });
			
		    let infoStore = new kakao.maps.InfoWindow({
		        content: "<div class='"+ storeList[i].storeId +"'>"+storeList[i].storeNm+"</div>" // 인포윈도우에 표시할 내용
		    });
		    
			addMarkerEvent(marker,infoStore,i);
			
		    markers.push(marker);
		    
		    //지도범위를 설정해주는 메서드
			bounds.extend(storeLatLng);
			bounds.extend(getOpposition(storeLatLng));
		}
		
		map.setBounds(bounds);
		
	}
			
	//매장목록을 출력하는 함수
	function showList(pageDTO){
		const storeList = pageDTO.storeList;
		let str = "";
		if(storeList==null || storeList.length==0){
			list.innerHTML = "검색결과가 없습니다."
			return;
		}
		//console.log(storeList)
		for( let i=0, len=storeList.length||0; i<len; i++){
			str += "<a href='/dealight/store/"+storeList[i].storeId+" '>"
			str +='<div class="store-card flex">'
			str +='<div class="img-container">'
			str +='<img src="https://via.placeholder.com/200x200" ></div>'
			str +='<div class="deatial-container flex-column" >'
			str +='<div class="search-header flex">'
			str += storeList[i].storeNm
			str +='<div  class="like" data-storeid="'+storeList[i].storeId+'" data-like="false">'
			str +='<i class="fas fa-heart" style="color:red"></i>'
			str +='</div><span class="f14">('+storeList[i].likeTotNum+')</span></div>'
			str +='<div class="flex rating-box">'
			str +='<div class="rating" data-rate-value="'+ storeList[i].avgRating +'"></div>'
			str +='<div class="f14">'+storeList[i].revwTotNum+'('+storeList[i].avgRating+')</div></div>'
			str +='<div class="f14 m-tb2">'
			str +='<i class="fas fa-store-alt"></i>'
			str +='<b>매장영업시간 : </b>'+ storeList[i].openTm + "~" + storeList[i].closeTm + '</div>'
			str +='<div class="f14 m-tb2">'
			str +='<i class="fas fa-utensils"></i>'
			str +='<b>대표메뉴 : </b>'+ storeList[i].repMenu + "</div>";
			str +='<div class="m-tb2">'
			if(storeList[i].seatStusCd == 'R'){
				str +='<i class="fas fa-user-clock" style="color:red"></i> 현재 2명이 대기중이에요~</div>'
			}
			if(storeList[i].seatStusCd == 'Y'){
				str +='<i class="fas fa-drumstick-bite" style="color:coral"></i> 서두르세요 자리가 얼마안남았어요~</div>'
			}
			if(storeList[i].seatStusCd == 'G'){
				str +='<i class="fas fa-drumstick-bite" style="color:green"></i> 바로 식사가능해요~</div>'
			}
			str +='<div class="btns felx">'
			if(storeList[i].htdlStusCd == "A"){
				str += '<button class="btn-big">핫딜중</button>'; 
			}
			if(storeList[i].htdlStusCd == "P"){
				str += '<button class="btn-big">핫딜예정</button>'
			}
			if(storeList[i].seatStusCd == "R"){
				str += '<button class="btn-big">줄서기</button>' 
			}
			str += '</div></div></div></div></a>'
			
		}
		list.innerHTML = str;
		
		$(".like").on("click", function(e){
			let storeId = $(this).data("storeid");
			let like = $(this).data("like");
			console.log(like);
			console.log(storeId)
			if(!isLogin()){
				alert("로그인을 해주세요");
				return;
			}
			
			if(like === true){
				let str="<i class='far fa-heart fa-lg' style='color:red;'/></i>";
				$(this).empty().append(str);
				$(this).data("like", false);
				removeLike({userId:"<c:out value='${userId}'/>",storeId:storeId});
			}
			if(like === false){
				let str="<i class='fas fa-heart fa-lg' style='color:red;'/></i>";
				$(this).empty().append(str);
				$(this).data("like", true)
				addLike({userId:"<c:out value='${userId}'/>",storeId:storeId});
				alert("찜목록에 추가했습니다.")
			}
			
		})
		//페이징처리
		showPaging(pageDTO)
	}
	function isLogin(){
		let userId = "<c:out value='${userId}'/>"
		if(userId ==='' || userId === null){
			return false
		}
		return true;
	}
	
	
	
	function addLike(params,callback,error){
    	let storeId = params.storeId,
    		userId = params.userId;
        $.ajax({
            type:'post',
            url:'/dealight/mypage/like/add/'+userId+'/'+storeId,
            contentType : "application/json",
            success : function(result, status, xhr) {
                if(callback) {
                    callback(result);
                }
            },
            error : function(xhr, status, er) {
                if(error) {
                    error(er);
                }               
            }
        });
		
	}
	
	function removeLike(params,callback,error) {
    	
    	let storeId = params.storeId,
    		userId = params.userId;
    	
        $.ajax({
            type:'delete',
            url:'/dealight/mypage/like/remove/'+userId+'/'+storeId,
            data : {'userId' : userId, 'storeId':storeId},
            contentType : "application/json",
            success : function(result, status, xhr) {
                if(callback) {
                    callback(result);
                }
            },
            error : function(xhr, status, er) {
                if(error) {
                    error(er);
                }               
            }
        });
        
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
	
	//페이지 번호클릭시 발생이벤트
	function addPageEventHandler(e){
		
		e.preventDefault();
		//actionForm에 내용을 업데이트한다.
		actionForm.elements["pageNum"].value = this.attributes["href"].value;
		//해당페이지에 해당하는 ajax통신을 요청한다.
		showMain();	
	
	}
	
	//마커들을 가지고있는 배열
	function deleteMaker(){
		for(let i =0; i<markers.length; i++){
			markers[i].setMap(null)
		}
	}	
	
	
	function getOpposition(storeLatLng){
		const diffLat = lat.value - storeLatLng.getLat();
		const diffLng = lng.value - storeLatLng.getLng();
		
		return new kakao.maps.LatLng(Number(lat.value) + diffLat, Number(lng.value) + diffLng);
	}
	
	function addMarkerEvent(marker,infoStore,i){
		//console.log(i);
	    //let store = document.getElementById("storeList");
		
		kakao.maps.event.addListener(marker, 'mouseover', function() {
	
			infoStore.open(map, marker);
	           list.childNodes[i].style.backgroundColor="white";
	        
	    });
		
		kakao.maps.event.addListener(marker, 'mouseout', function() {
	
	           list.childNodes[i].style.backgroundColor="#bbb";
	           infoStore.close();
	        
	    });
		
		kakao.maps.event.addListener(marker, 'click', function() {
			
			//console.log(marker.Fb)
	        let storeId = marker.Fb
			let target = document.getElementsByClassName(storeId)[0]
			list.scrollTop = target.offsetTop - 300;
			
	
	    });
	
	    
	}
	
	function moveToUser() {
	    // 이동할 위도 경도 위치를 생성합니다 
	    // 현재 내위치로가 경로필요
	    var moveLatLon = new kakao.maps.LatLng(37.570414, 126.98532);
	    map.setLevel(3);
	    map.panTo(moveLatLon);            
	}        
	
	

$(".rating").rate({
    max_value: 5,
    step_size: 0.5,
    initial_value: 3,
    selected_symbol_type: 'utf8_star', // Must be a key from symbols
    cursor: 'default',
    readonly: true,
});
function closeFilter(){
    //처음 필터조건을 기억하고 닫기버튼을 누르면 초기조건으로 되돌리고 닫아야한다.
    $(".filter-items").hide('slow');

}
</script>
</body>
</html>