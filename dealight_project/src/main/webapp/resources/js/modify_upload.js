$(document).ready(function(){
    
    let regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
    let maxSize = 5242880; // 5mb
    
function showUploadResult(uploadResultArr) {
        
        if(!uploadResultArr || uploadResultArr.length == 0){return; }
        
        let uploadUL = $(".uploadResult ul");
        
        let str = "";
        
        $(uploadResultArr).each(function(i,obj){
            
            if(obj.image) {
                let fileCallPath = encodeURIComponent(obj.uploadPath+"/s_"+obj.uuid+"_"+obj.fileName);
                str += "<li data-path='" + obj.uploadPath +"'";
                str += "data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"'data-type='"+obj.image+"'";
                str += "><div>";
                str += "<span>" + obj.fileName +"</span>";
                str += "<button type ='button' data-file=\'"+fileCallPath+"\'data-type='image' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
                str += "<img src='/display?fileName=" + fileCallPath + "'>";
                str += "</div>";
                str += "</li>";
                
            } else {
                let fileCallPath = encodeURIComponent(obj.uploadPath + "/" + obj.uuid + "_" + obj.fileName);
                let fileLink = fileCallPath.replace(new RegExp(/\\/g),"/");

                str += "<li "
                str += "data-path='" + obj.uploadPath + "'data-uuid='" + obj.uuid + "'data-filename='" + obj.fileName + "' data-type='" +obj.image+"'><div>";
                str += "<span> " + obj.fileName + "</span>";
                str += "<button type='button' data-file=\'"+fileCallPath+"\'data-type='file' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
                str += "<img src='/resources/img/attach.png'></a>";
                str += "</div>";
                str += "</li>";
            }
        });
        uploadUL.append(str);
    }
    
    function checkExtension(fileName, fileSize) {
        if(fileSize >= maxSize){
            alert("파일 사이즈 초과");
            return false;
        }
        
        if(regex.test(fileName)) {
            alert("해당 종류의 파일은 업로드 할 수 없습니다.");
            return false;
        }
        return true;
    }
    
    $("input[type='file']").change(function(e){
        
        let formData = new FormData();
        
        let inputFile = $("input[name='uploadFile']");
        
        let files = inputFile[0].files;
        
        for(let i = 0; i < files.length; i++){
            
            if(!checkExtension(files[i].name, files[i].size)) {
                return false;
            }
            formData.append("uploadFile", files[i]);
        }
        
        $.ajax({
            url : '/uploadAjaxAction',
            processData : false,
            contentType : false, data:
                formData, type: 'POST',
                dataType : 'json',
                success : function(result) {
                console.log(result);
                showUploadResult(result); // 업로드 결과 처리 함수
                }
            
            
        })
        
    });
    
    (function(){
        
        let storeId = '<c:out value="${storeId}"/>';
        
        $.getJSON("/business/manage/getStoreImage", {storeId:storeId}, function(storeImageList){
            
            console.log("즉시 함수..");
            
            console.log(storeImageList);
            
            let str = "";
            
            $(storeImageList).each(function(i, image){
                
                // image type
                if(image.fileType) {
                    
                    let fileCallPath = encodeURIComponent(image.uploadPath+"/s_" +image.uuid + "_" +image.fileName);
                    
                    str += "<li data-path='" + image.uploadPath + "'data-uuid='" + image.uuid + "'data-filename='"
                        + image.fileName +"'data-type='" + image.fileType+"'><div>";
                    str += "<span> " + image.fileName + "</span>";
                    str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='image'";
                    str += "class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
                    str += "<img src='/display?fileName=" + fileCallPath+"'>";
                    str += "</li>";
                    
                } else {
                    
                    str += "<li data-path='" + image.uploadPath +"' data-uuid='" + image.uuid 
                            +"' data-filename='" + image.fileName +"' data-type='" + image.fileType+"'><div>";
                    str += "<span>" + image.fileName+"</span><br/>";
                    str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='file'";
                    str += "class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
                    str += "<img src='/resources/img/attach.png'>";
                    str += "</div>";
                    str += "</li>";
                }
            });
            
            $(".uploadResult ul").html(str);
            
        }); // end getjson
        
    })(); // end function
    
    
    var formObj = $("form");
    
    $('button').on("click",function(e){
        
        e.preventDefault();
        
        var operation = $(this).data("oper");
        
        console.log(operation);
        
        if (operation === 'modify') {
            
            console.log("submit clicked");
            
            let str ="";
            
            $(".uploadResult ul li").each(function(i, obj) {
                
                let jobj = $(obj);
                
                console.dir(jobj);
                
                str += "<input type='hidden' name='storeImageList["+i+"].fileName' value='" + jobj.data("filename")+"'>";
                str += "<input type='hidden' name='storeImageList["+i+"].uuid' value='" + jobj.data("uuid")+"'>";
                str += "<input type='hidden' name='storeImageList["+i+"].uploadPath' value='" + jobj.data("path")+"'>";
                str += "<input type='hidden' name='storeImageList["+i+"].fileType' value='" + jobj.data("type")+"'>";
            });
            formObj.append(str).submit();
        }
        formObj.submit();
        
    });
    
    $(".uploadResult").on("click", "button", function(e){
    
        console.log("delete file");
        
        if(confirm("Remove this file?")) {
            
            let targetLi = $(this).closest("li");
            targetLi.remove();
        }
        
    });
    
    
});