let msg = {
    "object_type": "location",
    "content": {
        "title": "임종똥 분식",
        "description": "돈까스가 맛있는 임종똥 분식",
        "image_url": "http://localhost:8080/display?fileName=2020%5C11%5C15%2Fs_0b0c247f-9557-49d2-80ec-715b91dec301_mat.png",
        "image_width": 800,
        "image_height": 800,
        "link": {
        "web_url": "http://localhost:8080/business/manage/board?storeId=101",
        "mobile_web_url": "http://localhost:8080/business/manage/board?storeId=101",
        "android_execution_params": "platform=android",
        "ios_execution_params": "platform=ios"
        }
    },
    "buttons": [
        {
        "title": "웹으로 보기",
        "link": {
            "web_url": "http://localhost:8080/business/manage/board?storeId=101",
            "mobile_web_url": "http://localhost:8080/business/manage/board?storeId=101e"
        }
        }
    ],
    "address": "서울 종로구 종로 69",
    "address_title": "종각역 YMCA 임종똥 분식"
};

msgToMe(msg);


function msgToMe(msg, callback,error) {

    let token = "MSlf43G_nM-V9t1DER0xYolbzRsf8Qkn7ZSVewopb9QAAAF1ytRdMA";
    
        $.ajax({
            type : 'post',
            url : 'https://kapi.kakao.com/v2/api/talk/memo/default/send',
            data : JSON.stringify(msg),
            contentType : "application/x-www-form-urlencoded; charset=utf-8",
            beforeSend : function(xhr){
                xhr.setRequestHeader("Authorization", "Bearer " + token);
            },
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