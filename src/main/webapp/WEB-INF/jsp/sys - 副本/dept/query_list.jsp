<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<!doctype html>
<html>
<meta charset="UTF-8">
<title></title>
<head>
<%@ include file="/commons/head.jsp"%>
<script language="JavaScript" type="text/javascript"
	src="${ctx}/js/commons/list.js"></script>
</head>
<body>
	<!-- UI Structure Begin "当前位置" -->
	<div class="position">
		<div class="positon_L">
			<div class="position_C">当前位置：部门信息</div>
		</div>
	</div>
	<!-- UI Structure End "当前位置" -->
	<!-- UIStructureBegin "工具条" -->
	<div class="tool">
		<!-- UIStructureBegin "工具：操作按钮" -->
		<table border="0" cellpadding="0" cellspacing="0" width="100%"
			class="toolTable">
			<tr>
				<td class="tool_L">&nbsp;</td>
				<td class="tool_C">
					<div class="toolbar">
						<a class="btnList" id="A_SAVE_BUTTON"><span><span>
									<input id="SAVE_BUTTON" type="button"
									onclick="gotoConfirm()" value="确定" class="icon iconConfirm">
							</span></span></a>
					</div>
				</td>
				<td class="tool_O"></td>
				<td class="tool_R"></td>
			</tr>
		</table>
		<!-- UIStructureEnd "工具：操作按钮" -->
	</div>
	<!-- UIStructureEnd "工具条" -->
	<div class="tableFix">
		<!-- UI Structure Begin "panel" -->
		<div class="pnlForm" id="pnlForm_list">
			<div class="pnlHead">
				<div class="pnlHead_L">
					<div class="pnlHead_C">
						<div class="pnlTitle">
							<a class="switchBtn" onClick="javascript:sHlay(this,'hidden');"></a>部门列表
						</div>
						<div class="pnlTool"></div>
					</div>
				</div>
			</div>
			<div class="pnlBody">
				<div class="pnlContent">
					<!-- UI Structure Begin "信息列表表格" -->
					<form name="listForm" id="listForm"
						action="${ctx}/sys/Dept/queryList.do" method="post">
					<input type="hidden" name="formMap.ID" value="${formMap.ID}">	
						<!-- 隐含条件字段开始 -->
						<%@ include file="/commons/page_field.jsp"%>
						<!-- 隐含条件字段结束 -->
						<table width="100%" border="0" align="center" cellpadding="0"
							cellspacing="0" class="listTable">
							<!-- UI Structure Begin "信息列表表头" -->
							<tr class="head">
								<td width="30" align="center">选择</td>
								<td width="40">序号</td>
								<td>部门名称</td>
							
							</tr>
							<!-- UI Structure End "信息列表表头" -->
							<!-- UI Structure Begin "信息列表数据" -->
							<s:if test="resultList.size!=0">
								<s:iterator value="resultList" id="row" status="st">
									<tr <s:if test="#st.index%2!=0">class="oddRow"</s:if>
										<s:else>class="evenRow"</s:else>>
										<td align="center"><input type="checkbox" class="IDS"
											value="${row.DEPT_ID}" id="ID_${row.DEPT_ID}"
											onclick="selectOne(this,'${row.DEPT_ID}')"
											<s:if test="%{formMap.ID==DEPT_ID}">checked="checked"</s:if>>
											<input type="hidden" value="${row.NAME}"/>
										</td>
										<td>${page.firstResult + st.index+1}</td>
										<td>${row.NAME}</td>
										
									</tr>
								</s:iterator>
							</s:if>
							<s:else>
								<tr>

									<td colspan="3" align="center">没有找到您要查找的数据，请更换查询条件！</td>
								</tr>
							</s:else>
							<!-- UI Structure End "信息列表数据" -->
						</table>
						<!-- UIStructureBegin "翻页" -->
						<div style="text-align: center;"><%@ include
								file="/commons/page.jsp"%></div>
						<!-- UIStructureEnd "翻页" -->
					</form>
				</div>
			</div>
		</div>
		<!-- UI Structure End "panel" -->

	</div>
<script type="text/javascript">
function selectOne(obj,id){
	$(".IDS").attr("checked",false);
	if($("#ID_"+id).attr("checked")!="checked"){
	$("#ID_"+id).attr("checked",true);	
	}
}
 function  gotoConfirm(){
  if(checkSelected(false)){
   var  obj=$("input[class='IDS']:checked");	  
   var id =obj.val();	
   var name=obj.next().val();
   $(window.parent.changeDept(id,name)); 
   parent.ymPrompt.doHandler('close');
  }	  
 }
 
 function gotoList(ctx){
		$("#listForm").submit();
	}
	function doGotoPage(ctx){
		gotoList(ctx);
	}
 
</script>	
</body>
</html>
