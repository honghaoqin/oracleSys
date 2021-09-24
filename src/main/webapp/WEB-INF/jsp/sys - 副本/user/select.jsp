<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<!doctype html>
<html>
<meta charset="utf-8"><meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>用户列表</title>
<%@ include file="/commons/head.jsp"%>
	<script language="JavaScript" type="text/javascript"
	src="${ctx}/js/base/user_select.js"></script>
</head>
<body>
	<form name="callForm" id="callForm"
		action="${ctx}/sys/User/select.do" method="post">
		<!-- 隐含条件字段开始 -->
		<%@ include file="/commons/page_field.jsp"%>
	<input type="hidden" id="radio" name="formMap.radio" value="${formMap.radio}"/>
	<input type="hidden" id="showName" name="formMap.showName" value="${formMap.showName}"/>
	<input type="hidden" id="showId" name="formMap.showId" value="${formMap.showId}"/>
	<input type="hidden" id="ids" name="formMap.ids" value="${formMap.ids}"/>
 		<!-- 隐含条件字段结束 -->
		<div class="bodyDiv" style="min-width: 1000px;">
			<!-- UI Structure Begin "当前位置" -->
			<div class="position">
				<div class="positon_L">
					<div class="position_C">
						当前位置：保单维护&gt;保单列表
					</div>
				</div>
			</div>
			<!-- UI Structure End "当前位置" -->
			<!-- UIStructureBegin "工具条" -->
			<div class="tool">
				<!-- UIStructureBegin "工具：操作按钮" -->
				<table border="0" cellpadding="0" cellspacing="0" width="100%"
					class="toolTable">
					<tr>
						<td class="tool_O">
							<!-- UIStructureBegin "查询" -->
							<table border="0" cellpadding="0" cellspacing="0"
								class="searchOption">
								<tr>
									<td>
										<!-- UIStructureBegin "简单查询" -->
										<div id="simpleSearch">
											<table border="0" cellpadding="0" cellspacing="0"
												class="searchtable minWidth500">
												<tr>
												<td>登陆账号:</td>
													<td><input name="formMap.LOGIN_ID" id="LOGIN_ID"
														value="${formMap.LOGIN_ID}" type="text" class="inputSearch"
														tips="选择年度" onfocus="WdatePicker({dateFmt:'yyyy',readOnly:true})"></td>
													<td>用户名:</td>
													<td><input name="formMap.NAME" id="NAME"
														value="${formMap.NAME}" type="text" class="inputSearch"
														tips="输入关键字"></td>
														
													<td><a class="btnSearch"> <span><input
																onclick="gotoList('${ctx}')" type="button" value="查询"
																title="查询" class="icon iconAdd" id="btnAdd"></span>
													</a></td>
													<td><a id="btnSearchAdv" class="btnSearch"
														onClick="javascript:selectOk();"> <span><input
																type="button" value="选择确认" title="选择确认"
																class="icon iconAdd" id="btnAdd"></span>
													</a></td>
												</tr>
											</table>
										</div> <!-- UIStructureEnd "简单查询" -->
									</td>
								</tr>
							</table> <!-- UIStructureBegin "查询" -->
						</td>
					</tr>
				</table>
				<!-- UIStructureEnd "工具：操作按钮" -->

				<!-- UIStructureBegin "高级查询" -->

				
				<!-- UIStructureEnd "高级查询" -->
			</div>
			<!-- UIStructureEnd "工具条" -->
			<!-- UIStructureBegin "滚动内容区域" -->
			<div class="contentDiv">
				<div class="tableFix">
					<!-- UI Structure Begin "信息列表表格" -->
					<table border="0" align="center" cellpadding="0" cellspacing="0"
							class="listTable layoutTable"
							style="width: 100%;min-width:785px;">
							<!-- UI Structure Begin "信息列表表头" -->
							<tr class="head">
								<td width="30" align="center"><input type="checkbox"
									<c:if test="${formMap.radio==null}"> onclick="selectAll(this.checked);" </c:if>></td>
								<td width="40">序号</td>
								<td>登陆账号</td>
								<td>用户姓名</td>
								<td>用户类型</td>
								<td>所属机构</td>
								<td>职务</td>
								
							</tr>
							<!-- UI Structure End "信息列表表头" -->

							<!-- UI Structure Begin "信息列表数据" -->
							<s:if test="resultList.size!=0">
							 <c:set var="selectIDS" value=",${formMap.ids},"></c:set>
								<s:iterator value="resultList" id="row" status="st">
									<tr <s:if test="#st.index%2!=0">class="oddRow"</s:if>
										<s:else>class="evenRow"</s:else>>
										<td align="center">
										<c:set var="keys" value=",${row.USER_ID}"></c:set>
										<input type="checkbox" class="IDS"
											value="${row.USER_ID}" id="${row.USER_ID}"
											<c:if test="${selectIDS!='' && fn:contains(selectIDS,keys)}"> checked="checked" </c:if>
			 							    <c:if test="${formMap.radio!=null && formMap.radio!=''}"> onclick="selectRadio(this);" </c:if>
											>
											<input type="hidden" value="${row.LOGIN_ID}"/>
											<input type="hidden" value="${row.NAME}"/>
											</td>
										<td>${page.firstResult + st.index+1}</td>
										<td onclick="loadView('${ctx}','${row.USER_ID}')"
											style="cursor: pointer;">${row.LOGIN_ID}</td>
										<td onclick="loadView('${ctx}','${row.USER_ID}')"
											style="cursor: pointer;">${row.NAME}</td>
										<td onclick="loadView('${ctx}','${row.USER_ID}')"
											style="cursor: pointer;"><ssi:dict type="USER_TYPE"
												value="${row.TYPE_ID}" /></td>
										<td onclick="loadView('${ctx}','${row.USER_ID}')"
											style="cursor: pointer;">${row.DEPT_NAME}</td>
										<td onclick="loadView('${ctx}','${row.USER_ID}')"
											style="cursor: pointer;">${row.POSITION_NAME}</td>
									
									</tr>
								</s:iterator>
							</s:if>
							<s:else>
								<tr>

									<td colspan="7" align="center">没有找到您要查找的数据，请更换查询条件！</td>
								</tr>
							</s:else>
						</table>
					<!-- UI Structure End "信息列表表格" -->
				</div>
				<!-- UIStructureBegin "翻页" -->
				<%@ include file="/commons/page.jsp"%>
				<!-- UIStructureEnd "翻页" -->
			</div>
			<!-- UIStructureEnd "滚动内容区域" -->

		</div>
	</form>
	<%@ include file="/commons/foot.jsp"%>
	<script type="text/javascript">
	$(function() {
	});
	function selectOk(){
		var list = new Array();
		$("input[class='IDS']:checked").each(function(i){
			var obj={};
			obj.USER_ID=$(this).val();//医院id
			obj.LOGIN_ID = $(this).next().val();//医院名称
			obj.NAME=$(this).next().next().val();//总保费
			list.push(obj);
		});
		$(window.opener.backValueUser(list));//返回json值到父页面的回调函数中
		window.close();
	
	}
	</script>
</body>
</html>


