<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script type="text/javascript">
<!--
var tid = "<%=request.getParameter("id")%>";

var task = workflow.getFigure(tid);
jq(function(){
	jq('#performerType').combobox({
			editable:false,
			onChange:function(newValue, oldValue){
				switchTaskCandidatesList(newValue);
			}
		});
	_listener_win = jq('#listener-win').window({
		//href:'${ctx}/wf/procdef/procdef!forTaskListenerConfig.action',   
	    closed:true,
	    //cache:false,
	    draggable:false,
	    collapsible:false,
	    minimizable:false,
	    maximizable:false,
	    modal:true,
	    shadow:true
	});
	jq('#task-listeners-list').datagrid({
		//title:"Listener",
		//url:'${ctx}/wf/procdef/procdef!search.action',//å è½½è¡¨æ ¼æ°æ®çURL
		singleSelect:true,
		//width:500,
		height:300,
		//idField:'id',
		//pagination:true,
		//pageSize:15,
		//pageNumber:1,
		//pageList:[10,15],
		rownumbers:true,
		//sortName:'id',
	    //sortOrder:'asc',
	    striped:true,
	    toolbar:[{
	        text:'New',
	        iconCls:'icon-add',
	        handler:function(){
	    		_listener_win.window('open');
	    		//_listener_frame.src="";
	    		_listener_win.window('refresh','taskListenerConfig.jsp');
	    		//alert(_listener_frame.document.body.innerHTML);
	        }
	    }]
	});
	jq('#task-form-properties-list').datagrid({
		//title:"Listener",
		//url:'${ctx}/wf/procdef/procdef!search.action',//å è½½è¡¨æ ¼æ°æ®çURL
		singleSelect:true,
		//width:500,
		height:300,
		//idField:'id',
		//pagination:true,
		//pageSize:15,
		//pageNumber:1,
		//pageList:[10,15],
		rownumbers:true,
		//sortName:'id',
	    //sortOrder:'asc',
	    striped:true,
	    toolbar:[{
	        text:'New',
	        iconCls:'icon-add',
	        handler:function(){
	        }
	    }]
	});
	task_candidate_panel=jq('#task-candidate-panel').panel({
		border:false,
		//minimized:true,
		height:450
		//width:
		//fit:true
	});
	populateTaskProperites();
	//switchTaskCandidatesList(jq('#performerType').combobox('getValue'));
});
function switchTaskCandidatesList(performerType){
	if(performerType == 'candidateUsers'){
		task_candidate_panel.panel("refresh","candidateUsersConfig.jsp");
	}else if(performerType == 'candidateGroups'){
		task_candidate_panel.panel("refresh","candidateGroupsConfig.jsp");
	}
}
function listenerActionBt(value,rowData,rowIndex){
	var id = rowData.id;
	var e = '<img onclick="editListener(\''+id+'\')" src="image/edit.gif" title="'+"修改"+'" style="cursor:hand;"/>';   
    var d = '<img onclick="deleteListener(\''+id+'\')" src="image/delete.gif" title="'+"删除"+'" style="cursor:hand;"/>';
	return e+'&nbsp;'+d;
}
function editListener(id){
	_listener_win.window('open');
	_listener_win.window('refresh','taskListenerConfig.jsp');
}
function deleteListener(id){
	task.deleteListener(id);
	loadTaskListeners();
}
function formActionBt(value,rowData,rowIndex){
	var id = rowData.id;
	var e = '<img onclick="editForm('+id+')" src="image/edit.gif" title="'+"修改"+'" style="cursor:hand;"/>';   
    var d = '<img onclick="deleteForm('+id+')" src="image/delete.gif" title="'+"删除"+'" style="cursor:hand;"/>';
	return e+'&nbsp;'+d;
}
function editForm(id){
	
}
function deleteForm(id){
	
}
function saveTaskProperties(){
	//alert(tid);
	task.taskId=jq('#id').val();
	task.taskName=jq('#name').val();
	task.setContent(jq('#name').val());
	task.performerType=jq('#performerType').combobox('getValue');
	task.expression=jq('#expression').val();
	//task.formKey=jq('#formKey').val();
	task.isUseExpression=true;
	task.documentation=jq('#documentation').val();
	jq.messager.alert('Info','Save Successfully!','info');
}
function populateTaskProperites(){
	jq('#id').val(task.taskId);
	jq('#name').val(task.taskName);
	jq('#performerType').combobox('setValue',task.performerType);
	jq('#expression').val(task.expression);
	//jq('#formKey').val(task.formKey);
	jq('#documentation').val(task.documentation);
	loadTaskListeners();
}
function loadTaskListeners(){
	var listeners = task.listeners;
	var listener_grid_rows=[];
	//alert(listeners.getSize());
	for(var i=0;i<listeners.getSize();i++){
		var listener = listeners.get(i);
		var nlistener = {
					id:listener.getId(),
					listenerImplimentation:listener.getServiceImplementation(),
					type:listener.serviceType,
					event:listener.event,
					fields:listener.getFieldsString(),
					action:''
				};
		listener_grid_rows[i]=nlistener;
	};
	//alert(listener_grid_rows);
	var listener_grid_data={
			total:listeners.getSize(),
			rows:listener_grid_rows
	};
	jq('#task-listeners-list').datagrid('loadData',listener_grid_data);
}
//-->
</script>
<div id="task-properties-layout" class="easyui-layout" fit="true">
	<div id="task-properties-toolbar-panel" region="north" border="false" style="height:30px;background:#E1F0F2;">
		<a href="##" id="sb2" class="easyui-linkbutton" plain="true" iconCls="icon-save" onclick="saveTaskProperties()">保存</a>
	</div>
	<div id="task-properties-panel" region="center" border="true">
		<div id="task-properties-accordion" class="easyui-accordion" fit="true" border="false">
			<div id="general" title="主要配置" selected="true" class="properties-menu">
				<table id="general-properties">
					<tr>
						<td align="right">Id:</td>
						<td><input type="text" id="id" name="id" size="28" value=""/></td>
					</tr>
					<tr>
						<td align="right">标签:</td>
						<td><input type="text" id="name" name="name" size="28" value=""/></td>
					</tr>
					<tr>
						<td align="right">描述:</td>
						<td>
						<input type="text" id="documentation" name="documentation" size="28" value=""/>
						</td>
					</tr>
				</table>
			</div>
			
			<div id="main-config" title="执行者配置" class="properties-menu">
				<table id="main-properties">
					<tr>
						<td align="right">执行者类型:</td>
						<td width="65%">
							<select id="performerType" name="performerType" style="width:125px;">
							<option></option>
								<option value="assignee">Assignee</option>
								<option value="candidateUsers">Candidate Users</option>
								<option value="candidateGroups">Candidate Groups</option>
							</select>
						</td>
					</tr>
					<tr>
						<td align="right">执行者:</td>
						<td>
						<input type="text" id="expression" name="expression" value="" style="width:120px;"/>
					
						</td>
					</tr>
					
					<tr>
						<td></td>
						<td>
							<div id="task-candidate-panel">
							</div>
						</td>
					</tr>
				</table>
			</div>
			
			<div id="listeners" title="执行监听器" style="overflow: hidden;">
				<table id="task-listeners-list">
					<thead>
					<tr>
					<th field="listenerImplimentation"  align="middle" sortable="false">名称</th>
					<th field="type"  align="middle" sortable="false">类型</th>
					<th field="event"  align="middle" sortable="false">事件</th>
					<th field="fields"  align="middle" >执行内容</th>
					<th field="action"  align="middle" formatter="listenerActionBt">操作</th>
					</tr>
					</thead>
				</table>
			</div>
		</div>
	</div>
</div>