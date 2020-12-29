<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@include file="../../../../includes/mainMenu.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메뉴 수정</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic&display=swap" rel="stylesheet">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@800&display=swap" rel="stylesheet">
<script src="https://kit.fontawesome.com/0f892675ba.js" crossorigin="anonymous"></script>
<link rel="stylesheet" href="/resources/css/manage.css">
<style>
	.select_img img{
		margin : 20px 0;
	}
        /* The Delete Button*/
        .btn_delete {
        color: #aaa;
        float: right;
        font-size: 28px;
        font-weight: bold;
        }

        .btn_delete:hover,
        .btn_delete:focus {
        color: black;
        text-decoration: none;
        cursor: pointer;
        }
		#menu_board{
			width: 100%;
	        height: 95%;
	        display: flex;
	        flex-direction: column;
	        justify-content: flex-start;
	        align-items: flex-start;
	        overflow-y:hidden;
	        overflow-x: hidden;
		}
		.file_body img {
	
			width : 100px;
			height : 100px;
		
		}
	main{
		margin : 30px auto;
		width:1050px;
	}
	
	#menu_board div {
		/*border: 1px black solid;*/
	}
	
	.menu_reg_tit{
		width:90%;
		height:10%;
		display:flex;
		flex-direction:row;
		align-items:center;
		justify-content:flex-start;
		margin: 15px 15px;
		font-size: 36px;
		font-weight: bold;
		padding-bottom: 20px;
		border-bottom: 1px #eeeeef solid;
	}
	.menu_wrapper{
		margin-left:15px;
		width: 90%;
		height: 80%;
		display: flex;
		flex-direction: row;
		justify-content: flex-start;
		align-items: center;
		border: 1px #eeeeef solid;
	}
	.menu_left_wrapper{
		width:50%;
		height: 90%;
		display: flex;
		flex-direction: column;
		justify-content: center;
		align-items: center;
		border-right: 1px #eeeeef solid;
	}
	.menu_left_wrapper > div{
		width: 90%;
	}
	.menu_reg_wrapper{
		padding : 15px 15px;
		height: 70%;
		
	}
	.menu_left_wrapper.menu_reg_wrapper{
		border: 1px #eeeeef solid;
	}
	.menu_reg_wrapper.modal_menu{
		width : 80%;
	}

	.menu_right_wrapper{
		width:50%;
		height: 90%;
		display:flex;
		flex-direction: column;
		justify-content: flex-start;
		align-items: center;
		overflow-y:scroll;
	    overflow-x: hidden;
	}
	.menu_right_wrapper > div {
		width: 100%;
	}
	.menu_list_tit{
		margin-top:20px;
		font-size: 24px;
		font-weight: bold;
		padding-bottom:15px;
		border-bottom: 1px #eeeeef solid;
	}
	.menu_list_wrapper{
		height: 90%;
		display:flex;
		flex-direction: column;
		justify-content: flex-start;
		align-items: center;
	}
	.menu_list_wrapper > div{
		width: 90%;
		margin-bottom: 20px;
	}
	
	 .menu_la_in{
    	margin-bottom : 10px;
    	width:100%;
    	display:flex;
    	flex-direction: row;
    	justify-content: flex-start;
    	align-items: center;
    	
    }
    .menu_la_in > label{
    	width:20%;
    	height: 100%;
    	display: flex;
    	flex-direction: row;
    	justify-content: flex-start;
    	align-items: center;
    }
    .menu_la_in > input{
    	width:30%;
    	height: 100%;
    	display: flex;
    	flex-direction: row;
    	justify-content: flex-start;
    	align-items: center;
    	padding : 3px 5px;
    }
    #submit_menuRegForm{
    	align-self: flex-start;
        background-color: #d32323b6;
        color: white;
        border: 0px;
        border-radius: 3px;
        font-size: 15px;
        font-weight: bold;
        width: 150px;
        height: 40px;
        cursor: pointer;
    }
    #submit_menuRegForm:hover{
    	opacity: 0.7;
    }
    .menu{
    	width: 90%;
    	display: flex;
    	flex-direction: row;
    	align-items: center;
    	justify-content: flex-start;
    	height: 150px;
    	cursor: pointer;
    	border: 1px #eeeeef solid;
    	
    }
    .menu:hover{
    	opacity: 0.7;
    	box-shadow: 2px 2px 8px rgba(0,0,0,0.200);
    }
    .menu_list_left_wrapper {
    	width: 50%;
    	height: 100%;
    	display: flex;
    	flex-direction: column;
    	justify-content: center;
    	align-items: flex-start;
    }
    .menu_list_left_wrapper > span {
    	margin-left:15px;
    	margin-bottom: 10px;
    }
    .menu_list_right_wrapper{
    	width: 50%;
    	height: 100%;
    	display: flex;
    	flex-direction: row;
    	justify-content: center;
    	align-items: center;
    }
    .menu_list_right_wrapper img {
    	width:100px;
    	height: auto;
    }
    .menu_img_mdoal{
    	width:100px;
    	height: auto;
    }
    #recoMenu{
    	height: 20px;
    	display: flex;
    	flex-direction: row;
    	justify-content:flex-start;
    	align-items: center;
    }
    .menu_la_in > input.reco_menu{
    	height: 20px;
    	display: flex;
    	flex-direction: row;
    	justify-content:flex-start;
    	align-items: center;
    }
    .btn_modify.modal_menu {
    	margin-top:20px;
    	width: 45%;
    	align-self: flex-start;
        background-color: #d32323b6;
        color: white;
        border: 0px;
        border-radius: 3px;
        font-size: 15px;
        font-weight: bold;
        height: 40px;
        cursor: pointer;
        margin-right: 5%;
    }
    .btn_modify.modal_menu:hover{
    	opacity: 0.7;
    }
    .btn_remove.modal_menu:hover{
    	opacity: 0.7;
    }
    .btn_remove.modal_menu {
    	margin-top:20px;
    	width: 45%;
    	align-self: flex-start;
        background-color: #d32323b6;
        color: white;
        border: 0px;
        border-radius: 3px;
        font-size: 15px;
        font-weight: bold;
        height: 40px;
        cursor: pointer;
    }
    #menuForm_modify{
    	padding: 20px;
    	border : 1px #eeeeef solid;
    }
</style>
</head>
<body>
<%@include file="../../../../includes/manage_nav.jsp" %>	
	<div id="menu_board">
		<div class="menu_reg_tit">
			메뉴 등록
		</div>
		<div class="menu_wrapper">
			<div class="menu_left_wrapper">
				<div class="menu_reg_wrapper">
					<form action="/dealight/business/manage/menu/register" method="post" id="regForm">
						<input name="storeId" value="${storeId}" hidden>
						
						<div class="menu_la_in">
							<label for="name">메뉴 이름 : </label>
							<input name="name" required> </br>
						</div>
						<div class="menu_la_in">
							<label for="price">메뉴 가격 : </label>
							<input name="price" required>
						</div>
						<div class="menu_la_in">
							<label for="recoMenu">메뉴 추천 여부 : </label>
							<input id="recoMenu" name="recoMenu" type="checkbox">
						</div>
						<div class=""><h2>사진 첨부하기(1개만 가능)</h2></div>
							<div class="file_body">
							<div class="form_img">
								<input type="file" name='uploadFile'>
							</div> 
							<div class='uploadResult'>
								<ul>
								</ul>
							</div> <!-- uploadResult -->
						</div> 
						<div class='bigPictureWrapper'>
							<div class='bigPicture'>
							</div>
						</div>
						<button id="submit_menuRegForm" type="submit">제출하기</button></br>
					</form>
				</div>
			</div>
			<div class="menu_right_wrapper">
				<div class="menu_list_wrapper">
					<div class="menu_list_tit">메뉴 리스트</div>
					<c:if test="${empty menus }">
						<div>현재 등록하신 메뉴가 없습니다!🤣</div>
					</c:if>
					<c:if test="${not empty menus }">
						<c:forEach items="${menus }" var="menu">
							<div class="menu">
								<span hidden class='menuSeq'>${menu.menuSeq }</span>
								<span hidden class='storeId'>${menu.storeId }</span>
								<span hidden class='name'>${menu.name }</span>
								<span hidden class='price'>${menu.price }</span>
								<span hidden class='thumImgUrl'>${menu.thumImgUrl }</span>
								<span hidden class='recoMenu'>${menu.recoMenu }</span>
								<span hidden class='imgUrl'>${menu.imgUrl }</span>
								<div class="menu_list_left_wrapper">
									<span>메뉴 이름 : ${menu.name }</span>
									<span>메뉴 가격 : ${menu.price }</span>
									<span>메뉴 추천 여부 : ${menu.recoMenu }</span>
								</div>
								<div class="menu_list_right_wrapper">
									<c:if test="${not empty menu.imgUrl}"><img src="/display?fileName=${menu.encThumImgUrl }"></c:if>
								</div>
							</div>
						</c:forEach>
					</c:if>
				</div>
			</div>
		</div>


	</div>
<%@include file="../../../../includes/manage_nav_bot.jsp" %>
	<div id="myModal" class="modal">
		<!-- Modal content -->
		<div class="modal-content">
			<span class="close_modal"><i class="fas fa-times"></i></span>
			<div class="modal_header"></div>
			<div class="menu_content"></div>
		</div>
	</div>
<script src="/resources/js/clock.js"></script>
<script>

const storeId = ${storeId};

showTime(); // 현재 시간을 보여주는 코드
setInterval(showTime, 1000); // 매초 update

// '매장'의 정보를 가져온다.
function getStore(param,callback,error) {
    
    let storeId = param.storeId;

    $.getJSON("/dealight/business/manage/board/store/"+storeId+".json",
            function(data){
                if(callback){
                    callback(data);
                }
            }).fail(function(xhr,status,err){
                if(error){
                    error();
                }
    });
}

function showStoreInfo (storeId){
	
	getStore({storeId : storeId}, function (store) {
        let strStoreInfo = "";
        if(store == null){
        	storeInfoDiv.html("");
            return;
        }
        
        /*착석 상태*/
        let colors = document.getElementsByClassName("btn_seat_stus");
        for(let i = 0; i < colors.length; i++){
        	if(colors[i].dataset.color[0] === store.bstore.seatStusCd)
        		colors[i].className += " curStus";
        }
	})
};

showStoreInfo(storeId);

//매장의 착석 상태 코드를 변경한다.
function putChangeStatusCd(params,callback,error) {
	
	let storeId = params.storeId,
		seatStusCd = params.seatStusCd;
	
    $.ajax({
        type:'put',
        url:'/dealight/business/manage/board/seat/'+storeId+'/'+seatStusCd,
        data : {},
        contentType : "application/json",
        success : function(result, status, xhr) {
            if(callback) {
                callback(result);
            }
        },
        error : function(xhr, status, er) {
            if(error) {
                error(er);
            }               
        }
    });
    
    }

let changeSeatStusHandler = function(e) {
	
    e.preventDefault();
    
    let color = "";

    let param = {};
    param.storeId = storeId;
    
    if(e.target.dataset.color) param.seatStusCd = e.target.dataset.color[0];
    if(e.target.parentNode.dataset.color) param.seatStusCd = e.target.parentNode.dataset.color[0];
    if(e.target.parentNode.parentNode.dataset.color) param.seatStusCd = e.target.parentNode.parentNode.dataset.color[0];
    
    //param.seatStusCd = e.target.dataset.color[0];
    $(".btn_seat_stus").removeClass("curStus");
    e.target.className += " curStus";
    
	putChangeStatusCd(param, function(result){
    	showStoreInfo(param.storeId);
	});
}
/* 매장 착석 상태 처리*/
$(".btn_seat_stus").on("click",changeSeatStusHandler);
</script>
<script>
	/* 정규식으로 파일 형식을 제한한다. */
	const regex = new RegExp("(.*>)\.(exe|sh|zip|alz)$");
	/*최대 파일 크기를 제어한다  */
	const maxSize = 5242880; /* 5MB */
	// add category ***페이지마다 변경 필요
	const category = 'menuImgs';
	// page type
	const pageType = "register";
	// isModal
	const isModal = false;
	// btn id
	let btnSubmit = "#submit_menuRegForm";
	/* form 역할을 하는 엘리먼트를 선택한다. */
	let formObj = $("#regForm");
</script>
<script type="text/javascript" src="/resources/js/singleFileUpload.js?ver=1"></script>
<script>
/* 동인  */

	const menuUl = $(".menu_content");

	// 모달 선택
	const modal = $("#myModal"),
		close = $(".close"),
		modalContent = $(".modal-content"),
		btn_show_board = $("#btn_show_board");

	close.on("click", (e) => {
		modal.css("display","none");
		modal.find("ul").html("");
	});
	
	window.onclick = function(e) {
		
		  if (e.target === document.getElementById('myModal')) {
			  modal.css("display","none");
			  modal.find("ul").html("");
		  }
	};
	
    // esc 눌러서 모달 escape
    $(document).keyup(function(e) {
    	if(e.key === "Escape"){
    		modal.css("display","none");
    		modal.find("ul").html("");
    	}
    });
	
	/** REST FUL 대기 **/
	let menuService = (() => {
		
		/* 매장 내용 변경 put */
		function putModifyMenu(params, callback,error ){
			
			$.ajax({
				
				type : 'put',
				url : '/dealight/business/manage/menu/modify',
				data : {
					'storeId' : params.storeId,
					'menuSeq' : params.menuSeq,
					'name' : params.name,
					'price' : params.price,
					'recoMenu' : params.recoMenu,
					'imgUrl' : params.imgUrl,
					'thumImgUrl' : params.thumImgUrl
						},
			contentType : 'application/json',
			success : function(result, status, xhr) {
				if(callback) {
					callback(result);
				}
			},
			error : function(xhr, status, er) {
				if(error) {
					error(er);
				}
			}
			});
		}
		
	});

	

/* 페이지가 로드 되면 실행된다. */
$(document).ready(function(e){
    
	let showMenuModalHandler = function(e) {
		
			let menuSeq = $(e.target).parent().find(".menuSeq").text(),
			storeId = $(e.target).parent().find(".storeId").text(),
			name = $(e.target).parent().find(".name").text(),
			price = $(e.target).parent().find(".price").text(),
			recoMenu = $(e.target).parent().find(".recoMenu").text(),
			imgUrl = $(e.target).parent().find(".imgUrl").text(),
			thumImgUrl = $(e.target).parent().find(".thumImgUrl").text().trim();
		
		console.log(menuSeq);
		
		recoCheck = '';
		
		if(recoMenu === 'Y')
			recoCheck = 'checked';
		
		let strMenu = "";
		
		
		strMenu += "<div class='modal_tit'>";
		strMenu += "<span>메뉴 수정</span>";
		strMenu += "</div>";
		strMenu += "<div class='modal_top'>";
		strMenu += "<div class='menu_reg_wrapper modal_menu'>";
		strMenu += "<form id='menuForm_modify' action='' method='post'>";
		strMenu += "<input type='text' name='storeId' value='"+storeId+"' hidden>";
		strMenu += "<input type='text' name='menuSeq' value='"+menuSeq+"' hidden>";
		strMenu += "<div class='menu_la_in'>";
		strMenu += "<label>메뉴 이름</label>";
		strMenu += "<input type='text' name='name' value='"+name+"'>";
		strMenu += "</div>";
		strMenu += "<div class='menu_la_in'>";
		strMenu += "<label>메뉴 가격</label>";
		strMenu += "<input type='number' name='price' value='"+price+"'>";
		strMenu += "</div>";
		strMenu += "<div class='menu_la_in'>";
		strMenu += "<label>추천 여부</label>";
		strMenu += "<input type='checkbox' name='recoMenu' class='reco_menu' "+recoCheck+">";
		strMenu += "</div>";
		strMenu += "<div>";
		strMenu += "<div><h2>사진 첨부하기(1개만 가능)</h2></div>";
		strMenu += "<div class='file_body_modify'>";
		strMenu += "<div class='form_img_modify'>";
		strMenu += "<input type='file' id='js_upload' name='uploadFile'>";
		strMenu += "</div>";
		strMenu += "<div class='uploadResult_modify'>";
		strMenu += "<ul>";
		
		if(imgUrl){			
			strMenu += "<li data-imgurl='"+imgUrl+"' data-thumimgurl='"+thumImgUrl+"'><div>";
			strMenu += "<span> " + imgUrl + "</span>";
			strMenu += "<button type='button' ";
			strMenu += "class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
			strMenu += "<img class='menu_img_mdoal' src='/display?fileName="+encodeURI(thumImgUrl)+"'>";
			strMenu += "</div></li>";
		}
		
		
		strMenu += "</ul></div></div>";
		strMenu += "<div class='bigPictureWrapper_modify'><div class='bigPicture_modify'></div></div>";
		if(imgUrl) strMenu += "<input hidden name='imgUrl' value='"+imgUrl+"'>";
		if(imgUrl) strMenu += "<input hidden name='thumImgUrl' value='"+thumImgUrl+"'>";
		strMenu += "<button data-oper='modify' class='btn_modify modal_menu'>수정</button>";
		strMenu += "<button data-oper='remove' class='btn_remove modal_menu'>제거</button>";
		strMenu += "</form>";
		strMenu += "</div>";

		$(".menu_content").html(strMenu);
		modal.css("display", "block");
		
		var btnSubmit_modify = ".btn_modify";
		var formObj_modify =  $("#menuForm_modify");
		
		let showUploadResult_modify = function (uploadResultArr) {
	        
	        /**업로드 된게 없으면 그대로 반환 */
			if(!uploadResultArr || uploadResultArr.length == 0){return; }
	        
	        /*업로드 결과를 보여줄 ul를 선택 */
			let uploadUL_modify = $(".uploadResult_modify ul");
			
			let str = "";
	        
	        /*업로드 결과를 보여준다. */
			$(uploadResultArr).each(function(i,obj){
				
	            /* 만일 파일이 이미지 형식이면 */
	            /* data에 path,uuid,filename,type을 각각 저장한다. */
				
				if(i === 0) // 파일 1개만 올릴 수 있게
				if(obj.image) {
					let fileCallPath = encodeURIComponent(obj.uploadPath+"/s_"+obj.uuid+"_"+obj.fileName);
					
					// 
					let originPath = obj.uploadPath + "\\" + obj.uuid +"_" + obj.fileName;
					originPath = originPath.replace(new RegExp(/\\/g),"/");
					
					str += "<li data-path='" + obj.uploadPath +"'";
					str += "data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"'data-type='"+obj.image+"'";
					str += "><div>";
					str += "<span>" + obj.fileName +"</span>";
					str += "<img src='/display?fileName=" + fileCallPath + "'>";
					str += "</div>";
					str += "<button type ='button' data-file=\'"+fileCallPath+"\' data-type='image'"
								+" class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
					str += "</li>";
	                /* 만일 파일이 이미지 형식이 아니면 */
	                /* default img를 보여준다. */
				} else {
					let fileCallPath = encodeURIComponent(obj.uploadPath + "/" + obj.uuid + "_" + obj.fileName);
					let fileLink = fileCallPath.replace(new RegExp(/\\/g),"/");

					str += "<li "
					str += "data-path='" + obj.uploadPath + "'data-uuid='" + obj.uuid + "'data-filename='" + obj.fileName + "' data-type='" +obj.image+"'>" + "<div>";
					str += "<span> " + obj.fileName + "</span>";
					str += "<img src='/resources/img/attach.png'>";
					str += "</div>";
					str += "<button type='button' data-file=\'"+fileCallPath+"\'data-type='file' class='btn btn-warning btn-circle'><i class='fa fa-times'></i>삭제</button><br>";
					str += "</li>";
				}
			});
	        
			uploadUL_modify.html(str);
		}
	    
		var inputHandler_modify = function(e){
		        
		        /* 기존 기능은 제한한다.*/
				e.preventDefault();
				
				let str = "";
		        
		        /* 업로드 결과 화면에 업로드 결과를 작성해준다.*/
		        /* jquery의 foreach문 */
				$(".uploadResult_modify ul li").each(function(i, obj) {
					
					let jobj = $(obj);
					if(jobj.data("imgurl")){
						$("#menuForm_modify").find("input[name='imgUrl']").val(jobj.data("imgurl"));
						$("#menuForm_modify").find("input[name='thumbImgUrl']").val(jobj.data("thumimgurl"));						
					} else {
						$("#menuForm_modify").find("input[name='imgUrl']").val(jobj.data("path").replace(new RegExp(/\\/g),"/")+"/"+jobj.data("uuid")+"_"+jobj.data("filename"));
						$("#menuForm_modify").find("input[name='thumImgUrl']").val(jobj.data("path").replace(new RegExp(/\\/g),"/")+"/"+"s_"+jobj.data("uuid")+"_"+jobj.data("filename"));						
					}
					
				});
		        	
		        /*위에서 작성한 글을 form에 추가하고 제출한다. */
		        formObj_modify.attr("action","/dealight/business/manage/menu/modify");
		        formObj_modify.attr("method", "post");
		        formObj_modify.submit();
			
		};
		
	    
	    /* change() 해당하는 요소의 value에 변화가 생길 경우 이를 감지하여 등록된 콜백함수를 동작시킨다.  */
		var uploadHandler_modify = function(e){
			
	    	console.log("change event");
	    	
	    	let cloneObj = $(".form_img_modify").clone();
	        
	        let formData = new FormData();
	        
	        let inputFile = $("#js_upload");
	        
	        let files = inputFile[0].files;
	        
			formData.append("category", category);
			
	            if(!checkExtension(files[0].name, files[0].size)) {
	                return false;
	            }
	            formData.append("uploadFile", files[0]);
	        
	        $.ajax({
	            url : '/uploadAjaxAction',
	            processData : false,
	            contentType : false, data:
	                formData, type: 'POST',
	                dataType : 'json',
	                success : function(result) {
	                	showUploadResult_modify(result); // 업로드 결과 처리 함수
	               	 	$(".form_img_modify").html(cloneObj.html()); // 첨부파일 개수 초기화
	               	 	$("#js_upload").change(uploadHandler_modify); // 이벤트 등록 (재귀)
	                }
	        })
	    };
	
	    /* 업로드 결과를 누르면 해당 파일을 제거한다.  */
		var deleteHandler_modify = function(e){
			
			console.log("delete file");
			
			if(!confirm("Remove this file?"))
							return;
			
			  		let targetFile = $(this).data("file");
					console.log(targetFile);
			
					let type = $(this).data("type");
					console.log(type);
			
					let targetLi = $(this).closest("li");
					console.log(targetLi);
			
			$.ajax({
					url : '/deleteFile',
					data : {fileName : targetFile, type:type},
					dataType : 'text',
					type : 'POST',
					success : function(result) {
						alert(result);
						targetLi.remove();
					}
					}); // $.ajax
			};
	
		var showImage_modify = function (fileCallPath) {
			
			alert(fileCallPath);
			
			$(".bigPictureWrapper_modify").css("display","flex").show();
			
			$(".bigPicture_modify")
			.html("<img src='/display?fileName=" + fileCallPath + "'>")
			.animate({width:'100%',height:'100%'},1000);
			
			
		}// end show image
		
		var showImageHandler_modify = function(e) {
	    	
			if(e.target.type === "button")
	    		return;
	    	
	        let liObj = $(this);
	        
	        let path = encodeURIComponent(liObj.data("path")+ "/" + liObj.data("uuid") +"_" +liObj.data("filename"));
	        
	        if(liObj.data("type")){
	            
	            showImage_modify(path.replace(new RegExp(/\\/g), "/"));
	        } else {
	            //download
	            self.location = "/download?fileName=" + path
	        }
		};
		
		var bigImgAniHandler_modify = function (e) {
			$(".bigPicture_modify").animate({width:'0%',height:'0%'},1000);
			setTimeout(()=>{
				$(this).hide();
			}, 1000);
		}
		
		/* submit 타입의 버튼을 제어한다.*/
		$("#js_upload").change(uploadHandler_modify); 
		$(".uploadResult_modify").on("click", "button", deleteHandler_modify);
	    $(".uploadResult_modify").on("click", "li", showImageHandler_modify);
		$(".bigPictureWrapper_modify").on("click",bigImgAniHandler_modify);
		$(".btn_modify").on("click", inputHandler_modify);
		$(".btn_remove").on("click", function(e){
			
			e.preventDefault();
			
			if(confirm("정말로 삭제하시겠습니까?")){
				formObj_modify.attr("method", "post");
				formObj_modify.attr("action", "/dealight/business/manage/menu/delete").submit();
			} else {
				return;
			}
		});
		
	} // show menu
	
	$(".menu > *").on("click", showMenuModalHandler);
	
}); // ready end
</script>
<%@include file="../../../../includes/mainFooter.jsp" %>
</body>
</html>