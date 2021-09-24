<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<!-- UI Structure Begin "用户组录入" -->
<div class="pnlForm">
	<div class="pnlHead">
		<div class="pnlHead_L">
			<div class="pnlHead_C">
				<div class="pnlTitle">
					<a class="switchBtn" onClick="javascript:sHlay(this,'hidden');"></a>用户组录入
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
						<td class="labelTd"><em>*</em>组名称</td>
						<td class="inputTd"><input name="formMap.NAME" id="NAME"
							value="${formMap.NAME}" type="text" maxlength="100"
							class="input100" dataType="Require" msg="组名称不能为空" /></td>
						<td class="labelTd">所属机构</td>
						<td class="inputTd"><input type="hidden" id="DEPT_ID"  
							name="formMap.DEPT_ID" value="${formMap.DEPT_ID}"> <input
							type="text" id="PARENT_NAME" name="formMap.PARENT_NAME"
							value="${formMap.PARENT_NAME}" valuefield="DEPT_ID" dataType="Require" msg="所属机构不能为空" 
							class="selectTextInput autocomplete input100"> <ssi:listbox
								value="deptAuth" id="PARENT_NAME" /></td>
						<td class="labelTd">备注</td>
						<td class="inputTd"><input name="formMap.REMARK"
							id="REMARK" value="${formMap.REMARK}" type="text" maxlength="256"
							class="input100" /></td>
					</tr>
				</table>
			</div>
		</div>
	</div>
</div>
<!-- UI Structure End "用户组录入" -->
<script>
mainIframeHeight();
</script>