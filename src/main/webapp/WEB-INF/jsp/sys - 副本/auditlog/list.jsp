<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<c:set var="csspath" value='/hui' />
<!DOCTYPE HTML>
<html>
<head>
<meta charset="utf-8">
<meta name="renderer" content="webkit|ie-comp|ie-stand">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport"
	content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<meta http-equiv="Cache-Control" content="no-siteapp" />
<script type="text/javascript" src="${ctx}/js/commons/list.js"></script>
<!--[if lt IE 9]>
<script type="text/javascript" src="${csspath}/lib/html5.js"></script>
<script type="text/javascript" src="${csspath}/lib/respond.min.js"></script>
<script type="text/javascript" src="${csspath}/lib/PIE_IE678.js"></script>
<![endif]-->
<link rel="stylesheet" type="text/css"
	href="${csspath}/static/h-ui/css/H-ui.min.css" />
<link rel="stylesheet" type="text/css"
	href="${csspath}/static/h-ui.admin/css/H-ui.admin.css" />
<link rel="stylesheet" type="text/css"
	href="${csspath}/lib/Hui-iconfont/1.0.7/iconfont.css" />
<link rel="stylesheet" type="text/css"
	href="${csspath}/lib/icheck/icheck.css" />
<link rel="stylesheet" type="text/css"
	href="${csspath}/static/h-ui.admin/skin/default/skin.css" id="skin" />
<link rel="stylesheet" type="text/css"
	href="${csspath}/static/h-ui.admin/css/style.css" />
<!--[if IE 6]>
<script type="text/javascript" src="${csspath}/static/h-ui/js/DD_belatedPNG_0.0.8a-min.js" ></script>
<script>DD_belatedPNG.fix('*');</script>
<![endif]-->
<title>角色管理</title>
</head>
<body>
	<nav class="breadcrumb">
		<i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span>
		系统管理 <span class="c-gray en">&gt;</span>操作日志 <a
			class="btn btn-success radius r"
			style="line-height: 1.6em; margin-top: 3px" onclick="gotoRefresh()"
			title="刷新" id="btn-refresh"><i class="Hui-iconfont">&#xe68f;</i></a>
	</nav>

	<form name="listForm" id="listForm" action="${ctx}/sys/AuditLog/list.do"
		method="post">
		<!-- 隐含条件字段开始 -->
		<%@ include file="/commons/page_field.jsp"%>
		<!-- 隐含条件字段结束 -->
		<div class="page-container">
			<div class="text-c">
				角色名称：<input type="text" class="input-text" style="width: 250px"
					placeholder="输入角色名称" id="" name="">
				<button type="submit" class="btn btn-success radius" id="" name="">
					<i class="Hui-iconfont">&#xe665;</i> 搜角色
				</button>
			</div>
			
			<div class="mt-20">
				<table
					class="table table-border table-bordered table-hover table-bg table-sort">
					<thead>
						<tr class="text-c">
							<td width="40px">序号</td>
							<td>用户代码</td>
							<td>用户姓名</td>
							<td>权限代码</td>
							<td>权限名称</td>
							<td>日志级别</td>
							<td>操作时间</td>
						</tr>
					</thead>
					<tbody>

						<!-- UI Structure Begin "信息列表数据" -->
						<s:if test="resultList.size!=0">
							<s:iterator value="resultList" id="row" status="st">
								<tr class="text-c">
								<td>${page.firstResult + st.index+1}</td>
									<td>${row.USER_ID}</td>
									<td>${row.USER_NAME}</td>
									<td>${row.AUTH_ID}</td>
									<td>${row.AUTH_NAME}</td>
									
									<td>${row.RZJB}</td>
									<td><s:date name="CZSJ"
											format="yyyy-MM-dd HH:mm:ss" /></td>
								</tr>
							</s:iterator>
						</s:if>
						<!-- UI Structure End "信息列表数据" -->
					</tbody>
				</table>

				<!-- UIStructureBegin "翻页" -->
				<div style="text-align: center;"><%@ include
						file="/commons/page.jsp"%></div>
				<!-- UIStructureEnd "翻页" -->




			</div>
		</div>
	</form>
	<script type="text/javascript"
		src="${csspath}/lib/jquery/1.9.1/jquery.min.js"></script>
	<script type="text/javascript" src="${csspath}/lib/layer/2.1/layer.js"></script>
	<script type="text/javascript"
		src="${csspath}/lib/laypage/1.2/laypage.js"></script>
	<script type="text/javascript"
		src="${csspath}/lib/My97DatePicker/WdatePicker.js"></script>
	<%-- <script type="text/javascript" src="${csspath}/lib/datatables/1.10.0/jquery.dataTables.min.js"></script>  --%>
	<script type="text/javascript" src="${csspath}/static/h-ui/js/H-ui.js"></script>
	<script type="text/javascript"
		src="${csspath}/static/h-ui.admin/js/H-ui.admin.js"></script>
	<script type="text/javascript">
	function gotoList(ctx) {
		$("#listForm").submit();
	}
	function gotoRefresh() {
		location.replace("${ctx}/sys/Role/list.do?" + Math.random());
	}
	</script>
</body>
</html>

