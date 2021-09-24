<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<!doctype html>
<html>
<meta charset="UTF-8">
<title></title>
<head>
<%@ include file="/commons/head.jsp"%>
<script language="JavaScript" type="text/javascript"
	src="${ctx}/js/sys/partner.js"></script>
<script language="JavaScript" type="text/javascript"
	src="${ctx}/js/commons/list.js"></script>
</head>
<body>
	<!-- UI Structure Begin "当前位置" -->
	<div class="position">
		<div class="positon_L">
			<div class="position_C">
				当前位置：伙伴维护<span id="posNext"></span><span id="position_add"></span>
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
						<ssi:auth authId="S_PARTNER_ADD">
							<a class="btnList"><span><span> <input
										onclick="gotoAdd('${ctx}');" type="button" value="新增"
										class="icon iconAdd">
								</span></span></a>
						</ssi:auth>
						<ssi:auth authId="S_PARTNER_EDIT">
							<a class="btnList"><span><span> <input
										onclick="gotoEdit('${ctx}');" type="button" value="修改"
										class="icon iconEdit">
								</span></span></a>
						</ssi:auth>
						<ssi:auth authId="S_PARTNER_DEL">
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
					onclick="javascript:showAdv();"
					<c:if test='${formMap.searchStatus==null||formMap.searchStatus==""}'>class="btnList"</c:if>
					<c:if test='${formMap.searchStatus!=null&&formMap.searchStatus!=""}'>class="btnList  btnSearchDisable"</c:if>>
						<span><span> <input name="" type="button" value="搜索">
						</span></span>
				</a></td>
				<td class="tool_R"></td>
			</tr>
		</table>
		<!-- UIStructureEnd "工具：操作按钮" -->
		<!-- UIStructureBegin "查询" -->

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
										<td class="labelTd">名字：</td>
										<td class="inputTd"><input name="formMap.NAME"
											id="SEARCH_NAME" value="${formMap.NAME}" class="input100"
											type="text" maxlength="60" /></td>



										<td class="labelTd">电话：</td>
										<td class="inputTd"><input name="formMap.PHONE"
											id="SEARCH_PHONE" value="${formMap.PHONE}" class="input100"
											type="text" maxlength="11" /></td>



										<td class="labelTd">类型：</td>
										<td class="inputTd"><select name="formMap.PARTNER_TYPE"
											id="SEARCH_PARTNER_TYPE" class="select100">
												<option></option>
												<ssi:select type="PARTNER_TYPE"
													value="${formMap.PARTNER_TYPE}" />
										</select></td>

									</tr>
									<tr>



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
		<!-- UIStructureEnd "查询" -->
	</div>
	<!-- UIStructureEnd "工具条" -->

	<div class="tableFix">
		<span id="loadList"></span>
		<form id="callForm" name="callForm" method="post"
			action="${ctx}/sys/Partner/add.do"
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
		//加载列表信息
		$(document).ready(
				function() {
					resetMainIframeHeight();
					loading('${ctx}', "loadList");
					$("#loadList").load(
							"${ctx}/sys/Partner/loadList.do?" + Math.random(),
							{
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
				<ssi:auth authId="S_PARTNER_ADD">
				addauth = 1;
				</ssi:auth>
				<ssi:auth authId="S_PARTNER_EDIT">
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
