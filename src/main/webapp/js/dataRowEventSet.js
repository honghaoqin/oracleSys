/********************** 设置表格列表的鼠标事件：鼠标移动到上面是显示当前行 *********************/
// 页面装载时运行
$(function(){
	//initRow();
	$(".listTable tr,.listTable th").not(".head").bind("mouseover",function(){
		$(this).addClass("overRow");
	}).bind("mouseout",function(){
		$(this).removeClass("overRow");
	})
	$(".level1Row.folder").live("click",function(){
		$(this).addClass("close").nextUntil(".level1Row").hide();
	})
	$(".level1Row.folder.close").live("click",function(){
		$(this).removeClass("close").nextUntil(".level1Row").show();
	})
	$(".level2Row.folder").live("click",function(){
		$(this).addClass("close").nextUntil(".level1Row,.level2Row").hide();
	})
	$(".level2Row.folder.close").live("click",function(){
		$(this).removeClass("close").nextUntil(".level1Row,.level2Row").show();
	})
})
function initRow(){
	$(".level2Row.folder").each(function(){
		if($(this).next(".level3Row")!=null){
			if($(this).nextUntil(".level3Row").css("display")=="none"){
				$(this).addClass("close")
			}else{
				$(this).removeClass("close")
			}
		}else{
		}
	})
}