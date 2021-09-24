<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<!-- UI Structure Begin "角色录入" -->
<div class="pnlForm">
	<div class="pnlHead">
		<div class="pnlHead_L">
			<div class="pnlHead_C">
				<div class="pnlTitle">
					<a class="switchBtn" onClick="javascript:sHlay(this,'hidden');"></a>角色分配权限
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
						<col width="300" />
						<col width="" />
					</colgroup>
					<tr>
						<td class="inputTd">
							<!--begin: 祥表内容-->
							<input type="hidden" name="formMap.ROLE_ID" value="${formMap.ROLE_ID}">
							<div style="height: 500px; overflow: auto"
								class="treeview">
								<ul>
									<li class="open lastopen">
										<div class="hit open-hit lastopen-hit" onclick="$att(this);"></DIV>
										<span class="folder"> <input onclick="$ctt(this)"
											type="checkbox"> <A onclick='$atc(this)' href="#">权限</A>
									</span> <ssi:tree value="resultList" idKey="AUTH_ID"
											parentKey="PARENT_ID" valueKey="AUTH_ID" textKey="NAME"
											checkedKey="CHECKED" type="2" body="true" />
									</li>
								</ul>
							</div> <!--begin: 祥表内容-->
						</td>
						<td class="inputTd"></td>


					</tr>

				</table>
			</div>
		</div>
	</div>
</div>
<!-- UI Structure End "角色录入" -->
<script>
mainIframeHeight();
</script>