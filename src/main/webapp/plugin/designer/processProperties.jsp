<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script type="text/javascript">
<!--
var process = workflow.process;
var processVariablesEditCount = 0;
jq(function(){
	
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
	jq('#process-listeners-list').datagrid({
		//title:"Listener",
		//url:'${ctx}/wf/procdef/procdef!search.action',//加载表格数据的URL
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
	    		_listener_win.window('refresh','processListenerConfig.jsp');
	    		//alert(_listener_frame.document.body.innerHTML);
	        }
	    }]
	});
	_process_variables_dg=jq('#process-variables-table').datagrid({
		//title:"Listener",
		//url:'${ctx}/wf/procdef/procdef!search.action',//加载表格数据的URL
		singleSelect:true,
		//width:600,
		height:300,
		iconCls:'icon-edit',
		//fit:true,
		//idField:'id',
		rownumbers:true,
	    striped:true,
	    toolbar:[{
	        text:'New',
	        iconCls:'icon-add',
	        handler:function(){
		    	if(processVariablesEditCount>0){
						jq.messager.alert("error","有可修改的单元格，不能添加",'error');
					return;
				}
				jq('#process-variables-table').datagrid('appendRow',{
					id:'',
					name:'',
					type:'',
					scope:'',
					action:''
				});
				var index = jq('#process-variables-table').datagrid('getRows').length-1;
				jq('#process-variables-table').datagrid('beginEdit', index);
	        }
	    }],
		
		onDblClickRow:function(rowIndex,rowData){
			editProcessVariable(rowIndex);
		},
		
		onBeforeEdit:function(index,row){
			row.editing = true;
			jq(this).datagrid('refreshRow', index);
			processVariablesEditCount++;
		},
		onAfterEdit:function(index,row){
			row.editing = false;
			jq(this).datagrid('refreshRow', index);
			processVariablesEditCount--;
		},
		onCancelEdit:function(index,row){
			row.editing = false;
			jq(this).datagrid('refreshRow', index);
			processVariablesEditCount--;
		}
	});
	populateProcessProperites();
});
function listenerActionBt(value,rowData,rowIndex){
	var id = rowData.id;
	var e = '<img onclick="editListener(\''+id+'\')" src="image/edit.gif" title="'+"修改"+'" style="cursor:hand;"/>';   
    var d = '<img onclick="deleteListener(\''+id+'\')" src="image/delete.gif" title="'+"删除"+'" style="cursor:hand;"/>';
	return e+'&nbsp;'+d;
}
function editListener(id){
	_listener_win.window('open');
	_listener_win.window('refresh','processListenerConfig.jsp');
}
function deleteListener(id){
	process.deleteListener(id);
	loadTaskListeners();
}
function saveProcessProperties(){
	process.id=jq('#id').val();
	process.name=jq('#name').val();
	process.category=jq('#category').val();
	process.documentation=jq('#documentation').val();
	jq.messager.alert('Info','Save Successfully!','info');
}
function populateProcessProperites(){
	jq('#id').val(process.id);
	jq('#name').val(process.name);
	jq('#category').val(process.category);
	jq('#documentation').val(process.documentation);
	loadProcessListeners();
	loadProcessVariables();
}
function loadProcessListeners(){
	var listeners = process.listeners;
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
	jq('#process-listeners-list').datagrid('loadData',listener_grid_data);
}
function loadProcessVariables(){
	var variables = process.variables;
	var variables_grid_rows=[];
	for(var i=0;i<variables.getSize();i++){
		var variable = variables.get(i);
		var v = {
					id:variable.id,
					name:variable.name,
					type:variable.type,
					scope:variable.scope,
					defaultValue:variable.defaultValue,
					remark:variable.remark,
					action:''
				};
		variables_grid_rows[i]=v;
	};
	var variables_grid_data={
			total:variables.getSize(),
			rows:variables_grid_rows
	};
	_process_variables_dg.datagrid('loadData',variables_grid_data);
}
function cancelProcessVariable(id){
	_process_variables_dg.datagrid('cancelEdit', id);
}
function editProcessVariable(id){
	_process_variables_dg.datagrid('beginEdit', id);
}
function saveProcessVariable(id){
	_process_variables_dg.datagrid('endEdit', id);
	var rows = _process_variables_dg.datagrid('getRows');
	var rowData = rows[id];
	var variable = new draw2d.Process.variable();
	variable.name=rowData.name;
	variable.type=rowData.type;
	variable.scope=rowData.scope;
	variable.defaultValue=rowData.defaultValue;
	variable.remark=rowData.remark;
	process.addVariable(variable);
}
function deleteProcessVariable(id){
	var rows = _process_variables_dg.datagrid('getRows');
	var rowData = rows[id];
	process.deleteVariable(rowData.id);
	_process_variables_dg.datagrid('deleteRow',id);
	refreshAllProcessVariables();
}
function refreshAllProcessVariables(){
	var rs = _process_variables_dg.datagrid('getRows');
	for(var i=0;i<rs.length;i++){
		var ri =_process_variables_dg.datagrid('getRowIndex',rs[i]);
		_process_variables_dg.datagrid('refreshRow',ri);
	}
}
function processVariablesActionFormatter(value,rowData,rowIndex){
	var id = rowIndex;
	var name = rowData.name;
	var s='<img onclick="saveProcessVariable('+id+')" src="image/ok.png" title="'+"确定"+'" style="cursor:hand;"/>';
	var c='<img onclick="cancelProcessVariable('+id+')" src="image/cancel.png" title="'+"取消"+'" style="cursor:hand;"/>';
	var e='<img onclick="editProcessVariable('+id+')" src="image/modify.png" title="'+"修改"+'" style="cursor:hand;"/>';
	var d='<img onclick="deleteProcessVariable('+id+')" src="image/delete.gif" title="'+"删除"+'" style="cursor:hand;"/>';
	if(rowData.editing)
		return s;
	else
		return e+'&nbsp;'+d;
}
//-->
</script>
<div id="process-properties-layout" class="easyui-layout" fit="true">
	<div id="task-properties-toolbar-panel" region="north" border="false" style="height:30px;background:#E1F0F2;">
		<a href="##" id="sb2" class="easyui-linkbutton" plain="true" iconCls="icon-save" onclick="saveProcessProperties()">保存</a>
	</div>
	<div id="process-properties-panel" region="center" border="true">
		<div class="easyui-accordion" fit="true" border="false">
			<div id="general" title="流程属性面板" selected="true" class="properties-menu">
				<table id="general-properties">
					<tr>
						<td align="right">流程ID:</td>
						<td><input type="text" id="id" name="id" size="28" value=""/></td>
					</tr>
					<tr>
						<td align="right">流程名称:</td>
						<td><input type="text" id="name" name="name" size="28" value=""/></td>
					</tr>
					<tr>
						<td align="right">命名空间:</td>
						<td><input type="text" id="category" name="category" size="28" value=""/></td>
					</tr>
					<tr>
						<td align="right">流程描述:</td>
						<td><input type="text" id="documentation" name="documentation" size="28" value=""/></td>
					
					</tr>
				</table>
			</div>
		</div>
	</div>
</div>