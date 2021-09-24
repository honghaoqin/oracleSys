<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<!doctype html>
<html>
<meta charset="UTF-8">
<title></title>
<head>
<%@ include file="/commons/head.jsp"%>
<script language="JavaScript" type="text/javascript"
	src="${ctx}/js/sys/auth.js"></script>
<script language="JavaScript" type="text/javascript"
	src="${ctx}/js/commons/list.js"></script>
</head>
<body>
	<!-- UI Structure Begin "当前位置" -->
	<div class="position">
		<div class="positon_L">
			<div class="position_C">
				当前位置：权限维护 <span class="posNext"></span><span id="position_add"></span>权限
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
						<ssi:auth authId="S_AUTH_ADD">
							<a class="btnList"><span><span> <input
										onclick="gotoAdd('${ctx}');" type="button" value="新增"
										class="icon iconAdd">
								</span></span></a>
						</ssi:auth>
						<ssi:auth authId="S_AUTH_EDIT">
							<a class="btnList"><span><span> <input
										onclick="gotoEdit('${ctx}');" type="button" value="修改"
										class="icon iconEdit" single-edit=true>
								</span></span></a>
						</ssi:auth>
						<ssi:auth authId="S_AUTH_DEL">
							<a class="btnList"><span><span> <input
										onclick="gotoDel('${ctx}');" type="button" value="删除"
										class="icon iconDel">
								</span></span></a>
						</ssi:auth>
						<a class="btnList"><span><span> <input
									type="button" onclick="gotoSave('${ctx}')" value="保存"
									class="icon iconSave">
							</span></span></a>
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
										<td class="labelTd">权限代码：</td>
										<td class="inputTd"><input name="formMap.AUTH_ID"
											id="SEARCH_AUTH_ID" value="${formMap.AUTH_ID}" type="text"
											class="select100"></td>
										<td class="labelTd">名称 ：</td>
										<td class="inputTd"><input name="formMap.NAME"
											id="SEARCH_NAME" value="${formMap.NAME}" type="text"
											class="select100"></td>
										<td class="labelTd">上级权限：</td>
										<td class="inputTd"><input type="hidden"
											id="SEARCH_PARENT_ID" name="formMap.PARENT_ID"
											value="${formMap.PARENT_ID}"> <input type="text"
											id="SEARCH_PARENT_NAME" name="formMap.PARENT_NAME"
											value="${formMap.PARENT_NAME}" valuefield="SEARCH_PARENT_ID"
											class="selectTextInput autocomplete input100"> <ssi:listbox
												value="auth" id="SEARCH_PARENT_NAME" /></td>

										<td class="labelTd">是否菜单：</td>
										<td class="inputTd"><select name="formMap.MENU"
											id="SEARCH_MENU">
												<option value=""></option>
												<option value="1">是</option>
												<option value="0">否</option>
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
			action="${ctx}/sys/Auth/add.do"
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
		loading('${ctx}',"loadList");	
		$("#loadList").load("${ctx}/sys/Auth/loadList.do?" + Math.random(), {
			'formMap.IS_OK' : '${formMap.IS_OK}'
		}, function() {
		});
		 });

		//保存数据	
		function gotoSave(ctx) {
			var isview = $("#isview").val();
			if ('view' == isview) {
				alert("对不起，查看界面不能保存数据！");
			} else {
				var editauth = 0;
				var addauth = 0;
				<ssi:auth authId="S_AUTH_ADD">
				addauth = 1;
				</ssi:auth>
				<ssi:auth authId="S_AUTH_EDIT">
				editauth = 1;
				</ssi:auth>
				if ('add' == isview && addauth == 0) {
					alert("对不起，您没有数据新增的权限！");
				} else if ('edit' == isview && editauth == 0) {
					alert("对不起，您没有数据修改的权限！");
				} else {
					saveData(ctx);
				}
			}
		}
	</script>
</body>
</html>
