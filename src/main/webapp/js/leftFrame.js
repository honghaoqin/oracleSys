$(function(){
	//导航项初始化
	initOI();
	//初始化左边导航列表鼠标事件绑定
	initCS();
	//导航滚动区高度resize事件绑定
	$(window).bind("resize",function(){
		resizeScrollHeight();
	});
	//设置导航滚动区高度
	resizeScrollHeight();
	//initFrames();
});
//导航滚动区域高度设置
function resizeScrollHeight(){
	var scrHeight = document.body.clientHeight-uiConfig.leftPageSpaceHeight-$(".banner").height()-$(".menu").height()-$(".position").height();
	$("#scrDiv").height(scrHeight);
	if(!$("#outlookBar").hasClass("normalBar"))$(".outlookCont").height(scrHeight - $(".outlookItem_active,.outlookItem").length*$(".outlookHead").height());
}

/*************** js for outlookBar, by dengyg ***************/
//所在表格id="outlookBar"，导航项id="outlookItem"+序号
var activedOI = false;		//当前展开的outlookItem
var isOutlook = true;		//是否为只展开
//展开收起outlook导航项
function showOI(obj){
	
	var oTable = getParentTag(obj,"table");
	var sId = oTable.id.replace("outlookItem","");
	if(isOutlook){
		if(obj == oTable)return;
		activedOI.className = "outlookItem";
		activedOI.parentNode.className = "outlookItemTd";
		activedOI = oTable;
		activedOI.className = "outlookItem_active";
		activedOI.parentNode.className = "outlookItemTd_active";
		//setCookie("oi",sId)
	}else{
		activedOI = oTable;
		//var oi = getCookie("oi");
		if(activedOI.className == "outlookItem"){
		
			//关闭所有的菜单
			$("#outlookBar").find("table[class='outlookItem_active']").each(function(i,dom){
				$(dom).attr("class","outlookItem");
			});
			activedOI.className = "outlookItem_active";
			activedOI.parentNode.className = "outlookItemTd_active";
			//setCookie("oi",oi+sId+",");
			scrollToView(activedOI);
		}else{
			activedOI.className = "outlookItem";
			activedOI.parentNode.className = "outlookItemTd";
			//setCookie("oi",oi.replace(sId+",",""));
		}
	}
}
//从cookie记录中获取上次导航项展开状态，并初始化，保障刷新后的导航状态一致性
function initOI(){
	var items = $(".outlookItem_active,.outlookItem");
	var oiLength = items.length;
	if(oiLength == 0)return;
	if(document.getElementById("outlookBar").className == "outlookBar"){
		activedOI = items.get(0);	
	}else{
		isOutlook = false;
		scrObj = document.getElementById("scrDiv");//.body;
		scrObj.style.overflow = "auto";
	}
}
//获取某个tagName的父级标签
function getParentTag(obj,tag){
	tag = tag.toLowerCase();
	do{
		obj = obj.parentNode;
	}while(obj.tagName.toLowerCase() != tag)
	return obj;
}
//滚动高度，滚动时间间隔对象，滚动对象
var scrHeight = 0, scrInterval = null, scrObj = null;
//展开outlookBar导航项时，滚动到完全显示某个三级导航列表
function scrollToView(obj){
	scrHeight = getIE(obj)[1] + obj.clientHeight - scrObj.clientHeight - scrObj.scrollTop;
	if(scrHeight > 0)scrInterval = setInterval(toScroll,50)
//	if(scrHeight > 0)document.body.scrollTop += offHeight;
}
//滚动左边导航
function toScroll(){
	var off = Math.ceil(scrHeight/2);
	scrHeight -= off;
	scrObj.scrollTop += off;
	if(scrHeight <= 0)clearInterval(scrInterval);
}
//获取对象相对窗口左上角的位置
function getIE(e){
	var t=e.offsetTop;
	var l=e.offsetLeft;
	while(e=e.offsetParent){
		t+=e.offsetTop;
		l+=e.offsetLeft;
	}
	var rtn = new Array(l,t)
	return rtn
}

//window.attachEvent("onload",initOI);

//左边导航鼠标效果类定义
function CurrentSign(){
	this.currentObj = null;		//点击后标志当前功能项
	this.defaultClass = new Array();
	this.currentClass = new Array();
	this.overClass = new Array();
	this.outClass = new Array();
	
	this.itemOut = itemOut;
	this.itemOver = itemOver;
	this.itemClick = itemClick;
	this.addRelateClass = addRelateClass;
	
	var _this = this;
	
	function itemOut(obj){
		if(_this.currentObj == obj)return;
		obj.className = _this.outClass[_this.overClass.strIndex(obj.className)];
	}
	
	function itemOver(obj){
		if(_this.currentObj == obj)return;
		obj.className = _this.overClass[_this.defaultClass.strIndex(obj.className)];
	}
	
	function itemClick(obj){
		if(_this.currentObj == obj)return;
		if(_this.currentObj)_this.currentObj.className = _this.defaultClass[_this.currentClass.strIndex(_this.currentObj.className)];
		obj.className = _this.currentClass[_this.overClass.strIndex(obj.className)];		
		_this.currentObj = obj;
		//将选中的ID加入到Cookie
		if(obj.id)setCookie("ni",obj.id);
		
	}
	//添加关联的样式名，参数1为默认样式，参数2为当前样式
	//参数3为鼠标在上面时样式（缺少就自动等同参数2），参数4为鼠标移开样式（缺少就自动等同参数1）
	function addRelateClass(){
		var args = addRelateClass.arguments;
		_this.defaultClass.push(args[0])
		_this.currentClass.push(args[1])
		if(args.length > 2){
			_this.overClass.push(args[2])
		}else{
			_this.overClass.push(args[1])
		}
		if(args.length > 3){
			_this.outClass.push(args[3])
		}else {
			_this.outClass.push(args[0])
		}
	}
}
Array.prototype.strIndex = function(str){
	if(this.length == 0 || str == "")return -1;
	var len = this.length;
	for(var i=0;i<len;i++){
		if(this[i] == str)return i;
	}
	return -1;
}
//左边导航列表鼠标效果对象
var leftMenuCS = new CurrentSign();
//初始化左边导航列表鼠标事件
function initCS(){
	$(".outlookHead").bind("click",function(){
		showOI(this);
	}).bind("mouseover",function(){
		$(this).addClass("outlookHead_over");
	}).bind("mouseout",function(){
		$(this).removeClass("outlookHead_over");
	});
	$(".outlookCont .infoItem").bind("click",function(){
	
		leftMenuCS.itemClick(this);
		//alert('infoItem');
	//	parent.navTo($(this).text(),$(this).attr("href"),"iconTabList",true);
	}).bind("mouseover",function(){
		leftMenuCS.itemOver(this);
	}).bind("mouseout",function(){
		leftMenuCS.itemOut(this);
	});
	$(".navItem, .navItem_active").bind("click",function(){
		$(".navItem, .navItem_active").removeClass().addClass("navItem");
		$(this).removeClass().addClass("navItem_active");
	})
	$(".navSwitch").bind("click",function(){
		$(this).toggleClass("open");
		if($(this).hasClass("open")){
			$(this).parent().siblings(".thirdList").css("display","block");
		} else{
			$(this).parent().siblings(".thirdList").css("display","none");
		}
	});
	//从cookie记录中获取上次导航项展开状态，并初始化，保障刷新后的导航状态一致性
	var ni = getCookie("ni");
	if(ni){
		var obj=$("#"+ni)[0];
		leftMenuCS.itemOver(obj);
		leftMenuCS.itemClick(obj);
		$(obj).parents("table[class='outlookItem']").attr("class","outlookItem_active");
	}
}
//window.attachEvent("onload",initCS);
//test.addRelateClass("1","2","3")
leftMenuCS.addRelateClass("infoItem","infoItem_active","infoItem_over");

/************ 显示隐藏左边导航（原frameset框架使用） **********/
/************ 显示隐藏左边导航 **********/
$(function(){
	var shLeftID = 1;
	var sResizeShow = "",sResizeHide = "";
	initFrames();
	$("#btnShLeft").bind("click",function(){
		shLeftFrame(this)
	})
	/*收起、展开左菜单*/
	$(".colCtr").height(function(){
		$(this).height($(this).siblings(".col1").height());
	})
	
	var  w1=250;
	$("#sHLeft2.shLeft").live("click",function(){
		$(this).removeClass().addClass("hdLeft");
		$(this).parent().css("margin-left","0px");
		$("#mainCol").width($("#mainCol").width()+w1);
		$("#leftCol").css({"display":"none","width":"0px","margin-left":"0px"})
	})
	$("#sHLeft2.hdLeft").live("click",function(){
		$(this).removeClass().addClass("shLeft");
		$(this).parent().css("margin-left","5px");
		$("#mainCol").width($("#mainCol").width()-w1-5);
		$("#leftCol").css({"display":"block","width":w1,"margin-left":"5px"})
	})
	
	
	
	
	
	var  w2=200;
	$("#sHLeft.shLeft").live("click",function(){
		$(this).removeClass().addClass("hdLeft");
		$(this).parent().css("margin-left","0px");
		$("#mainCol").width($("#mainCol").width()+w2);
		$("#leftCol").css({"display":"none","width":"0px","margin-left":"0px"})
	})
	$("#sHLeft.hdLeft").live("click",function(){
		$(this).removeClass().addClass("shLeft");
		$(this).parent().css("margin-left","5px");
		$("#mainCol").width($("#mainCol").width()-w2);
		$("#leftCol").css({"display":"block","width":w2,"margin-left":"5px"})
	})
})
function shLeftFrame(obj){
	if($(obj).hasClass("btnHideLeft")){
		$(obj).attr("title","显示左栏");
		$(obj).removeClass().addClass("btnShowLeft");
		$("#pnlLeftFrame").removeClass().addClass("pnlLeftFrame pnlLeftFrame_hidden");
		if(window.parent.frames["mainFrame"]){
			$(window.parent.frames["contentframeset"]).attr("cols",sResizeHide);
		}
		//shLeftID = 0;
	}
	else
	{
		$(obj).attr("title", "隐藏左栏");
		$(obj).removeClass().addClass("btnHideLeft");
		$("#pnlLeftFrame").removeClass().addClass("pnlLeftFrame");
		if(window.parent.frames["mainFrame"]){
			$(window.parent.frames["contentframeset"]).attr("cols",sResizeShow);
		}
		//shLeftID = 1;
		/*ie10、chrome等浏览器下不能兼容frame宽度改变的解法方案*/
		window.parent.contentframeset.rows=window.parent.contentframeset.rows;
	}
	//setCookie("shL",shLeftID)
}
function initFrames(){
	if($("#frameResize").length > 0){
		if($("#frameResize").css("width") != "auto")sResizeShow = $("#frameResize").css("width").replace("px","")+",*";
		if($("#frameResize").css("height") != "auto")sResizeHide = $("#frameResize").css("height").replace("px","")+",*";
	}
	if($(window.parent.frames["mainFrame"]).length > 0){
		if(sResizeShow == ""){sResizeShow = $(window.parent.frames["contentframeset"]).attr("cols");}
		else $(window.parent.frames["contentframeset"]).attr("cols",sResizeShow)
	}
	
	//shL = getCookie("shL");
	//if(shL != ""){
	//	shLeftID = parseInt(shL);
	//	if(shLeftID == 0){shLeftID = 1;shLeftFrame();}
	//}
}
