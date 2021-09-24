<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<!-- UI Structure Begin "角色查看" -->
<div class="pnlForm">
	<div class="pnlHead">
		<div class="pnlHead_L">
			<div class="pnlHead_C">
				<div class="pnlTitle">
					<a class="switchBtn" onClick="javascript:sHlay(this,'hidden');"></a>角色查看
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
							class="input100" maxlength="100" />
						</td>
					
					</tr>
				</table>
			</div>
		</div>
	</div>
</div>
<!-- UI Structure End "角色查看" -->
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
	//		});
		    mainIframeHeight();
		    </script>