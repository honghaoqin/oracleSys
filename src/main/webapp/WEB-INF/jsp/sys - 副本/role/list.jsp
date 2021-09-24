<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>

<!doctype html>
<html>
<meta charset="UTF-8">
<title></title>
<head>
<%@ include file="/commons/head.jsp"%>
<script language="JavaScript" type="text/javascript"
	src="${ctx}/js/sys/role.js"></script>
<script language="JavaScript" type="text/javascript"
	src="${ctx}/js/commons/list.js"></script>
<script type="text/javascript" src="${csspath}/js/treeview/treeview.js"></script>
<link type="text/css" rel="stylesheet"
	href="${csspath}/js/treeview/treeview.css"></link>
<script type="text/javascript">
	function $ctt(c) {
		var isc = $(c).is(':checked');
		chk(c.parentNode.parentNode, isc);
	}
	function chk(o, isc) {
		$(o).children("ul").find("input[type='checkbox']").attr("checked", isc);
		if (isc) {
			$(o).parent().parentsUntil(".treeview", "li").children("span")
					.children("input[type='checkbox']").attr("checked", isc);
		}
	}
	AjaxTreeView.config.onclick = function(o, a) {
		var isc = $(a).prev().is(':checked');
		isc = !isc;
		$(a).prev().attr("checked", isc);
		chk(o, isc);
	}
</script>
</head>
<body>

	<!-- UI Structure Begin "当前位置" -->
	<div class="position">
		<div class="positon_L">
			<div class="position_C">
				当前位置：角色维护 <span class="posNext"></span><span id="position_add"></span>角色
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
				<td class="tool_C">
					<div class="toolbar">
						<ssi:auth authId="S_ROLE_ADD">
							<a class="btnList"><span><span> <input
										onclick="gotoAdd('${ctx}')" type="button" value="新增"
										class="icon iconAdd">
								</span></span></a>
						</ssi:auth>
						<ssi:auth authId="S_ROLE_EDIT">
							<a class="btnList"><span><span> <input
										onclick="gotoEdit('${ctx}')" type="button" value="修改"
										class="icon iconEdit" single-edit=true>
								</span></span></a>
						</ssi:auth>
						<ssi:auth authId="S_ROLE_DEL">
							<a class="btnList"><span><span> <input
										onclick="gotoDel('${ctx}')" type="button" value="删除"
										class="icon iconDel">
								</span></span></a>
						</ssi:auth>
						<a class="btnList"><span><span> <input
									type="button" onclick="gotoSave('${ctx}')" value="保存"
									class="icon iconSave">
							</span></span></a>
						<ssi:auth authId="S_ROLE_ASSIGN_AUTH">
							<a class="btnList"><span><span> <input
										onclick="gotoAssignAuth('${ctx}');" type="button" value="分配权限"
										class="icon iconPermiss">
								</span></span></a>

							<a class="btnList"><span><span> <input
										onclick="gotoCopyAuth('${ctx}');" type="button" value="复制权限"
										class="icon iconPermiss">
								</span></span></a>
							<a class="btnList"><span><span> <input
										onclick="gotoViewAuth('${ctx}');" type="button"
										value="查看已分配权限" class="icon iconPermiss">
								</span></span></a>
						</ssi:auth>
					</div>
				</td>
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

										<td class="labelTd" width="120">角色名称:</td>
										<td class="inputTd"><input name="formMap.NAME"
											id="SEARCH_NAME" value="${formMap.NAME}" class="input100"
											class="input1 input3" type="text" maxlength="50" /></td>

										</td>
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
		$(document).ready(function(){
		//加载列表信息
		resetMainIframeHeight();
		loading('${ctx}', "loadList");
		$("#loadList").load("${ctx}/sys/Role/loadList.do?" + Math.random(), {
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
				var assignAuth = 0;
				var copyAuth = 0;
				<ssi:auth authId="S_ROLE_ASSIGN_AUTH">
				assignAuth = 1;
				copyAuth = 1;
				</ssi:auth>
				<ssi:auth authId="S_ROLE_ADD">
				addauth = 1;
				</ssi:auth>
				<ssi:auth authId="S_ROLE_EDIT">
				editauth = 1;
				</ssi:auth>
				if ('add' == isview && addauth == 0) {
					alert("对不起，您没有数据新增的权限！");
				} else if ('edit' == isview && editauth == 0) {
					alert("对不起，您没有数据修改的权限！");
				} else if ('assignAuth' == isview && assignAuth == 0) {
					alert("对不起，您没有分配权限的权限！");
				} else if ('copyAuth' == isview && copyAuth == 0) {
					alert("对不起，您没有复制权限的权限！");
				} else {
					if ("copyAuth" == isview && copyAuth == 1) {
						copyRoleAuth(ctx);
					} else {
						saveData(ctx);
					}
				}
			}
		}
		function selectAllS(c) {
			$(".IDSS").attr("checked", c);
		}
		function copyRoleAuth(ctx) {
			if (checkSelected(true, "IDSS")) {
				if (!confirm("是否确定复制您所选择的角色的权限?")) {
					return false;
				}
				var id = "";
				$("input[class='IDSS']:checked").each(function(i) {
					if (i != 0) {
						id += ",";
					}
					id += this.value;
				});
				$("#callForm").find("input[name='formMap.ROLE_IDS']").remove();
				$(
						"<input name='formMap.ROLE_IDS' value='"+id+"' type='hidden'/>")
						.appendTo("#callForm");
				var action = ctx + "/sys/Role/copyAuth.do";
				$.ajax({
					url : action + "?" + Math.random(),
					type : "POST", // 请求的方式:"POST" 或者 "GET"
					dataType : "JSON", // 数据返回的格式
					async : false,
					data : $('#callForm').serialize(),
					success : function(data) {
						alert(data["MSG"]);
					},
					error : function() {
						alert("系统异常,请联系系统管理员！");
					}
				});

			}
		}
		function gotoViewAuth(ctx) {
			if (checkSelected(false)) {
				var id = $("input[class='IDS']:checked").val();
				loading(ctx, "loaddata");
				$("#isview").val("view");
				$("#loaddata").load(
						ctx + "/sys/Role/loadViewAuth.do?formMap.ROLE_ID=" + id
								+ "&" + Math.random());
			}
		}
	</script>
</body>
</html>
