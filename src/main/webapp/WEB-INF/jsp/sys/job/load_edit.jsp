<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<div class="pnlForm">
	<div class="pnlHead">
		<div class="pnlHead_L">
			<div class="pnlHead_C">
				<div class="pnlTitle">
					<a class="switchBtn" onClick="javascript:sHlay(this,'hidden');"></a>定时任务修改
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

					</colgroup>

					<input type="hidden" name="formMap.JOB_ID"
						value="${resultMap.JOB_ID}" />
					<tr>
						<td class="labelTd">名称</td>
						<td class="inputTd"><input name="formMap.DES" id="DES"
							value="${resultMap.DES}" type="text"
							class="commonTextInput input100" maxlength="200" /></td>
						<td class="labelTd"><em>*</em> 类</td>
						<td class="inputTd"><input name="formMap.CLS" id="CLS"
							value="${resultMap.CLS}" type="text"
							class="commonTextInput input100" maxlength="200"
							dataType="Require" msg="类不能为空" /></td>
					</tr>
					<tr>
						<td class="labelTd">开始时间</td>
						<td class="inputTd"><input name="formMap.START_TIME"
							id="START_TIME" value="${resultMap.START_TIME}" type="text"
							class="commonTextInput input100"
							onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',readOnly:true})" /></td>
						<td class="labelTd">结束时间</td>
						<td class="inputTd"><input name="formMap.END_TIME"
							id="END_TIME" value="${resultMap.END_TIME}" type="text"
							class="commonTextInput input100"
							onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',readOnly:true})" /></td>
					</tr>
					<tr>
						<td class="labelTd">DURABILITY</td>
						<td class="inputTd"><input name="formMap.DURABILITY"
							id="DURABILITY" value="${resultMap.DURABILITY}" type="text"
							class="commonTextInput input100" maxlength="1" /></td>
						<td class="labelTd">VOLATILITY</td>
						<td class="inputTd"><input name="formMap.VOLATILITY"
							id="VOLATILITY" value="${resultMap.VOLATILITY}" type="text"
							class="commonTextInput input100" maxlength="1" /></td>
					</tr>
					<tr>
						<td class="labelTd">RECOVER</td>
						<td class="inputTd"><input name="formMap.RECOVER"
							id="RECOVER" value="${resultMap.RECOVER}" type="text"
							class="commonTextInput input100" maxlength="1" /></td>
						<td class="labelTd"><em>*</em> 表达式</td>
						<td class="inputTd"><input name="formMap.EXPRESSION"
							id="EXPRESSION" value="${resultMap.EXPRESSION}" type="text"
							class="commonTextInput input100" maxlength="50"
							dataType="Require" msg="表达式不能为空" /></td>
					</tr>
					<tr>
						<td class="labelTd">排除1</td>
						<td class="inputTd"><input name="formMap.CAL1" id="CAL1"
							value="${resultMap.CAL1}" type="text"
							class="commonTextInput input100" maxlength="50" /></td>
						<td class="labelTd">排除2</td>
						<td class="inputTd"><input name="formMap.CAL2" id="CAL2"
							value="${resultMap.CAL2}" type="text"
							class="commonTextInput input100" maxlength="50" /></td>
					</tr>
					<tr>
						<td class="labelTd">排除3</td>
						<td class="inputTd"><input name="formMap.CAL3" id="CAL3"
							value="${resultMap.CAL3}" type="text"
							class="commonTextInput input100" maxlength="50" /></td>
						<td class="labelTd">排除4</td>
						<td class="inputTd"><input name="formMap.CAL4" id="CAL4"
							value="${resultMap.CAL4}" type="text"
							class="commonTextInput input100" maxlength="50" /></td>
					</tr>
					<tr>
						<td class="labelTd">排除5</td>
						<td class="inputTd"><input name="formMap.CAL5" id="CAL5"
							value="${resultMap.CAL5}" type="text"
							class="commonTextInput input100" maxlength="50" /></td>
						<td class="labelTd">排除6</td>
						<td class="inputTd"><input name="formMap.CAL6" id="CAL6"
							value="${resultMap.CAL6}" type="text"
							class="commonTextInput input100" maxlength="50" /></td>
					</tr>
					<tr>
						<td class="labelTd">排除7</td>
						<td class="inputTd"><input name="formMap.CAL7" id="CAL7"
							value="${resultMap.CAL7}" type="text"
							class="commonTextInput input100" maxlength="50" /></td>
						<td class="labelTd">排除8</td>
						<td class="inputTd"><input name="formMap.CAL8" id="CAL8"
							value="${resultMap.CAL8}" type="text"
							class="commonTextInput input100" maxlength="50" /></td>
					</tr>
					<tr>
						<td class="labelTd">排除9</td>
						<td class="inputTd"><input name="formMap.CAL9" id="CAL9"
							value="${resultMap.CAL9}" type="text"
							class="commonTextInput input100" maxlength="50" /></td>
						<td class="labelTd">排除10</td>
						<td class="inputTd"><input name="formMap.CAL10" id="CAL10"
							value="${resultMap.CAL10}" type="text"
							class="commonTextInput input100" maxlength="50" /></td>
					</tr>

				</table>
			</div>
		</div>
	</div>
</div>
<script>
mainIframeHeight();
</script>
