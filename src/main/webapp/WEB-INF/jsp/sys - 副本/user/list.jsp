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
<title>用户管理</title>
</head>
<body>
	<nav class="breadcrumb">
		<i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span>
		用户中心 <span class="c-gray en">&gt;</span> 用户管理 <a
			class="btn btn-success radius r"
			style="line-height: 1.6em; margin-top: 3px" onclick="gotoRefresh()"
			title="刷新" id="btn-refresh"><i class="Hui-iconfont">&#xe68f;</i></a>
	</nav>

	<form name="listForm" id="listForm" action="${ctx}/sys/User/list.do"
		method="post">
		<!-- 隐含条件字段开始 -->
		<%@ include file="/commons/page_field.jsp"%>
		<!-- 隐含条件字段结束 -->
		<div class="page-container">
			<div class="text-c">
				日期范围： <input type="text"
					onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'datemax\')||\'%y-%M-%d\'}'})"
					id="datemin" class="input-text Wdate" style="width: 120px;">
				- <input type="text"
					onfocus="WdatePicker({minDate:'#F{$dp.$D(\'datemin\')}',maxDate:'%y-%M-%d'})"
					id="datemax" class="input-text Wdate" style="width: 120px;">
				<input type="text" class="input-text" style="width: 250px"
					placeholder="输入会员名称、电话、邮箱" id="" name="">
				<button type="submit" class="btn btn-success radius" id="" name="">
					<i class="Hui-iconfont">&#xe665;</i> 搜用户
				</button>
			</div>
			<div class="cl pd-5 bg-1 bk-gray mt-20">
				<span class="l"> <a href="javascript:;" onclick="gotoAdd()"
					class="btn btn-primary radius"> <i class="Hui-iconfont">&#xe600;</i>添加
				</a> <a href="javascript:;" onclick="gotoEdit()"
					class="btn btn-secondary radius"> <i class="Hui-iconfont">&#xe6df;</i>修改
				</a> <a href="javascript:;" onclick="gotoDel()"
					class="btn btn-danger radius"> <i class="Hui-iconfont">&#xe6e2;</i>删除
				</a>


				</span> <span class="r"></span>
			</div>
			<div class="mt-20">
				<table
					class="table table-border table-bordered table-hover table-bg table-sort">
					<thead>
						<tr class="text-c">
							<th width="25" align="center"><input type="checkbox"
								onclick="selectAll(this.checked);"></th>
							<th width="40">序号</th>
							<th>登陆账号</th>
							<th>用户姓名</th>
							<th>所属部门</th>
							<th>生效日期</th>
							<th>失效日期</th>
							<th>分页</th>
							<th>上次登录时间</th>

						</tr>
					</thead>
					<tbody>

						<!-- UI Structure Begin "信息列表数据" -->
						<s:if test="resultList.size!=0">
							<s:iterator value="resultList" id="row" status="st">
								<tr class="text-c">
									<td align="center"><input type="checkbox" class="IDS"
										value="${row.USER_ID}" id="${row.USER_ID}"></td>
									<td>${page.firstResult + st.index+1}</td>
									<td>${row.LOGIN_ID}</td>
									<td>${row.NAME}</td>
									<td>${row.DEPT_NAME}</td>
									<td><s:date name="START_DT" format="yyyy-MM-dd" /></td>
									<td><s:date name="END_DT" format="yyyy-MM-dd" /></td>
									<td>${row.PAGE_SIZE}</td>
									<td><s:date name="LOGIN_DT" format="yyyy-MM-dd HH:mm:ss" /></td>

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
		/*用户-排序*/
		/* $(function(){
		 $('.table-sort').dataTable({
		 "aaSorting": [[ 1, "desc" ]],//默认第几个排序
		 "bStateSave": true,//状态保存
		 "aoColumnDefs": [
		 //{"bVisible": false, "aTargets": [ 3 ]} //控制列的隐藏显示
		 {"orderable":false,"aTargets":[0,2,3,4,7]}// 制定列不参与排序
		 ]
		 });
		 $('.table-sort tbody').on( 'click', 'tr', function () {
		 if ( $(this).hasClass('selected') ) {
		 $(this).removeClass('selected');
		 }
		 else {
		 table.$('tr.selected').removeClass('selected');
		 $(this).addClass('selected');
		 }
		 });
		 }); */
		/*用户-添加*/
		function gotoAdd() {
			layer_show('添加用户', '${ctx}/sys/User/toAdd.do', '', '510');
			//layer_show(title,url,w,h);
		}
		/*用户-修改*/
		function gotoEdit() {
			if (checkSelected(false)) {
				var id = $("input[class='IDS']:checked").val();
				layer_show('修改用户', '${ctx}/sys/User/toEdit.do?formMap.USER_ID='
						+ id + '&' + Math.random(), '', '510');
			}

		}
		/*用户-删除*/
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
			$("#deleteForm").find("input[name='formMap.USER_ID']").remove();
			$(
					"<input name='formMap.USER_ID' value='"+id+"' type='hidden'/>")
					.appendTo("#deleteForm");
			$.ajax({
				url : "${ctx}/sys/User/delete.do?" + Math.random(),
				type : "POST", // 请求的方式:"POST" 或者 "GET"
				dataType : "JSON", // 数据返回的格式
				async : false,
				data : $('#deleteForm').serialize(),
				success : function(data) {
					alert(data["MSG"]);
					if (data["MSG"] == '数据删除成功!') {
					location.replace("${ctx}/sys/User/list.do?"+ Math.random());
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
		

		function gotoList(ctx) {
			$("#listForm").submit();
		}

		function gotoRefresh() {
			location.replace("${ctx}/sys/User/list.do?" + Math.random());
		}

		/*用户-查看*/
		function member_show(title, url, id, w, h) {
			layer_show(title, url, w, h);
		}
		/*用户-停用*/
		function member_stop(obj, id) {
			layer
					.confirm(
							'确认要停用吗？',
							function(index) {
								$(obj)
										.parents("tr")
										.find(".td-manage")
										.prepend(
												'<a style="text-decoration:none" onClick="member_start(this,id)" href="javascript:;" title="启用"><i class="Hui-iconfont">&#xe6e1;</i></a>');
								$(obj)
										.parents("tr")
										.find(".td-status")
										.html(
												'<span class="label label-defaunt radius">已停用</span>');
								$(obj).remove();
								layer.msg('已停用!', {
									icon : 5,
									time : 1000
								});
							});
		}

		/*用户-启用*/
		function member_start(obj, id) {
			layer
					.confirm(
							'确认要启用吗？',
							function(index) {
								$(obj)
										.parents("tr")
										.find(".td-manage")
										.prepend(
												'<a style="text-decoration:none" onClick="member_stop(this,id)" href="javascript:;" title="停用"><i class="Hui-iconfont">&#xe631;</i></a>');
								$(obj)
										.parents("tr")
										.find(".td-status")
										.html(
												'<span class="label label-success radius">已启用</span>');
								$(obj).remove();
								layer.msg('已启用!', {
									icon : 6,
									time : 1000
								});
							});
		}
		/*用户-编辑*/
		function member_edit(title, url, id, w, h) {
			layer_show(title, url, w, h);
		}
		/*密码-修改*/
		function change_password(title, url, id, w, h) {
			layer_show(title, url, w, h);
		}
		/*用户-删除*/
		function member_del(obj, id) {
			layer.confirm('确认要删除吗？', function(index) {
				$(obj).parents("tr").remove();
				layer.msg('已删除!', {
					icon : 1,
					time : 1000
				});
			});
		}
	</script>
</body>
</html>