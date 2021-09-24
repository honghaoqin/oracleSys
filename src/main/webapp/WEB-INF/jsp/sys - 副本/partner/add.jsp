<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<!-- UI Structure Begin "伙伴录入" -->
<div class="pnlForm" id="pnlForm_add">
	<div class="pnlHead">
		<div class="pnlHead_L">
			<div class="pnlHead_C">
				<div class="pnlTitle">
					<a class="switchBtn" onClick="javascript:sHlay(this,'hidden');"></a>伙伴录入
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
						<td class="labelTd">名字</td>
						<td class="inputTd"><input name="formMap.NAME" id="NAME"
							value="${formMap.NAME}" type="text" maxlength="60"
							class="input100" /></td>
						<td class="labelTd">电话</td>
						<td class="inputTd"><input name="formMap.PHONE" id="PHONE"
							value="${formMap.PHONE}" type="text" maxlength="11"
							class="input100" /></td>
							
						</td>
						<td class="labelTd">类型</td>
						<td class="inputTd">
						<select name="formMap.PARTNER_TYPE" id="PARTNER_TYPE" class="select100">
						<option></option>
						 <ssi:select type="PARTNER_TYPE" value="${formMap.PARTNER_TYPE}"/>
						</select>	
					 </td>	
						
					</tr>
					<tr>
						
						<td class="labelTd">银行</td>
						<td class="inputTd">
						<select name="formMap.BANK" id="BANK" class="select100">
						<option></option>
						 <ssi:select type="BANK" value="${formMap.BANK}"/>
						</select>
						<td class="labelTd">支行名称</td>
						<td class="inputTd"><input name="formMap.BANK_NAME"
							id="BANK_NAME" value="${formMap.BANK_NAME}" type="text"
							maxlength="64" class="input100" /></td>
						<td class="labelTd">银行账号</td>
						<td class="inputTd"><input name="formMap.BANK_ACCOUNT"
							id="BANK_ACCOUNT" value="${formMap.BANK_ACCOUNT}" type="text"
							maxlength="20" class="input100" /></td>
					  
					</tr>

				</table>
			</div>
		</div>
	</div>
</div>
<!-- UI Structure End "伙伴录入" -->
<script>
	mainIframeHeight();
</script>
