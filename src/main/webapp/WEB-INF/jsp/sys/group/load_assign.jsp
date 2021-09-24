<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<!-- UI Structure Begin "panel" -->
<div class="pnlForm" id="pnlForm_list">
	<div class="pnlHead">
		<div class="pnlHead_L">
			<div class="pnlHead_C">
				<div class="pnlTitle">
					<a class="switchBtn" onClick="javascript:sHlay(this,'hidden');"></a>用户列表
				</div>
				<div class="pnlTool"></div>
			</div>
		</div>
	</div>
	<div class="pnlBody">
		<div class="pnlContent">
			<!-- UI Structure Begin "信息列表表格" -->
				

				<table width="100%" border="0" align="center" cellpadding="0"
					cellspacing="0" class="listTable">
					<!-- UI Structure Begin "信息列表表头" -->
					<tr class="head">
								<td width="30" align="center"><input type="checkbox"
									onclick="selectAllS(this.checked);"></td>
								<td width="40">序号</td>
								<td>用户名</td>
								<td>姓名</td>
								<td>所属机构 </td>
								
							</tr>
					<!-- UI Structure End "信息列表表头" -->
					<!-- UI Structure Begin "信息列表数据" -->
					<s:if test="resultList.size!=0">
								<s:iterator value="resultList" id="row" status="st">
									<tr <s:if test="#st.index%2!=0">class="oddRow"</s:if>
										<s:else>class="evenRow"</s:else>>
										<td align="center">
										<input type="checkbox" <s:if test="#row.CHECKED==1">checked</s:if>
										name="formMap.USER_ID" class="IDSS" value="${row.USER_ID}">
										</td>
										<td>${page.firstResult + st.index+1}</td>
										<td>
											${row.LOGIN_ID}
										</td>
										<td>
											${row.NAME}
										</td>
										<td>
											${row.DEPT_NAME}
										</td>
									</tr>
								</s:iterator>
							</s:if>
							<s:else>
								<tr>

									<td colspan="9" align="center">没有找到您要查找的数据，请更换查询条件！</td>
								</tr>
							</s:else>
					<!-- UI Structure End "信息列表数据" -->
				</table>
				
			</form>
		</div>
	</div>
</div>
<!-- UI Structure End "panel" -->
<script>
function selectAllS(c){
	$(".IDSS").attr("checked",c);
}
	<c:if test='${formMap.isShow=="N"}'>
	$("#pnlForm_list").toggleClass("hidden");
	</c:if>
mainIframeHeight();
</script>