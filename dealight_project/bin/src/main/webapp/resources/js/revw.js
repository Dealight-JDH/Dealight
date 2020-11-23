console.log("Revw Module...............");


var revwService = (function(){
	function getList(param, callback, error){
		var storeId = param.storeId;
		var page = param.page || 1;
		
		$.getJSON("/revws/pages/"+storeId+"/"+page+".json",
				function(data){
			if(callback){
				//callback(data);
				callback(data.revwCnt,data.list);
			}
		}).fail(function(xhr, status, err){
			if(error){
				error();
			}
		});
	}
	return {getList:getList};
})();