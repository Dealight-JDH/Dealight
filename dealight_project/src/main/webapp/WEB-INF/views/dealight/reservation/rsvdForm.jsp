<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>딜라이트</title>
<script src="https://code.jquery.com/jquery-1.10.2.js"></script>
</head>
<body>

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
										value='<c:out value="${storeId }"/>' />

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
											<c:if test="${store.bstore.htdl.htdlId ne null}">
												<%-- <c:if test=" ${store.bstore.htdl.stusCd eq P }"> --%>
												<%-- </c:if> --%>
											</c:if>
											<c:forEach items="${menus }" var="menus">
												<option value="${menus.menuSeq}">${menus.name }</option>
											</c:forEach>
										</select> <input type="button" id="btnAddMenus" value="추가"></input>

									</div>
									<div id="container"></div>
									<span id="menusTotAmtSumMsg"></span> <span id="menusTotAmt" name="totAmt" value="0"></span>
									<button class ="tabWrapperBtn" type="submit">예약하기</button>
								</form>
							</div>
						</li>
						<li><div class="content__wrapper">
								<form id="waitingForm" action="/dealight/waiting"
									method="post">
									<input type='hidden' name='storeId' value='<c:out value="${storeId }"/>' />

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

<script type="text/javascript">
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
						if(p.arrSelMenus[i].cnt >= 10){
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
						if (p.arrSelMenus[i].cnt == 1){
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
				if(menusTotAmt == 0){
					$('#menusTotAmtSumMsg').text("");
					$('#menusTotAmt').text("");
					
				}else{
					$('#menusTotAmtSumMsg').text("총금액");
					$('#menusTotAmt').text(menusTotAmt);
				
				}
			}

		}

		var menus = new Menus();

		//jstl로 전체 상품 목록 미리 세팅<select id="menu" onchange="mySelect()" >

		<c:forEach items="${menus }" var="menus">
		menus.arrAllMenus.push({
			menusId : "${menus.menuSeq}",
			menusUnprc : "${menus.price}",
			menusNm : "${menus.name }",
			cnt : 0
		});
		</c:forEach>

		$('#btnAddMenus').on('click', function() {
			menus.select($('#menu option:selected').val());
		});
		const reserveForm =$("#reserveForm");
		const reserve =$("#reserve");
		const pnum =$("#pnum");
		var submitted = false;
		$("#reserveForm button").on("click", function(e) {
			  if(submitted == true) { return; }
			//1.기존 이벤트(페이지 이동)를 막는다
			e.preventDefault();
			
			//2.이벤트 막고 하고 싶은거
			//2.1 페이지 이동시 다음페이지에 데이터를 넘길 수 있도록 input hidden에 선택된 메뉴 수량 넣음
			//시간
			if (menus.arrSelMenus.length === 0) {
				alert("메뉴가 선택되지않았습니다");
				return;
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

			for (let i = 0; i < menus.arrSelMenus.length; i++) {
				if(menus.arrSelMenus[i].cnt === 0){
					alert("메뉴 수량을 선택해주세요");
				return; 
			}
				//메뉴이름
				const menuNm = '<input type="hidden" name=menu['+i+'].name value="'+menus.arrSelMenus[i].menusNm+'">'; 
				reserveForm.append(menuNm);
				const menuPrice = '<input type="hidden" name=menu['+i+'].price value="'+menus.arrSelMenus[i].menusUnprc+'">'; 
				reserveForm.append(menuPrice);
				const menuQty = '<input type="hidden" name=menu['+i+'].qty value="'+menus.arrSelMenus[i].cnt+'">'; 
				reserveForm.append(menuQty);
				
			}

			submitted =true;
			reserveForm.submit();
		
		});
		
	
	const waitingForm = $("#waitingForm");
	$(document).ready(function() {
		
 			$("#waitingForm button").on("click",function(e) {
 				 if(submitted == true) { return; }
			//1.기존 이벤트(페이지 이동)를 막는다
			e.preventDefault();
			//2.이벤트 막고 하고 싶은거
			//2.1 페이지 이동시 다음페이지에 데이터를 넘길 수 있도록 input hidden에 선택된 메뉴 수량 넣음
			//시간
			if($("#waitingNum option:selected").val() === ""){
				alert("인원수를 선택해주세요");
				return;
			}
			const watingPersonNum = '<input type="hidden" name=pnum value="'
					+ $("#waitingNum option:selected").val() + '">';
			waitingForm.append(watingPersonNum);

			submitted=true;
			waitingForm.submit();

			//waitingForm.submit();
		});
		
		});
	</script>
</body>
</html>

