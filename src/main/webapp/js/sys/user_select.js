function gotoList(ctx){
	showdiv();
	$("#callForm").attr("action",ctx+"/sys/User/select.do").submit();
}
function doGotoPage(ctx){
	gotoList(ctx);
}
function checkSelected(mutil){
	if(mutil==null){
		mutil = false;
	}
	var checkedSizes = $("input[class='IDS']:checked").length;
	if(checkedSizes==0){
		if(mutil){
			alert("请选择一条或多条记录");
		}else{
			alert("请选择一条记录");
		}
		return false;
	}else if(!mutil && checkedSizes>1){
		alert("请选择一条记录");
		return false;
	}
	return true;
}
function selectAll(c){
	$(".IDS").attr("checked",c);
}
