/*通用函数*/
$(function(){
	//默认滚动高度
	initH();
	$(window).resize(function(){
		initH();
	})
	//标签页切换
	$("ul.tabBar > li").click(switchTab); 
	//表单输入控件交互效果事件绑定
	$("input:text,textarea").bind("focus", function(){
		$(this).addClass("inputFocus");
	}).bind("blur", function(){
		$(this).removeClass("inputFocus");
	}); 
	//表单默认激活第一个输入控件
	//$("input:text,textarea").first().focus().select();
	//页面分辨率选择
	var sizetime=null;
	$(".pagesize").bind("click",function(){
		clearTimeout(sizetime);
		posX=$(this).offset().left;
		posY=$(this).offset().top+18;
		sizetime=setTimeout(function(){showSize(posX,posY)},300);
	})
	$("#sizeList").bind("mouseout",function(){
		//hideSize();
		clearTimeout(sizetime);
	})
})
function showSize(px,py){
	$("#sizeList").css({"display":"block","left":px,"top":py})
}
function hideSize(){
	$("#sizeList").css({"display":"none"})
}
function switchTab() {
	$(this).addClass("selected").siblings().removeClass("selected"); 
	var tab = $(this).attr("tabPage"); 
	$("#" + tab).show().siblings().hide(); 
} 
function initH(){
	$(".contentDiv").each(function(){
		$(this).height($(window).height()-$(this).siblings(".position").height()-$(this).siblings(".tool").height()-$(this).siblings(".pageBar").height()-$(this).siblings(".formSubmit").height()-uiConfig.listPageSpaceHeight);
	})
	$(".formPage .contentDiv").each(function(){
		$(this).height($(window).height()-$(this).siblings(".position").height()-$(this).siblings(".tool").height()-$(this).siblings(".pageBar").height()-$(this).siblings(".formSubmit").height()-uiConfig.formPageSpaceHeight);
	})
}

function sHlay(obj,cssN){
		$(obj).parents(".pnlForm, .pnlForm2, .pnlForm3").toggleClass(cssN);
}
function showAdv(){
	if($("#btnSearchAdv").attr("class")=="btnSearch"){
	    $("#searchStatus").val("1");
		$("#advSearch").css("display","block");
		$("#btnSearchAdv").removeClass().addClass("btnSearchDisable");
	}else{
	    $("#searchStatus").val("");
		$("#advSearch").css("display","none");
		$("#btnSearchAdv").removeClass().addClass("btnSearch");
	}
	initH();
   $("#mainIframe",parent.document.body).height($(document).height());
}
function hideAdv(){
    $("#searchStatus").val("");
	$("#advSearch").css("display","none");
	$("#btnSearchAdv").removeClass().addClass("btnSearch");
	initH();
	$("#mainIframe",parent.document.body).height($(document).height());
	
}
function popFlLay(layName,layCont){
	$(".winTitle","#floatWin").html(layName);
	$(".winBody","#floatWin").html($("#"+layCont).html());
	$("#floatWin").show().css({"left":($(window).width()-$("#floatWin").width())/2, "top":($(window).height()-$("#floatWin").height())/2});
	$(".winHead","#floatWin").css("width",$("#floatWin").width())
}
function hideFlLay(){
	$("#floatWin").hide();
}
