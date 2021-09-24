<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<div class="pnlForm">
	<div class="pnlHead">
		<div class="pnlHead_L">
			<div class="pnlHead_C">
				<div class="pnlTitle">
					<a class="switchBtn" onClick="javascript:sHlay(this,'hidden');"></a>定时任务录入
				</div>
				<div class="pnlTool"></div>
			</div>
		</div>
	</div>
	<div class="pnlBody">
		<div class="pnlContent optionBar2">
			<div class="tableFix">
			<input name="formMap.ISSTART" id="ISSTART" value="0" type="hidden" />
				<table width="100%" border="0" cellpadding="0" cellspacing="0"
					class="formTable">
					<colgroup>
						<col width="80" />
						<col width="" />
						<col width="80" />
						<col width="" />
					</colgroup>
					<tr>
						<td class="labelTd">名称</td>
						<td class="inputTd"><input name="formMap.DES" id="DES"
							value="${formMap.DES}" type="text" maxlength="200"
							class="input100" /></td>
						<td class="labelTd"><em>*</em>类</td>
						<td class="inputTd"><input name="formMap.CLS" id="CLS"
							value="${formMap.CLS}" type="text" maxlength="200"
							class="input100" dataType="Require" msg="类不能为空" /></td>
					</tr>
					<tr>
						<td class="labelTd">开始时间</td>
						<td class="inputTd"><input name="formMap.START_TIME"
							id="START_TIME" value="${formMap.START_TIME}" type="text"
							class="input100"
							onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',readOnly:true,maxDate:'#F{$dp.$D(\'END_TIME\')||\'9999-12-31\'}' })" /></td>
						<td class="labelTd">结束时间</td>
						<td class="inputTd"><input name="formMap.END_TIME"
							id="END_TIME" value="${formMap.END_TIME}" type="text"
							class="input100"
							onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',readOnly:true,minDate:'#F{$dp.$D(\'START_TIME\')||\'1900-01-01\'}' })" /></td>
					</tr>
					<tr>
						<td class="labelTd">DURABILITY</td>
						<td class="inputTd"><input name="formMap.DURABILITY"
							id="DURABILITY" value="${formMap.DURABILITY}" type="text"
							maxlength="1" class="input100" /></td>
						<td class="labelTd">VOLATILITY</td>
						<td class="inputTd"><input name="formMap.VOLATILITY"
							id="VOLATILITY" value="${formMap.VOLATILITY}" type="text"
							maxlength="1" class="input100" /></td>
					</tr>
					<tr>
						<td class="labelTd">RECOVER</td>
						<td class="inputTd"><input name="formMap.RECOVER"
							id="RECOVER" value="${formMap.RECOVER}" type="text" maxlength="1"
							class="input100" /></td>
						<td class="labelTd"><em>*</em>表达式</td>
						<td class="inputTd"><input name="formMap.EXPRESSION"
							id="EXPRESSION" value="${formMap.EXPRESSION}" type="text"
							maxlength="50" class="input100" dataType="Require" msg="表达式不能为空" /></td>
					</tr>
					<tr>
						<td class="labelTd">排除1</td>
						<td class="inputTd"><input name="formMap.CAL1" id="CAL1"
							value="${formMap.CAL1}" type="text" maxlength="50"
							class="input100" /></td>
						<td class="labelTd">排除2</td>
						<td class="inputTd"><input name="formMap.CAL2" id="CAL2"
							value="${formMap.CAL2}" type="text" maxlength="50"
							class="input100" /></td>
					</tr>
					<tr>
						<td class="labelTd">排除3</td>
						<td class="inputTd"><input name="formMap.CAL3" id="CAL3"
							value="${formMap.CAL3}" type="text" maxlength="50"
							class="input100" /></td>
						<td class="labelTd">排除4</td>
						<td class="inputTd"><input name="formMap.CAL4" id="CAL4"
							value="${formMap.CAL4}" type="text" maxlength="50"
							class="input100" /></td>
					</tr>
					<tr>
						<td class="labelTd">排除5</td>
						<td class="inputTd"><input name="formMap.CAL5" id="CAL5"
							value="${formMap.CAL5}" type="text" maxlength="50"
							class="input100" /></td>
						<td class="labelTd">排除6</td>
						<td class="inputTd"><input name="formMap.CAL6" id="CAL6"
							value="${formMap.CAL6}" type="text" maxlength="50"
							class="input100" /></td>
					</tr>
					<tr>
						<td class="labelTd">排除7</td>
						<td class="inputTd"><input name="formMap.CAL7" id="CAL7"
							value="${formMap.CAL7}" type="text" maxlength="50"
							class="input100" /></td>
						<td class="labelTd">排除8</td>
						<td class="inputTd"><input name="formMap.CAL8" id="CAL8"
							value="${formMap.CAL8}" type="text" maxlength="50"
							class="input100" /></td>
					</tr>
					<tr>
						<td class="labelTd">排除9</td>
						<td class="inputTd"><input name="formMap.CAL9" id="CAL9"
							value="${formMap.CAL9}" type="text" maxlength="50"
							class="input100" /></td>
						<td class="labelTd">排除10</td>
						<td class="inputTd"><input name="formMap.CAL10" id="CAL10"
							value="${formMap.CAL10}" type="text" maxlength="50"
							class="input100" /></td>
					</tr>
					
				</table>
			</div>
		</div>
	</div>
</div>
<script>
mainIframeHeight();
</script>