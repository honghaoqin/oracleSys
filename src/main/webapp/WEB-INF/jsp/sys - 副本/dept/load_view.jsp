<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<!-- UI Structure Begin "机构查看" -->
<div class="pnlForm">
	<div class="pnlHead">
		<div class="pnlHead_L">
			<div class="pnlHead_C">
				<div class="pnlTitle">
					<a class="switchBtn" onClick="javascript:sHlay(this,'hidden');"></a>机构查看
				</div>
				<div class="pnlTool"></div>
			</div>
		</div>
	</div>
	<div class="pnlBody">
		<div class="pnlContent optionBar2">
			<div class="tableFix">
				<input type="hidden" name="formMap.DEPT_ID"
					value="${resultMap.DEPT_ID}" />
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

						<td class="labelTd"><em>*</em>机构名称</td>
						<td class="inputTd"><input name="formMap.NAME" id="NAME"
							value="${resultMap.NAME}" type="text" maxlength="100"
							class="input100" dataType="Require" msg="部门名称不能为空" /></td>
						<td class="labelTd">上级机构</td>
						
						
						<td class="inputTd">
						<input type="hidden" id="PARENT_ID" name="formMap.PARENT_ID"
							value="${resultMap.PARENT_ID}">
						<input type="text" id="PARENT_NAME" class="input100"  readonly="readonly"
							dataType="Require" msg="上级机构不能为空" name="formMap.PARENT_NAME"
							value="${resultMap.PARENT_NAME}">	
						</td>				
								
						
					</tr>
					<tr>
					<td class="labelTd">拼音头</td>
						<td class="inputTd"><input name="formMap.SPELL" id="SPELL"
							value="${resultMap.SPELL}" type="text"
							class="input100" maxlength="50" />
						</td>
						<td class="labelTd">说明</td>
						<td class="inputTd"><input name="formMap.DES" id="DES"
							value="${resultMap.DES}" type="text" maxlength="50"
							class="input100" /></td>
						<td class="labelTd" width="120">排序</td>
						<td class="inputTd"><input name="formMap.SORT" id="SORT"
							value="${resultMap.SORT}" type="text"
							class="input100" maxlength="22" dataType="Double"
							msg="排序必须是数值" /></td>
					</tr>
				</table>
			</div>
		</div>
	</div>
</div>
<!-- UI Structure End "机构查看" -->
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
		//	});
		    mainIframeHeight();
	</script>