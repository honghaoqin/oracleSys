<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<!-- UI Structure Begin "panel" -->
<div class="pnlForm">
	<div class="pnlHead">
		<div class="pnlHead_L">
			<div class="pnlHead_C">
				<div class="pnlTitle">
					<a class="switchBtn" onClick="javascript:sHlay(this,'hidden');"></a>权限列表
				</div>
				<div class="pnlTool"></div>
			</div>
		</div>
	</div>
	<div class="pnlBody">
		<div class="pnlContent">
			<!-- UI Structure Begin "信息列表表格" -->
			<form name="listForm" id="listForm"
				action="${ctx}/sys/Auth/loadList.do" method="post">
				<!-- 隐含条件字段开始 -->
				<%@ include file="/commons/page_field.jsp"%>
				<!-- 隐含条件字段结束 -->

				<table width="100%" border="0" align="center" cellpadding="0"
					cellspacing="0" class="listTable">
				<!-- UI Structure Begin "信息列表表头" -->
						<tr class="head">
							<td width="40px" align="center"><input type="checkbox"
								onclick="selectAll(this.checked);"></td>
							<td width="90px">序号</td>
							<td>权限代码</td>
							<td>权限名称</td>
							<td>上级权限</td>
							<td>菜单</td>
							
						</tr>
						<!-- UI Structure End "信息列表表头" -->
						<!-- UI Structure Begin "信息列表数据" -->

						<s:if test="resultList.size!=0">
							<s:iterator value="resultList" id="row" status="st">
								<tr <s:if test="#st.index%2!=0">class="oddRow"</s:if>
									<s:else>class="evenRow"</s:else>>
									<td align="center"><input type="checkbox" class="IDS"
										value="${row.AUTH_ID}"></td>
									<td>${page.firstResult + st.index+1}
								<%-- 	<a class="up"
										onclick="gotoMoveUpDown('${ctx}','${row.AUTH_ID}',-1);">上移</A><a
										class="l-bar-separator"></a> <a class="down"
										onclick="gotoMoveUpDown('${ctx}','${row.AUTH_ID}',1);">下移</A><a
										class="l-bar-separator"></a> --%>
									</td>
									<td onclick="loadView('${ctx}','${row.AUTH_ID}')"
											style="cursor: pointer;">${row.AUTH_ID}</td>
									<td onclick="loadView('${ctx}','${row.AUTH_ID}')"
											style="cursor: pointer;">${row.NAME}</td>
									<td onclick="loadView('${ctx}','${row.AUTH_ID}')"
											style="cursor: pointer;">${row.PARENT_ID}</td>
								
									<td onclick="loadView('${ctx}','${row.AUTH_ID}')"
											style="cursor: pointer;">${row.MENU}</td>
									
									
								</tr>
							</s:iterator>
						</s:if>
						<s:else>
							<tr>

								<td colspan="6" align="center">没有找到您要查找的数据，请更换查询条件！</td>
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
<script type="text/javascript">
<c:if test='${formMap.isShow=="N"}'> 
$("#pnlForm_list").toggleClass("hidden");
</c:if>
mainIframeHeight();
</script>	
