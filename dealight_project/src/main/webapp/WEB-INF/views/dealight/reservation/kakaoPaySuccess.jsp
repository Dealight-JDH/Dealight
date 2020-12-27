<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@include file="../../includes/mainMenu.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
		*{
            padding: 0;
            margin: 0;
            border:0;
            font-family: 'Nanum Gothic', sans-serif;
        }

        /* div{
            border: 1px solid red;
        }  */

       /*  .nav-bar{
        display: flex;
        
        height: 60px;
        justify-content: center;
        border: 1px solid red;
        align-items: center;
        background-color: #d32323;
        color: white;
        } */

        .main-container{
            display: flex;
            min-width: 1050px;
            height: 600px;
            flex-direction: row;
            justify-content: center;
            
            margin:60px;
        }

        .pay-container{
            display: flex;
            width: 43%;
            height: 90%;
            flex-direction: column;
            align-content: center;
            margin: 0 32px;
            padding: 8px;
            border: 1px solid rgb(139, 139, 139, 0.3);
            /* box-shadow: 3px 3px 4px  rgb(139, 139, 139); */
            box-shadow: 0px 16px 32px rgba(0, 0, 0, 0.1), 0px 3px 8px
		rgba(0, 0, 0, 0.1);
        } 

        .success_title{
            display: flex;
            justify-content: center;
            align-items: center;
            margin: 30px 36px 0;
            height: 40px;

        }

        .success-img{
            display: flex;
            justify-content: center;
            align-items: center;
            
            height: 150px;
            margin: 10px 36px 0;
        }

        .success_img{
            width: 100px;
            height: 100px;
            background-color: white;
        }
        p{
            font-size: 18px;
        }

        .css-font{
            font-size: 14px;
        }
        
        .success_title>span{
            font-size: 25px;
            font-weight: bold;
            margin-left: 32px;
        }

        /* .content-wrap{
            display: flex;
            flex-direction: column;
            
        } */

        .success_menu{
            display: flex;
            justify-content: flex-start;
            align-items: center;
            margin: 30px 36px 0 85px;
            height: 40px;
        }

        .success_menu>span{
            font-size: 16px;
            font-weight: bold;
            margin-left: 32px;
        }

        .success_sub{
            display: flex;
            justify-content: center;
            align-items: center;
            margin: 4px 36px;
            height: 40px;
        }

        .success_paymentMethod{

            display: flex;
            justify-content: flex-start;
            align-items: center;
            margin: 15px 36px 0 85px;
            height: 40px;

        }

        .success_paymentMethod>span{
            font-size: 16px;
            font-weight: bold;
            margin-left: 32px;
        }

        .success_amount{
            display: flex;
            justify-content: flex-start;
            align-items: center;
            margin: 15px 36px 0 85px;
            height: 40px;
        }

        .success_amount>span{
            font-size: 16px;
            font-weight: bold;
            margin-left: 32px;
        }

        .btn-wrap{
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            margin: 0 36px 10px;
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
        }
</style>
</head>
<body>


	<div class="main-container">

        <div class="pay-container">

            <div class="success-img">
                <img class="success_img" src="/resources/img/check_circle_big.png" alt="">
            </div>
            <div class="success_title">
                <span><c:out value="${userId }"/></span><p>님의 예약이 완료되었습니다.</p>
            </div>

            <div class="success_sub">
                    <h3>맛있는 식사 되세요!</h3>
            </div>

    
                <div class="success_menu">
                    <span>예약 음식:</span>&nbsp;<p class="css-font"><c:out value="${kakaoPayInfo.item_name}"/></p>
                </div>
    
                <div class="success_paymentMethod">
                    <span>결제 수단:</span>&nbsp;<p class="css-font"><c:out value="${kakaoPayInfo.payment_method_type}"/></p>
                </div>
    
    
                <div class="success_amount">
                    <span>결제 금액:</span>&nbsp;<p class="css-font"><c:out value="${kakaoPayInfo.amount.total}"/></p>
                </div>
    

            <div class="btn-wrap">
                <div class="btn_home">
                    <button class="btn" data-oper="home"><span>홈으로 이동</span></button>
                </div>
    
                <div class="btn_rsvdDtls">
                    <button class="rsvd_btn" data-oper="rsvdDetail"><span>예약내역 상세보기</span></button>
                </div>
            </div>




        </div>
    </div>
<%-- <h1>카카오 결제 성공!!!</h1>

<h2>결제 일시</h2> <fmt:formatDate value="${kakaoPayInfo.approved_at}" pattern="yyyy-MM-dd HH:mm:ss"/>
<h2>예약 번호</h2> <c:out value="${kakaoPayInfo.partner_order_id}"/>
<h2>상품명</h2> <c:out value="${kakaoPayInfo.item_name}"/>
<h2>상품수량</h2> <c:out value="${kakaoPayInfo.quantity}"/>
<h2>결제금액</h2> <c:out value="${kakaoPayInfo.amount.total}"/>
<h2>결제수단</h2> <c:out value="${kakaoPayInfo.payment_method_type}"/>
</body> --%>


<script>
	const rsvdId = '${rsvdId}';
	const userId = '${userId}';
	const storeId = '${storeId}';
	console.log(rsvdId);
	console.log(userId);
	console.log(storeId);

	$(document).ready(function(){
		$("button").on("click", function(e){
			e.preventDefault();
			let operation = $(this).data("oper");
			
			if(operation === 'home'){
				location.href = '/dealight/dealight';
			}else if(operation === 'rsvdDetail'){
				location.href = '/dealight/mypage/reservation';
			}
			
		});
		
	});

	
	let sendObj = "{\"sendUser\":\""+userId+"\",\"rsvdId\":\""+rsvdId+"\",\"cmd\":\"rsvd\",\"storeId\":\""+storeId+"\"}";
	console.log(sendObj);
	/* if(socket != null){
		socket.send(sendObj);
	} */

</script>
</html>