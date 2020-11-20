<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<div class="right">
		<div class="sticky">
			<h1>예약</h1>
			<form id="selection" action="/dealight/reservation/kakaoPay" method="get"
				onsubmit="myStop()">
				<!-- <input type="hidden" id="selMenu" name="selMenu"> -->
				<div class="row">
					<select id="time">
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
					<select id="menu" onchange="mySelect()" required="required">
						<option value="">메뉴</option>
						<c:forEach items="${menus }" var="menu">
							<option value="${menu.price}""><c:out value='${menu.name}'/></option>
						</c:forEach>
					</select>
					
				</div>
				<div id="demo"></div>
				<div id="menuSum"></div>
				<button type="submit">예약하기</button>

			</form>
		</div>
	</div>

	</div>

</body>
</html>

<script>
	//메뉴를 선택한다 
	//demo에 선택한 메뉴와 가격 수량버튼이 나온다
	//수량이 변경됨에 따라 가격부분이 가격 *수량 값이변경되도록한다.
	let optionsIndex = [];
	const target = document.getElementById("menu");
	const form = document.getElementById("selection");
	const targetP = document.getElementById("num");
	const targetT = document.getElementById("time");
	let menuCntMap = new Map();
	let menuPriceSum = 0;
	const pForMenuSum = document.createElement("p");
	const element = document.getElementById("demo");
	const element2 = document.getElementById("menuSum");
	function mySelect() {
		//변경사항
		//selectedindex를 배열 optionsIndex에 담는다			
		//배열의 length만큼 index.text/index.value가져와서 Object obj에 담아 options담아줌 이걸 foreach			
		if (target.options[target.selectedIndex].text === "메뉴") {
			return;
		}
		for (let i = 0; i < optionsIndex.length; i++) {
			if (optionsIndex[i] === target.options[target.selectedIndex]) {
				alert("이미 선택된 옵션입니다");
				return;
			}
		}
		//
		//첫번째 선택된거 배열에 담고 다시 이벤트 발생하면 중복으로 담음
		optionsIndex.push(target.options[target.selectedIndex]);
		//

		let key = target.options[target.selectedIndex].text;
		let val = target.options[target.selectedIndex].value;
		const pForKey = document.createElement("p");
		pForKey.innerHTML = key;
		element.appendChild(pForKey);
		const p = document.createElement("p");
		p.innerHTML = val;
		element.appendChild(p);
		menuCntMap.set(key, 1);
		//총합계 메뉴가 선택되면 선택된 메뉴의 가격(단가*수량)의 합계를 보여준다.
		//클릭할때마다 바껴야한다.
		//클릭될때 마다 생성X 한번만 생겨야한다
		//한 메뉴에 대한 sum이아니라 모든 것에 대한 sum이여야한다

		menuPriceSum += Number(val);
		pForMenuSum.innerHTML = menuPriceSum;
		element2.appendChild(pForMenuSum);

		const inputDown = document.createElement("input");
		inputDown.type = "button";
		inputDown.value = "-";
		inputDown.id = "down" + key;
		element.appendChild(inputDown);
		const input = document.createElement("input");
		input.type = "text";
		input.id = "menuCnt" + key;
		input.value = "1";
		input.size = "2";
		element.appendChild(input);
		const inputUp = document.createElement("input");
		inputUp.type = "button";
		inputUp.value = "+";
		inputUp.id = "up" + key;
		element.appendChild(inputUp);
		let count = 1;
		let menuCnt = document.getElementById("menuCnt" + key);
		let sum = val;
		const inputX = document.createElement("input");
		inputX.type = "button";
		inputX.id = "x" + key;
		inputX.value = "X"
		element.appendChild(inputX);
		//-를 누르면 수량 감소 
		document.addEventListener('click', function(e) {
			if (e.target && e.target.id == 'down' + key) {
				if (menuCnt.value > 1) {
					count--;
					menuCnt.value = count;
					sum = count * Number(val);
					p.innerHTML = sum;
					menuCntMap.set(key, count);
					menuPriceSum -= Number(val);
					pForMenuSum.innerHTML = menuPriceSum;
				} else {
					alert("최소수량 입니다");
				}
			}
		});
		//+누르면 수량 증가
		document.addEventListener('click', function(e) {
			if (e.target && e.target.id == 'up' + key) {
				count++;
				menuCnt.value = count;
				sum = count * Number(val);
				p.innerHTML = sum;
				menuCntMap.set(key, count);
				menuPriceSum += Number(val);
				pForMenuSum.innerHTML = menuPriceSum;
			}
		});
		//X버튼 누르면 해당메뉴관련 정보 사라지고 다시 선택가능한 상태로 만들어야함  
		document.addEventListener('click', function(e) {
			if (e.target && e.target.id == "x" + key) {
				//메뉴이름 삭제 
				element.removeChild(pForKey);
				//해당메뉴 총가격 삭제
				element.removeChild(p);
				//버튼 삭제
				element.removeChild(inputDown);
				element.removeChild(input);
				element.removeChild(inputUp);
				element.removeChild(inputX);
				//총합계에서 해당 메뉴의 sum 빼주기
				menuCntMap.set(key, 0);
				menuPriceSum -= sum;
				pForMenuSum.innerHTML = menuPriceSum;
				if (menuPriceSum == 0) {
					element2.removeChild(pForMenuSum);
				}
				//optionsIndex에서  빼줌
				for (let i = 0; i < optionsIndex.length; i++) {
					//lenth 동안 optionsIndex[i] == key 일때 그 index 삭제
					if (optionsIndex[i].text == key) {
						optionsIndex.splice(i, 1);
					}
				}
			}
		});
	}
	function myStop() {
		//1.기존 이벤트(페이지 이동)를 막는다
		event.preventDefault();
		//2.이벤트 막고 하고 싶은거
		//2.1 페이지 이동시 다음페이지에 데이터를 넘길 수 있도록 input hidden에 선택된 메뉴 수량 넣음
		//시간
		//인원수
		const input = document.createElement("input");
		input.type = "hidden";
		input.name = "pnum";
		input.value = targetP.value;
		form.appendChild(input);
		const input1 = document.createElement("input");
		input1.type = "hidden";
		input1.name = "time";
		input1.value = targetT.value;
		form.appendChild(input1);
		
		let totQty = 0;
		let totAmt = 0;
		//메뉴 이름 가격 수량 넘기기
		for (let i = 0; i < optionsIndex.length; i++) {
			const key = optionsIndex[i].text;
			const input = document.createElement("input");
			input.type = "hidden"
			input.name = "menu[" + i + "].name";
			input.value = optionsIndex[i].text;
			form.appendChild(input);
			const input2 = document.createElement("input");
			input2.type = "hidden";
			input2.name = "menu[" + i + "].price";
			input2.value = optionsIndex[i].value;
			form.appendChild(input2);
			const input3 = document.createElement("input");
			input3.type = "hidden";
			input3.name = "menu[" + i + "].qty";
			input3.value = menuCntMap.get(key);
			totQty += menuCntMap.get(key);
			totAmt += (optionsIndex[i].value * menuCntMap.get(key));
			form.appendChild(input3);
		}
		
		console.log("==="+totQty);
		console.log("---"+totAmt);
		
		
		const input4 = document.createElement("input");
		input4.type = "hidden"
		input4.name = "totAmt";
		input4.value = totAmt;
		
		const input5 = document.createElement("input");
		input5.type = "hidden"
		input5.name = "totQty";
		input5.value = totQty;
		
		form.appendChild(input4);
		form.appendChild(input5);
		//3. 2에서 하고 싶은 거 실행 후  submit()
		form.submit();
	}
</script>