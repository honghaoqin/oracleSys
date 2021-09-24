<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script type="text/javascript">
<!--
var tid = "<%=request.getParameter("id")%>";

var gateway = workflow.getFigure(tid);
jq(function(){
	jq('#performerType').combobox({
			editable:false,
			onChange:function(newValue, oldValue){
				switchGatewayCandidatesList(newValue);
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
	jq('#gateway-listeners-list').datagrid({
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
	    		_listener_win.window('refresh','gatewayListenerConfig.jsp');
	    		//alert(_listener_frame.document.body.innerHTML);
	        }
	    }]
	});
	jq('#gateway-form-properties-list').datagrid({
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
	gateway_candidate_panel=jq('#gateway-candidate-panel').panel({
		border:false,
		//minimized:true,
		height:450
		//width:
		//fit:true
	});
	populateGatewayProperites();
	//switchTaskCandidatesList(jq('#performerType').combobox('getValue'));
});
function switchGatewayCandidatesList(performerType){
	if(performerType == 'candidateUsers'){
		gateway_candidate_panel.panel("refresh","candidateUsersConfig.jsp");
	}else if(performerType == 'candidateGroups'){
		gateway_candidate_panel.panel("refresh","candidateGroupsConfig.jsp");
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
	_listener_win.window('refresh','GatewayListenerConfig.jsp');
}
function deleteListener(id){
	gateway.deleteListener(id);
	loadGatewayListeners();
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
function saveGatewayProperties(){
	gateway.gatewayId=jq('#id').val();
	gateway.gatewayName=jq('#name').val();
	jq.messager.alert('Info','Save Successfully!','info');
}
function populateGatewayProperites(){
	jq('#id').val(gateway.gatewayId);
	jq('#name').val(gateway.gatewayName);
}
function loadGatewayListeners(){
	var listeners = gateway.listeners;
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
	jq('#gateway-listeners-list').datagrid('loadData',listener_grid_data);
}
//-->
</script>
<div id="gateway-properties-layout" class="easyui-layout" fit="true">
	<div id="gateway-properties-toolbar-panel" region="north" border="false" style="height:30px;background:#E1F0F2;">
		<a href="##" id="sb2" class="easyui-linkbutton" plain="true" iconCls="icon-save" onclick="saveGatewayProperties()">保存</a>
	</div>
	<div id="gateway-properties-panel" region="center" border="true">
		<div id="gateway-properties-accordion" class="easyui-accordion" fit="true" border="false">
			<div id="general" title="流程属性面板" selected="true" class="properties-menu">
				<table id="general-properties">
					<tr>
						<td align="right">Id:</td>
						<td><input type="text" id="id" name="id" size="50" value=""/></td>
					</tr>
					<tr>
						<td align="right">标签:</td>
						<td><input type="text" id="name" name="name" size="50" value=""/></td>
					</tr>
				</table>
			</div>
		</div>
	</div>
</div>