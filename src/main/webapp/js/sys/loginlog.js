function gotoList(ctx){
	$("#loaddata").html("");
	$("#isview").val("");
	$("#position_add").text("查询");
	var  pageSize=$("#page_pageSize").val();
	var  pageNumber=$("#page_pageNumber").val();
	loading(ctx,"loadList");
	$("#loadList").load(ctx+"/sys/LoginLog/loadList.do?"+Math.random(),
		 {'page.pageSize':pageSize,'page.pageNumber':pageNumber
		 }, function(){});
}


