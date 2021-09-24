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
<title>部门管理</title>
</head>
<body>
	<nav class="breadcrumb">
		<i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span>
		 系统管理<span class="c-gray en">&gt;</span> 部门管理 <a
			class="btn btn-success radius r hidden-480"
			style="line-height: 1.6em; margin-top: 3px" onclick="gotoList('${ctx}')"
			title="刷新" id="btn-refresh"><i class="Hui-iconfont">&#xe68f;</i></a>
	</nav>

	<form name="listForm" id="listForm" action="${ctx}/sys/Dept/list.do"
		method="post">
		<!-- 隐含条件字段开始 -->
		<%@ include file="/commons/page_field.jsp"%>
		<!-- 隐含条件字段结束 -->
		<div class="page-container">
			<div class="text-l">
				<span class="hidden-480">部门名称:</span>
				<input type="text" class="input-text" style="width:14em"
					placeholder="输入部门名称" id="NAME" name="formMap.NAME" value="${formMap.NAME}">
				<button type="submit" class="btn btn-success radius" id="searchBtn" name="searchBtn">
					<i class="Hui-iconfont">&#xe665;</i><span class="hidden-480">搜索</span>
				</button>
			</div>
			<div class="cl pd-5 bg-1 bk-gray mt-20">
				<span class="l"> <a href="javascript:;" onclick="gotoAdd()"
					class="btn btn-primary radius"> <i class="Hui-iconfont">&#xe600;</i><span class="hidden-480">添加</span>
				</a> <a href="javascript:;" onclick="gotoEdit()"
					class="btn btn-secondary radius"> <i class="Hui-iconfont">&#xe6df;</i><span class="hidden-480">修改</span>
				</a> <a href="javascript:;" onclick="gotoDel()"
					class="btn btn-danger radius"> <i class="Hui-iconfont">&#xe6e2;</i><span class="hidden-480">删除</span>
				</a>
				</span> <span class="r"></span>
			</div>
			<div class="mt-20">
				<table
					class="table table-border table-bordered table-hover table-bg table-sort">
					<thead>
						<tr class="text-c">
							<th width="40px" align="center"><input type="checkbox"
								onclick="selectAll(this.checked);"></th>
							<th width="40">序号</th>
								<th>部门名称</th>
								<th class="hidden-480">上级部门</th>
								<th class="hidden-480">说明</th>
								<th>创建时间</th>

						</tr>
					</thead>
					<tbody>

						<!-- UI Structure Begin "信息列表数据" -->
						<s:if test="resultList.size!=0">
							<s:iterator value="resultList" id="row" status="st">
								<tr class="text-c">
								   <td align="center"><input type="checkbox" class="IDS"
										value="${row.DEPT_ID}"></td>
									    <td>${page.firstResult + st.index+1}</td>
										<td>${row.NAME}</td>
										<td class="hidden-480">${row.PARENT_NAME}</td>
										<td class="hidden-480">${row.DES}</td>
										<td><s:date name="CREATED_DATE"
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
	<!-- 数据删除的表单begin -->
	<form id="deleteForm" name="deleteForm" method="post"></form>
	<!-- 数据删除的表单end -->
	<%@ include file="/commons/foot.jsp"%>
	<script type="text/javascript">
		/*部门-添加*/
		function gotoAdd() {
			layer_show('添加部门', '${ctx}/sys/Dept/toAdd.do', '', '510');
		}
		/*部门-修改*/
		function gotoEdit() {
			if (checkSelected(false)) {
				var id = $("input[class='IDS']:checked").val();
				layer_show('修改部门', '${ctx}/sys/Dept/toEdit.do?formMap.DEPT_ID='
						+ id + '&' + Math.random(), '', '510');
			}

		}
		/*部门-删除*/
		function gotoDel() {
		if (checkSelected(true)) {
		layer.confirm('确认要删除吗？', function() {
			var id = "";
			$("input[class='IDS']:checked").each(function(i) {
				if (i != 0) {id += ",";}
				id += this.value;
			});
			$("#deleteForm").find("input[name='formMap.DEPT_ID']").remove();
			$("<input name='formMap.DEPT_ID' value='"+id+"' type='hidden'/>").appendTo("#deleteForm");
			$.ajax({
				url : "${ctx}/sys/Dept/delete.do?" + Math.random(),
				type : "POST", // 请求的方式:"POST" 或者 "GET"
				dataType : "JSON", // 数据返回的格式
				async : false,
				data : $('#deleteForm').serialize(),
				success : function(data) {
					alert(data["MSG"]);
					if (data["MSG"] == '数据删除成功!') {
						gotoList('${ctx}');
					}
                
				},
				error : function() {
					layer.alert("系统异常,请联系系统管理员！");
				}
			});
		     });
		  }
		}
	</script>
</body>
</html>