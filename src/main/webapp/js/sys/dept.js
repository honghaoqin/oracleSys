//保存数据	
function saveData(ctx){
	
if (Validator.Validate($("#callForm")[0], 2)) {
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
				 $("#loadList").load(ctx+"/sys/Dept/loadList.do?"+Math.random(),{'formMap.isShow':'Y'},
				                function(){$("#loaddata").html("");});
				}else if(data["MSG"]=='数据修改成功!'){
				 $("#loadList").load(ctx+"/sys/Dept/loadList.do?"+Math.random(),{'formMap.isShow':'Y'},
				                function(){$("#loaddata").html("");});
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
	$("#callForm").attr("action",ctx+"/sys/Dept/add.do");
	$("#loaddata").load(ctx+"/sys/Dept/loadAdd.do?"+Math.random());
}
//加载修改界面
function  gotoEdit(ctx){
	if(checkSelected(false)){
	$("#isview").val("edit");
	$("#position_add").text("修改");
	var id = $("input[class='IDS']:checked").val();
	loading(ctx,"loaddata");
	$("#callForm").attr("action",ctx+"/sys/Dept/edit.do");
    $("#loaddata").load(ctx+"/sys/Dept/loadEdit.do?formMap.DEPT_ID="+id+"&"+Math.random());
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
	$("#deleteForm").find("input[name='formMap.DEPT_ID']").remove();
	$("<input name='formMap.DEPT_ID' value='"+id+"' type='hidden'/>").appendTo("#deleteForm");
	var  action=ctx+"/sys/Dept/del.do";
	$.ajax({
		url     : action+"?"+Math.random(),
		type    :   "POST",                     // 请求的方式:"POST" 或者 "GET"
		dataType:   "JSON",                     // 数据返回的格式
		async	:    false, 
		data: $('#deleteForm').serialize(),
		success :   function(data){
			alert(data["MSG"]);
			if(data["MSG"]=='数据删除成功!'){
			$("#loadList").load(ctx+"/sys/Dept/loadList.do?formMap.isShow=Y&"+Math.random());
			$("#loaddata").load(ctx+"/sys/Dept/loadAdd.do?"+Math.random());
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
	$("#ID_"+id).attr("checked",true);
	loading(ctx,"loaddata");
	$("#callForm").attr("action",ctx+"/sys/Dept/add.do");
    $("#loaddata").load(ctx+"/sys/Dept/loadView.do?formMap.DEPT_ID="+id+"&"+Math.random());
}
 //加载列表数据
function loadList(ctx){
	  $("#loadList").load(ctx+"/sys/Dept/loadList.do?"+Math.random());
}
function gotoList(ctx){
	$("#loaddata").html("");
	$("#isview").val("");
	$("#position_add").text("查询");
	var  pageSize=$("#page_pageSize").val();
	var  pageNumber=$("#page_pageNumber").val();
	  var  NAME=$("#SEARCH_NAME").val();					
     loading(ctx,"loadList");
	$("#loadList").load(ctx+"/sys/Dept/loadList.do?"+Math.random(),
     {'formMap.NAME':NAME,'page.pageSize':pageSize,'page.pageNumber':pageNumber}, function(){});
}
