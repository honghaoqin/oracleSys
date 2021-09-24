//加载列表数据
function gotoList(ctx){
	$("#isview").val("");
	$("#position_add").text("查询");
	var  pageSize=$("#page_pageSize").val();
	var  pageNumber=$("#page_pageNumber").val();
	var  user_name=$("#SEARCH_USER_NAME").val();
	var  auth_id=$("#SEARCH_AUTH_ID").val();
	var  auth_name=$("#SEARCH_AUTH_NAME").val();
	loading(ctx,"loadList");
	$("#loadList").load(ctx+"/sys/AuditLog/loadList.do?"+Math.random(),
		 {'page.pageSize':pageSize,'page.pageNumber':pageNumber,
		  'formMap.USER_NAME':user_name,'formMap.AUTH_ID':auth_id,
		  'formMap.AUTH_NAME':auth_name}, function(){});
}
