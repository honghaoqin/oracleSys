<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
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
<%@ include file="/commons/head.jsp"%>
<title>待办事宜</title>
</head>
<body>
	<nav class="breadcrumb">
		<i class="Hui-iconfont">&#xe67f;</i>首页<span class="c-gray en">&gt;</span>
		系统管理<span class="c-gray en">&gt;</span>待办事宜 <a
			class="btn btn-success radius r hidden-480"
			style="line-height: 1.6em; margin-top:3px" onclick="gotoList('${ctx}')"
			title="刷新" id="btn-refresh"><i class="Hui-iconfont">&#xe68f;</i></a>
	</nav>
	<form name="listForm" id="listForm" action="${ctx}/sys/Todo/list.do"
		method="post">
		<!-- 隐含条件字段开始 -->
		<%@ include file="/commons/page_field.jsp"%>
		<!-- 隐含条件字段结束 -->
		<div class="page-container">
			<div class="text-l">
				<span class="hidden-480">标题:</span>
				<input type="text" class="input-text" style="width:14em"
					placeholder="输入标题" id="MSG" name="formMap.MSG" value="${formMap.MSG}">
				<button type="submit" class="btn btn-success radius" id="searchBtn" name="searchBtn">
					<i class="Hui-iconfont">&#xe665;</i><span class="hidden-480">搜索</span>
				</button>
			</div>
			
			<div class="mt-20">
				<table
					class="table table-border table-bordered table-hover table-bg table-sort">
					<thead>
						<tr class="text-c">
							<th style="width:2em" class="hidden-320">序号</th>
								<th>标题</th>
								<th class="hidden-480">待办人</th>
								<th class="hidden-480">待办部门</th>
								<th>待办时间</th>

						</tr>
					</thead>
					<tbody>
						<!-- UI Structure Begin "信息列表数据" -->
						<s:if test="resultList.size!=0">
							<s:iterator value="resultList" id="row" status="st">
								<tr class="text-c">
								   
									    <td class="hidden-320">${page.firstResult + st.index+1}</td>
										<td>${row.MSG}</td>
										<td class="hidden-480">${row.USER_NAME}</td>
										<td class="hidden-480">${row.DEPT_NAME}</td>
										<td><s:date name="MONTIME"
											format="MM-dd HH:mm:ss" /></td>
										

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
<%@ include file="/commons/foot.jsp"%>
</body>
</html>