<%@ page contentType="text/html;charset=UTF-8"%>

<s:if test="resultMap.appMap.approveList.size!=0">
<div class="pnlForm">
	<div class="pnlHead">
		<div class="pnlHead_L">
			<div class="pnlHead_C">
				<div class="pnlTitle">
					<a class="switchBtn" onClick="javascript:sHlay(this,'hidden');"></a>
					审核意见
				</div>
				<div class="pnlTool"></div>
			</div>
		</div>
	</div>
	<div class="pnlBody">
		<div class="pnlContent">
			<div class="tableFix">
				<table border="0" align="left" cellpadding="0" cellspacing="0"
					class="listTable" style="width: 785px;">
					
						<s:iterator value="resultMap.appMap.approveList" id="row" status="st">
							<tr>
								<td class="fqa">
									<li><span>【${row.SH_NODE}】</span>[<em>${row.POSITIONNAME}</em>][<em>${row.NAME}(${row.LOGIN_ID})</em>]<span
										class="time">（${row.AP_DATE}）</span><span><em>处理结果：</em>${row.YJ_STATUS}</span></li>
									<li><em>意见：</em>${row.REMARK}</li>
								</td>
							</tr>
						</s:iterator>
					
				</table>
			</div>
		</div>
	</div>
</div>

<s:if test="resultMap.appMap.noApproveList.size!=0">

<div class="pnlForm">
	<div class="pnlHead">
		<div class="pnlHead_L">
			<div class="pnlHead_C">
				<div class="pnlTitle">
					<a class="switchBtn" onClick="javascript:sHlay(this,'hidden');"></a>
					待审列表
				</div>
				<div class="pnlTool"></div>
			</div>
		</div>
	</div>
	<div class="pnlBody">
		<div class="pnlContent">
			<div class="tableFix">
				<table border="0" align="left" cellpadding="0" cellspacing="0"
					class="listTable" style="width: 785px;">
					
						<s:iterator value="resultMap.appMap.noApproveList" id="row" status="st">
							<tr>
								<td class="fqa">
									<li><span>【${row.TASKNAME}】</span>[<em>${row.POSITIONNAME}</em>][<em>${row.NAME}(${row.LOGIN_ID})</em>]&nbsp;&nbsp;<span><em>审核任务：</em>待处理</span></li>
								</td>
							</tr>
						</s:iterator>
				</table>
			</div>
		</div>
	</div>
</div>
</s:if>
</s:if>