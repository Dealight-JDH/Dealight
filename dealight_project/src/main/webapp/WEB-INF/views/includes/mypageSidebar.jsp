<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>

.middle-container {
	height: 100%;
	width: 100%;
	display: inline-block;
}

.sidenav {
	border: 1px solid black;
	margin-top: 80px;
	height: 100%;
	width: 200px;
	/* position: fixed; */
	/* z-index: 1; */
	top: 0;
	left: 0;
	overflow-x: hidden;
	display: inline-block;
}

.profile {
	border: 1px solid black;
	margin-left: auto;
	margin-right: auto;
}

.img {
	display: block;
	margin-left: auto;
	margin-right: auto;
}

.profile-content {
	display: block;
	text-align: center;
}

.id {
	margin: 15px 0 0 0;
}

.id-ctgr {
	margin: 3px 0 20px 0;
}

.navMenu {
	border: 1px solid black;
	margin-top: 30px;
	width: 100%;
}

.accordion {
	background-color: white;
	color: black;
	cursor: pointer;
	padding: 6px 8px 10px 16px;
	text-decoration: none;
	text-align: left;
	width: 100%;
	border: none;
	font-size: 15px;
	transition: 0.3s;
}

.accordion a {
	text-decoration: none;
}

.active, .accordion:hover {
	background-color: crimson;
	color: white;
}

.active, .accordion a:hover {
	background-color: crimson;
	color: white;
}

.panel {
	padding: 0 2px;
	display: none;
	background-color: #f9f9f9;
	color: black;
	overflow: hidden;
}

.panel a {
	display: block;
	margin-left: 10px;
	padding: 6px 10px;
	text-decoration: none;
	font-size: 12px;
}

.panel a:hover {
	color: crimson;
	font-weight: bold;
}
</style>
</head>
<body>

<div class="middle-container">

	<div class="sidenav">
		<div class="profile">
			<img src="../../../resources/img/person.png" class="img" alt="profile" width="150"
				height="150">
	
			<div class="profile-content">
				<h4 class="id">홍길동님</h4>
				<h6 class="id-ctgr">( 일반 회원 )</h6>
			</div>
		</div>
	
		<div class="navMenu">
			<button class="accordion">
				<a href="#">예약내역</a>
			</button>
			<button class="accordion">
				<a href="#">사업자등록</a>
			</button>
			<button class="accordion">
				<a href="#">사업자등록 확인</a>
			</button>
			<button class="accordion">
				<a href="#">웨이팅</a>
			</button>
	
			<button class="accordion">
				<a href="writable-list?userId=${userId }">나의리뷰</a>
		</button>
		<div class="panel">
			<a href="writable-list?userId=${userId }">작성 가능한 리뷰</a>
			<a href="written-list?userId=${userId }">내가 작성한 리뷰</a>
			</div>
	
			<button class="accordion">
				<a href="#">찜목록</a>
			</button>
			<button class="accordion">
				<a href="#">알림함</a>
			</button>
			<button class="accordion">
				<a href="#">회원정보수정</a>
			</button>
			<button class="accordion">
				<a href="#">비밀번호변경</a>
			</button>
		</div>
	</div>

<script>
       var acc = document.getElementsByClassName("accordion");
       var i;

       for (i = 0; i < acc.length; i++) {
           acc[i].addEventListener("click", function() {
               this.classList.toggle("active");

               var panel = this.nextElementSibling;

               if (panel.style.display === "block") {
                   panel.style.display = "none";
               } else {
                   panel.style.display = "block";
               }
           })
       }

   </script>

</body>
</html>