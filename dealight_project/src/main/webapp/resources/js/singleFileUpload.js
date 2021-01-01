/* 페이지가 로드 되면 실행된다. */
	let getImg = function(storeId){
		
		console.log('store Id : '+storeId);
		console.log('page type : '+pageType);
		
		if(storeId === null || storeId < 1)
			return;
		
		if(pageType !== 'modify' && pageType !== 'get')
				return;

		
		console.log('get image pass');

		$.getJSON("/dealight/business/manage/getStoreImgs", {storeId:storeId}, function(imgs){
		    
		    console.log(imgs);
		    
		    let str = "";
		    
		    $(imgs).each(function(i, img){
		        
		        // image type
		        if(img.image) {
		            
		            let fileCallPath = encodeURIComponent(img.uploadPath+"/s_" +img.uuid + "_" +img.fileName);
		            
		            str += "<li data-path='" + img.uploadPath + "'data-uuid='" + img.uuid + "'data-filename='"
		                + img.fileName +"'data-type='" + img.image+"'><div>";
		            str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='image'";
		            str += "class='btn btn-warning btn-circle fileupload_img_btn'><i class='far fa-times-circle'></i></button><br>";
		            str += "<img src='/display?fileName=" + fileCallPath+"'>";
		            str += "</div></li>";
		            
		        } else {
		            
		            str += "<li data-path='" + img.uploadPath +"' data-uuid='" + img.uuid 
		                    +"' data-filename='" + img.fileName +"' data-type='" + img.image+"'><div>";
		            str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='image'";
		            str += "class='btn btn-warning btn-circle fileupload_img_btn'><i class='far fa-times-circle'></i></button><br>";
		            str += "<img src='/resources/img/attach.png'>";
		            str += "</div>";
		            str += "</li>";
		        }
		    });
		    
		    $(".uploadResult ul").html(str);
		    
		}); // end json
		
	}; // end function

    /*업로드 결과를 보여준다. */
	let showUploadResult = function (uploadResultArr) {
        
        /**업로드 된게 없으면 그대로 반환 */
		if(!uploadResultArr || uploadResultArr.length == 0){return; }
        
        /*업로드 결과를 보여줄 ul를 선택 */
		let uploadUL = $(".uploadResult ul");
		
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
				str += "<button type ='button' data-file=\'"+fileCallPath+"\' data-type='image'"
				+" class='btn btn-warning btn-circle fileupload_img_btn'><i class='far fa-times-circle'></i></button><br>";
				str += "<img src='/display?fileName=" + fileCallPath + "'>";
				str += "</div>";
				str += "</li>";
                /* 만일 파일이 이미지 형식이 아니면 */
                /* default img를 보여준다. */
			} else {
				let fileCallPath = encodeURIComponent(obj.uploadPath + "/" + obj.uuid + "_" + obj.fileName);
				let fileLink = fileCallPath.replace(new RegExp(/\\/g),"/");

				str += "<li "
				str += "data-path='" + obj.uploadPath + "'data-uuid='" + obj.uuid + "'data-filename='" + obj.fileName + "' data-type='" +obj.image+"'>" + "<div>";
				str += "<button type='button' data-file=\'"+fileCallPath+"\'data-type='file' class='btn btn-warning btn-circle fileupload_img_btn'><i class='far fa-times-circle'></i></button><br>";
				str += "<img src='/resources/img/attach.png'>";
				str += "</div>";
				str += "</li>";
			}
		});
        
		uploadUL.html(str);
	}
    
    /*파일 valid check */
	let checkExtension = function (fileName, fileSize) {
        
        /*파일 사이즈를 체크한다. */
        if(fileSize >= maxSize){
			alert("파일 사이즈 초과");
			return false;
		}
		/*파일 형식을 체크한다. */
		if(regex.test(fileName)) {
			alert("해당 종류의 파일은 업로드 할 수 없습니다.");
			return false;
		}
		return true;
	}
	
	let inputHandler = function(e){
	        
	        /* 기존 기능은 제한한다.*/
			e.preventDefault();
			
			let str = "";
	        
	        /* 업로드 결과 화면에 업로드 결과를 작성해준다.*/
	        /* jquery의 foreach문 */
			$(".uploadResult ul li").each(function(i, obj) {
				
				let jobj = $(obj);

				str += "<input type='hidden' name='imgUrl' value='" + jobj.data("path").replace(new RegExp(/\\/g),"/")+"/"+jobj.data("uuid")+"_"+jobj.data("filename")+"'>";
				str += "<input type='hidden' name='thumImgUrl' value='" + jobj.data("path").replace(new RegExp(/\\/g),"/")+"/"+"s_"+jobj.data("uuid")+"_"+jobj.data("filename")+"'>";
				
			});
			
			console.log(str);
	        	
	        /*위에서 작성한 글을 form에 추가하고 제출한다. */
			formObj.attr("method", "post");
			formObj.append(str).submit();
		
	};
	
    
    /* change() 해당하는 요소의 value에 변화가 생길 경우 이를 감지하여 등록된 콜백함수를 동작시킨다.  */
	let uploadHandler = function(e){
		
    	console.log("change event");
    	
    	let cloneObj = $(".form_img").clone();
        
        let formData = new FormData();
        
        let inputFile = $("input[name='uploadFile']");
        
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
                	showUploadResult(result); // 업로드 결과 처리 함수
               	 	$(".form_img").html(cloneObj.html()); // 첨부파일 개수 초기화
               	 	$("input[type='file']").change(uploadHandler); // 이벤트 등록 (재귀)
                }
        })
    };

    /* 업로드 결과를 누르면 해당 파일을 제거한다.  */
	let deleteHandler = function(e){
		
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

		
		
		
	let showImage = function (fileCallPath) {
		
		alert(fileCallPath);
		
		$(".bigPictureWrapper").css("display","flex").show();
		
		$(".bigPicture")
		.html("<img src='/display?fileName=" + fileCallPath + "'>")
		.animate({width:'100%',height:'100%'},1000);
		
		
	}// end show image
	
	let showImageHandler = function(e) {
    	
		if(e.target.type === "button")
    		return;
    	
        let liObj = $(this);
        
        let path = encodeURIComponent(liObj.data("path")+ "/" + liObj.data("uuid") +"_" +liObj.data("filename"));
        
        if(liObj.data("type")){
            
            showImage(path.replace(new RegExp(/\\/g), "/"));
        } else {
            //download
            self.location = "/download?fileName=" + path
        }
	};
	
	let bigImgAniHandler = function (e) {
		$(".bigPicture").animate({width:'0%',height:'0%'},1000);
		setTimeout(()=>{
			$(this).hide();
		}, 1000);
	}
	
	/* submit 타입의 버튼을 제어한다.*/
	if(btnSubmit) $(btnSubmit).on("click", inputHandler);
	if(!isModal) $("input[type='file']").change(uploadHandler);
	if(isModal)  $("#js_upload").change(uploadHandler); 
	$(".uploadResult").on("click", "button", deleteHandler);
    $(".uploadResult").on("click", "li", showImageHandler);
	$(".bigPictureWrapper").on("click",bigImgAniHandler);
	
	
	if(storeId) getImg(storeId);
