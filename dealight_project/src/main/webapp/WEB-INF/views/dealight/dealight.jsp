<%@page import="com.dealight.domain.UserVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%-- <%@include file="../includes/mypageMenubar.jsp" %> --%>
    <%@include file="../includes/loginmodalHeader.jsp" %>
    <%@include file="../includes/mainMenu.jsp" %>
    
 <%
           Cookie[] cookies = request.getCookies(); 
           String cookieVal ="";
            
            if(cookies !=null){
            	for(Cookie i : cookies){
                    if(i.getName().equals("id")){
                        cookieVal=i.getValue();
                    }
                }
            }
            
/*            
           UserVO user = (UserVO)session.getAttribute("user");
           String loginState = "";
           String display = ""; //로그인 전에 로그아웃 메뉴 숨기기
           //세션에 로그인 정보가 담겼다면 로그인 모달창 비활성화
           if(user != null){
        	   loginState = "onclick=\"goMypage()\"";
           }else{
        	   loginState = "onclick=\"openModal()\"";
        	   display = "none";
           }
            */
%>    
    
   
    
    
<body>
<h1>main page</h1>
<!-- 사람이모지 메뉴바+서브메뉴 -->
<%-- <div class="dropdown">
    <button class="dropbtn" id="openModal" type="button" <%=loginState%>">사람이모지~~</button>
    <div class="dropdown-content">
       <a href="/dealight/mypage/reservation">예약내역(미구현)</a>
      <a href="#waiting/list">웨이팅(미구현)</a>
      <a href="#review">나의리뷰(미구현)</a>
      <a href="#like">좋아요(미구현)</a> 
      <a href="/dealight/mypage/modify">회원정보수정</a>
      <a href="/dealight/logout" style="display:<%=display %>">로그아웃</a>
    </div>
  </div>
    <div class="back-bg"></div> --%>
    
    
    <!-- 모달창~~ -->
     <div class="modal-content" id = "content">
       
        <span onclick="closebtn()" class="modal-close"">x</span>
        <div class="modal-header">
        <div id="profile"> 000 Dealight </div>
       
       </div>
     <form action="/dealight/dealight" method="post"> 
       <div class="modal-body">
         <div class="form-group">
           <label>아이디</label> 
           <input class="form-control" name='userId' value="<%=cookieVal !="" ? cookieVal : "" %>">
         </div>      
         <div class="form-group">
           <label>비밀번호</label> 
           <input type = 'password' class="form-control" name='pwd'>
           <p>${msg }</p>
         </div>
          <p class="saveId"> id저장<input type="checkbox" name="saveId"  <%=cookieVal!=""?"checked" : ""%> ></p>
         <div class="form-group">
        <p class="find">   <a href="/dealight/email/findId">아이디 찾기</a>
           <a href="/dealight/email/findPwd">비밀번호 찾기</a> </p>
         </div>
 
       </div>
    <div class="modal-footer">
     <button id='loginbtn' type="submit" class="btn btn-warning">Login</button>
    <button id='registerbtn' type="button" class="btn btn-danger" onclick="location.href='/dealight/email/email'">Register</button>
</div>
 </form> 
<div>
	<%--  <input type="hidden" id="msg" value='<c:out value="${msg}"/>'>  --%>
    <a href="#google"><img id = "googlelogo" src="/resources/img/googlelogo.JPG"></a>

</div>

</div>
     <!-- /.modal-content -->
   <!-- </div> -->
   <!-- /.modal-dialog -->
 </div>
 <!-- /.modal -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
 <script>
 //로그인 실패 메세지가 들어온다면 모달창이 고정된 상태로 유지한다!
 let msg = "${msg}";
	if(msg != ""){
		let modalbtn = document.getElementById('openModal');

		modalbtn.onclick=openModal();
	}
 
 
/*      //1. 버튼을 누르면 모달창이 띄어지고, 배경 회색으로 변경
        function openModal(){
            document.getElementById('content').style.display='block';
            document.body.style.backgroundColor = "rgba(0,0,0,0.4)";

     }

     //2. X버튼을 누르면 모달창이 사라지고 원상복귀
        function closebtn(){
        document.getElementById('content').style.display='none';
        document.body.style.backgroundColor = "white";
     }
     
     //3. login상태에서 사람모양 클릭시 mypage(예약내역)로 이동
     function goMypage(){
    	 location.href="/dealight/mypage/reservation";

     } */
 </script>
</body>
</html>