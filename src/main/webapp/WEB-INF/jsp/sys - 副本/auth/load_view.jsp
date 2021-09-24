<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<!-- UI Structure Begin "权限查看" -->
<div class="pnlForm">
	<div class="pnlHead">
		<div class="pnlHead_L">
			<div class="pnlHead_C">
				<div class="pnlTitle">
					<a class="switchBtn" onClick="javascript:sHlay(this,'hidden');"></a>权限查看
				</div>
				<div class="pnlTool"></div>
			</div>
		</div>
	</div>
	<div class="pnlBody">
		<div class="pnlContent optionBar2">
			<div class="tableFix">
				<input type="hidden" name="formMap.AUTH_ID"
					value="${resultMap.AUTH_ID}" />
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
						<td class="labelTd" width="120">权限名称</td>
						<td class="inputTd"><input name="formMap.NAME" id="NAME"
							value="${resultMap.NAME}" type="text"
							class="commonTextInput input100" maxlength="100" /></td>
						<td class="labelTd" width="120">上级权限</td>
						<td class="inputTd"><input type="hidden" id="PARENT_ID"
							name="formMap.PARENT_ID" value="${resultMap.PARENT_ID}">
							<input type="text" id="PARENT_NAME" name="formMap.PARENT_NAME"
							value="${resultMap.PARENT_NAME}" valuefield="PARENT_ID"
							class="selectTextInput autocomplete input100"> <ssi:listbox
								value="auth" id="PARENT_NAME" /></td>
						<td class="labelTd" width="120">参数</td>
						<td class="inputTd"><input name="formMap.PARAM" id="PARAM"
							value="${resultMap.PARAM}" type="text"
							class="commonTextInput input100" maxlength="255" /></td>
					</tr>
					<tr>
						<td class="labelTd" width="120">菜单</td>
						<td class="inputTd"><input type="checkbox" value="1"
							name="formMap.MENU" id="MENU" class="commonTextInput"
							<c:if test ="${resultMap.MENU == '1'}">CHECKED</c:if> /></td>
						<td class="labelTd" width="120">排序</td>
						<td class="inputTd"><input name="formMap.SORT" id="SORT"
							value="${resultMap.SORT}" type="text"
							class="commonTextInput input100" maxlength="22" dataType="Double"
							msg="排序必须是数值" /></td>

						<td class="labelTd" width="120">跳转</td>
						<td class="inputTd"><input name="formMap.TARGET" id="TARGET"
							value="${resultMap.TARGET}" type="text"
							class="commonTextInput input100" maxlength="255" /></td>
					</tr>
					<tr>
						<td class="labelTd" width="120">备注</td>
						<td class="inputTd"><input name="formMap.REMARK" id="REMARK"
							value="${resultMap.REMARK}" type="text"
							class="commonTextInput input100" maxlength="255" /></td>
					</tr>

				</table>
			</div>
		</div>
	</div>
</div>
<!-- UI Structure End "权限查看" -->
<script language="javascript">
		//$(document).ready(function(){
		    $("#loaddata input[type='text']").removeClass("inputRO");
		    $("#loaddata input[type='text']").addClass("inputRO");
		    $("#loaddata input[type='text']").removeAttr("readonly");
		    $("#loaddata input[type='text']").attr("readonly",true);
		    $("#loaddata input[type='text']").removeAttr("onfocus");
		    $("#loaddata textarea").removeClass("inputRO");
		    $("#loaddata textarea").addClass("inputRO");
		    $("#loaddata textarea").removeAttr("readonly");
		    $("#loaddata textarea").attr("readonly",true);
		    
		    $("#loaddata input[type='checkbox']").attr("disabled",true);
		    $("#loaddata select").attr("disabled",true);
		    $("#loaddata td[name='td_operation']").css("display","none");
			//});
		    mainIframeHeight();
	</script>