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
				 $("#loadList").load(ctx+"/sys/Auth/loadList.do?"+Math.random(),{'formMap.isShow':'Y'}, function(){});
				//加载修改界面
				 $("#loaddata").html("");
				}else if(data["MSG"]=='数据修改成功!'){
				loading(ctx,"loadList");		
				 $("#loadList").load(ctx+"/sys/Auth/loadList.do?"+Math.random());
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
	$("#callForm").attr("action",ctx+"/sys/Auth/add.do");
	loading(ctx,"loaddata");	
	$("#loaddata").load(ctx+"/sys/Auth/loadAdd.do?"+Math.random());
}
//加载修改界面
function  gotoEdit(ctx){
	if(checkSelected(false)){
	$("#isview").val("edit");
	$("#position_add").text("修改");
	var id = $("input[class='IDS']:checked").val();
	loading(ctx,"loaddata");
	$("#callForm").attr("action",ctx+"/sys/Auth/edit.do");
    $("#loaddata").load(ctx+"/sys/Auth/loadEdit.do?formMap.AUTH_ID="+id+"&"+Math.random());
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
	$("#deleteForm").find("input[name='formMap.AUTH_ID']").remove();
	$("<input name='formMap.AUTH_ID' value='"+id+"' type='hidden'/>").appendTo("#deleteForm");
	var  action=ctx+"/sys/Auth/del.do";
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
			$("#loadList").load(ctx+"/sys/Auth/loadList.do?formMap.isShow=Y&"+Math.random());
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
	$("#callForm").attr("action",ctx+"/sys/Auth/add.do");
    $("#loaddata").load(ctx+"/sys/Auth/loadView.do?formMap.AUTH_ID="+id+"&"+Math.random());
}
 //加载列表数据
function gotoList(ctx){
	$("#isview").val("");
	$("#position_add").text("查询");
	var  pageSize=$("#page_pageSize").val();
	var  pageNumber=$("#page_pageNumber").val();
    var  name=$("#SEARCH_NAME").val();
    var  auth_id=$("#SEARCH_AUTH_ID").val();
    var  parent_id=$("#SEARCH_PARENT_ID").val();
    var  menu=$("#SEARCH_MENU").val();
    $("#loaddata").empty();
	$("#loadList").empty();
    loading(ctx,"loadList");
	$("#loadList").load(ctx+"/sys/Auth/loadList.do?"+Math.random(),
     {'formMap.PARENT_ID':parent_id,'formMap.AUTH_ID':auth_id,'formMap.NAME':name,
	  'formMap.MENU':menu,'page.pageSize':pageSize,'page.pageNumber':pageNumber}, function(){});
	
}

function gotoMoveUpDown(ctx,varid,step){
	$.post(ctx+"/sys/Auth/moveUpDown.do?r="+Math.random(),{"formMap.ID":varid,"formMap.STEP":step}
	,function(){
		gotoList(ctx);
	});	
  
  }
