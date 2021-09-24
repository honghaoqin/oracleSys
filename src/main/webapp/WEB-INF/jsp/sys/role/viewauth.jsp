<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<!DOCTYPE HTML>
<html>
<head>
<meta charset="utf-8">
<meta name="renderer" content="webkit|ie-comp|ie-stand">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<meta http-equiv="Cache-Control" content="no-siteapp" />
<LINK rel="Bookmark" href="/favicon.ico" >
<LINK rel="Shortcut Icon" href="/favicon.ico" />
<%@ include file="/commons/head.jsp"%>
<script type="text/javascript" src="${ctx}/js/treeview/treeview.js"></script>
<link type="text/css" rel="stylesheet"
	href="${ctx}/js/treeview/treeview.css"></link>
<title>权限分配</title>
</head>
<body>
<article class="page-container">
	<form action="${ctx}/sys/Role/assignAuth.do" method="post" class="form form-horizontal" id="callForm" name="callForm">
	 <div>
		  <!--begin: 祥表内容-->
							<input type="hidden" name="formMap.ROLE_ID" value="${formMap.ROLE_ID}">
							<div style="height: 500px; overflow: auto"
								class="treeview">
								<ul>
									<li class="open lastopen">
										<div class="hit open-hit lastopen-hit" onclick="$att(this);"></DIV>
										<span class="folder"><A onclick='$atc(this)' href="#">权限</A>
									</span> <ssi:tree value="resultList" idKey="AUTH_ID"
											parentKey="PARENT_ID" valueKey="AUTH_ID" textKey="NAME"
											checkedKey="CHECKED" type="1" body="true" />
									</li>
								</ul>
							</div> <!--begin: 祥表内容-->	
		</div>
	</form>
</article>
<%@ include file="/commons/foot.jsp"%>
</body>
</html>