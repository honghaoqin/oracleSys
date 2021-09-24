<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>

<!doctype html>
<html>
<meta charset="UTF-8">
<title></title>
<head>
<script language="JavaScript" type="text/javascript"
	src="${ctx}/js/sys/user.js"></script>
<script language="JavaScript" type="text/javascript"
	src="${ctx}/js/commons/list.js"></script>
<%@ include file="/commons/head.jsp"%>
</head>
<body>
	<!-- UI Structure Begin "当前位置" -->
	<div class="position">
		<div class="positon_L">
			<div class="position_C">
				当前位置：用户维护 <span class="posNext"></span><span id="position_add"></span>用户
			</div>
		</div>
	</div>
	<!-- UI Structure End "当前位置" -->
	<!-- UIStructureBegin "工具条" -->
	<div class="tool">
		<!-- UIStructureBegin "工具：操作按钮" -->
		<table border="0" cellpadding="0" cellspacing="0" width="100%"
			class="toolTable">
			<tr>
				<td class="tool_L"></td>
				<td class="tool_C"><div class="toolbar">
						<ssi:auth authId="S_USER_ADD">
							<a class="btnList"><span><span> <input
										onclick="gotoAdd('${ctx}');" type="button" value="新增"
										class="icon iconAdd">
								</span></span></a>
						</ssi:auth>
						<ssi:auth authId="S_USER_EDIT">
							<a class="btnList"><span><span> <input
										onclick="gotoEdit('${ctx}');" type="button" value="修改"
										class="icon iconEdit" single-edit=true>
								</span></span></a>
						</ssi:auth>
						<ssi:auth authId="S_USER_DEL">
							<a class="btnList"><span><span> <input
										onclick="gotoDel('${ctx}');" type="button" value="删除"
										class="icon iconDel">
								</span></span></a>
						</ssi:auth>
						<a class="btnList"><span><span> <input
									type="button" onclick="gotoSave('${ctx}')" value="保存"
									class="icon iconSave">
							</span></span></a>
						<ssi:auth authId="S_USER_ASSIGN_ROLE">
							<a class="btnList"> <span> <span> <input
										type="button" value="分配角色" title="分配角色"
										class="icon iconPermiss" onclick="gotoAssignRole()">
								</span>
							</span>
							</a>
						</ssi:auth>
						<ssi:auth authId="S_USER_ASSIGN_GROUP">
							<a class="btnList"> <span> <span> <input
										type="button" value="分配用户组" title="分配用户组"
										class="icon iconPermiss" onclick="gotoAssignGroup()">
								</span>
							</span>
							</a>
						</ssi:auth>
						<ssi:auth authId="S_USER_ASSIGN_ROLE">

							<a class="btnList"> <span> <span> <input
										type="button" value="查看角色" title="查看已分配的角色"
										class="icon iconUser" onclick="gotoViewRole()">
								</span>
							</span>
						</ssi:auth>
						<ssi:auth authId="S_USER_ASSIGN_GROUP">
							</a>
							<a class="btnList"> <span> <span> <input
										type="button" value="查看用户组" title="查看已分配用户组"
										class="icon iconUser" onclick="gotoViewGroup()">
								</span>
							</span>
							</a>
						</ssi:auth>
					</div></td>
				<td class="tool_O"><a id="btnSearchAdv"
					onClick="javascript:showAdv();"
					<c:if test='${formMap.searchStatus==null||formMap.searchStatus==""}'>class="btnList"</c:if>
					<c:if test='${formMap.searchStatus!=null&&formMap.searchStatus!=""}'>class="btnList  btnSearchDisable"</c:if>>
						<span><span> <input name="" type="button" value="搜索"
								title="搜索">
						</span></span>
				</a></td>
				<td class="tool_R"></td>
			</tr>
		</table>
		<!-- UIStructureEnd "工具：操作按钮" -->
		<!-- UIStructureBegin "高级查询" -->

		<input type="hidden" name="formMap.searchStatus" id="searchStatus"
			value="${formMap.searchStatus}" />
		<div class="advSearch" id="advSearch"
			<c:if test='${formMap.searchStatus==null||formMap.searchStatus==""}'> style="display: none;"</c:if>>
			<div class="searchHead">
				<div class="searchTitle">查询</div>
				<a href="javascript:hideAdv();" class="btnClose" title="关闭查询"></a>
			</div>
			<div class="searchBody">
				<div class="searchCont">
					<table border="0" cellspacing="0" cellpadding="0"
						class="searchTable">
						<tr>
							<td class="searchTd">
								<table width="100%" border="0" cellpadding="0" cellspacing="0"
									class="formTable">
									<tr>
										<td class="labelTd" width="120">登陆账号 ：</td>
										<td class="inputTd"><input name="formMap.LOGIN_ID"
											id="SEARCH_LOGIN_ID" value="${formMap.LOGIN_ID}"
											class="input100" class="input1 input3" type="text"
											maxlength="50" /></td>

										<td class="labelTd" width="120">类型 ：</td>
										<td class="inputTd"><input type="hidden"
											name="formMap.TYPE_ID_OP" value="=" /> <select
											class="select100" name="formMap.TYPE_ID" id="SEARCH_TYPE_ID">
												<option></option>
												<ssi:select value="${formMap.TYPE_ID}" type="USER_TYPE" />
										</select></td>
									</tr>
								</table>
							</td>
							<td class="btnTd"><a class="btnSearch2"><span><span>
											<input onclick="gotoList('${ctx}')" type="button" value="搜索"
											title="搜索" class="icon iconDown">
									</span></span></a></td>
						</tr>
					</table>
				</div>
			</div>
		</div>
		<!-- UIStructureEnd "高级查询" -->
	</div>
	<!-- UIStructureEnd "工具条" -->

	<div class="tableFix">
		<span id="loadList"></span>
		<form id="callForm" name="callForm" method="post"
			action="${ctx}/sys/User/add.do"
			onSubmit="return Validator.Validate(this);">
			<!--数据新增或修改 -->
			<span id="loaddata"></span>
		</form>
	</div>
	<!-- 数据删除的表单 -->
	<form id="deleteForm" name="deleteForm" method="post"></form>
	<!-- 记录是否是查看界面-->
	<input type="hidden" id="isview" name="isview" value="view">
	<script>
		$(document).ready(function() {
		//加载列表信息
		resetMainIframeHeight();
		loading('${ctx}', "loadList");
		$("#loadList").load("${ctx}/sys/User/loadList.do?" + Math.random(), {
			'formMap.IS_OK' : '${formMap.IS_OK}'}, function() {});
		});
		//保存数据	
		function gotoSave(ctx) {
			var isview = $("#isview").val();
			if ('view' == isview) {
				alert("对不起，查看界面不能保存数据！");
			} else {
				var editauth = 0;
				var addauth = 0;
				var assignRole = 0;
				var assignGroup = 0;
				<ssi:auth authId="S_USER_ADD">
				addauth = 1;
				</ssi:auth>
				<ssi:auth authId="S_USER_EDIT">
				editauth = 1;
				</ssi:auth>
				<ssi:auth authId="S_USER_ASSIGN_GROUP">
				assignGroup = 1;
				</ssi:auth>
				<ssi:auth authId="S_USER_ASSIGN_ROLE">
				assignRole = 1;
				</ssi:auth>
				if ('add' == isview && addauth == 0) {
					alert("对不起，您没有数据新增的权限！");
				} else if ('edit' == isview && addauth == 0) {
					alert("对不起，您没有数据修改的权限！");
				} else if ('assignRole' == isview && assignRole == 0) {
					alert("对不起，您没有用户角色分配的权限！");
				} else if ('assignGroup' == isview && assignGroup == 0) {
					alert("对不起，您没有用户组分配的权限！");
				} else {
					saveData(ctx);
				}
			}
		}

		function gotoAssignRole() {
			if (checkSelected(false)) {
				$("#isview").val("assignRole");
				$("#callForm").attr("action",
						"${ctx}/sys/User/assignRole.do?" + Math.random());
				var id = $("input[class='IDS']:checked").val();
				$("#loaddata").load(
						"${ctx}/sys/User/loadAssignRole.do?formMap.USER_ID="
								+ id + "&" + Math.random());
			}
		}
		function gotoViewRole() {
			if (checkSelected(false)) {
				$("#isview").val("view");
				var id = $("input[class='IDS']:checked").val();
				$("#loaddata").load(
						"${ctx}/sys/User/loadViewAssignRole.do?formMap.USER_ID="
								+ id + "&" + Math.random());
			}
		}
		function gotoAssignGroup() {
			if (checkSelected(false)) {
				$("#isview").val("assignGroup");
				$("#callForm").attr("action",
						"${ctx}/sys/User/assignGroup.do?" + Math.random());
				var id = $("input[class='IDS']:checked").val();
				$("#loaddata").load(
						"${ctx}/sys/User/loadAssignGroup.do?formMap.USER_ID="
								+ id + "&" + Math.random());
			}
		}
		function gotoViewGroup() {
			if (checkSelected(false)) {
				$("#isview").val("view");
				var id = $("input[class='IDS']:checked").val();
				$("#loaddata").load(
						"${ctx}/sys/User/loadViewAssignGroup.do?formMap.USER_ID="
								+ id + "&" + Math.random());
			}
		}
	</script>
</body>
</html>
