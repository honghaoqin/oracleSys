<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<script type="text/javascript" src="${ctx}/plugin/AsyncBox/AsyncBox.v1.4.5.js"></script>
<link rel="stylesheet" id='skin' type="text/css" href="${ctx}/plugin/AsyncBox/QQBrowser/asyncbox.css" /> 
<title>无标题文档</title>
</head>
<frameset rows="23,*" cols="*" frameborder="no" border="0"
	framespacing="0">
	<frame src="top.jsp" name="topFrame1" scrolling="No"
		noresize="noresize" id="topFrame1" title="topFrame1" />
	<frameset cols="20%,*" frameborder="no" border="0" framespacing="0">
		<frame src="left.jsp" name="leftFrame1"
			frameborder="0" scrolling="No" noresize="noresize" id="leftFrame1"
			title="leftFrame1" />
		<frame src="main.jsp" name="mainFrame1"
			frameborder="0" style="padding-top: 10px;" id="mainFrame1"
			title="mainFrame1" />
	</frameset>
</frameset>