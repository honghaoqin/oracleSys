<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html lang="en">

	<head>
	<base href="<%=basePath%>">
	
	<script type="text/javascript" src="${ctx}/static/js/jquery-1.7.2.js"></script>
	<script type="text/javascript" src="${ctx}/plugins/tab/js/framework.js"></script>
	<link href="${ctx}/plugins/tab/css/import_basic.css" rel="stylesheet" type="text/css"/>
	<link  rel="stylesheet" type="text/css" id="skin" prePath="${ctx}/plugins/tab/" /><!--默认相对于根目录路径为../，可添加prePath属性自定义相对路径，如prePath="<%=request.getContextPath()%>"-->
	<script type="text/javascript"  src="${ctx}/plugins/tab/js/tab.js"></script>
	</head>
	
	
<body>
<div id="tab_menu" style="height:30px;"></div>
<div style="width:100%;">
	<div id="page" style="width:100%;height:100%;"></div>
</div>		
</body>
<script type="text/javascript">

function tabAddHandler(mid,mtitle,murl){
	tab.update({
		id :mid,
		title :mtitle,
		url :murl,
		isClosed :true
	});
	tab.add({
		id :mid,
		title :mtitle,
		url :murl,
		isClosed :true
	});

	tab.activate(mid);
}
alert("smh");
 var tab;	
$( function() {
	 tab = new TabView( {
		containerId :'tab_menu',
		pageid :'page',
		cid :'tab1',
		position :"top"
	});
	
	tab.add( {
		id :'tab1_index1',
		title :"主页",
		url :"${ctx}/sys/Login/login_default.do",
		isClosed :false
	});
	/**tab.add( {
		id :'tab1_index1',
		title :"主页",
		url :"/per/undoTask!gettwo",
		isClosed :false
	});
	**/
});
alert("smh2");
	function cmainFrameT(){
		var hmainT = document.getElementById("page");
		var bheightT = document.documentElement.clientHeight;
		hmainT .style.width = '100%';
		hmainT .style.height = (bheightT  - 51) + 'px';
	}
	cmainFrameT();
	window.onresize=function(){  
		cmainFrameT();
	};

</script>
</html>

