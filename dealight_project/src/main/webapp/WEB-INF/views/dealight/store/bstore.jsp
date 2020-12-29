<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%@include file="../../includes/mainMenu.jsp" %>

<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic&display=swap" rel="stylesheet">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link rel="stylesheet" href="/resources/css/selectbox.css" type="text/css" />
<link rel="stylesheet" href="/resources/css/bstore.css">
<link rel="preconnect" href="https://fonts.gstatic.com">
<script src="/resources/js/Rater.js"></script>
<style type="text/css">
.panel-footer{
        display: flex;
        width: 100%;
        flex-direction: row;
        flex-wrap: wrap;
        justify-content: center;
        align-content: center;
        /* margin-top: 60px; */
        /* left: 33px; */
    }
    ul{
        display: flex;
        flex-direction: row;
    }
    li{
        /* display: flex;
        flex-direction: row; */
        list-style: none;
        /* outline: 1px solid red; */
    }
    .pagination a{
        color: black;
        padding: 8px 16px;
        border-radius: 5px;
        border: 1px solid #ddd;
        text-decoration: none;
    }
    .pagination a.active{
        background-color: #D32323;
        border-radius: 5px;
        color: white;
    }
    .pagination a:hover:not(.active){
        background-color: #ddd;
    } 
</style>
</head>
<body>
    <div class="store-container flex-column center">
        <div class="main-header">
            <div class="main-img-container">
                <c:if test="${store.imgs[0].fileName ne null}">
					<c:forEach items="${store.imgs }" var="imgs">
						<c:url value="/display" var="url"> 
							<c:param name="fileName" value="${imgs.uploadPath}/${imgs.uuid}_${imgs.fileName}" /> 
						</c:url>
 						<img class="main-img"
							src='${url }'>
 					</c:forEach>
				</c:if>
            </div>
            <!-- absolute -->
            <div class="shadow"></div>
            <div class="header-container flex-column">
                <div class="header-title flex">
                    ${store.storeNm }
                    <div class="like" data-storeid="${store.storeId }" data-like="false">
                        <i class="far fa-heart fa-xs" style="color:#f43939"></i>
                    </div>
                    <div class="header-box m4">${store.eval.likeTotNum}</div>
                </div>
                <div class="header-rate flex">
                    <div class='rating' data-rate-value='${store.eval.avgRating}'></div>
                    <div class="header-box m4">
                        ${store.eval.revwTotNum}개의 리뷰
                    </div>

                </div>
                <div class="contents-container flex">
                    <div class="contents">
                        분위기 좋은집
                    </div>
                    <div class="contents">
                        데이트하기 좋은곳
                    </div>
                    <div class="contents">
                        조용함
                    </div>
                    <div class="contents">
                        맛집
                    </div>
                </div>
                <div class="contents-container flex">
                    <div class="stus ${store.bstore.seatStusCd ne 'B'? 'green':'' }">
                    	<c:choose>
                    		<c:when test="${store.bstore.seatStusCd eq 'B'}">
		                        <i class="fas fa-store-alt fa-lg"></i>영업이 끝났습니다
                    		</c:when>
                    		<c:otherwise>
		                        <i class="fas fa-store-alt fa-lg"></i>영업중
                    		</c:otherwise>
                    	</c:choose>
                    </div>
                    <c:if test="${store.bstore.htdl ne null }">
	                    <div class="stus red">
	                        <i class="fas fa-fire fa-lg"></i>
	                        핫딜중
	                    </div>
                    </c:if>
                    <c:if test="${store.bstore.seatStusCd ne 'B'}">
	                    <div class="stus white">
		                    <c:choose>
								<c:when test="${store.bstore.seatStusCd eq 'G'}">
			                        <i class="fas fa-user-clock" style="color:green"></i> 바로 식사가능해요~
								</c:when>
								<c:when test="${store.bstore.seatStusCd eq 'R'}">
			                        <i class="fas fa-user-clock" style="color:#f43939"></i> 현재 <c:out value="${store.bstore.waits.waitTot}" />명이 대기중이에요~
								</c:when>
								<c:when test="${store.bstore.seatStusCd eq 'Y'}">
			                        <i class="fas fa-user-clock" style="color:tomato"></i> 서두르세요 자리가 얼마 안남았어~
								</c:when>
							</c:choose>
	                    </div>
                    </c:if>
                </div>
            </div>
        </div>


        <div class="main-body flex center">
            <div class="flex-column item-container">

                <div class="divider"></div>

                <div class="body-item flex-column">
                    <h4 class="item-header">
                        매장정보
                    </h4>
                    <div class="item-contents flex-column">
                        <div class="item">
                            <div class="i-title"> <i class="fas fa-store"></i> 식당소개</div>
                            <div class="i-contents">${store.bstore.storeIntro}</div>
                        </div>
                        <div class="item flex-column">
                            <div class="i-title"> <i class="fas fa-phone"></i> 전화번호</div>
                            <div class="i-contents">${store.telno}</div>
                        </div>
                    </div>
                </div>

                <div class="divider"></div>
				<c:if test="${store.bstore.menus[0].menuSeq ne null }">
	                <div class="body-item flex-column">
	                    <h4 class="item-header">
	                        메뉴소개
	                    </h4>
	                    <div class="menu-container flex">
	                    	<c:forEach items="${store.bstore.menus }" var="menus">
	                    		<c:if test="${menus.imgUrl ne null}">
			                        <div class="menu-card flex-column">
			                        	<c:url value="/display/" var="url"> 
											<c:param name="fileName" value="${menus.imgUrl}" /> 
										</c:url>
			                            <img class="menu-img" src="${url }">
			                            <div class="i-contents">
			                                <c:out value="${menus.name}" />
			                            </div>
			                            <div class="i-contents">${menus.price}</div>
			                        </div>
	                    		</c:if>
	                        </c:forEach>
	
	                    </div>
	                    <div class="menus flex">
	                    	<c:forEach items="${store.bstore.menus }" var="menus">
	                    		<c:if test="${menus.imgUrl eq null}">
			                        <div class="menu-item flex">
			                            <div class="i-contents">
			                                ${menus.name} -
			                            </div>
			                            <div class="i-contents"> ${menus.price}원</div>
			                        </div>
	                        	</c:if>
	                        </c:forEach>
	                    </div>
	                </div>
				</c:if>
                <div class="divider"></div>

                <div class="body-item flex-column">
                    <h4 class="item-header">
                        매장위치 & 영업시간
                    </h4>
                    <div class="location-container flex">
                        <div class="map" id="map" >
                        </div>
                        <div class="item-contents  flex-column">
                            <div class="item flex">
                                <div class="i-title loc center">주소</div>
                                <div class="i-contents center">${store.loc.addr}</div>
                            </div>
                            <div class="item flex">
                                <div class="i-title loc">영업시간</div>
                                <div class="i-contents center">${store.bstore.openTm} - ${store.bstore.closeTm}</div>
                            </div>
                            <div class="item flex">
                                <div class="i-title loc">브레이크타임</div>
                                <div class="i-contents center">${store.bstore.breakSttm} - ${store.bstore.breakEntm}</div>
                            </div>
                            <div class="item flex">
                                <div class="i-title loc">휴일</div>
                                <div class="i-contents center">${store.bstore.hldy}</div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="divider"></div>

                <c:if test="${store.eval.revwTotNum != 0 }"> 
	                <div class="body-item flex-column">
	                    <div class="item-header">
	                        매장 리뷰
	                    </div>
	                    <div class="revw-card">
	                        <div class="revw_wrapper">
	                        </div>
	                        <div class="panel-footer">
				            </div>
	                    </div>
	
	                </div>
                </c:if>
            </div>
            <div class="nav-container">
                <div class="nav flex-column">
                   	<c:if test="${store.bstore.htdl ne null }">
                    	<div class="nav-box htdl" id="htdlBtn">
	                        <div class="nav-header"  style="cursor: pointer;">
	                            핫딜중인 상품
	                        </div>
	                        <div class="nav-body" id="htdl" style="display:none">
	                            <div class="htdlcard js-htdl0">
	                                <div class="card-img">
	                                    <img src="/display?fileName=/${store.bstore.htdl.htdlImg }" alt="" style="width: 100%; z-index: -1;">
	                                    <div class="card-img-top"></div>
	                                    <div class="card-dc">
					                        <span> <fmt:formatNumber value="${store.bstore.htdl.dcRate}" type="percent" groupingUsed="false" /></span>
					                    </div>
					                    <div class="card-price card-afterPrice">
					                        ₩<span>${store.bstore.htdl.befPrice }</span>
					                    </div>
					                    <div class="card-price card-beforePrice">
					                        ₩<span>${store.bstore.htdl.befPrice - store.bstore.htdl.ddct }</span>
					                    </div>
					                </div>
					                <div class="card-body">
					                    <div class="card-rate">
					                        <div class="card-curpnum">
					                            <span><i class="fas fa-fire"></i></span>
					                            
					                        </div>
					                    </div>
					                    <div class="card-title">
					                        <h3>[${store.bstore.htdl.brch }] ${store.bstore.htdl.name }</h3>
					                    </div>
					                    <div class="card-menu">
					                        메뉴:&nbsp;<span>${store.bstore.htdl.setName }</span>
					                    </div>
					                    <div class="card-intro">
					                        <div style="width: 40px; align-self: flex-start;">소개 : </div><span>${store.bstore.htdl.intro }</span>
	                                    </div>
	                                </div>
		                            <button class="nav-btn " id="htdldtls" data-id="${store.bstore.htdl.htdlId }" style="background-color: #0ab3c9; border: none">
		                                상세보기
		                            </button>
		                            <button class="nav-btn" id="purchase" data-id="${store.bstore.htdl.htdlId }">
		                                구매하기
		                            </button>
	                            </div>
	                        </div>
                    	</div>
                    </c:if>

                    <div class="nav-box">
                        <div class="nav-header">
                            예약 & 줄서기
                        </div>
                        <div class="nav-tabs flex">
                            <div class="tab" id="wait">줄서기</div>
                            <div class="tab tab-selected" id="reserve">예약하기</div>
                        </div>
                        <form id="waitingForm" action="/dealight/store/wait" method="post" class="wait-tab flex-column" style="display: none;">
                            <div class="dropdown-box flex">
                                <div class="dropdown flex" id="pnum">
                                    <div class="dropdown-select flex">
                                        <span class="select">인원</span>
                                        <i class="fa fa-angle-down" style="font-size:20px"></i>
                                    </div>
                                    <div class="dropdown-list">
                                        <!-- <div class="dropdown-list__item">
                                            blabla1
                                        </div>
                                        <div class="dropdown-list__item">
                                            blablabla2
                                        </div>
                                        <div class="dropdown-list__item">
                                            blablabla3
                                        </div> -->
                                    </div>
                                </div>
                            </div>
                            <button class="nav-btn" id="waitingBtn">
                                줄서기
                            </button>
                        </form>
                        <form id="reserveForm" action="/dealight/reservation/" method="get" class="wait-tab flex-column">
                            <div class="flex">
                                <div class="dropdown-box flex">
                                    <div class="dropdown flex" id="time">
                                        <div class="dropdown-select flex">
                                            <span class="select">시간</span>
                                            <i class="fa fa-angle-down" style="font-size:20px"></i>
                                        </div>
                                        <div class="dropdown-list">
                                            <!-- <div class="dropdown-list__item">
                                                blabla1
                                            </div>
                                            <div class="dropdown-list__item">
                                                blablabla2
                                            </div>
                                            <div class="dropdown-list__item">
                                                blablabla3
                                            </div> -->
                                        </div>
                                    </div>
                                </div>
                                <div class="dropdown-box flex">
                                    <div class="dropdown flex" id="pNumRsvd">
                                        <div class="dropdown-select flex">
                                            <span class="select">인원</span>
                                            <i class="fa fa-angle-down" style="font-size:20px"></i>
                                        </div>
                                        <div class="dropdown-list">
                                            <!-- <div class="dropdown-list__item">
                                                blabla1
                                            </div>
                                            <div class="dropdown-list__item">
                                                blablabla2
                                            </div>
                                            <div class="dropdown-list__item">
                                                blablabla3
                                            </div> -->
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="dropdown-box flex">
                                <div class="dropdown flex" id="menu">
                                    <div class="dropdown-select flex">
                                        <span class="select">메뉴</span>
                                        <i class="fa fa-angle-down" style="font-size:20px"></i>
                                    </div>
                                    <div class="dropdown-list">
                                        <!-- <div class="dropdown-list__item">
                                            blabla1
                                        </div>
                                        <div class="dropdown-list__item">
                                            blablabla2
                                        </div>
                                        <div class="dropdown-list__item">
                                            blablabla3
                                        </div> -->
                                        <c:forEach items="${store.bstore.menus }" var="menu">
                                        	<div class='dropdown-list__item' data-value='${menu.menuSeq}' data-price='${menu.price }'>${menu.name }</div>
										</c:forEach>
                                    </div>
                                </div>
                            </div>
                            <div class="flex-column" >
								<div id="htdl-container"></div>
                            	<div class="flex-column" id="menus">
	                            </div>
	                            
                                <div class="divider"></div>
                                
                                <div class="flex" style="justify-content: flex-end; display:none;">
	                                <div id="total"></div>원
                                </div>

							</div>
                            <button class="nav-btn" id="reserveBtn">
                                예약하기
                            </button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
<form id="actionForm" action="#" method="get">
	<input type='hidden' name='storeId' value='<c:out value="${store.storeId }"/>' />
</form>
<%@include file="/WEB-INF/views/includes/mainFooter.jsp" %>
</body>
	<script type="text/javascript" src="/resources/js/revw.js"></script>
	
	<!-- 현중 -->
	<script type="text/javascript">
		window.onload=function(){
			
			//핫딜 중인 상품 클릭 이벤트
			$("#htdlBtn").click(function() {
				$("#htdl").slideToggle();
			});
			$("#htdldtls").on("click",function(e){
				self.location = "/dealight/hotdeal/get/" + $(this).data("id")
			})
			
			//핫딜 구매하기 버튼 클릭
			$("#purchase").on("click", function(e){
				let htdlContainer = $("#htdl-container");

				const menus = $("#menus")
	    		//요소가 이미추가되어있나 확인
	    		let seq = $(this).prev().find(".card-menu span").html();
	    		if($("#menus").find("div[data-value='" + seq +"']").length != 0){
					alert("핫딜은 하나만 구매가능합니다.")
				 	return;
	    		}
	    		console.log(seq)
	    		//처음추가되는 상황일때 총액을 보여준다.
	    		if(menus.find(".menu-container").length == 0){
	    			$("#total").parent().show();
	    		}
	    		let price = $(this).siblings(".card-img").find(".card-beforePrice span").html()
	    		console.log($(this).siblings(".card-img").find(".card-beforePrice span").html())
	    		let str = "";
	    		str += '<div class="menu-container flex" data-value="'+seq+'" data-htdl="'+ $(this).data("id") +'">'
	    		str += '<div class="menu-header center">'
	    		str += seq + '<br>(' + price + '원)</div>'
	    		str += '<div class="menu-qty flex center" data-qty="1" data-price="'+ price +'">'
	    		str += '<div class="qty center">1</div>'
	    		str += '<div class="qty-btn flex-column">'
	    		str += '</div></div>'
	    		str += '<div class="cancle center"><i class="fas fa-times" style="color: #f43939;"></i></div></div>'
	    		
	    		$("#menus").append(str);
	    		
    			//메뉴이름 수량 +,-
    			//이벤트 +,-,x 이벤트 등
	    		let target = $("#menus").find("div[data-value='" + seq +"']")
	    		
	    		//메뉴를 추가한뒤 total에 가격추가
	    		$("#total").text( (price -0) + ($("#total").text()-0))
	    		
	    		//cancle
	    		target.on("click", ".cancle", target,function(e){
	    			console.log("cancle")
	    			let menu = $(this).prev();
	    			console.log(menu.data("price")*menu.data("qty"))
	    			$("#total").text($("#total").text()-menu.data("price")*menu.data("qty"))
	    			
	    			target.remove();
	    			if(menus.find(".menu-container").length == 0){
		    			$("#total").parent().hide();
		    		}
	    		});
			})  
			
			//
			let htdlId = '<c:out value="${htdlId}"/>' || null;
			console.log(htdlId)
			if(htdlId){
				$("#purchase").trigger("click");
			}
			
			//
			let result = '<c:out value="${result }"/>';
			checkModal(result);
			function checkModal(result){
				
				if(result === "fail"){
					alert("줄서기를 할 수 없습니다..(마이페이지에서 나의 상태를 확인해주세요.)")
				}
				if(result === "success"){
					alert("줄서기를 성공하셨습니다.")
				}
			}
			
			//selectbox 
			let pNumValues = [["1명", "1"], ["2명", "2"], ["3명","3"], ["4명","4"]];
		    let timeValues = [["13:00","13:00"],["13:30", "13:30"], ["14:00", "14:00"], ["17:00","17:00"], ["17:30","17:30"]];
	    	let a = "<c:out value='${store.bstore.menus }'/>"
	    	
	    	//(클릭이벤트를 걸어줄 요소, 셀렉박스 요소값, 선택값을 추가할 form)
	    	selectEvent($("#pnum") ,pNumValues,  $("#actionForm"))
	    	selectEvent($("#time") ,timeValues,  $("#actionForm"))
	    	selectEvent($("#pNumRsvd") ,pNumValues,  $("#actionForm"))
	    	selectMenu($("#menu"),$("#resverForm"))
		   
			const actionForm = $("#actionForm")
			
			//탭에서 예약하기 클릭
			 $("#reserve").on("click", function(e){
			    	
		        $(this).addClass("tab-selected");
		        
		        $(this).prev().removeClass("tab-selected")
		        //시간 셀렉박스를 보여준다.
		        $("#waitingForm").hide();
		        $("#reserveForm").show();
		        $(".pnum .dropdown-select .select").text("인원")
		        
		        //actionForm 초기화
		        let storeIdTag = $("input[name='storeId']").clone();
		        actionForm.empty()
				actionForm.append(storeIdTag);		        
		    });
		    
	    	//탭에서 줄서기 클릭
		    $("#wait").on("click", function(e){
		    	
		        $(this).addClass("tab-selected");
		        
		        $(this).next().removeClass("tab-selected")
		        
		        //시간 셀렉바스를 숨긴다.
		        $("#reserveForm").hide();
		        $("#waitingForm").show();
		        $(".time .dropdown-select .select").text("시간")
		        $(".pNumRsvd .dropdown-select .select").text("인원")
		        
		        
		        //actionForm 초기화
		        let storeIdTag = $("input[name='storeId']").clone();
		        actionForm.empty()
				actionForm.append(storeIdTag);		        
		    });
		    
			//줄서기 클릭(form 제출)
			$("#waitingBtn").on("click", function(e) {
				
				e.preventDefault();
				
				if (actionForm.find("input[name='pnum']").length == 0 ) {
					alert("인원수를 선택해주세요");
					return;
				}
				actionForm.attr("action","/dealight/store/wait").attr("method","post")
				actionForm.submit();
			});
		    
		    let paramHtdlId = '<c:out value="${store.bstore.htdl.htdlId}"/>' || null;
			let paramUserId = '<c:out value="${userId}"/>' || null;
			let storeId = '<c:out value="${store.storeId}"/>';
			
			let isHtdlPayHistory = false;//핫딜을 구매했는지 체크
		    
		    //예약하기 버튼 클릭시(종우꺼 확인) 
		    $("#reserveBtn").on("click", function(e) {
		    	//이벤트를 막고
		    	e.preventDefault();
						    
		    	let menus = $("#menus")
		    	//로그인 확인하고
		    	if(paramUserId === null){
					alert("로그인 후 서비스를 이용해 주세요.");
					return;
				}
		    	//메뉴가 있는지 확인
		    	
		    	if (menus.find(".menu-container").length == 0) {
					alert("메뉴가 선택되지않았습니다");
					return;
				}
		    	//인원수 확인
		    	if (actionForm.find("input[name='pnum']").length == 0) {
					alert("인원수를 선택해 주세요");
					return;
				}
				
		    	//시간 확인
				if (actionForm.find("input[name='time']").length == 0) {
					alert("예약시간을 선택해 주세요");
					return;
				}
		    	
		    	//핫딜 구매 체크
				/* if(paramHtdlId != null && paramUserId != null){
					
					isHtdlPayExistChecked({userId : paramUserId, htdlId: paramHtdlId},function(result){
						
						console.log("===========hotdeal pay check: "+ result);
						isHtdlPayHistory = result;
						
						if(!isHtdlPayHistory && paramHtdlId != null){
							alert('이미 핫딜 상품을 구매하셨습니다. 감사합니다');
							return;
						}
						
					});
				} */
		    	
		    	//form에 요소들 추가  시간, 인원, 메뉴리스트, 핫딜번호, 사용자, 매장번호
		    	menus.find(".menu-container").each(function(index, item){
			    	//핫딜 메뉴가 있는지 확인
			    	if($(item).data("htdl") != null){
			    		
			    		isHtdlPayExistChecked({userId : paramUserId, htdlId: $(item).data("htdl")},function(result){
							
							console.log("===========hotdeal pay check: "+ result);
							isHtdlPayHistory = result;
							
							if(!isHtdlPayHistory && paramHtdlId != null){
								alert('이미 핫딜 상품을 구매하셨습니다. 감사합니다');
								return;
							}
							
						});
			    		
						const htdlIdInput = '<input type="hidden" name="htdlId" value="'+$(item).data("htdl") +'">';
			    		actionForm.append(htdlIdInput);
			    	}
		    			
		    		//메뉴이름
	    			const menuNm = '<input type="hidden" name=menu['+index+'].name value="'+$(item).data("value")+'">';
		    		//메뉴가격
					const menuPrice = '<input type="hidden" name=menu['+index+'].price value="'+$(item).find(".menu-qty").data("price")+'">';
		    		//메뉴수량
					const menuQty = '<input type="hidden" name=menu['+index+'].qty value="'+$(item).find(".menu-qty").data("qty")+'">';
						
			    	//메뉴추가
					actionForm.append(menuNm).append(menuPrice).append(menuQty);
		    	});
				let time = $("input[name='time']").val();
		    	let pnum = $("input[name='pnum']").val();
				console.log(storeId)
				console.log(pnum)
				console.log(time)
		    	//예약 가능여부 체크
		    	isRsvdAvailChecked({storeId: storeId, time: time, pnum: pnum}, function(data){
					console.log("reserve avail check: " + data);
					
					RsvdAvailChecked = data;
					if(RsvdAvailChecked){
						actionForm.attr("action","/dealight/reservation/")
		    			//form제출
						actionForm.submit();
					}
					else{
		    			//form 초기화 시키고 아이디 태그 추가
						let storeIdTag = $("input[name='storeId']").clone();
						let pnumTag = $("input[name='pnum']").clone();
						let timeTag = $("input[name='time']").clone();
						actionForm.empty();
						actionForm.append(storeIdTag).append(pnumTag).append(timeTag);
						alert('선택하신 인원 및 시간은 예약이 불가합니다. 죄송합니다.');
						return;
					}
				}); 
		    });//예약하기
		    function isRsvdAvailChecked(param, callback, error){
				
				let storeId = param.storeId;
				let time = param.time;
				let pnum = param.pnum;
				console.log(storeId)
				console.log(pnum)
				console.log(time)

				$.getJSON("/dealight/reservation/rsvdavailcheck/"+storeId+"/"+time+"/"+pnum+".json",
						function(data){
							 if(callback){
								callback(data);
							}
							
					}).fail(function(xhr,status, err){
						if(error){
							error();
						}
					});
			}
		}
	    
	    function selectMenu(menu,form){
	    	 const list = menu.find(".dropdown-list");
			 const selectValue =menu.find(".select");
	    	//셀렉메뉴 클릭 이벤트를 등록하고
			 menu.on('click', function(e){
		        	e.stopPropagation();
					list.css("opacity","1")
			    	
			    	if(list.css("visibility") ==="visible"){
			    		list.css("visibility","")
			    		return
			    	}
			        list.css("visibility","visible");
		        });
	    	//셀렉박스 외부 클릭시 이벤트 등록
	    	$(document).click(function(){
	        	list.css("visibility","") 
	        });
	    	//셀렉 박스 요소 클릭 이벤트
	    	 menu.find(".dropdown-list__item").on("click", function(e){
	    		//요소를 클릭하면
	    		const menus = $("#menus")
	    		//요소가 이미추가되어있나 확인
	    		let seq = $(this).text();
	    		if($("#menus").find("div[data-value='" + seq +"']").length != 0){
					alert("이미 추가하신 메뉴입니다.")
				 	return;
	    		}
	    		//처음추가되는 상황일때 총액을 보여준다.
	    		//처음추가되는 상황일때 총액을 보여준다.
	    		if(menus.find(".menu-container").length == 0){
	    			$("#total").parent().show();
	    		}
	    		
	    		//메뉴 컨테이너에 요소추가
	    		let str = "";
	    		str += '<div class="menu-container flex" data-value="'+$(this).text()+'">'
	    		str += '<div class="menu-header center">'
	    		str += $(this).text() + '<br>(' + $(this).data("price") + '원)</div>'
	    		str += '<div class="menu-qty flex center" data-qty="1" data-price="'+  $(this).data("price") +'">'
	    		str += '<div class="qty center">1</div>'
	    		str += '<div class="qty-btn flex-column">'
	    		str += '<div class="menu-btn plus flex"><i class="fas fa-plus center"></i></div>'
	    		str += '<div class="menu-btn minus flex"><i class="fas fa-minus center"></i></div>'
	    		str += '</div></div>'
	    		str += '<div class="cancle center"><i class="fas fa-times" style="color: #f43939;"></i></div></div>'
	    		
	    		$("#menus").append(str);
	    		
    			//메뉴이름 수량 +,-
    			//이벤트 +,-,x 이벤트 등
	    		let target = $("#menus").find("div[data-value='" + seq +"']")
	    		
	    		//메뉴를 추가한뒤 total에 가격추가
	    		$("#total").text( ($(this).data("price")-0) + ($("#total").text()-0))
	    		
	    		//plus
	    		console.log(target)
	    		target.on("click", ".menu-qty .qty-btn .plus", function(e){
	    			console.log("plus")
	    			let qtyTag =target.find(".menu-qty")
	    			let curQty = qtyTag.data("qty");
	    			if(curQty == 10){
	    				alert("최고 수량입니다.");
	    				return;
	    			}
	    			
	    			qtyTag.data("qty", curQty + 1);
	    			qtyTag.find(".qty").text(curQty + 1)
	    			
	    			$("#total").text( (qtyTag.data("price")-0) + ($("#total").text()-0))
	    			
	    			
	    		});
    			
    			//minus
	    		target.on("click", ".menu-qty .qty-btn .minus", function(e){
	    			console.log("minus")
	    			let qtyTag =target.find(".menu-qty")
	    			let curQty = qtyTag.data("qty");
	    			if(curQty == 1){
	    				alert("최소 수량입니다.");
	    				return;
	    			}
	    			
	    			qtyTag.data("qty", curQty - 1);
	    			qtyTag.find(".qty").text(curQty - 1)
	    			
	    			$("#total").text($("#total").text()- qtyTag.data("price"))
	    		})
	    		
	    		//cancle
	    		target.on("click", ".cancle", target,function(e){
	    			console.log("cancle")
	    			let menu = $(this).prev();
	    			console.log(menu.data("price")*menu.data("qty"))
	    			$("#total").text($("#total").text()-menu.data("price")*menu.data("qty"))
	    			
	    			target.remove();
	    			if(menus.find(".menu-container").length == 0){
		    			$("#total").parent().hide();
		    		}
	    		});
	    		
	        	
	    	 });
	        	
  	    }
	    
	    function selectEvent(dropdown, values, form){
		    const list = dropdown.find(".dropdown-list");
		    const selectValue =dropdown.find(".select");
		   	let name = dropdown.attr("id");
		   	if(name == "pNumRsvd"){
		   		name = "pnum"
		   	}
			
		    //셀렉박스 클릭 이벤트
	        dropdown.on('click', function(e){
	        	e.stopPropagation();
				list.css("opacity","1")
		    	
		    	if(list.css("visibility") ==="visible"){
		    		list.css("visibility","")
		    		return
		    	}
		        list.css("visibility","visible");
	        });
		    
		    //셀렉박스 외부 클릭시 이벤트
	        $(document).click(function(){
	        	list.css("visibility","") 
	        });
	        
	      	//select 아이템 추가
	        let str = addItem(values);
	        list.append(str);
	        
	        //셀렉박스 요소 선택 이벤트
	        dropdown.find(".dropdown-list__item").on("click", function(e){
	            selectValue.html($(this).html());
	        	
	        	let inputTag = form.find("input[name='"+name+"']");
	        	console.log(inputTag);
	        	console.log($(this).data("value"))
	        	if(inputTag.length == 0){
	        		let str =""
	        		str += "<input type='hidden' name='"+ name +"' value='" + $(this).data("value") + "'>"
	        		form.append(str);
	        		
	        		return;
	        	}
	        	//간단하게 form 요소만 변경(기존에 있어야함)
	            inputTag.val($(this).data("value"));
	        	
	        });
	        
	      	//select 아이템 추가 함수
	        function addItem(values){
	           let str ="";
	           for(let index in values){
	           		str += "<div class='dropdown-list__item' data-value='"+(values[index])[1]+"'>"+(values[index])[0]+"</div>";
	           }
	           return str;
	        		
	        }
	      	
	   	};

	//전달받은 핫딜번호를 ajax를 통해 vo 가져오기
	/* function getHtdl(param, callback, error){
		
		let htdlId = param.htdlId;
		console.log("htdlId: " + htdlId);
		
		$.getJSON("/dealight/store/htdl/get/"+htdlId+".json", function(data){
			if(callback){
				callback(data);
			}
			
		}).fail(function(xhr,status, err){
			if(error){
				error();
			}
		});
	} */
	
	/* $(document).ready(function() {
		console.log("hotdeal htdlId.........."+ paramHtdlId);
		
		let htdl = {};
		if(paramHtdlId != null){
			
			//핫딜 페이지에서 넘어온 핫딜 ajax
			getHtdl({htdlId : paramHtdlId},function(result){
				htdl = result;
				console.log(htdl);
				
				addHtdl(result);

				$("#purchase").on("click", function(e){
					let htdlContainer = $("#htdl-container");
					
					console.log(htdlContainer[0].hasChildNodes());
					if(htdlContainer[0].hasChildNodes()){
						alert("핫딜은 하나만 구매가능합니다.")
						return;
					}
					$("#htdl").slideToggle();
					addHtdl(result);
				})
			});
		}
		function addHtdl(result){
			if(result != null){
				let menusNm = [];
				
				for(let i=0,len=result.htdlDtls.length; i<len; i++){
					menusNm.push(result.htdlDtls[i].menuName);
				}
				let menusNmStr = menusNm.join(",");
				
				//선택 메뉴 배열에 담기
				menus.arrSelMenus.push({
					htdlId : result.htdlId+"htdl",
					menusNm : menusNmStr,
					menusUnprc : result.befPrice - result.ddct,
					cnt : 1
				});
				
				showHtdlForm(result);
				//핫딜 상품 삭제
				$("#htdlRemoveBtn").on("click", function(e){
					console.log("click");
					$("#div_htdl"+paramHtdlId).remove();
					menus.htdlDeSelect(result.htdlId+"htdl");
				});
			}
		}
		
		
	}); */
	
	
	
	//전달받은 핫딜 폼 그리기
	/* function showHtdlForm(htdlVO){
		
		if(htdlVO != null){
			let htdlMenuName = [];
			let htdlStr = "";
			let afterPrcie = htdlVO.befPrice - htdlVO.ddct;
			
			htdlStr += '<div id="div_htdl'+htdlVO.htdlId+'">';
			htdlStr += '<span style="color: red">핫딜 상품</span><br>';
			
			for(let i=0,len=htdlVO.htdlDtls.length; i<len; i++){
				htdlMenuName.push(htdlVO.htdlDtls[i].menuName);
			}
			
			let menuNameStr = htdlMenuName.join(",");
			
			htdlStr += '<span>'+menuNameStr+'</span><br>';
			htdlStr += '<input  type="text" style="width:100px" id="htdlPrice" name="" value="'+afterPrcie+'" readonly ="readonly"/>'
			htdlStr += '<button type="button" id="htdlRemoveBtn" class="remove" name="">X</button>';
			htdlStr += '</div>';
			
			menusTotAmt += afterPrcie;
			$('#menusTotAmtSumMsg').text("총금액");
			$('#menusTotAmt').text(menusTotAmt);
			
			$("#htdl-container").append(htdlStr);
			menus.afterProc();
			
		}
	} */
	
	
	//핫딜 구매이력 체크
	function isHtdlPayExistChecked(param, callback, error){
		
		let userId = param.userId;
		let htdlId = param.htdlId;
		
		$.getJSON("/dealight/reservation/htdlcheck/"+userId+"/"+htdlId+".json",
				function(data){
			if(callback){
				callback(data);
			}
			
		}).fail(function(xhr, status, err){
			if(error){
				error();
			}
		});
		
	}
	
	
	

	
	
</script>

<script type="text/javascript">
//좋아요
$(document).ready(function(){
	$(".like").on("click", function(e){
		e.stopPropagation();
		let storeId = $(this).data("storeid");
		let like = $(this).data("like");
		console.log(like);
		console.log(storeId)
		if(!isLogin()){
			alert("로그인을 해주세요");
			return;
		}
		//하드코딩.........제발...
		if(like === true){
			let str='<i class="far fa-heart fa-xs" style="color:#f43939"></i>';
			$(this).empty().append(str);
			$(this).data("like", false);
			removeLike({userId:"<c:out value='${userId}'/>",storeId:storeId});
			console.log($(this).next()[0].innerHTML)
			$(this).next()[0].innerHTML = $(this).next()[0].innerHTML-1
		}
		if(like === false){
			let str='<i class="fa fa-heart fa-xs" style="color:#f43939"></i>';
			$(this).empty().append(str);
			$(this).data("like", true)
			addLike({userId:"<c:out value='${userId}'/>",storeId:storeId});
			console.log($(this).next())
			$(this).next()[0].innerHTML = $(this).next()[0].innerHTML-0+1
			alert("찜목록에 추가했습니다.")
		}
		
	})
})
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
</script>
	
	<!-- 지도 -->
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=0e7b9cd1679ce3dedf526e66a6c1a860&libraries=services,clusterer,drawing"></script>
	<script>
	var lat =${store.loc.lat};
	var lng =${store.loc.lng};
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = { 
        center: new kakao.maps.LatLng(lat, lng), // 지도의 중심좌표
        level: 5 // 지도의 확대 레벨
    };

	var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

	// 마커가 표시될 위치입니다 
	var markerPosition  = new kakao.maps.LatLng(lat, lng); 

	// 마커를 생성합니다
	var marker = new kakao.maps.Marker({
    position: markerPosition
	});

	// 마커가 지도 위에 표시되도록 설정합니다
	marker.setMap(map);
	</script>
<!--리뷰 -->
	<script type="text/javascript">
		
			function getList(param, callback, error){
				var storeId = param.storeId;
				var page = param.page || 1;
				
				$.getJSON("/dealight/revws/pages/"+storeId+"/"+page+".json", function(data){
					if(callback){
						//callback(data);
						console.log(data);
						callback(data.revwCnt,data.list);
					}
				}).fail(function(xhr, status, err){
					if(error){
						error();
					}
				});
			}
		$(document).ready(function() {
			let storeIdValue = '<c:out value="${store.storeId}"/>';
			let revwUL = $(".revw_wrapper");
			let revwPageFooter = $(".panel-footer");
			showList(1);

			let pageNum = 1;

			

			function showList(page) {
				console.log("show list" + page);
				getList({storeId : storeIdValue,page : page || 1},function(revwCnt, list) {
									console.log("revwCnt: "+ revwCnt);
									console.log("list: "+ list);
									console.log(list);
									if (page == -1) {
										pageNum = Math.ceil(revwCnt / 4.0);
										showList(pageNum);
										return;
									}

									let str = "";
									if (list == null || list.length == 0) {
										return;
									}
									for(let i = 0 , len = list.length ||0; i<len; i++){
										str+="<div class='modal_top_revw'><div class='revw_reg_wrapper'><div class='revw_store_info'>"
										str+=" <div class='revw_store_name'>"+list[i].userId+"</div>"
										str+="<div class='revw_rate_wrapper'><div class='rating' data-rate-value='"+ list[i].rating+"' style='font-size: 16px'></div>";
										str+=" </div><div class='revw_rsvd_id'><span>리뷰 등록 날짜 : "+ list[i].regdate+"</span>"
										str+="</div></div>"
										str+="<div class='revw_info_wrapper'><div class='revw_cnts_textarea'>"
										str+="<textarea cols='30' row='20' name='cnts' readonly>"+ list[i].cnts+"</textarea></div>"
										str+="</div>"
										if(list[i].replyCnts !=null){
											str+="<div class='reply_wrapper'><div class='reply_item'><div class='reply_item_icon'>"
											str+="<i class='fas fa-reply'></i>"
											str+="<div class='reply_item_date'>"+list[i].replyRegDt+"</div></div>"
											str+="<div class='reply_cnts_wrapper'><div class='reply_cnts'>"
											str+=list[i].replyCnts
											str+="</div></div></div></div>"
										}	
										str	+= "</div></div>";
									}
	
									
									revwUL.html(str);
									showRevwPage(revwCnt); 
								});

			}
			revwPageFooter.on("click", "li a", function(e) {
				e.preventDefault();
				console.log("page click");

				let targetPageNum = $(this).attr("href");

				console.log("targetPageNum :" + targetPageNum);

				pageNum = targetPageNum;

				showList(pageNum);

			});
			function showRevwPage(revwCnt) {
				let endNum = Math.ceil(pageNum / 5.0) * 5;
				let startNum = endNum - 4;

				let prev = (startNum != 1);
				
				let next = false;

				if (endNum * 4 >= revwCnt) {
					endNum = Math.ceil(revwCnt / 4.0);
				}
				if (endNum * 4 < revwCnt) {
					next = true;
				}
				
				let str = '<ul class="pagination">';

				if (prev) {
					str+= '<li> <a href="'+ (startNum - 1) +'" aria-label="Previous"><span aria-hidden="true">&laquo;</span></a></li>'
				}

				for (let i = startNum; i <= endNum; i++) {
					var active= pageNum ==i?"active":"";
					str += '<li><a href="' + i + '" '+ (pageNum ==i?'class="active"':'') + '>'+i+'</a></li>'
				}
				if (next) {
					str += "<li><a href='" + (endNum + 1)
							+ "'>Next</a></li>";
					str +='<a href="'+(endNum + 1)+'" aria-label="Next"><span aria-hidden="true">&raquo;</span></a></li>'
				}
				str += "</ul>";
				console.log(str);
				revwPageFooter.html(str);

			}

		});
		$(".rating").rate({
		    max_value: 5,
		    step_size: 0.5,
		    initial_value: 3,
		    selected_symbol_type: 'utf8_star', // Must be a key from symbols
		    cursor: 'default',
		    readonly: true,
		});
	</script>
</body>
</html>