<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<!-- UI Structure Begin "用户录入" -->
<div class="pnlForm">
	<div class="pnlHead">
		<div class="pnlHead_L">
			<div class="pnlHead_C">
				<div class="pnlTitle">
					<a class="switchBtn" onClick="javascript:sHlay(this,'hidden');"></a>用户录入
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
							id="LOGIN_ID" value="${formMap.LOGIN_ID}" type="text"
							maxlength="50" class="input100" dataType="Require" msg="登陆账号不能为空" /></td>
						<td class="labelTd"><em>*</em>用户姓名</td>
						<td class="inputTd"><input name="formMap.NAME" id="NAME"
							value="${formMap.NAME}" type="text" maxlength="100"
							class="input100" dataType="Require" msg="用户姓名不能为空" /></td>
						<td class="labelTd"><em>*</em>密码</td>
						<td class="inputTd"><input type="password"
							value="${formMap.PSW}" name="formMap.PSW" id="PSW"
							class="input100" dataType="Require" msg="密码不能为空" /></td>
					</tr>
					<tr>
					  <td class="labelTd"><em>*</em>所属机构</td>
					  <td class="inputTd"><input type="hidden" id="DEPT_ID"
							name="formMap.DEPT_ID" value="${formMap.DEPT_ID}"> <input
							type="text" id="DEPT_ID_NAME" class="input100" readonly="readonly"
							dataType="" msg="上级机构不能为空" name="formMap.DEPT_ID_NAME"
							value="${formMap.DEPT_ID_NAME}"> <a class="btnSearch"><span><span>
										<input onclick="gotoDeptList()" type="button" value="选择"
										class="icon">
								</span></span></a></td>
					  
					   <td class="labelTd"><em>*</em>生效日期</td>
						<td class="inputTd"><input name="formMap.START_DT"
							id="START_DT" value="${formMap.START_DT}" type="text"
							class="input100"
							onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',readOnly:true})"
							dataType="Require" msg="生效日期不能为空" /></td>	
						<td class="labelTd"><em>*</em>失效日期</td>
						<td class="inputTd"><input name="formMap.END_DT" id="END_DT"
							value="${formMap.END_DT}" type="text" class="input100"
							onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',readOnly:true})"
							dataType="Require" msg="失效日期不能为空" /></td>
					
						
						
				    </tr>
					<tr>		
						
										
						<td class="labelTd">分页</td>
						<td class="inputTd"><select name="formMap.PAGE_SIZE"
							id="PAGE_SIZE" class="select100">
								<option value="5">5
						</select></td>
					
						<td class="labelTd">皮肤</td>
						<td class="inputTd" colspan="4"><select
							name="formMap.STYLESHEET" id="STYLESHEET" class="select100">
								<option value="gstyle">蓝色
						</select></td>

					</tr>
				</table>
			</div>
		</div>
	</div>
</div>
<!-- UI Structure End "用户录入" -->
<script>
function gotoDeptList(){
    var id=$("#DEPT_ID").val(); 	
	var url="${ctx}/sys/Dept/queryList.do?formMap.ID="+id;
	ymPrompt.win({message:url,width:600,height:450,title:'',maxBtn:false,minBtn:false,iframe:true,
		handler:function (result) {}});
}	
function  changeDept(id,name,typeId,typeName){
	$("#DEPT_ID").val(id);
	$("#DEPT_ID_NAME").val(name);
}
	mainIframeHeight();
	</script>
