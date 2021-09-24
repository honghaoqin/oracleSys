<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<!-- UI Structure Begin "机构修改" -->
<div class="pnlForm">
	<div class="pnlHead">
		<div class="pnlHead_L">
			<div class="pnlHead_C">
				<div class="pnlTitle">
					<a class="switchBtn" onClick="javascript:sHlay(this,'hidden');"></a>机构修改
				</div>
				<div class="pnlTool"></div>
			</div>
		</div>
	</div>
	<div class="pnlBody">
		<div class="pnlContent optionBar2">
			<div class="tableFix">
				<input type="hidden" name="formMap.DEPT_ID"
					value="${resultMap.DEPT_ID}" />
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

						<td class="labelTd"><em>*</em>机构名称</td>
						<td class="inputTd"><input name="formMap.NAME" id="NAME"
							value="${resultMap.NAME}" type="text" maxlength="100"
							class="input100" dataType="Require" msg="部门名称不能为空" /></td>
						<td class="labelTd">上级机构</td>
						
						
						<td class="inputTd">
						<input type="hidden" id="PARENT_ID" name="formMap.PARENT_ID"
							value="${resultMap.PARENT_ID}">
						<input type="text" id="PARENT_NAME" class="input100"  readonly="readonly"
							dataType="" msg="上级机构不能为空" name="formMap.PARENT_NAME"
							value="${resultMap.PARENT_NAME}">	
							<a class="btnSearch"><span><span>
									<input onclick="gotoDeptList()" type="button" value="选择"
											class="icon">
									</span></span></a>
						</td>				
								
							
					</tr>
					<tr>
					<td class="labelTd">拼音头</td>
						<td class="inputTd"><input name="formMap.SPELL" id="SPELL"
							value="${resultMap.SPELL}" type="text"
							class="input100" maxlength="50" />
						</td>
						<td class="labelTd">说明</td>
						<td class="inputTd"><input name="formMap.DES" id="DES"
							value="${resultMap.DES}" type="text" maxlength="50"
							class="input100" /></td>
						<td class="labelTd" width="120">排序</td>
						<td class="inputTd"><input name="formMap.SORT" id="SORT"
							value="${resultMap.SORT}" type="text"
							class="input100" maxlength="22" dataType="Double"
							msg="排序必须是数值" /></td>
					</tr>
				</table>
			</div>
		</div>
	</div>
</div>
<!-- UI Structure End "机构修改" -->
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