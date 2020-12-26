<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<!-- 다울 -->
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic&display=swap" rel="stylesheet">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link rel="stylesheet" href="/resources/css/selectbox.css" type="text/css" />
<link rel="stylesheet" href="/resources/css/bstore.css">
<link rel="stylesheet" href="/resources/css/store.css">
<link rel="stylesheet" href="/resources/css/tab.css">
<link rel="preconnect" href="https://fonts.gstatic.com">
<script src="/resources/js/Rater.js"></script>
</head>
<body>
    <div class="store-container flex-column center">
        <div class="main-header">
            <div class="main-img-container">
                <c:if test="${store.imgs[0].fileName ne null}">
					<c:forEach items="${store.imgs }" var="imgs">
						<img class="main-img"
							src='/resources/images/store/<c:out value="${imgs.fileName}" />'>
					</c:forEach>
				</c:if>
            </div>
            <!-- absolute -->
            <div class="shadow"></div>
            <div class="header-container flex-column">
                <div class="header-title flex">
                    ${store.storeNm }
                    <div class="like" data-storeid="'+storeList[i].storeId+'" data-like="false">
                        <i class="fa fa-heart fa-xs" style="color:#f43939"></i>
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
                        분위기 좋은집
                    </div>
                    <div class="contents">
                        분위기 좋은집
                    </div>
                    <div class="contents">
                        분위기 좋은집
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
                            <div class="i-title"><i class="fas fa-store"></i> 식당소개</div>
                            <div class="i-contents">${store.bstore.storeIntro}</div>
                        </div>
                        <div class="item flex-column">
                            <div class="i-title"><i class="fas fa-phone-square-alt"></i> 전화번호</div>
                            <div class="i-contents">${store.telno}</div>
                        </div>
                    </div>
                </div>

                <div class="divider"></div>

                <div class="body-item flex-column">
                    <h4 class="item-header">
                        메뉴소개
                    </h4>
                    <div class="menu-container flex">
                    	<c:forEach items="${store.bstore.menus }" var="menus">
                    		<c:if test="${menus.imgUrl ne null}">
		                        <div class="menu-card flex-column">
		                            <img class="menu-img" src="https://via.placeholder.com/200x200">
		                            ${menus.imgUrl}
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

                <div class="body-item flex-column">
                    <div class="item-header">
                        매장 리뷰
                    </div>
                    <div class="revw-card">
                        <%-- <c:if test="${not empty writtenList}"> --%>
                        <div class="revw_wrapper">
                            <%-- <c:forEach items="${writtenList}" var="revw"> --%>
                            <div class='modal_top_revw'>
                                <div class='revw_reg_wrapper'>
                                    <div class='revw_store_info'>
                                        <div class='revw_store_name'>아이디</div>
                                        <div class='revw_rate_wrapper'>
                                            <div class='rating' data-rate-value='"+revw.rating+"'
                                                style="font-size: 16px"></div>
                                        </div>
                                        <div class='revw_rsvd_id'>
                                            <span>리뷰 등록 날짜 : ${revw.regdate}</span>
                                        </div>
                                    </div>
                                    <div class='revw_info_wrapper' action='/dealight/mypage/review/register' method='post'>

                                        <div class='revw_cnts_textarea'>
                                            <textarea cols='30' row='20' name='cnts' readonly>${revw.cnts}</textarea>
                                        </div>
                                        <input name='rating' id='rate_input' hidden>
                                        <%-- <c:if test="${revw.imgs != null}">
														<div class='revw_img_box'>
															<div class='revw_img_wrapper'>
														<c:forEach items="${revw.imgs}" var="img">
															<c:if test="${img.fileName != null}">
																<img src=''>
                                                            </c:if>
                                                        </div>
														</c:forEach>  --%>
                                    </div>
                                   <%--  </c:if> --%>
                                    <%-- <c:if test="${revw.replyCnts != null}"> --%>
                                    <div class='reply_wrapper'>
                                        <div class='reply_item'>
                                            <div class='reply_item_icon'>
                                                <i class='fas fa-reply'></i>
                                                <div class='reply_item_name'>${revw.storeNm}</div>
                                                <div class='reply_item_date'>${revw.replyRegDt}</div>
                                            </div>
                                            <div class='reply_cnts_wrapper'>
                                                <div class='reply_cnts'>
                                                    ${revw.replyCnts}
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <%-- </c:if> --%>
                                </div>
                            </div>
                            <%-- </c:forEach> --%>
                        </div>
                    </div>

                </div>
            </div>
            <div class="nav-container">
                <div class="nav flex-column">
                    <div class="nav-box htdl">
                    	<c:if test="${store.bstore.htdl ne null }">
	                        <div class="nav-header" id="htdlBtn">
	                            핫딜중인 상품
	                        </div>
	                        <div class="nav-body" id="htdl" style="display:none">
	                            <div class="htdlcard js-htdl0">
	                                <div class="card-img">
	                                    <img src="1.jpg" alt="" style="width: 100%; z-index: -1;">
	                                    <div class="card-img-top"></div>
	                                    <div class="card-dc">
					                        <span> <fmt:formatNumber value="${store.bstore.htdl.dcRate}" type="percent" groupingUsed="false" /></span>
					                    </div>
					                    <div class="card-price card-afterPrice">
					                        <span>₩${store.bstore.htdl.befPrice }</span>
					                    </div>
					                    <div class="card-price card-beforePrice">
					                        <span>₩${store.bstore.htdl.befPrice - store.bstore.htdl.ddct }</span>
					                    </div>
					                </div>
					                <div class="card-body">
					                    <div class="card-rate">
					                        <div class="card-rating" data-rate-value=2></div>
					                        <div class="card-curpnum">
					                            <span><i class="fas fa-fire"></i></span>
					                            
					                        </div>
					                    </div>
					                    <div class="card-title">
					                        <h3>[${store.bstore.htdl.brch }] ${store.bstore.htdl.name }</h3>
					                    </div>
					                    <div class="card-menu">
					                        메뉴:&nbsp;<span>디저트 콤보 1인 세트</span>
					                    </div>
					                    <div class="card-intro">
					                        <div style="width: 40px; align-self: flex-start;">소개 : </div><span>${store.bstore.htdl.intro }</span>
	                                    </div>
	                                </div>
	                            <button class="nav-btn" id="purchase">
	                                구매하기
	                            </button>
	                            </div>
	                        </div>
                        </c:if>
                    </div>

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
                                <div class="dropdown flex" id="pNum">
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
                            <button class="nav-btn" type="submit">
                                줄서기
                            </button>
                            <input type='hidden' name='storeId'value='<c:out value="${store.storeId }"/>' />
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
                            	<div class="flex-column" id="menus">
	                                <div class="menu-container flex">
	                                    <div class="menu-header center">
	                                        만두굿<br>
	                                        (18000원)                        
	                                    </div>
	                                    <div class="menu-qty flex center">
	                                        <div class="qty center">
	                                            9
	                                        </div>
	                                        <div class="qty-btn flex-column">
	                                            <div class="menu-btn flex">
	                                                <i class="fas fa-plus center"></i>
	                                            </div>
	                                            <div class="menu-btn flex">
	                                                <i class="fas fa-minus center"></i>
	                                            </div>
	                                        </div>
	                                    </div>
	                                    <div class="cancle center">
	                                        <i class="fas fa-times" style="color: #f43939;"></i>
	                                    </div>
	                                </div>
	                                <div class="menu-container flex">
	                                    <div class="menu-header center">
	                                        핫딜 상품 <br>
	                                        2인세트
	                                        만두, 깡통<br>
	                                        (18000원)
	                                    </div>
	                                    <div class="menu-qty flex center">
	                                        <div class="qty center">
	                                            9
	                                        </div>
	                                        <div class="qty-btn flex-column">
	                                            <div class="menu-btn flex">
	                                                <i class="fas fa-plus center"></i>
	                                            </div>
	                                            <div class="menu-btn flex">
	                                                <i class="fas fa-minus center"></i>
	                                            </div>
	                                        </div>
	                                    </div>
	                                    <div class="cancle center">
	                                        <i class="fas fa-times" style="color: #f43939;"></i>
	                                    </div>
	                                </div>
	                            </div>
                                <div class="divider"></div>
                                <div class="flex" style="justify-content: flex-end">
	                                <div id="total">
	                                    
	                                </div>
	                                원
                                </div>
                                

								<div id="htdl-container"></div>
							</div>
                            <button class="nav-btn" type="submit">
                                예약하기
                            </button>
                            <input type='hidden' name='storeId'value='<c:out value="${store.storeId }"/>' />
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

</body>
	<div class="container">

		<div class="left">
			<div class="column">
				<!-- 상태코드에 따라 동그라미색 반영 이모지 추가 필요/핫딜 이모지&처리코드 필요 -->
				<c:choose>
					<c:when test="${store.bstore.seatStusCd eq 'O'}">
						<span> 주황</span>
					</c:when>
					<c:when test="${store.bstore.seatStusCd eq 'G'}">
						<span> 초록</span>
					</c:when>
					<c:when test="${store.bstore.seatStusCd eq 'R'}">
						<span> 빨강</span>
					</c:when>
					<c:when test="${store.bstore.seatStusCd eq 'Y'}">
						<span> 노랑</span>
					</c:when>
				</c:choose>
				<!-- 매장이름 -->
				<h1 style="display: inline-block">${store.storeNm }</h1>
				<!-- 좋아요 버튼 이모지 추가필요-->
				<button type="button">하트</button>
				<c:choose>
					<c:when test="${store.bstore.seatStusCd eq 'B'}">
						<span style="border-style:solid; padding:5px; color:black" >영업종료</span>
					</c:when>
					<c:when test="${store.bstore.seatStusCd ne 'B'}">
						<span style="border-style:solid; padding:5px; color:red;" >영업중</span>
					</c:when>
				</c:choose>
				<br>
				<!-- 웨이팅중인 고객수 -->
					<h4>
						<c:out value="${store.bstore.waits.waitTot}" />
						명이 웨이팅 중 입니다!
					</h4>
				<br>

				<div class="img">

					<!--대표이미지 추가해야할수도?-->
					<c:if test="${store.imgs[0].fileName ne null}">
						<c:forEach items="${store.imgs }" var="imgs">
							<img class="imgCon"
								src='/resources/images/store/<c:out value="${imgs.fileName}" />'>
						</c:forEach>
					</c:if>
				</div>
				<p>평균평점 : ${store.eval.avgRating} 리뷰 : ${store.eval.revwTotNum}
					좋아요 : ${store.eval.likeTotNum}</p>
			</div>
			<!--  미구현 -->
			<div class="column">
				<h1>예약 가능상태</h1>
			</div>
			<div class="column">
				<h1>매장정보</h1>
				<c:if test="${store.bstore.storeIntro ne null}">
					<p>${store.bstore.storeIntro}</p>
				</c:if>
				<p>${store.loc.addr}</p>
				<p>${store.telno}</p>

				<c:if test="${store.bstore.openTm ne null}">
					<p>영업시간 : ${store.bstore.openTm} - ${store.bstore.closeTm}</p>
				</c:if>
				<c:if test="${store.bstore.breakSttm ne null}">
					<p>브레이크 타임 : ${store.bstore.breakSttm} - ${store.bstore.breakEntm}</p>
				</c:if>
				<c:if test="${store.bstore.lastOrdTm ne null}">
					<p>라스트오더 : ${store.bstore.lastOrdTm}</p>
				</c:if>
				<c:if test="${store.bstore.hldy ne null}">
					<p>휴무일 : ${store.bstore.hldy}</p>
				</c:if>
			</div>
			<div class="column">
				<h1>메뉴</h1>
				<c:forEach items="${store.bstore.menus }" var="menus">
					<p>
						<c:out value="${menus.imgUrl}" />
						<c:out value="${menus.name}" />
						<c:out value="${menus.price}" />
					</p>

				</c:forEach>

			</div>

			<div class="column">
				<h1>리뷰</h1>
				<div class='revwColumn'></div>
				<div class="revwFooter"></div>
			</div>

			<div class="column">
				<h1>지도</h1>
				<div id="map" style="width: 100%; height: 350px; margin-bottom:50px;"></div>
			</div>

			<!-- 미구현 -->
			<div class="column">
				<h1>주변가게</h1>
				<div class="conNearByColumn">

					<c:forEach items="${nearbyStore}" var="nearbyStore">
						<div class="conNearBy">
							<img class="imgNearBy"
								src='/resources/images/store/<c:out value="${nearbyStore.repImg}" />'>
							${nearbyStore.storeNm} ${nearbyStore.avgRating}
							${nearbyStore.revwTotNum} ${nearbyStore.likeTotNum}<br>
							${nearbyStore.addr}
						</div>

					</c:forEach>

				</div>

			</div>
		
		</div>

		<div class="right">
			<div class="sticky">
				<c:if test="${store.bstore.htdl ne null }">
					<div class="htdlBtnCon">
						<button id='htdlBtn'>지금 진행중인 핫딜!</button>
					</div>	
					<div class="htdlCon">
						
						<div id='htdl'>
							<button id="purchase">구매하기</button>
							${store.bstore.htdl }
						</div>
					</div>
				</c:if> 
			<section class="tabWrapper">
				<ul class="tabs">
					<li class="active">예약</li>
					<li>줄서기</li>
				</ul>

				<ul class="tab__content">

					<li class="active">
						<div class="content__wrapper">
							<form id="reserveForm" action="/dealight/reservation/"
								method="get">
								<input type='hidden' name='storeId'value='<c:out value="${store.storeId }"/>' />

								<!-- <input type="hidden" id="selMenu" name="selMenu"> -->
								<div class="row">
									<select id="time" required="required">
										<option value="">시간</option>
										<option value="13:30">13:30</option>
										<option value="14:00">14:00</option>
										<option value="14:30">14:30</option>
									</select> 
									<select id="num" required="required">
										<option value="">인원수</option>
										<option value="1">1</option>
										<option value="2">2</option>
										<option value="3">3</option>
										<option value="4">4</option>
									</select>
								</div>
								<div class="row">
									<select id="menu">
										<option value="">메뉴</option>
										
										<c:forEach items="${store.bstore.menus }" var="menus">
											<option value="${menus.menuSeq}">${menus.name }</option>
										</c:forEach>
									</select> <input type="button" id="btnAddMenus" value="추가"></input>

								</div>
								<div id="container"></div><br>
								<div id="htdl-container"></div>
								
								<span id="menusTotAmtSumMsg"></span> <span id="menusTotAmt" name="totAmt" value="0"></span>
								<button class ="tabWrapperBtn" type="submit">예약하기</button>
							</form>
						</div>
						
						
					</li>
						
					<li>
						<div class="content__wrapper">
							<form id="waitingForm" action="/dealight/store/wait" method="post">
								<div class="row">
									 <select id="waitingNum" required="required">
										<option value="">인원수</option>
										<option value="1">1</option>
										<option value="2">2</option>
										<option value="3">3</option>
										<option value="4">4</option>
									</select>
								</div>
								<input type='hidden' name='storeId' value='<c:out value="${store.storeId }"/>' />
								<button class ="tabWrapperBtn" type="submit">줄서기</button>
							</form>
						</div>
					</li>

				</ul>
					
				<form id='reserveFormObj' action="/dealight/reservation/" method="get">
					<input type='hidden' name='storeId' value='<c:out value="${store.storeId }"/>' />
				</form>
			</section>
		</div>
	</div>
	
	<script type="text/javascript" src="/resources/js/revw.js"></script>
	
	<!-- 현중 -->
	<script type="text/javascript">
		window.onload=function(){
			
			//핫딜 중인 상품 클릭 이벤트
			$("#htdlBtn").click(function() {
				$("#htdl").slideToggle();
			});
			
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
		    let timeValues = [["",""],["핫딜매장우선보기", "H"], ["식사가능매장우선보기", "S"], ["웨이팅있는매장보기","W"], ["예약가능매장보기","R"]];
	    	let a = "<c:out value='${store.bstore.menus }'/>"
	    	console.log(a);
	    	//(클릭이벤트를 걸어줄 요소, 셀렉박스 요소값, 선택값을 추가할 form)
	    	selectEvent($("#pNum") ,pNumValues,  $("#waitingForm"))
	    	selectEvent($("#time") ,timeValues,  $("#reserveForm"))
	    	selectEvent($("#pNumRsvd") ,pNumValues,  $("#reserveForm"))
	    	selectMenu($("#menu"),$("#resverForm"))
		    //정렬기준
		    /* $(".dropdown-list__item").on("click", function(e){
		    	console.log("change")
				showMain();
		    }); */
			
			
		}
		 $("#reserve").on("click", function(e){
		    	
	        $(this).addClass("tab-selected");
	        
	        $(this).prev().removeClass("tab-selected")
	        //시간 셀렉박스를 보여준다.
	        $("#waitingForm").hide();
	        $("#reserveForm").show();
	        
	        
	    });
	    
	    $("#wait").on("click", function(e){
	    	
	        $(this).addClass("tab-selected");
	        
	        $(this).next().removeClass("tab-selected")
	        
	        //시간 셀렉바스를 숨긴다.
	        $("#reserveForm").hide();
	        $("#waitingForm").show();
	    });
	    
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
	            selectValue.html($(this).html());
	    		//요소를 클릭하면
	    		
	    		//요소가 이미추가되어있나 확인
	    		let seq = $(this).data("value");
	    		if($("#menus").find("div[data-value='" + seq +"']").length != 0){
					alert("이미 추가하신 메뉴입니다.")
				 	return;
	    		}
	    		
	    		//메뉴 컨테이너에 요소추가
	    		let str = "";
	    		str += '<div class="menu-container flex" data-value="'+$(this).data("value")+'">'
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
	    			
	    		}) 
	    		
	        	
	    	 })
	        	
  	    }
	    
	    
	    //예약하기 버튼 클릭시(종우꺼 확인) 
	    	//이벤트를 막고
	    	//로그인 확인하고
	    	//메뉴가 있는지 확인
	    	//인원수 확인
	    	//시간 확인
	    	
	    	//핫딜 구매 체크
	    	
	    	//form에 요소들 추가
	    	//핫딜 메뉴가 있는지 확인
	    		//있으면 추가
	    	//메뉴추가
	    		//메뉴이름
	    		//메뉴가격
	    		//메뉴수량
	    	
	    	//예약 가능여부 체크
	    		//콜벡으로 form제출
	    		//아니면
	    			//form 초기화 시키고 아이디 태그 추가
	    	
	    
	    function selectEvent(dropdown, values, form){
		    const list = dropdown.find(".dropdown-list");
		    const selectValue =dropdown.find(".select");
		   	let name = dropdown.attr("id");
			
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
	</script>

	
	
<!--메뉴선택 -->
<script src="https://code.jquery.com/jquery-1.10.2.js"></script>
<script type="text/javascript">

		

	var menus = new Menus();

	//jstl로 전체 상품 목록 미리 세팅<select id="menu" onchange="mySelect()" >

	<c:forEach items="${store.bstore.menus }" var="menus">
		menus.arrAllMenus.push({
			menusId : "${menus.menuSeq}",
			menusUnprc : "${menus.price}",
			menusNm : "${menus.name }",
			cnt : 0
		});
		
	</c:forEach>
	//종우 ------------------------
	let paramHtdlId = '<c:out value="${store.bstore.htdl.htdlId}"/>' || null;
	let paramUserId = '<c:out value="${userId}"/>' || null;
	let storeId = '<c:out value="${store.storeId}"/>';
	
	let isHtdlPayHistory = false;//핫딜을 구매했는지 체크

	//전달받은 핫딜번호를 ajax를 통해 vo 가져오기
	function getHtdl(param, callback, error){
		
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
	}
	
	$(document).ready(function() {
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
		
		
	});
	
	
	
	//전달받은 핫딜 폼 그리기
	function showHtdlForm(htdlVO){
		
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
			
			/* menusTotAmt += afterPrcie;
			$('#menusTotAmtSumMsg').text("총금액");
			$('#menusTotAmt').text(menusTotAmt); */
			
			$("#htdl-container").append(htdlStr);
			menus.afterProc();
			
		}
	}
	
	
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
	
	//예약 가능여부 체크
	function isRsvdAvailChecked(param, callback, error){
		
		let storeId = param.storeId;
		let time = param.time;
		let pnum = param.pnum;

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
	//=================================================
	
	function Menus() {

		//json 배열[{menusId:menusId, menusNm:menusNm, amt:amt},{...},{...}]
		this.arrAllMenus = new Array();//상품 목록
		this.arrSelMenus = new Array();//선택한 상품 목록

		var p = this;

		//상품 추가 시
		this.select = function(trgtMenusId) {

			var selectedIndex = -1;

			//전체 목록 배열에서 검색하여 menusId가 없다면 선택 목록에 push후 container안에 그려준다.

			//선택 목록에서 검색
			for (var i = 0; i < p.arrSelMenus.length; i++) {

				if (p.arrSelMenus[i].menusId == trgtMenusId) {
					selectedIndex = i;
					break;
				}
			}

			if (selectedIndex < 0) {//선택목록에 없을 경우 추가. 잇을경우 얼럿.
				//전체목록에서 선택 추가해줌.
				for (var j = 0; j < p.arrAllMenus.length; j++) {

					if (p.arrAllMenus[j].menusId == trgtMenusId) {
						p.arrSelMenus.push(p.arrAllMenus[j]);
						p.arrSelMenus[p.arrSelMenus.length - 1].cnt = 1;//무조건 개수 초기화
						p.appendChoiceDiv(p.arrAllMenus[j]);
						break;
					}
				}
			} else {
				alert("이미 추가한 상품입니다.");
			}
			p.afterProc();
		}

		//상품 제거 시
		this.deselect = function(trgtMenusId) {

			var selectedIndex = -1;

			//배열에서 검색.
			for (var i = 0; i < p.arrSelMenus.length; i++) {

				if (p.arrSelMenus[i].menusId == trgtMenusId) {
					p.removeChoiceDiv(p.arrSelMenus[i]);
					p.arrSelMenus.splice(i, 1);
					break;
				}
			}
			p.afterProc();
		}
		//종우----------
		//핫딜 상품 제거 시
		this.htdlDeSelect = function(trgtMenusId) {

			var selectedIndex = -1;
			//배열에서 검색.
			for (var i = 0; i < p.arrSelMenus.length; i++) {
				if (p.arrSelMenus[i].htdlId == trgtMenusId) {
					p.arrSelMenus.splice(i, 1);
					break;
				}
			}
			p.afterProc();
		}
		//--------------

		this.appendChoiceDiv = function(prmtObj) {

			var innerHtml = "";

			innerHtml += '<div id="div_'+prmtObj.menusId+'">';
			innerHtml += '	<span>' + prmtObj.menusNm + '</span>';
			innerHtml += '	<input  type="text" id="input_sumAmt_'+prmtObj.menusId+'" name="" value="0" readonly ="readonly"/>'
			innerHtml += '	<br><button type="button" id="" class="add" name="" onclick="menus.minus(\''+ prmtObj.menusId + '\');">-</button>';
			innerHtml += '	<input style=width:30px; type="text" id="input_cnt_'+prmtObj.menusId+'" name="" value="0" readonly ="readonly"/>'
			innerHtml += '	<button  type="button" id="" class="remove" name="" onclick="menus.plus(\''+ prmtObj.menusId + '\');">+</button>';
			innerHtml += '	<button type="button" id="" class="remove" name="" onclick="menus.deselect(\''+ prmtObj.menusId + '\');">X</button>';
			innerHtml += '</div>';
			$('#container').append(innerHtml);

		}
		this.removeChoiceDiv = function(prmtObj) {
			$("#div_" + prmtObj.menusId).remove();
		}

		this.plus = function(trgtMenusId) {

			for (var i = 0; i < p.arrSelMenus.length; i++) {

				if (p.arrSelMenus[i].menusId == trgtMenusId) {
					if (p.arrSelMenus[i].cnt >= 10) {
						alert("최대수량입니다.");
						break;
					}

					p.arrSelMenus[i].cnt++;
					break;
				}
			}

			p.afterProc();
		}

		this.minus = function(trgtMenusId) {

			for (var i = 0; i < p.arrSelMenus.length; i++) {

				if (p.arrSelMenus[i].menusId == trgtMenusId) {
					if (p.arrSelMenus[i].cnt == 1) {
						alert("최소수량입니다.");
						break;
					}
					p.arrSelMenus[i].cnt--;
					break;
				}
			}

			p.afterProc();
		}

		//계산 후처리.
		this.afterProc = function() {

			for (var i = 0; i < p.arrSelMenus.length; i++) {
				$('#input_cnt_' + p.arrSelMenus[i].menusId).val(
						p.arrSelMenus[i].cnt);
				$('#input_sumAmt_' + p.arrSelMenus[i].menusId).val(
						p.arrSelMenus[i].cnt * p.arrSelMenus[i].menusUnprc);
			}

			var menusTotAmt = 0;
			for (var i = 0; i < p.arrSelMenus.length; i++) {
				menusTotAmt += p.arrSelMenus[i].cnt
						* p.arrSelMenus[i].menusUnprc;
			}
			if (menusTotAmt == 0) {
				$('#menusTotAmtSumMsg').text("");
				$('#menusTotAmt').text("");

			} else {
				$('#menusTotAmtSumMsg').text("총금액");
				$('#menusTotAmt').text(menusTotAmt);

			}
		}

	}

	$('#btnAddMenus').on('click', function() {
		//value만 넘겨주면 된다.
		menus.select($('#menu option:selected').val());
	});
	
	//종우
	const reserveForm = $("#reserveForm");
	const reserve = $("#reserve");
	const pnum = $("#pnum");
	const reserveFormObj = $("#reserveFormObj");
	
	$("#reserveForm button").on("click", function(e) {
		//1.기존 이벤트(페이지 이동)를 막는다
		e.preventDefault();

		if(paramUserId === null){
			alert("로그인 후 서비스를 이용해 주세요.");
			return;
		}
		//시간,인원 수
		let time = $("#time option:selected").val();
		let pnum = $("#num option:selected").val();
		let RsvdAvailChecked = false;
		
		//예약 가능여부 체크
		isRsvdAvailChecked({storeId: storeId, time: time, pnum: pnum},
				function(data){
			console.log("reserve avail check: " + data);
			
			RsvdAvailChecked = data;
		});
		
		
		//해당 핫딜 구매했는지 체크
		if(paramHtdlId != null && paramUserId != null){
			
			isHtdlPayExistChecked({userId : paramUserId, htdlId: paramHtdlId},
					function(result){
				
				console.log("===========hotdeal pay check: "+ result);
				isHtdlPayHistory = result;
				
				if(!isHtdlPayHistory && paramHtdlId != null){
					alert('이미 핫딜 상품을 구매하셨습니다. 감사합니다');
					return;
				}
				
			});
		}
		
		//2.이벤트 막고 하고 싶은거
		//2.1 페이지 이동시 다음페이지에 데이터를 넘길 수 있도록 input hidden에 선택된 메뉴 수량 넣음
		//시간
		
		if (menus.arrSelMenus.length === 0) {
			alert("메뉴가 선택되지않았습니다");
			return;
		}

		if ($("#num option:selected").val() === "") {
			alert("인원수를 선택해 주세요");
			return;
		}
		
		if ($("#time option:selected").val() === "") {
			alert("예약시간을 선택해 주세요");
			return;
		}

		const personNum = '<input type="hidden" name=pnum value="'+ $("#num option:selected").val() + '">';
		const reserveTime = '<input type="hidden" name=time value="'+ $("#time option:selected").val() + '">';
		reserveFormObj.append(personNum);
		reserveFormObj.append(reserveTime);
		//3. 2에서 하고 싶은 거 실행 후  submit()

		for (let i = 0; i < menus.arrSelMenus.length; i++) {
			if (menus.arrSelMenus[i].cnt === 0) {
				alert("메뉴 수량을 선택해주세요");
				return;
			}
			
			//핫딜번호
			if(paramHtdlId != null){
				const htdlIdInput = '<input type="hidden" name="htdlId" value="'+paramHtdlId+'">';
				reserveFormObj.append(htdlIdInput);
			}
			
			//메뉴이름
			const menuNm = '<input type="hidden" name=menu['+i+'].name value="'+menus.arrSelMenus[i].menusNm+'">';
			const menuPrice = '<input type="hidden" name=menu['+i+'].price value="'+menus.arrSelMenus[i].menusUnprc+'">';
			const menuQty = '<input type="hidden" name=menu['+i+'].qty value="'+menus.arrSelMenus[i].cnt+'">';
			reserveFormObj.append(menuNm);
			reserveFormObj.append(menuPrice);
			reserveFormObj.append(menuQty);

		}
		
		setTimeout(()=>{
			if(RsvdAvailChecked){
				reserveFormObj.submit();
			}
			else{
				let storeIdTag = $("input[name='storeId']").clone();
				reserveFormObj.empty();
				reserveFormObj.append(storeIdTag);
				alert('선택하신 현재 인원은 예약이 불가합니다. 죄송합니다.');
				return;
			}
		}, 200);
		
	});
//-----------------------웨이팅 등록 이벤트------------------현중
	$(document).ready(function() {
		
		const waitingForm = $("#waitingForm");
		
		$("#waitingForm button").on("click", function(e) {
			
			e.preventDefault();
			
			if ($("#waitingNum option:selected").val() === "") {
				alert("인원수를 선택해주세요");
				return;
			}
			
			let inputTag = "";
			inputTag += '<input type="hidden" name=pnum value="' + $("#waitingNum option:selected").val() + '">';
			waitingForm.append(inputTag);

			waitingForm.submit();

			//waitingForm.submit();
		});

	});
</script>
	
<!-- 예약/웨이팅 탭 -->

	
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
		$(document).ready(function() {
			let storeIdValue = '<c:out value="${store.storeId}"/>';
			let revwUL = $(".revwColumn");
			showList(1);

			let pageNum = 1;
			let revwPageFooter = $(".revwFooter");

			function showRevwPage(revwCnt) {
				let endNum = Math.ceil(pageNum / 5.0) * 5;
				let startNum = endNum - 4;

				let prev = startNum != 1;
				let next = false;

				if (endNum * 4 >= revwCnt) {
					endNum = Math.ceil(revwCnt / 4.0);
				}
				if (endNum * 4 < revwCnt) {
					next = true;
				}
				
				let str = "<ul>";

				if (prev) {
					str += "<li><a href='" + (startNum - 1)
							+ "'>Previous</a></li>";
				}

				for (let i = startNum; i <= endNum; i++) {
					/* var active= pageNum ==i?"active":""; */
					str += "<li><a href='"+i+"'>" + i
							+ "</a></li>";
				}
				if (next) {
					str += "<li><a href='" + (endNum + 1)
							+ "'>Next</a></li>";
				}
				str += "</ul></div>";
				console.log(str);
				revwPageFooter.html(str);

			}

			function showList(page) {
				console.log("show list" + page);
				revwService.getList(
								{
									storeId : storeIdValue,
									page : page || 1
								},
								function(revwCnt, list) {
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
									for (let i = 0, len = list.length || 0; i < len; i++) {
										str += "<div class='revwCon'><strong>"+ list[i].userId+ "</strong>";
										str += " <strong>"+ list[i].rating+ "점</strong>"
										str += " <small class='reg'>"+ list[i].regDt+ "</small>";
										str += "<p>"+ list[i].cnts;
										
										if(list[i].replyCnts !=null){
											str += "<div class='reply'>"+ list[i].replyCnts+"</div>";
										}	
										str	+= "</p></div></div></div>";
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

		});
	</script>
	
</body>
</html>