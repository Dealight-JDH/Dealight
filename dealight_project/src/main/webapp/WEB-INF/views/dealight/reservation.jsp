<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@include file="../includes/mainMenu.jsp"%>
<!DOCTYPE html>
<html>
<head>
<script>
// 로그인이 안된 상태면 메인페이지로 넘어가게
/* let msg = '${msg}';
	if(msg != ""){
        alert(msg);
        location.href = '/dealight/store?clsCd=B&storeId='+${storeId};
     } */
</script>
<meta charset="UTF-8">
<title>Insert title here</title>


<style type="text/css">
* { /* CSS초기화. 이거 없으면 div태그 사이에 공백 생김*/

margin  : 0;   /* 값이 0일 때는 단위 안씀. */
border  : 0;
padding : 0;
font-family: 'Nanum Gothic', sans-serif;
}

/* .nav {
	height: 70px;
	width: 100%;
	border-style: solid;
} */

.container {
	display: flex;
    /* height: 900px; */
    min-width: 1050px;
    height: auto;
	justify-content: center;
    margin:40px;
}

.left {
    display: flex;
	width: 40%;
    height: 80%;
    flex-direction: column;
    
    align-content: center;
    margin: 0 32px;
    padding: 8px;
    border: 1px solid rgb(139, 139, 139, 0.3);
    /* box-shadow: 3px 3px 4px  rgb(139, 139, 139); */
    box-shadow: 0px 16px 32px rgba(0, 0, 0, 0.1), 0px 3px 8px
rgba(0, 0, 0, 0.1);

}

.left p {
	margin: 20px;
}

.left h4 {
	border-radius: 5px;
	border-style: solid;
	padding: 5px 50px 5px 50px;
	border-color: grey;
	display: inline-block;
}

.column {
	display: flex;
    flex-direction: column;
    justify-content: center;
    align-content: center;
    height: 40%;
	border-bottom-style: solid;
	border-bottom-color: rgba(138, 134, 134, 0.199);
	
}
.reg{
	float:right;
}

.revwFooter {
	display: flex;
	justify-content: flex-end;
}

.revwFooter ul {
	list-style-type: none;
}
.revwFooter a{
	 text-decoration: none;
      border-radius: 2px;
      border-color: black;
}


.revwFooter li {
	display: inline;
	margin: 5px;
}

.revwColumn {
	display: flex;
	flex-direction: row;
	flex-wrap: wrap;
	justify-content: flex-start;
	margin: 10px;
}

.revwCon {
	width: 45%;
	display: inline-block;
	border-style: solid;
	border-color: rgba(138, 134, 134, 0.199);
}

.reply{
	background-color: rgba(138, 134, 134, 0.199);
	border-radius : 2px;
	padding : 5px;
	margin:5px;
	
}
.right {
	width: 20%;
	min-width: 300px;
	margin:30px;
}

.img {
	width: 95%;
	margin: auto;
}

.imgCon {
	width: 32%;
	height: 150px;
	
}

.sticky {
	position: -webkit-sticky;
	position: sticky;
	top: 100px;
	margin: auto;
	width: 85%;
	text-align: center;
	padding: 10px;
	
}

.sticky ul {
	margin: 0;
	padding: 0;
	list-style: none;
}



/*/reservation*/
#myDIV {
  width: 100%;
  margin-top: 20px;
  display: none;
}


.payment{
    display: block;
    padding: 10px;
     size:10px;
}
.payment2{
    margin: 0 auto;
    border-style: solid;
    padding: 10px;
    size:10px;

}
.pay{
    width: 80%;
    border-style: solid;
    padding: 10px;
    margin: 35px;
}

/*핫딜*/
.htdlCon{
	border-style : solid;

}

/* .htdlBtnCon {
  	${nearbyStore.repImg}
  
} */

.htdlBtnCon button{
	outline :0;
	border:none;
	background-color: white;
}
.conNearByColumn {
	display: flex;
	flex-direction: row;
	flex-wrap: wrap;
	justify-content: flex-start;
	
}
/*주변가게*/
.conNearBy{
	width:30%;
	display: inline-block;
	border-style: solid;
	border-color: rgba(138, 134, 134, 0.199);
	margin: 10px;
	height:250px;
}

.imgNearBy{
	border-style: solid;
	border-color: rgba(138, 134, 134, 0.199);
	width:100%;
	height:150px;
}

.footer{
	width : 100%;
	height : 300px;
}

/* div{
    border: 1px solid red;
} */

.nav-bar{
        display: flex;
        
        height: 75px;
        justify-content: center;
        border: 1px solid red;
        align-items: center;
        background-color: #d32323;
        color: white;
    }

    .storeInfo{
        display: flex;
        margin-top: 20px;
        /* margin-bottom: 4px; */
        justify-content: center;

    }


    a{
        text-decoration: none;
        color: black;
        font-weight: 700;
        font-size: 20px;
    }

    .storeName{
        display: flex;
        justify-content: center;
        align-items: center;
        height: 40px;
        margin-top: 12px;
    }

    .css-storeName{
        
        margin-left: 12px;
    }

    .repImg{
        display: flex;
        justify-content: center;
        margin-top: 12px;
        /* padding-bottom: 6px; */
    }

    .rsvdInfo{
        display: flex;
        justify-content: center;
        margin-top: 20px;
    }

    .userInfo{
        display: flex;
        justify-content: center;
        margin-top: 12px;
    }
    .rsvdTime{
        display: flex;
        justify-content: center;
        margin-top: 8px;
    }

    .pnum{
        display: flex;
        justify-content: center;
        margin-top: 8px;
    }

    .moneyInfo{
        display: flex;
        justify-content: center;
        margin-top: 20px;
        
    }
    .menuMoneyInfo{
        display: flex;
        justify-content: center;
        margin-top: 8px;
    }

    .totMoney{
        display: flex;
        justify-content: center;
        margin-top: 8px;
    }

    .btn-wrap{
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            margin: 8px 36px 10px;
            padding-bottom: 8px;
            /* align-items: center; */
        }

        .btn_home{
            display: flex;
            /* justify-content: center;
            align-items: center; */
            width: 70%;
            margin-top: 12px;
            height: 50px;
        }

        .btn_rsvdDtls{
            display: flex;
            /* justify-content: flex-start; */
            width: 70%;
            align-items: center;
            margin: 10px 36px 8px;
            height: 50px;
        }


        .btn{
            width: 100%;
            height: 100%;
            font-size: 16px;
            background-color: red;
            color: white;
            cursor: pointer;
            border-radius: 3px;
            outline: none;
        }

        .rsvd_btn{
            width: 100%;
            height: 100%;
            font-size: 16px;
            background-color: white;
            border: 1px solid rgb(139, 139, 139);
            color: black;
            cursor: pointer;
            border-radius: 3px;
            outline: none;
        }
        
        .totMoneyLabel{
            font-weight: 700;
        }
        
		/* div{
		    border: 1px solid red;
		} */
</style>
</head>
<body>

	<div class="container">
		<div class="left">
			<div class="column">
				
				<!--  <input type="button" value="<" onClick="history.go(-1)">-->
				<%-- <h1><a
					href='/dealight/store/<c:out value="${store.storeId}"/>'>
					매장정보</a></h1>
				${store.storeNm } --%>
				
				<div class="storeInfo">
                    <h1>매장 정보</h1>
                </div>
                
                <div class="storeName">
                    <label>매장명: </label>
                    
                    <span class="css-storeName">
                        <a href='/dealight/store/${store.storeId}'>
                        ${store.storeNm }</a>
                    </span>
                </div>
                
				
				<c:if test="${store.bstore.repImg != null}">
				<c:set var="filePath" value= "/${store.bstore.repImg }"/>
					<%-- <img class="imgCon"
						src='/resources/images/store/<c:out value="${store.imgs[0].fileName}" />'> --%>
						
						<div class="repImg">
						<img class="imgCon" src="/display?fileName=/<c:out value="${filePath}" />">
						</div>
				</c:if>

				<%-- 대표 이미지: <c:out value="${filePath}" /> --%>
			</div>
			
			
			<div class="column">
				<div class="rsvdInfo">
				<h1>예약 정보</h1></div>
				
				<div class="userInfo">회원 정보: ${userId}</div>
                <div class="rsvdTime">예약 시간: ${time}</div>
                <div class="pnum">예약 인원: ${pnum}명</div>
				
				<%-- <c:out value="${store.imgs[0].fileName}" />
				회원정보 <c:out value="${userId }"></c:out>
				시간 : ${time } <br> 인원수 : ${pnum } --%>
				
				<!-- <p>요금세부정보</p> -->
				<div class="moneyInfo"><h1>요금 정보</h1></div>
				
				<c:forEach items="${rsvdMenuList.menu }" var="menu"
					varStatus="status">
					<div class="menuMoneyInfo">${menu.name} (${menu.price}) X ${menu.qty} = ${menu.price*menu.qty}</div>
					<%-- ${menu.name} (${menu.price}) X ${menu.qty} =   ${menu.price*menu.qty}<br> --%>
					<c:set var="totAmt" value="${totAmt + menu.price*menu.qty}" />
					<c:set var="totQty" value="${totQty + menu.qty}" />
				</c:forEach>
				
				<div class="totMoney"><label class="totMoneyLabel">총 합계:</label>&nbsp;${totAmt }원</div>
				</div>
				
				<!-- 총합계 : -->
				<%-- <c:out value="${totAmt}" /> --%>
				
				<div class="btn-wrap">
                <div class="btn_home">
                    <button class="btn" data-oper="payBtn"><span>결제 하기</span></button>
                </div>
    
                <div class="btn_rsvdDtls">
                    <button class="rsvd_btn" data-oper="backBtn"><span>뒤로 가기</span></button>
                </div>
            </div>
				
				<!-- <h1>결제 요청</h1>
				<button class="payment" onclick="myFunction()">결제 수단 선택</button>

				<div id="myDIV">

					<button class="payment2">신용카드</button> -->
					<form id="kakaoPayForm" action="/dealight/reservation/kakaoPay"
						method="post">
						<input type="hidden" name="storeId" value="${store.storeId }">
						<input type="hidden" name="userId" value="${userId }">
						<c:if test="${htdlId ne null }">
							<input type="hidden" name="htdlId" value="${htdlId}">
						</c:if>

						<%-- ${status.index} 따옴표안에 넣지말고 그냥 써줘야함 --%>
						<c:forEach items="${rsvdMenuList.menu}" var="menu"
							varStatus="status">
							<input type="hidden" name="menu[${status.index}].name"
								value="${menu.name}">
							<input type="hidden" name="menu[${status.index}].price"
								value="${menu.price}">
							<input type="hidden" name="menu[${status.index}].qty"
								value="${menu.qty}">

						</c:forEach>
						
						<input type="hidden" name="pnum" value="${pnum}">
						 <input type="hidden" name="time" value="${time}"> 
						 <input type="hidden" name="totAmt" value="${totAmt}"> 
						 <input type="hidden" name="totQty" value="${totQty}">
						
					</form>
				<!-- </div> -->
				
			</div>
		</div>

	<!-- </div> -->


	<script>
	
		$(document).ready(function(){
			$("button").on("click", function(e){
				e.preventDefault();
					
				let operation = $(this).data("oper");
				
				if(operation === 'payBtn')
					$("form").submit();	
				else if(operation === 'backBtn')
					location.href="/dealight/store/"+${store.storeId};
				
			});
		});
	
		/* function myFunction() {
			const x = document.getElementById("myDIV");
			if (x.style.display === "block") {
				x.style.display = "none";
			} else {
				x.style.display = "block";
			}
		} */
	</script>
	
</body>
</html>

