<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<div class="pnlForm">
	<div class="pnlHead">
		<div class="pnlHead_L">
			<div class="pnlHead_C">
				<div class="pnlTitle">
					<a class="switchBtn" onClick="javascript:sHlay(this,'hidden');"></a>权限录入
				</div>
				<div class="pnlTool"></div>
			</div>
		</div>
	</div>
	<div class="pnlBody">
		<div class="pnlContent optionBar2">
			<div class="tableFix">
				<table width="100%" border="0" cellpadding="0" cellspacing="0"
					class="formTable">
					<colgroup>
						<col width="80" />
						<col width="" />
						<col width="80" />
						<col width="" />
						<col width="80" />
						<col width="" />
					</colgroup>
					<tr>
						<td class="labelTd"><em>*</em>权限代码</td>
						<td class="inputTd"><input name="formMap.AUTH_ID"
							id="AUTH_ID" value="${formMap.AUTH_ID}" type="text"
							maxlength="100" class="input100" dataType="Require,NumEng"
							msg="权限代码不能为空,只能输入数字和英文字符" /></td>
						<td class="labelTd">权限名称</td>
						<td class="inputTd"><input name="formMap.NAME" id="NAME"
							value="${formMap.NAME}" type="text" maxlength="100"
							class="input100" /></td>
						<td class="labelTd">上级权限</td>
						<td class="inputTd"><input type="hidden" id="PARENT_ID"
							name="formMap.PARENT_ID" value="${formMap.PARENT_ID}"> <input
							type="text" id="PARENT_NAME" name="formMap.PARENT_NAME"
							value="${formMap.PARENT_NAME}" valuefield="PARENT_ID"
							class="selectTextInput autocomplete input100"> <ssi:listbox
								value="auth" id="PARENT_NAME" /></td>
					</tr>
					<tr>			
						<td class="labelTd">参数</td>
						<td class="inputTd"><input name="formMap.PARAM" id="PARAM"
							value="${formMap.PARAM}" type="text" maxlength="255"
							class="input100" /></td>
					
						<td class="labelTd">菜单</td>
						<td class="inputTd"><input type="checkbox" value="1"
							name="formMap.MENU" id="MENU" class="commonTextInput"
							checked="checked" /></td>
						<td class="labelTd">排序</td>
						<td class="inputTd"><input name="formMap.SORT" id="SORT"
							value="${formMap.SORT}" type="text" maxlength="22"
							class="input100" dataType="Double" msg="排序必须是数值" /></td>
					</tr>
					<tr>
				
						<td class="labelTd">跳转</td>
						<td class="inputTd"><input name="formMap.TARGET" id="TARGET"
							value="${formMap.TARGET}" type="text" maxlength="255"
							class="input100" /></td>
					
						<td class="labelTd">备注</td>
						<td class="inputTd"><input name="formMap.REMARK" id="REMARK"
							value="${formMap.REMARK}" type="text" maxlength="255"
							class="input100" /></td>
					</tr>
				</table>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript">
mainIframeHeight();
</script>	