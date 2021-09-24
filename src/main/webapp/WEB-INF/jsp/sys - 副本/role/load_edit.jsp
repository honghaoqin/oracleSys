<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<!-- UI Structure Begin "角色修改" -->
<div class="pnlForm">
	<div class="pnlHead">
		<div class="pnlHead_L">
			<div class="pnlHead_C">
				<div class="pnlTitle">
					<a class="switchBtn" onClick="javascript:sHlay(this,'hidden');"></a>角色修改
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
					<input type="hidden" name="formMap.ROLE_ID"
						value="${resultMap.ROLE_ID}" />
					<tr>
						<td class="labelTd" width="120">角色名称</td>
						<td class="inputTd"><input name="formMap.NAME" id="NAME"
							value="${resultMap.NAME}" type="text"
							class="commonTextInput input100" maxlength="100" /></td>
						
					</tr>
				</table>
			</div>
		</div>
	</div>
</div>
<!-- UI Structure End "角色修改" -->
<script>
mainIframeHeight();
</script>