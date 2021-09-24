<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<!-- UI Structure Begin "用户组查看" -->
<div class="pnlForm">
	<div class="pnlHead">
		<div class="pnlHead_L">
			<div class="pnlHead_C">
				<div class="pnlTitle">
					<a class="switchBtn" onClick="javascript:sHlay(this,'hidden');"></a>用户组查看
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
					<input type="hidden" name="formMap.GROUP_ID"
						value="${resultMap.GROUP_ID}" />
					<tr>
						<td class="labelTd" width="120"><em>*</em> 组名称</td>
						<td class="inputTd"><input name="formMap.NAME" id="NAME"
							value="${resultMap.NAME}" type="text"
							class="commonTextInput input100" maxlength="100"
							dataType="Require" msg="组名称不能为空" /></td>
						<td class="labelTd" width="120">所属部门</td>
						<td class="inputTd"><input type="hidden" id="DEPT_ID"
							name="formMap.DEPT_ID" value="${resultMap.DEPT_ID}"> <input
							type="text" id="PARENT_NAME" name="formMap.PARENT_NAME"
							value="${resultMap.DEPT_ID_NAME}" valuefield="DEPT_ID"
							class="selectTextInput autocomplete input100"> <ssi:listbox
								value="deptAuth" id="PARENT_NAME" /></td>
						<td class="labelTd" width="120">备注</td>
						<td class="inputTd"><input name="formMap.REMARK" id="REMARK"
							value="${resultMap.REMARK}" type="text"
							class="commonTextInput input100" maxlength="256" /></td>
					</tr>
				</table>
			</div>
		</div>
	</div>
</div>
<!-- UI Structure End "用户组查看" -->
<script language="javascript">
	//	$(document).ready(function(){
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
		//	});
		    mainIframeHeight();
		    </script>