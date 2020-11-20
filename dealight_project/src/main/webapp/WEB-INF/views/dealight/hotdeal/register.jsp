<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

</head>
<body>

	<div>
		<form action="/dealight/hotdeal/register" method="post">
			<label>핫딜 제목</label>
			<input class="form-control" name='name'><br>
			
			<label>핫딜 메뉴</label><br>
			<c:forEach items="${menuLists }" var="menu" varStatus="status">
				<input type="checkbox" id="menu<c:out value="${status.count}"/>" class="js-menu" value="${menu.price }" >
				<label for="menu<c:out value="${status.count}"/>"> ${menu.name }</label>
			</c:forEach>
			<br>

			<label>할인율</label>
			 <select id="dcRate" name="dcRate">
				<option value="">--</option>
				<option value="10">10%</option>
				<option value="20">20%</option>
				<option value="30">30%</option>
				<option value="40">40%</option>
				<option value="50">50%</option>
			</select><br> 
			<label>할인 적용전 가격</label> 
			<input class="js-befPrice" value="0" name='befPrice' readonly='readonly'><br> 
			<label>할인 적용후 가격</label> 
			<input class="js-aftPrice" readonly='readonly'><br>
			<label>핫딜 기간</label> 
			<input type="time" name="startTm">
			<input type="time" name="endTm"><br>
			
			<label>핫딜 제안 인원: </label> 
			<input class="form-control" type="number" min="0" max="50" name='suggPnum' readonly='readonly'><br>
			
			<label>핫딜 예약 손님 인원: </label>
			<input class="form-control" type="number" min="0" max="50" name='lmtPnum'><br>
			
			<label>핫딜 소개</label><br>
			<textarea rows="2" cols="22" name="intro"></textarea>
			<br>
			<input type='hidden' id='storeId' name='storeId' value='<c:out value="${storeId}"/>'>
			 
			<button type="submit" data-oper = 'register'>승낙</button>
			<button type="submit" data-oper = 'refuse' >거절</button>

		</form>
	</div>
</body>
</html>

<script>
	
	const msg = '<c:out value="${msg}"/>';
	const storeId = '<c:out value="${storeId}"/>';
	console.log("==========storeId: "+storeId);
	//메뉴 리스트, 할인율, 메뉴 체크박스
	const menuLists = document.querySelectorAll(".js-menu"),
	dcRate = document.querySelector("#dcRate"),
	menuBox = document.querySelectorAll(".js-menu");

	//할인 적용 전/후 가격
	let befPrice = document.querySelector(".js-befPrice");
	let afterPrice = document.querySelector(".js-aftPrice");
	let total = 0;
	let rate = 0;
	
	$(document).ready(function() {

		if(msg != null && msg.length > 0){
			alert(msg);
		}
		console.log($(".js-menu"));

		//메뉴에 따른 가격 선택
		for (let i = 0; i < menuLists.length; i++) {
			$(".js-menu").eq(i).click(function() {
				console.log($(this).val());
				menuCheck($(this).val(), i);
			});
		}

		//할인율 변화
		$("#dcRate").change(function(){
			rate = $(this).val()/100;
			console.log("change: " + rate);

			getAfterPrice(total, rate);
		});
		
		let formObj = $("form");
		
		console.log(formObj);
		
		$("button").on("click", function(e){
			e.preventDefault();
			
			let operation = $(this).data("oper");
			console.log(operation);
			
			if(operation === 'register'){
				
				for(let i =0; i< menuBox.length; i++){
					//체크된 라벨 input 추가
					if(menuBox[i].checked){		
						console.log(i+"================");
						 formObj.append("<input type='hidden' name='menu["+i+"].name' value='"+ $("label[for='menu"+(i+1)+"']").text()+"'>");
						 formObj.append("<input type='hidden' name='menu["+i+"].price' value='"+ $("#menu"+(i+1)).val()+"'>");
							
					}
				}
				
				formObj.submit();
				
			}else if(operation === 'refuse'){
				
				location.href="/dealight/hotdeal/register?storeId="+storeId;
				
			}
			
			
		});
		
		
		
	});

	//할인 적용한 가격 계산
	function getAfterPrice(total, rate) {
		let price = total - (total * rate);
		console.log(price);
		afterPrice.value = price;
	}

	//메뉴 체크
	function menuCheck(price, idx) {

		if (menuLists[idx].checked)
			total += Number(price);
		else
			total -= Number(price);
		befPrice.value = total;

		getAfterPrice(total, rate);
	}
</script>