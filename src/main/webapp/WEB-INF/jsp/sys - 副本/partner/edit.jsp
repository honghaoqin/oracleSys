<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<!-- UI Structure Begin "伙伴修改" -->
<div class="pnlForm" id="pnlForm_edit">
	<div class="pnlHead">
		<div class="pnlHead_L">
			<div class="pnlHead_C">
				<div class="pnlTitle">
					<a class="switchBtn" onClick="javascript:sHlay(this,'hidden');"></a>伙伴修改
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
					<input type="hidden" name="formMap.PARTNER_ID"
						value="${resultMap.PARTNER_ID}" />
					<tr>
						<td class="labelTd">名字</td>
						<td class="inputTd"><input name="formMap.NAME" id="NAME"
							value="${resultMap.NAME}" type="text" maxlength="60"
							class="input100" /></td>
						<td class="labelTd">电话</td>
						<td class="inputTd"><input name="formMap.PHONE" id="PHONE"
							value="${resultMap.PHONE}" type="text" maxlength="11"
							class="input100" /></td>
							
						</td>
						<td class="labelTd">类型</td>
						<td class="inputTd">
						<select name="formMap.PARTNER_TYPE" id="PARTNER_TYPE" class="select100">
						<option></option>
						 <ssi:select type="PARTNER_TYPE" value="${resultMap.PARTNER_TYPE}"/>
						</select>	
					 </td>	
						
					</tr>
					<tr>
						
						<td class="labelTd">银行</td>
						<td class="inputTd">
						<select name="formMap.BANK" id="BANK" class="select100">
						<option></option>
						 <ssi:select type="BANK" value="${resultMap.BANK}"/>
						</select>
						<td class="labelTd">支行名称</td>
						<td class="inputTd"><input name="formMap.BANK_NAME"
							id="BANK_NAME" value="${resultMap.BANK_NAME}" type="text"
							maxlength="64" class="input100" /></td>
						<td class="labelTd">银行账号</td>
						<td class="inputTd"><input name="formMap.BANK_ACCOUNT"
							id="BANK_ACCOUNT" value="${resultMap.BANK_ACCOUNT}" type="text"
							maxlength="20" class="input100" /></td>
					  
					</tr>
					<tr>
						<td class="labelTd">排序</td>
						<td class="inputTd"><input name="formMap.SORT" id="SORT"
							value="${resultMap.SORT}" type="text" class="input100"
							maxlength="22" /></td>
					</tr>
				</table>
			</div>
		</div>
	</div>
</div>
<!-- UI Structure End "伙伴修改" -->
<script>
 mainIframeHeight();
</script>
