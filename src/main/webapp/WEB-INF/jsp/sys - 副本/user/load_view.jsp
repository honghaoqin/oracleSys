<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<!-- UI Structure Begin "用户查看" -->
<div class="pnlForm">
	<div class="pnlHead">
		<div class="pnlHead_L">
			<div class="pnlHead_C">
				<div class="pnlTitle">
					<a class="switchBtn" onClick="javascript:sHlay(this,'hidden');"></a>用户查看
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
						<td class="labelTd"><em>*</em>登陆账号</td>
						<td class="inputTd"><input name="formMap.LOGIN_ID"
							id="LOGIN_ID" value="${resultMap.LOGIN_ID}" type="text"
							maxlength="50" class="input100" dataType="Require" msg="登陆账号不能为空" /></td>
						<td class="labelTd"><em>*</em>用户姓名</td>
						<td class="inputTd"><input name="formMap.NAME" id="NAME"
							value="${resultMap.NAME}" type="text" maxlength="100"
							class="input100" dataType="Require" msg="用户姓名不能为空" /></td>
						<td class="labelTd"><em>*</em>生效日期</td>
						<td class="inputTd"><input name="formMap.START_DT"
							id="START_DT" value="${resultMap.START_DT}" type="text"
							class="input100"
							onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',readOnly:true})"
							dataType="Require" msg="生效日期不能为空" /></td>
					</tr>
					<tr>	
						<td class="labelTd"><em>*</em>失效日期</td>
						<td class="inputTd"><input name="formMap.END_DT" id="END_DT"
							value="${resultMap.END_DT}" type="text" class="input100"
							onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',readOnly:true})"
							dataType="Require" msg="失效日期不能为空" /></td>
					
						<td class="labelTd"><em>*</em>密码</td>
						<td class="inputTd"><input type="password"
							value="${resultMap.PSW}" name="formMap.PSW" id="PSW"
							class="input100" dataType="Require" msg="密码不能为空" /></td>
						<td class="labelTd"><em>*</em>所属机构</td>
						<td class="labelTd"><em>*</em>所属机构</td>
						  <td class="inputTd"><input type="hidden" id="DEPT_ID"
							name="formMap.DEPT_ID" value="${resultMap.DEPT_ID}"> <input
							type="text" id="DEPT_ID_NAME" class="input100" readonly="readonly"
							dataType="" msg="上级机构不能为空" name="formMap.DEPT_ID_NAME"
							value="${resultMap.DEPT_ID_NAME}"></td>
					</tr>
					 <tr>			
						<td class="labelTd"><em>*</em>类型</td>
						<td class="inputTd"><select class="select100"
							name="formMap.TYPE_ID" id="TYPE_ID">
								<option></option>
								<ssi:select value="${resultMap.TYPE_ID}" type="USER_TYPE" />
						</select></td>
						<td class="labelTd"><em>*</em>职务</td>
						<td class="inputTd">
						<select name="formMap.POSITION_ID"
							id="POSITION_ID" class="select100">
							<option></option>
							<s:if test="resultList.size!=0">
								<s:iterator value="resultList" id="row" status="st">
								<option value="${row.POSITION_ID}" 
								<s:if test='%{POSITION_ID==resultMap.POSITION_ID}'>selected="selected"</s:if>>${row.NAME}</option>
							 </s:iterator>
							</s:if></select>	
						</td>
						<td class="labelTd">分页</td>
						<td class="inputTd">
						<input name="formMap.PAGE_SIZE"
							id="PAGE_SIZE" value="${resultMap.PAGE_SIZE}" type="text"
							class="commonTextInput input100" maxlength="22"
							dataType="Double,Require" msg="分页必须是数值,不能为空" /></td>
					</tr>
					<tr>		
						<td class="labelTd">皮肤</td>
						<td class="inputTd" colspan="4">
						<select name="formMap.STYLESHEET" id="STYLESHEET" class="select100">
						<option value="gstyle">蓝色</select>
						</td>
						
					</tr>
				</table>
			</div>
		</div>
	</div>
</div>
<!-- UI Structure End "用户查看" -->
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