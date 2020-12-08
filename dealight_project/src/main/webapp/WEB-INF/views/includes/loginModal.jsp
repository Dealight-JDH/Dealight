<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
            %>
<!-- jongwoo -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
    <!-- 모달창~~ -->
     <div class="modal-content" id = "content">
       
        <span onclick="closebtn()" class="modal-close">x</span>
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
        
         <p class="find">   <a href="/dealight/findid">아이디 찾기</a>
           <a href="/dealight/findpwd">비밀번호 찾기</a> </p>
         </div>
 
       </div>
    <div class="modal-footer">
     <button id='loginbtn' type="submit" class="btn btn-warning">Login</button>
    <button id='registerbtn' type="button" class="btn btn-danger" onclick="location.href='/dealight/policies'">Register</button> 
</div>
 </form> 
<div>
   <!--  <a href="#google"><img id = "googlelogo" src="/resources/img/googlelogo.JPG"></a> -->

</div>

</div>
     <!-- /.modal-content -->
   <!-- </div> -->
   <!-- /.modal-dialog -->
 </div>
 <!-- /.modal -->
 <script>
 //로그인 실패 메세지가 들어온다면 모달창이 고정된 상태로 유지한다!
 let msg = "${msg}";
	if(msg != ""){
		let modalbtn = document.getElementById('openModal');

		modalbtn.onclick=openModal();
	}
	</script>
</body>
</html>