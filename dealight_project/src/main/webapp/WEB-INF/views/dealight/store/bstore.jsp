<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/resources/store.css">
</head>
<body>
	<div class="container">
		<div class="nav">
			<h1>메뉴바~~~~~~~~~~~~~~~</h1>
		</div>
		<div class="left">
			<div class="column">
				<h1>${store.storeNm }</h1>
				<c:forEach items="${store.bstore.waits }" var="waits">
					<h4>
						<c:out value="${waits.waitTot}" />
						명이 웨이팅중입니다!
					</h4>
					<br>
				</c:forEach>
				<div class="img">

				<!--체크-->
						<c:if test="${store.imgs[0].imgUrl != null}">
					<c:forEach items="${store.imgs }" var="imgs">
							<img class="imgCon"
								src='/resources/image/<c:out value="${imgs.imgUrl}" />'>
					</c:forEach>
						</c:if>
				</div>
				<p>평균평점 : ${store.eval.avgRating} 리뷰 : ${store.eval.revwTotNum}
					좋아요 : ${store.eval.likeTotNum}</p>
			</div>
			<div class="column">
				<h1>예약 가능상태</h1>
			</div>
			<div class="column">
				<h1>매장정보</h1>
				<c:if test="${store.bstore.storeIntro!= null}">
					<p>${store.bstore.storeIntro}</p>
				</c:if>
				<p>${store.loc.addr}</p>
				<p>${store.telno}</p>

				<c:if test="${store.bstore.openTm!= null}">
					<p>영업시간 : ${store.bstore.openTm} - ${store.bstore.closeTm}</p>
				</c:if>
				<c:if test="${store.bstore.breakSttm!= null}">
					<p>브레이크 타임 : ${store.bstore.breakSttm} -
						${store.bstore.breakEntm}</p>
				</c:if>
				<c:if test="${store.bstore.lastOrdTm!= null}">
					<p>라스트오더 : ${store.bstore.lastOrdTm}</p>
				</c:if>
				<c:if test="${store.bstore.hldy!= null}">
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
				<div class="footer"></div>
			</div>
			<div class="column">
				<h1>주변가게</h1>
			</div>
		</div>
			<div class="right">
			<div class="sticky">
				<h1>예약</h1>
				<form id="reserveForm" action="/controller/dealight/reservation" method="post">
					<input type='hidden' name='storeId' value='<c:out value="${store.storeId }"/>' />
					
					<!-- <input type="hidden" id="selMenu" name="selMenu"> -->
					<div class="row">
						<select id="time" required="required">
							<option value="">시간</option>
							<option value="13:30">13:30</option>
							<option value="14:00">14:00</option>
							<option value="14:30">14:30</option>
						</select> <select id="num" required="required">
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
						</select>
						<input type="button" id="btnAddGoods" value="추가"></input>

					</div>
					<div id="container"></div>

					총금액&emsp; <input id="goodsTotAmt" name="totAmt" value=0>
					<button type="submit">예약하기</button>

				</form>
			</div>
		</div>
	</div>
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
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
							let revwPageFooter = $(".footer");

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
																+ "</small>"
														str += "<p>"
																+ list[i].cnts
																+ "</p></div></div></div>";
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
	<!--옵션선택 -->

<script src="https://code.jquery.com/jquery-1.10.2.js"></script>
	<script type="text/javascript">
		function Goods() {

			//json 배열[{goodsId:goodsId, goodsNm:goodsNm, amt:amt},{...},{...}]
			this.arrAllGoods = new Array();//상품 목록
			this.arrSelGoods = new Array();//선택한 상품 목록

			var p = this;

			//상품 추가 시
			this.select = function(trgtGoodsId) {

				var selectedIndex = -1;

				//전체 목록 배열에서 검색하여 goodsId가 없다면 선택 목록에 push후 container안에 그려준다.

				//선택 목록에서 검색
				for (var i = 0; i < p.arrSelGoods.length; i++) {

					if (p.arrSelGoods[i].goodsId == trgtGoodsId) {
						selectedIndex = i;
						break;
					}
				}

				if (selectedIndex < 0) {//선택목록에 없을 경우 추가. 잇을경우 얼럿.
					//전체목록에서 선택 추가해줌.
					for (var j = 0; j < p.arrAllGoods.length; j++) {

						if (p.arrAllGoods[j].goodsId == trgtGoodsId) {
							p.arrSelGoods.push(p.arrAllGoods[j]);
							p.arrSelGoods[p.arrSelGoods.length - 1].cnt = 0;//무조건 개수 초기화
							p.appendChoiceDiv(p.arrAllGoods[j]);
							break;
						}
					}
				} else {
					alert("이미 추가한 상품입니다.");
				}
				p.afterProc();
			}

			//상품 제거 시
			this.deselect = function(trgtGoodsId) {

				var selectedIndex = -1;

				//배열에서 검색.
				for (var i = 0; i < p.arrSelGoods.length; i++) {

					if (p.arrSelGoods[i].goodsId == trgtGoodsId) {
						p.removeChoiceDiv(p.arrSelGoods[i]);
						p.arrSelGoods.splice(i, 1);
						break;
					}
				}
				p.afterProc();
			}

			this.appendChoiceDiv = function(prmtObj) {

				var innerHtml = "";

				innerHtml += '<div id="div_'+prmtObj.goodsId+'">';
				innerHtml += '	<span>' + prmtObj.goodsNm + '</span>';
				innerHtml += '	<input type="text" id="input_sumAmt_'+prmtObj.goodsId+'" name="" value="0"/>'
				innerHtml += '	<button type="button" id="" class="add" name="" onclick="goods.minus(\''
						+ prmtObj.goodsId + '\');">-</button>';
				innerHtml += '	<input type="text" id="input_cnt_'+prmtObj.goodsId+'" name="" value="0"/>'
				innerHtml += '	<button type="button" id="" class="remove" name="" onclick="goods.plus(\''
						+ prmtObj.goodsId + '\');">+</button>';
				innerHtml += '	<button type="button" id="" class="remove" name="" onclick="goods.deselect(\''
						+ prmtObj.goodsId + '\');">제거</button>';
				innerHtml += '</div>';
				$('#container').append(innerHtml);

			}

			this.removeChoiceDiv = function(prmtObj) {
				$("#div_" + prmtObj.goodsId).remove();
			}

			this.plus = function(trgtGoodsId) {

				for (var i = 0; i < p.arrSelGoods.length; i++) {

					if (p.arrSelGoods[i].goodsId == trgtGoodsId) {
						p.arrSelGoods[i].cnt++;
						break;
					}
				}

				p.afterProc();
			}

			this.minus = function(trgtGoodsId) {

				for (var i = 0; i < p.arrSelGoods.length; i++) {

					if (p.arrSelGoods[i].goodsId == trgtGoodsId) {
						if (p.arrSelGoods[i].cnt == 0)
							break;
						p.arrSelGoods[i].cnt--;
						break;
					}
				}

				p.afterProc();
			}

			//계산 후처리.
			this.afterProc = function() {

				for (var i = 0; i < p.arrSelGoods.length; i++) {
					$('#input_cnt_' + p.arrSelGoods[i].goodsId).val(
							p.arrSelGoods[i].cnt);
					$('#input_sumAmt_' + p.arrSelGoods[i].goodsId).val(
							p.arrSelGoods[i].cnt * p.arrSelGoods[i].goodsUnprc);
				}

				var goodsTotAmt = 0;
				for (var i = 0; i < p.arrSelGoods.length; i++) {
					goodsTotAmt += p.arrSelGoods[i].cnt
							* p.arrSelGoods[i].goodsUnprc;
				}
				$('#goodsTotAmt').val(goodsTotAmt);

			}

		}

		var goods = new Goods();

		//jstl로 전체 상품 목록 미리 세팅<select id="menu" onchange="mySelect()" >

		<c:forEach items="${store.bstore.menus }" var="menus">
		goods.arrAllGoods.push({
			goodsId : "${menus.menuSeq}",
			goodsUnprc : "${menus.price}",
			goodsNm : "${menus.name }",
			cnt : 0
		});
		</c:forEach>

		$('#btnAddGoods').on('click', function() {
			goods.select($('#menu option:selected').val());
		});
		const reserveForm =$("#reserveForm");
		const reserve =$("#reserve");
		const pnum =$("#pnum");
		$("#reserveForm button").on("click", function(e) {
			//1.기존 이벤트(페이지 이동)를 막는다
			e.preventDefault();
			//2.이벤트 막고 하고 싶은거
			//2.1 페이지 이동시 다음페이지에 데이터를 넘길 수 있도록 input hidden에 선택된 메뉴 수량 넣음
			//시간
			if (goods.arrSelGoods.length === 0) {
				alert("메뉴가 선택되지않았습니다");
				return;
			}
			for (let i = 0; i < goods.arrSelGoods.length; i++) {
				if(goods.arrSelGoods[i].cnt === 0){
					alert("메뉴 수량을 선택해주세요");
				return; 
				}
			}
			if($("#num option:selected").val() === ""){
				alert("인원수를 선택해 주세요");
				return;
			}
			if($("#time option:selected").val() === ""){
				alert("예약시간을 선택해 주세요");
				return;
			}
			
			const personNum = '<input type="hidden" name=pnum value="'+$("#num option:selected").val()+'">'; 
			reserveForm.append(personNum);
			const reserveTime = '<input type="hidden" name=time value="'+$("#time option:selected").val()+'">'; 
			reserveForm.append(reserveTime);
			//3. 2에서 하고 싶은 거 실행 후  submit()
			
			for (let i = 0; i < goods.arrSelGoods.length; i++) {
				if(goods.arrSelGoods[i].cnt === 0){
					alert("메뉴 수량을 선택해주세요");
				return; 
				}
				//메뉴이름
				const menuNm = '<input type="hidden" name=menu['+i+'].name value="'+goods.arrSelGoods[i].goodsNm+'">'; 
				reserveForm.append(menuNm);
				const menuPrice = '<input type="hidden" name=menu['+i+'].price value="'+goods.arrSelGoods[i].goodsUnprc+'">'; 
				reserveForm.append(menuPrice);
				const menuQuan = '<input type="hidden" name=menu['+i+'].quan value="'+goods.arrSelGoods[i].cnt+'">'; 
				reserveForm.append(menuQuan);
				
				
			}
			reserveForm.submit();
		});
	</script>

	<!-- 수량버튼 -->
</body>
</html>