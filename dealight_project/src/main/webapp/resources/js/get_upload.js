
$(document).ready(function() {
	

    (function(){
        
    	//let storeId = ${storeId};
        
        $.getJSON("/business/manage/getStoreImgs", {storeId:storeId}, function(imgs){
            
            console.log("즉시 함수..");
            
            console.log(imgs);
            
            let str = "";
            
            $(imgs).each(function(i, img){
            	
            	console.log(img);
                
                // image type
                if(img.image) {
                    
                    let fileCallPath = encodeURIComponent(img.uploadPath+"/s_" +img.uuid + "_" +img.fileName);
                    
                    str += "<li data-path='" + img.uploadPath + "'data-uuid='" + img.uuid + "'data-filename='"
                        + img.fileName +"'data-type='" + img.image+"'><div>";
                    str += "<img src='/display?fileName=" + fileCallPath+"'>";
                    str += "</li>";
                    
                } else {
                    
                    str += "<li data-path='" + img.uploadPath +"' data-uuid='" + img.uuid 
                            +"' data-filename='" + img.fileName +"' data-type='" + img.image+"'><div>";
                    str += "<span>" + img.fileName+"</span><br/>";
                    str += "<img src='/resources/img/attach.png'>";
                    str += "</div>";
                    str += "</li>";
                }
            });
            
            $(".uploadResult ul").html(str);
            
        }); // end getjson
        
    })(); // end function

    
    $(".uploadResult").on("click", "li", function(e){
        
        console.log("view image");
        
        let liObj = $(this);
        
        let path = encodeURIComponent(liObj.data("path")+ "/" + liObj.data("uuid") +"_" +liObj.data("filename"));
        
        if(liObj.data("type")){
            
            showImage(path.replace(new RegExp(/\\/g), "/"));
        } else {
            //download
            self.location = "/download?fileName=" + path
        }
    });
    
    function showImage(fileCallPath) {
        
        alert(fileCallPath);
        
        $(".bigPictureWrapper").css("display", "flex").show();
        
        $(".bigPicture")
        .html("<img src='/display?fileName=" + fileCallPath +"'>")
        .animate({width:'100%',height:'100%'},1000);
        
    }
    
    $(".bigPictureWrapper").on("click",function(e){
        $(".bigPicture").animate({width : '0%', height : '0%'}, 1000);
        setTimeout(function(){
            $('.bigPictureWrapper').hide();
        },1000);
    })


    var operForm = $("#operForm");
    
    $("button[data-oper='modify']").on("click", function(e){
        
        operForm.attr("action", "/board/modify").submit();
        
    });
    
    $("button[data-oper='list']").on("click",function(e){
        
        operForm.find("#bno").remove();
        operForm.attr("action","/board/list");
        operForm.submit();
        
    });
    
});
