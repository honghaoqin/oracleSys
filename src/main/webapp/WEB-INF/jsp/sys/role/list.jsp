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
<title>角色管理</title>
</head>
<body>
	<nav class="breadcrumb">
		<i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span>
		系统管理 <span class="c-gray en">&gt;</span> 角色管理 <a
			class="btn btn-success radius r hidden-480"
			style="line-height: 1.6em; margin-top: 3px" onclick="gotoList('${ctx}')"
			title="刷新" id="btn-refresh"><i class="Hui-iconfont">&#xe68f;</i></a>
	</nav>

	<form name="listForm" id="listForm" action="${ctx}/sys/Role/list.do"
		method="post">
		<!-- 隐含条件字段开始 -->
		<%@ include file="/commons/page_field.jsp"%>
		<!-- 隐含条件字段结束 -->
		<div class="page-container">
			<div class="text-l">
				<span class="hidden-480">角色名称：</span><input type="text" class="input-text" style="width:14em"
					placeholder="输入角色名称" id="NAME" name="formMap.NAME" value="${formMap.NAME}">
				<button type="submit" class="btn btn-success radius" id="searchBtn" name="searchBtn">
					<i class="Hui-iconfont">&#xe665;</i><span class="hidden-480">搜索</span>
				</button>
			</div>
			<div class="cl pd-5 bg-1 bk-gray mt-20">
				<span class="l"> 
				<a href="javascript:;" onclick="gotoAdd()"
					class="btn btn-primary radius"> <i class="Hui-iconfont">&#xe600;</i><span class="hidden-480">添加</span>
				</a>
				 <a href="javascript:;" onclick="gotoEdit()"
					class="btn btn-secondary radius"> <i class="Hui-iconfont">&#xe6df;</i><span class="hidden-480">修改</span>
				</a> 
				<a href="javascript:;" onclick="gotoDel()"
					class="btn btn-danger radius"> <i class="Hui-iconfont">&#xe6e2;</i><span class="hidden-480">删除</span>
				</a>
				<a href="javascript:;" onclick="gotoAssignAuth()"
					class="btn btn-warning radius"> <i class="Hui-iconfont">&#xe607;</i><span class="hidden-480">分配权限</span>
				</a>
				<a href="javascript:;" onclick="gotoCopyAuth()"
					class="btn btn-success radius"> <i class="Hui-iconfont">&#xe6ea;</i><span class="hidden-480">复制权限</span>
				</a>
				<a href="javascript:;" onclick="gotoViewAuth()"
					class="btn btn-danger radius" title="已分配权限"> <i class="Hui-iconfont" title="已分配权限">&#xe695;</i><span class="hidden-480">已分配权限</span>
				</a>


				</span> <span class="r"></span>
			</div>
			<div class="mt-20">
				<table
					class="table table-border table-bordered table-hover table-bg table-sort">
					<thead>
						<tr class="text-c">
							<th style="width:1em" align="center"><input type="checkbox"
								onclick="selectAll(this.checked);"></th>
							<td style="width:2em">序号</td>
							<td>角色名称</td>
							<td class="hidden-480">创建时间</td>

						</tr>
					</thead>
					<tbody>

						<!-- UI Structure Begin "信息列表数据" -->
						<s:if test="resultList.size!=0">
							<s:iterator value="resultList" id="row" status="st">
								<tr class="text-c">
									<td align="center"><input type="checkbox" class="IDS"
										value="${row.ROLE_ID}" id="${row.ROLE_ID}"></td>
									<td>${page.firstResult + st.index+1}</td>
									<td>${row.NAME}</td>
									<td class="hidden-480"><s:date name="CREATED_DATE"
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
	/*角色-添加*/
	function gotoAdd() {
		layer_show('添加角色', '${ctx}/sys/Role/toAdd.do', '', '510');
		//layer_show(title,url,w,h);
	}
	/*角色-修改*/
	function gotoEdit() {
		if (checkSelected(false)) {
			var id = $("input[class='IDS']:checked").val();
			layer_show('修改角色', '${ctx}/sys/Role/toEdit.do?formMap.ROLE_ID='
					+ id + '&' + Math.random(), '', '510');
		}

	}
	/*角色-删除*/
	function gotoDel() {
	if (checkSelected(true)) {
	layer.confirm('确认要删除吗？', function(index) {
		var id = "";
		$("input[class='IDS']:checked").each(function(i) {
			if (i != 0) {
				id += ",";
			}
			id += this.value;
		});
		$("#deleteForm").find("input[name='formMap.ROLE_ID']").remove();
		$(
				"<input name='formMap.ROLE_ID' value='"+id+"' type='hidden'/>")
				.appendTo("#deleteForm");
		$.ajax({
			url : "${ctx}/sys/Role/delete.do?" + Math.random(),
			type : "POST", // 请求的方式:"POST" 或者 "GET"
			dataType : "JSON", // 数据返回的格式
			async : false,
			data : $('#deleteForm').serialize(),
			success : function(data) {
				alert(data["MSG"]);
				if (data["MSG"] == '数据删除成功!') {
				location.replace("${ctx}/sys/Role/list.do?"+ Math.random());
				} else {
					return;
				}
			},
			error : function() {
				layer.alert("系统异常,请联系系统管理员！");
			}
		});
	     });
	  }
	}
	/*角色-分配权限*/
	function gotoAssignAuth() {
		if (checkSelected(false)) {
			var id = $("input[class='IDS']:checked").val();
			layer_show('分配权限1', '${ctx}/sys/Role/toAssignAuth.do?formMap.ROLE_ID='
					+ id + '&' + Math.random(), '400', '510');
	

		}

	}
	/*角色-复制权限*/
	function gotoCopyAuth() {
		if (checkSelected(false)) {
			var id = $("input[class='IDS']:checked").val();
			layer_show('复制权限', '${ctx}/sys/Role/toCopyAuth.do?formMap.ROLE_ID='
					+ id + '&' + Math.random(), '400', '510');
		}

	}
	/*角色-查看已分配权限*/
	function gotoViewAuth() {
		if (checkSelected(false)) {
			var id = $("input[class='IDS']:checked").val();
			layer_show('已分配权限', '${ctx}/sys/Role/toViewAuth.do?formMap.ROLE_ID='
					+ id + '&' + Math.random(), '400', '510');
		   }
		}		
	</script>
</body>
</html>