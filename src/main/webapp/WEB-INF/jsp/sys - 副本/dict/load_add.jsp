<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<div class="pnlForm">
	<div class="pnlHead">
		<div class="pnlHead_L">
			<div class="pnlHead_C">
				<div class="pnlTitle">
					<a class="switchBtn" onClick="javascript:sHlay(this,'hidden');"></a>字典录入
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
						<td class="labelTd"><em>*</em>类型</td>
						<td class="inputTd"><select class="select100"
							name="formMap.TYPE" id="TYPE">
								<option></option>
								<ssi:select value="${formMap.TYPE}" type="dicttype" />
						</select></td>
						<td class="labelTd"><em>*</em>值</td>
						<td class="inputTd"><input name="formMap.VALUE" id="VALUE"
							value="${formMap.VALUE}" type="text" maxlength="100"
							class="input100" dataType="Require" msg="值不能为空" /></td>
					
						<td class="labelTd"><em>*</em>文本</td>
						<td class="inputTd"><input name="formMap.TEXT" id="TEXT"
							value="${formMap.TEXT}" type="text" maxlength="800"
							class="input100" dataType="Require" msg="文本不能为空" /></td>
				    </tr>
					<tr>			
						<td class="labelTd">描述</td>
						<td class="inputTd"><input name="formMap.DES" id="DES"
							value="${formMap.DES}" type="text" maxlength="100"
							class="input100" /></td>
					
						<td class="labelTd">排序</td>
						<td class="inputTd"><input name="formMap.SORT" id="SORT"
							value="${formMap.SORT}" type="text" maxlength="22"
							class="input100" dataType="Double" msg="排序必须是数值" /></td>
						<td class="labelTd">缓存</td>
						<td class="inputTd"><input type="checkbox" value="1"
							name="formMap.CACHE" id="CACHE" class="commonTextInput"
							checked="checked" /></td>
					</tr>
				</table>
			</div>
		</div>
	</div>
</div>
<script>
mainIframeHeight();
</script>