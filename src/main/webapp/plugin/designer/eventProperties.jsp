<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script type="text/javascript">
<!--
var tid = "<%=request.getParameter("id")%>";
var event = workflow.getFigure(tid);
jq(function(){
	jq('#performerType').combobox({
			editable:false,
			onChange:function(newValue, oldValue){
				switchEventCandidatesList(newValue);
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
	jq('#event-listeners-list').datagrid({
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
	    		_listener_win.window('refresh','eventListenerConfig.jsp');
	    		//alert(_listener_frame.document.body.innerHTML);
	        }
	    }]
	});
	jq('#event-form-properties-list').datagrid({
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
	event_candidate_panel=jq('event-candidate-panel').panel({
		border:false,
		//minimized:true,
		height:450
		//width:
		//fit:true
	});
	populateEventProperites();
	//switchTaskCandidatesList(jq('#performerType').combobox('getValue'));
});
function switchEventCandidatesList(performerType){
	if(performerType == 'candidateUsers'){
		event_candidate_panel.panel("refresh","candidateUsersConfig.jsp");
	}else if(performerType == 'candidateGroups'){
		event_candidate_panel.panel("refresh","candidateGroupsConfig.jsp");
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
	_listener_win.window('refresh','eventListenerConfig.jsp');
}
function deleteListener(id){
	event.deleteListener(id);
	loadEventListeners();
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
function saveEventProperties(){
	//alert(tid);
	event.eventId=jq('#id').val();
	event.eventName=jq('#name').val();
	//event.setContent(jq('#name').val());
	//task.performerType=jq('#performerType').combobox('getValue');
	event.expression=jq('#expression').val();
	//task.formKey=jq('#formKey').val();
	//task.documentation=jq('#documentation').val();
	jq.messager.alert('Info','Save Successfully!','info');
}
function populateEventProperites(){
	jq('#id').val(event.eventId);
	jq('#expression').val(event.expression);
	jq('#name').val(event.eventName);
}
function loadEventListeners(){
	var listeners = event.listeners;
	var listener_grid_rows=[];
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
	jq('#event-listeners-list').datagrid('loadData',listener_grid_data);
}
//-->
</script>
<div id="event-properties-layout" class="easyui-layout" fit="true">
	<div id="event-properties-toolbar-panel" region="north" border="false" style="height:30px;background:#E1F0F2;">
		<a href="##" id="sb2" class="easyui-linkbutton" plain="true" iconCls="icon-save" onclick="saveEventProperties()">保存</a>
	</div>
	<div id="event-properties-panel" region="center" border="true">
		<div id="event-properties-accordion" class="easyui-accordion" fit="true" border="false">
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
						<td width="65%">
						<input type="text" id="expression" name="expression" value="" style="width:120px;" />
						</td>
					</tr>
					 
					<tr>
						<td></td>
						<td>
							<div id="event-candidate-panel">
							</div>
						</td>
					</tr>
				</table>
			</div>
		</div>
	</div>
</div>