<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<div class="pnlForm">
	<div class="pnlHead">
		<div class="pnlHead_L">
			<div class="pnlHead_C">
				<div class="pnlTitle">
					<a class="switchBtn" onClick="javascript:sHlay(this,'hidden');"></a>字典查看
				</div>
				<div class="pnlTool"></div>
			</div>
		</div>
	</div>
	<div class="pnlBody">
		<div class="pnlContent optionBar2">
			<div class="tableFix">
				<input type="hidden" name="formMap.DICT_ID"
					value="${resultMap.DICT_ID}" />
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
						<td class="labelTd" width="120"><em>*</em> 类型</td>
						<td class="inputTd"><select class="select100"
							name="formMap.TYPE" id="TYPE">
								<option></option>
								<ssi:select value="${resultMap.TYPE}" type="dicttype" />
						</select></td>
						<td class="labelTd" width="120"><em>*</em> 值</td>
						<td class="inputTd"><input name="formMap.VALUE" id="VALUE"
							value="${resultMap.VALUE}" type="text"
							class="commonTextInput input100" maxlength="100"
							dataType="Require" msg="值不能为空" /></td>
					
						<td class="labelTd" width="120"><em>*</em> 文本</td>
						<td class="inputTd"><input name="formMap.TEXT" id="TEXT"
							value="${resultMap.TEXT}" type="text"
							class="commonTextInput input100" maxlength="800"
							dataType="Require" msg="文本不能为空" /></td>
					</tr>
					<tr>		
						<td class="labelTd" width="120">描述</td>
						<td class="inputTd"><input name="formMap.DES" id="DES"
							value="${resultMap.DES}" type="text"
							class="commonTextInput input100" maxlength="100" /></td>
					
						<td class="labelTd" width="120">排序</td>
						<td class="inputTd"><input name="formMap.SORT" id="SORT"
							value="${resultMap.SORT}" type="text"
							class="commonTextInput input100" maxlength="22" dataType="Double"
							msg="排序必须是数值" /></td>
						<td class="labelTd" width="120">缓存</td>
						<td class="inputTd"><input type="checkbox" value="1"
							name="formMap.CACHE" id="CACHE" class="commonTextInput input100"
							<c:if test = "${resultMap.CACHE == '1'}">CHECKED</c:if> /></td>
					</tr>

				</table>
			</div>
		</div>
	</div>
</div>
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