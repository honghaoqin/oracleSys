//保存数据	
function saveData(ctx){
if (Validator.Validate($("#callForm")[0], 2)) {
	  var id = $("input[class='IDS']:checked").val();
	  var  action=$("#callForm").attr("action");
		$.ajax({
			url     : action+"?"+Math.random(),
			type    :   "POST",                     // 请求的方式:"POST" 或者 "GET"
			dataType:   "JSON",                     // 数据返回的格式
			async	:    false, 
			data: $('#callForm').serialize(),
			success :   function(data){
				alert(data["MSG"]);
				if(data["MSG"]=='数据新增成功!'){
				loading(ctx,"loadList");		
				 $("#loadList").load(ctx+"/sys/User/loadList.do?"+Math.random(),{'formMap.isShow':'Y'}, function(){});
				//加载修改界面
				 $("#loaddata").html("");
				}else if(data["MSG"]=='数据修改成功!'){
				loading(ctx,"loadList");		
				 $("#loadList").load(ctx+"/sys/User/loadList.do?"+Math.random());
				}else if(data["MSG"]=='角色分配成功!'){
				loading(ctx,"loaddata");		
				$("#loaddata").load(ctx+"/sys/User/loadAssignRole.do?formMap.USER_ID="+id+"&"+Math.random());
				}else if(data["MSG"]=='用户组分配成功!'){
			    loading(ctx,"loaddata");	
				$("#loaddata").load(ctx+"/sys/User/loadAssignGroup.do?formMap.USER_ID="+id+"&"+Math.random());
				}else{
				   return;
				}
			},
		    error:function(){
			alert("系统异常,请联系系统管理员！");
		  }
		 });
	}		
}
//加载新增界面
function gotoAdd(ctx){
    $("#isview").val("add");
	$("#position_add").text("新增");
	loading(ctx,"loaddata");
	$("#callForm").attr("action",ctx+"/sys/User/add.do");
	loading(ctx,"loaddata");	
	$("#loaddata").load(ctx+"/sys/User/loadAdd.do?"+Math.random());
}
//加载修改界面
function  gotoEdit(ctx){
	if(checkSelected(false)){
	$("#isview").val("edit");
	$("#position_add").text("修改");
	var id = $("input[class='IDS']:checked").val();
	loading(ctx,"loaddata");
	$("#callForm").attr("action",ctx+"/sys/User/edit.do");
    $("#loaddata").load(ctx+"/sys/User/loadEdit.do?formMap.USER_ID="+id+"&"+Math.random());
 }	
}		
function gotoDel(ctx){
	if(checkSelected(true)){
		if(!confirm("是否确定删除?")){
			return false;
		}
		$("#isview").val("delete");
		$("#position_add").text("删除");
		var id = "";
		$("input[class='IDS']:checked").each(function(i){
			if(i!=0){
				id+=",";
			}
			id += this.value;
		});
	$("#deleteForm").find("input[name='formMap.USER_ID']").remove();
	$("<input name='formMap.USER_ID' value='"+id+"' type='hidden'/>").appendTo("#deleteForm");
	var  action=ctx+"/sys/User/del.do";
	$.ajax({
		url     : action+"?"+Math.random(),
		type    :   "POST",                     // 请求的方式:"POST" 或者 "GET"
		dataType:   "JSON",                     // 数据返回的格式
		async	:    false, 
		data: $('#deleteForm').serialize(),
		success :   function(data){
			alert(data["MSG"]);
			if(data["MSG"]=='数据删除成功!'){
		    loading(ctx,"loadList");	
			$("#loadList").load(ctx+"/sys/User/loadList.do?formMap.isShow=Y&"+Math.random());
			$("#loaddata").html("");
			}else{
			return;
			}
		},
	error:function(){
		alert("系统异常,请联系系统管理员！");
	}
	});	
}
}

 //加载查看界面
function loadView(ctx,id){
	$("#isview").val("view");
	$("#position_add").text("查看");
	$(".IDS").attr("checked",false);
	$("#"+id).attr("checked",true);
	loading(ctx,"loaddata");
	$("#callForm").attr("action",ctx+"/sys/User/add.do");
    $("#loaddata").load(ctx+"/sys/User/loadView.do?formMap.USER_ID="+id+"&"+Math.random());
}
 //加载列表数据
function gotoList(ctx){
	$("#isview").val("");
	$("#position_add").text("查询");
	var  pageSize=$("#page_pageSize").val();
	var  pageNumber=$("#page_pageNumber").val();
    var  LOGIN_ID=$("#SEARCH_LOGIN_ID").val();
    var  TYPE_ID=$("#SEARCH_TYPE_ID").val();
    loading(ctx,"loadList");
	$("#loadList").load(ctx+"/sys/User/loadList.do?"+Math.random(),
     {'formMap.LOGIN_ID':LOGIN_ID,'formMap.TYPE_ID':TYPE_ID,
	 'page.pageSize':pageSize,'page.pageNumber':pageNumber}, function(){});
	 $("#loaddata").html("");
}
