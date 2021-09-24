<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<!-- UI Structure Begin "机构录入" -->
<div class="pnlForm">
	<div class="pnlHead">
		<div class="pnlHead_L">
			<div class="pnlHead_C">
				<div class="pnlTitle">
					<a class="switchBtn" onClick="javascript:sHlay(this,'hidden');"></a>机构录入
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
					</colgroup>
					<tr>
						<td class="labelTd"><em>*</em>机构名称</td>
						<td class="inputTd"><input name="formMap.NAME" id="NAME"
							value="${formMap.NAME}" type="text" maxlength="100"
							class="input100" dataType="Require" msg="机构名称不能为空" /></td>
						<td class="labelTd">上级机构</td>
						<td class="inputTd"><input type="hidden" id="PARENT_ID"
							name="formMap.PARENT_ID" value="${formMap.PARENT_ID}"> <input
							type="text" id="PARENT_NAME" class="input100" readonly="readonly"
							dataType="" msg="上级机构不能为空" name="formMap.PARENT_NAME"
							value="${formMap.PARENT_NAME}"> <a class="btnSearch"><span><span>
										<input onclick="gotoDeptList()" type="button" value="选择"
										class="icon">
								</span></span></a></td>
					
						<td class="labelTd">说明</td>
						<td class="inputTd"><input name="formMap.DES" id="DES"
							value="${formMap.DES}" type="text" maxlength="50"
							class="input100" /></td>
					</tr>
				</table>
			</div>
		</div>
	</div>
</div>
<!-- UI Structure End "机构录入" -->

<script>
	mainIframeHeight();
	function gotoDeptList(){
	    var id=$("#PARENT_ID").val(); 	
		var url="${ctx}/sys/Dept/queryList.do?formMap.ID="+id;
		ymPrompt.win({message:url,width:600,height:450,title:'',maxBtn:false,minBtn:false,iframe:true,
			handler:function (result) {}});
	}	
	function  changeDept(id,name){
		$("#PARENT_ID").val(id);
		$("#PARENT_NAME").val(name);
	}
	
</script>
