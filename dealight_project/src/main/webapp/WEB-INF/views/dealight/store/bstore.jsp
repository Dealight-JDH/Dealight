<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@include file="../../includes/mainMenu.jsp" %>
<%@include file="../../includes/loginModal.jsp" %>
<%@include file="../../includes/loginmodalHeader.jsp" %>
<!DOCTYPE html>
<!-- 다울 -->
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/resources/css/store.css">
<link rel="stylesheet" href="/resources/css/tab.css">
<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
</head>
<body>
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
				<c:forEach items="${store.bstore.waits }" var="waits">
					<h4>
						<c:out value="${waits.waitTot}" />
						명이 웨이팅 중 입니다!
					</h4>
					<br>
				</c:forEach>
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
					<p>브레이크 타임 : ${store.bstore.breakSttm} -
						${store.bstore.breakEntm}</p>
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
			<c:if test="${store.bstore.htdl.htdlId ne null}"> <%-- ${store.bstore.htdl.stusCd!=null } --%>
				<c:if test=" ${store.bstore.htdl.stusCd eq P }">
				<div class="htdlBtnCon">
				<button id='htdlBtn'>지금 진행중인 핫딜!</button>
				</div>	
				<div class="htdlCon">
					<P id='htdl'>핫딜상세</p>
				</div>
				</c:if>
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
									<input type='hidden' name='storeId'
										value='<c:out value="${store.storeId }"/>' />

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
											<c:if test="${store.bstore.htdl.htdlId ne null}">
												<%-- <c:if test=" ${store.bstore.htdl.stusCd eq P }"> --%>
												<%-- </c:if> --%>
											</c:if>
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
						<li><div class="content__wrapper">
								<form id="waitingForm" action="/dealight/waiting"
									method="post">
									<input type='hidden' name='storeId' value='<c:out value="${store.storeId }"/>' />

									<!-- <input type="hidden" id="selMenu" name="selMenu"> -->
									<div class="row">
										 <select id="waitingNum" required="required">
											<option value="">인원수</option>
											<option value="1">1</option>
											<option value="2">2</option>
											<option value="3">3</option>
											<option value="4">4</option>
										</select>
									</div>
									<button class ="tabWrapperBtn" type="submit">줄서기</button>
								</form>
							</div>
						</li>

					</ul>
				</section>
				</div>
		</div>
			<div class="footer">
			<h1>footer</h1>
			</div>
	</div>
	
	<script type="text/javascript" src="/resources/js/revw.js"></script>

	<!--리뷰 -->
	<script type="text/javascript">
		$(document)
				.ready(
						function() {
							
							
							
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
								revwService
										.getList(
												{
													storeId : storeIdValue,
													page : page || 1
												},
												function(revwCnt, list) {
													console.log("revwCnt: "
															+ revwCnt);
													console
															.log("list: "
																	+ list);
													console.log(list);
													if (page == -1) {
														pageNum = Math
																.ceil(revwCnt / 4.0);
														showList(pageNum);
														return;
													}

													let str = "";
													if (list == null
															|| list.length == 0) {
														return;
													}
													for (let i = 0, len = list.length || 0; i < len; i++) {
														str += "<div class='revwCon'><strong>"
																+ list[i].userId
																+ "</strong>";
														str += " <strong>"
																+ list[i].rating
																+ "점</strong>"
														str += " <small class='reg'>"
																+ list[i].regDt
																+ "</small>";
														str += "<p>"
																+ list[i].cnts;
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
	
	let paramHtdlId = '<c:out value="${htdlId}"/>' || null;
	$(document).ready(function() {


		console.log("hotdeal htdlId.........."+ paramHtdlId);
		
		if(paramHtdlId != null){
			
		
		//핫딜 페이지에서 넘어온 핫딜 ajax
		getHtdl({htdlId : paramHtdlId},function(result){
			
			console.log(result);
			
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
			
		  });
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

		this.appendChoiceDiv = function(prmtObj) {

			var innerHtml = "";

			innerHtml += '<div id="div_'+prmtObj.menusId+'">';
			innerHtml += '	<span>' + prmtObj.menusNm + '</span>';
			innerHtml += '	<input  type="text" id="input_sumAmt_'+prmtObj.menusId+'" name="" value="0" readonly ="readonly"/>'
			innerHtml += '	<br><button type="button" id="" class="add" name="" onclick="menus.minus(\''
					+ prmtObj.menusId + '\');">-</button>';
			innerHtml += '	<input style=width:30px; type="text" id="input_cnt_'+prmtObj.menusId+'" name="" value="0" readonly ="readonly"/>'
			innerHtml += '	<button  type="button" id="" class="remove" name="" onclick="menus.plus(\''
					+ prmtObj.menusId + '\');">+</button>';
			innerHtml += '	<button type="button" id="" class="remove" name="" onclick="menus.deselect(\''
					+ prmtObj.menusId + '\');">X</button>';
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
		menus.select($('#menu option:selected').val());
	});
	const reserveForm = $("#reserveForm");
	const reserve = $("#reserve");
	const pnum = $("#pnum");
	var submitted = false;

	$("#reserveForm button")
			.on("click", function(e) {
						if (submitted == true) {
							return;
						}
						//1.기존 이벤트(페이지 이동)를 막는다
						e.preventDefault();

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

						const personNum = '<input type="hidden" name=pnum value="'
								+ $("#num option:selected").val() + '">';
						reserveForm.append(personNum);
						const reserveTime = '<input type="hidden" name=time value="'
								+ $("#time option:selected").val() + '">';
						reserveForm.append(reserveTime);
						//3. 2에서 하고 싶은 거 실행 후  submit()

						for (let i = 0; i < menus.arrSelMenus.length; i++) {

							if (menus.arrSelMenus[i].cnt === 0) {
								alert("메뉴 수량을 선택해주세요");
								return;
							}
							
							//핫딜번호
							if(paramHtdlId != null){
								const htdlIdInput = '<input type="hidden" name="htdlId" value="'+paramHtdlId+'">';
								reserveForm.append(htdlIdInput);
								
							}
							//메뉴이름
							const menuNm = '<input type="hidden" name=menu['+i+'].name value="'+menus.arrSelMenus[i].menusNm+'">';
							reserveForm.append(menuNm);
							const menuPrice = '<input type="hidden" name=menu['+i+'].price value="'+menus.arrSelMenus[i].menusUnprc+'">';
							reserveForm.append(menuPrice);
							const menuQty = '<input type="hidden" name=menu['+i+'].qty value="'+menus.arrSelMenus[i].cnt+'">';
							reserveForm.append(menuQty);

						}
						submitted = true;

						reserveForm.submit();

					});

	const waitingForm = $("#waitingForm");
	$(document)
			.ready(
					function() {

						$("#waitingForm button")
								.on(
										"click",
										function(e) {
											if (submitted == true) {
												return;
											}
											//1.기존 이벤트(페이지 이동)를 막는다
											e.preventDefault();
											//2.이벤트 막고 하고 싶은거
											//2.1 페이지 이동시 다음페이지에 데이터를 넘길 수 있도록 input hidden에 선택된 메뉴 수량 넣음
											//시간
											if ($("#waitingNum option:selected")
													.val() === "") {
												alert("인원수를 선택해주세요");
												return;
											}
											const watingPersonNum = '<input type="hidden" name=pnum value="'
													+ $(
															"#waitingNum option:selected")
															.val() + '">';
											waitingForm.append(watingPersonNum);

											submitted = true;
											waitingForm.submit();

											//waitingForm.submit();
										});

					});
</script>
	
	<!-- 예약/웨이팅 탭 -->
	<script>
		$(document).ready(
				function() {

					// Variables
					var clickedTab = $(".tabs > .active");
					var tabWrapper = $(".tab__content");
					var activeTab = tabWrapper.find(".active");
					var activeTabHeight = activeTab.outerHeight();

					// Show tab on page load
					activeTab.show();

					// Set height of wrapper on page load
					tabWrapper.height(activeTabHeight);

					$(".tabs > li").on(
							"click",
							function() {

								// Remove class from active tab
								$(".tabs > li").removeClass("active");

								// Add class active to clicked tab
								$(this).addClass("active");

								// Update clickedTab variable
								clickedTab = $(".tabs .active");

								// fade out active tab
								activeTab.fadeOut(250, function() {

									// Remove active class all tabs
									$(".tab__content > li").removeClass(
											"active");

									// Get index of clicked tab
									var clickedTabIndex = clickedTab.index();

									// Add class active to corresponding tab
									$(".tab__content > li").eq(clickedTabIndex)
											.addClass("active");

									// update new active tab
									activeTab = $(".tab__content > .active");

									// Update variable
									activeTabHeight = activeTab.outerHeight();

									// Animate height of wrapper to new tab height
									tabWrapper.stop().delay(50).animate({
										height : activeTabHeight
									}, 500, function() {

										// Fade in active tab
										activeTab.delay(50).fadeIn(250);

									});
								});
							});
				});
	</script>
	<!-- 핫딜  -->
	<script>
		$(document).ready(function() {
			$("#htdlBtn").click(function() {
				$("#htdl").slideToggle();
			});
		});
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
	
	
</body>
</html>