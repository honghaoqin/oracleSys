//保存数据	
function saveData(ctx){
if (Validator.Validate($("#callForm")[0], 2)) {
    var  pageSize=$("#page_pageSize").val();
	var  pageNumber=$("#page_pageNumber").val();
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
				 gotoList(ctx);
				}else if(data["MSG"]=='数据修改成功!'){
				 loading(ctx,"loadList");		 
				 $("#loadList").load(ctx+"/sys/Partner/loadList.do?"+Math.random()
				 ,{'formMap.isShow':'Y','page.pageSize':pageSize,'page.pageNumber':pageNumber}
				 , function(){
				 $("#ID_"+id).attr("checked",true);
				  });
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
//加载新增界面
function gotoAdd(ctx){
    $("#isview").val("add");
    $("#posNext").removeClass("posNext"); 
    $("#posNext").attr("class","posNext");
	$("#position_add").text("新增伙伴");
	loading(ctx,"loaddata");
	$("#callForm").attr("action",ctx+"/sys/Partner/add.do");
	loading(ctx,"loaddata");		
	$("#loaddata").load(ctx+"/sys/Partner/toAdd.do?"+Math.random());
}
//加载修改界面
function  gotoEdit(ctx){
	if(checkSelected(false)){
	$("#isview").val("edit");
	$("#posNext").removeClass("posNext"); 
    $("#posNext").attr("class","posNext");
	$("#position_add").text("修改伙伴");
	var id = $("input[class='IDS']:checked").val();
	loading(ctx,"loaddata");
	$("#callForm").attr("action",ctx+"/sys/Partner/edit.do");
    $("#loaddata").load(ctx+"/sys/Partner/toEdit.do?formMap.PARTNER_ID="+id+"&"+Math.random());
 }	
}
function gotoDel(ctx){
	if(checkSelected(true)){
		if(!confirm("是否确定删除?")){
			return false;
		}
		$("#isview").val("delete");
		$("#posNext").removeClass("posNext"); 
        $("#posNext").attr("class","posNext");
		$("#position_add").text("删除伙伴");
		var id = "";
		$("input[class='IDS']:checked").each(function(i){
			if(i!=0){
				id+=",";
			}
			id += this.value;
		});
	$("#deleteForm").find("input[name='formMap.PARTNER_ID']").remove();
	$("<input name='formMap.PARTNER_ID' value='"+id+"' type='hidden'/>").appendTo("#deleteForm");
	var  action=ctx+"/sys/Partner/del.do";
	$.ajax({
		url     : action+"?"+Math.random(),
		type    :   "POST",                     // 请求的方式:"POST" 或者 "GET"
		dataType:   "JSON",                     // 数据返回的格式
		async	:    false, 
		data: $('#deleteForm').serialize(),
		success :   function(data){
			alert(data["MSG"]);
			if(data["MSG"]=='数据删除成功!'){
			 gotoList(ctx);
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
function gotoView(ctx,id){
	$("#isview").val("view");
	$("#posNext").removeClass("posNext"); 
    $("#posNext").attr("class","posNext");
	$("#position_add").text("查看伙伴");
	$(".IDS").attr("checked",false);
	$("#ID_"+id).attr("checked",true);
	loading(ctx,"loaddata");
	$("#callForm").attr("action",ctx+"/sys/Partner/add.do");
    $("#loaddata").load(ctx+"/sys/Partner/toView.do?formMap.PARTNER_ID="+id+"&"+Math.random());
}
 //加载列表数据
function gotoList(ctx){
    $("#loaddata").html("");
	$("#isview").val("");
	$("#posNext").removeClass("posNext"); 
    $("#posNext").attr("class","posNext");
	$("#position_add").text("查询伙伴");
	var  pageSize=$("#page_pageSize").val();
	var  pageNumber=$("#page_pageNumber").val();
	var  name=$("#SEARCH_NAME").val();
	var  phone=$("#SEARCH_PHONE").val();
	var  partner_type=$("#SEARCH_PARTNER_TYPE").val();
     loading(ctx,"loadList");
	$("#loadList").load(ctx+"/sys/Partner/loadList.do?"+Math.random(),
     {'formMap.NAME':name,'formMap.PHONE':phone,'formMap.PARTNER_TYPE':partner_type,'page.pageSize':pageSize,'page.pageNumber':pageNumber}, function(){});
}
