<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script type="text/javascript">
<!--
var listenerFieldsEditCount = 0;
var listenerId = "";
jq(function(){
	
	_listener_event_type=jq('#listenerEventType').combobox({
		editable:false
	});
	
	_task_listener_fields_dg=jq('#task-listeners-fields-list').datagrid({
		//title:"Listener",
		//url:'${ctx}/wf/procdef/procdef!search.action',//加载表格数据的URL
		singleSelect:true,
		width:600,
		height:300,
		iconCls:'icon-edit',
		//fit:true,
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
		    	if(listenerFieldsEditCount>0){
					jq.messager.alert("error","有可修改的单元格，不能添加",'error');
					return;
				}
				jq('#task-listeners-fields-list').datagrid('appendRow',{
					id:'',
					fieldName:'',
					type:'',
					value:'',
					action:''
				});
				var index = jq('#task-listeners-fields-list').datagrid('getRows').length-1;
				jq('#task-listeners-fields-list').datagrid('beginEdit', index);
	        }
	    }],
		
		onDblClickRow:function(rowIndex,rowData){
			editListenerField(rowIndex);
		},
		
		onBeforeEdit:function(index,row){
			row.editing = true;
			jq(this).datagrid('refreshRow', index);
			listenerFieldsEditCount++;
		},
		onAfterEdit:function(index,row){
			row.editing = false;
			jq(this).datagrid('refreshRow', index);
			listenerFieldsEditCount--;
		},
		onCancelEdit:function(index,row){
			row.editing = false;
			jq(this).datagrid('refreshRow', index);
			listenerFieldsEditCount--;
		}
	});
	jq('#fieldSaveBt').linkbutton({
		iconCls:"icon-save"
	});
	jq('#fieldCancelBt').linkbutton({
		iconCls:"icon-cancel"
	});
	jq("#listenerServiceClass").autocomplete(_process_def_provided_listeners, {
		width: 450,
		minChars: 0,
		max: 10,
		autoFill: true,
		mustMatch: false,
		matchContains: false,
		scrollHeight: 220,
		//multiple: true,
		//multipleSeparator: " ",
		scroll: true
	});
	populateListenerProperties();
});
function changeListenerServiceType(obj){
	if(obj.value=='javaClass'){
		jq('#listenerServiceLabel').html('java类:');
		jq('#listenerServiceClass').show();
		jq('#listenerServiceExpression').hide();
	}else if(obj.value=='expression'){
		jq('#listenerServiceLabel').html('表达式:');
		jq('#listenerServiceClass').hide();
		jq('#listenerServiceExpression').show();
	}
}
function listenerFieldsActionFormatter(value,rowData,rowIndex){
	var id = rowIndex;
	var s='<img onclick="saveListenerField('+id+')" src="image/ok.png" title="'+"确定"+'" style="cursor:hand;"/>';
	var c='<img onclick="cancelListenerField('+id+')" src="image/cancel.png" title="'+"取消"+'" style="cursor:hand;"/>';
	var e='<img onclick="editListenerField('+id+')" src="image/modify.png" title="'+"修改"+'" style="cursor:hand;"/>';
	var d='<img onclick="deleteListenerField('+id+')" src="image/delete.gif" title="'+"删除"+'" style="cursor:hand;"/>';
	if(rowData.editing)
		return s;
	else
		return e+'&nbsp;'+d;
}
function cancelListenerField(id){
	_task_listener_fields_dg.datagrid('cancelEdit', id);
}
function editListenerField(id){
	_task_listener_fields_dg.datagrid('beginEdit', id);
}
function saveListenerField(id){
	//alert(id);
	_task_listener_fields_dg.datagrid('endEdit', id);
	//alert(editcount);
}
function deleteListenerField(id){
	_task_listener_fields_dg.datagrid('deleteRow',id);
	refreshAllListenerFields();
}
function refreshAllListenerFields(){
	var rs = _task_listener_fields_dg.datagrid('getRows');
	for(var i=0;i<rs.length;i++){
		var ri =_task_listener_fields_dg.datagrid('getRowIndex',rs[i]);
		_task_listener_fields_dg.datagrid('refreshRow',ri);
	}
}
function createNewListener(){
	var newListener = new draw2d.Task.Listener();
    return newListener;   
}
function getExsitingListener(){
	if(listenerId != "" && listenerId != null && listenerId!="null"&&listenerId!="NULL"){
		var listener = task.getListener(listenerId);
		return listener;
	}
}
function getListenerFieldsGridChangeRows(){
	if(listenerFieldsEditCount>0){
		jq.messager.alert("error","",'error');
		return null;
	}
    var insertRows = _task_listener_fields_dg.datagrid('getChanges','inserted');   
    var updateRows = _task_listener_fields_dg.datagrid('getChanges','updated');   
    var deleteRows = _task_listener_fields_dg.datagrid('getChanges','deleted');   
    var changesRows = {   
            inserted : [],   
            updated : [],
            deleted : []  
            };   
    if (insertRows.length>0) {   
        for (var i=0;i<insertRows.length;i++) {   
            changesRows.inserted.push(insertRows[i]);
        }   
    }   

    if (updateRows.length>0) {   
        for (var k=0;k<updateRows.length;k++) {   
            changesRows.updated.push(updateRows[k]);
        }   
    }   
       
    if (deleteRows.length>0) {   
        for (var j=0;j<deleteRows.length;j++) {   
            changesRows.deleted.push(deleteRows[j]);   
        }   
    }
    return changesRows;
}
function saveListenerConfig(){
	if(listenerId != "" && listenerId != null && listenerId!="null"&&listenerId!="NULL"){
		var listener = getExsitingListener();
		var r = updateExistingListener(listener);
		if(!r)return;		
	}else{
		var listener = createNewListener();
		var r = insertNewListener(listener);
		if(!r)return;
	}
	_listener_win.window('close');
}
function insertNewListener(listener){
	listener.event=_listener_event_type.combobox('getValue');
	jq('input[name="listenerServiceType"]').each(function(i){
		if(this.checked){
			listener.serviceType=this.value;
			return false;
		}
	});
	listener.serviceClass=jq('#listenerServiceClass').val();
	listener.serviceExpression=jq('#listenerServiceExpression').val();
    var changesRows = getListenerFieldsGridChangeRows();
    if(changesRows == null)return false;
    var insertRows = changesRows['inserted'];   
    if (insertRows.length>0) {   
        for (var i=0;i<insertRows.length;i++) {
            var field = new draw2d.Task.Listener.Field();
    		field.name=insertRows[i].fieldName;
    		field.value=insertRows[i].value;
    		field.type=insertRows[i].type;
    		listener.fields.add(field);  
        }   
    }
	task.listeners.add(listener);
	loadTaskListeners();
	return true;
}
function updateExistingListener(listener){
	listener.event=_listener_event_type.combobox('getValue');
	jq('input[name="listenerServiceType"]').each(function(i){
		if(this.checked){
			listener.serviceType=this.value;
			return false;
		}
	});
	listener.serviceClass=jq('#listenerServiceClass').val();
	listener.serviceExpression=jq('#listenerServiceExpression').val();
	var changesRows = getListenerFieldsGridChangeRows();
    if(changesRows == null)return false;
    var insertRows = changesRows['inserted'];   
    var updateRows = changesRows['updated'];   
    var deleteRows = changesRows['deleted'];
    if (insertRows.length>0) {   
        for (var i=0;i<insertRows.length;i++) {   
        	var field = new draw2d.Task.Listener.Field();
    		field.name=insertRows[i].fieldName;
    		field.value=insertRows[i].value;
    		field.type=insertRows[i].type;
    		listener.fields.add(field);
        }   
    }   

    if (updateRows.length>0) {   
        for (var k=0;k<updateRows.length;k++) {   
        	var field = listener.getField(updateRows[k].id);
    		field.name=updateRows[k].fieldName;
    		field.value=updateRows[k].value;
    		field.type=updateRows[k].type;
        }   
    }   
       
    if (deleteRows.length>0) {   
        for (var j=0;j<deleteRows.length;j++) {   
        	listener.deleteField(deleteRows[j].id);
        }   
    }
    loadTaskListeners();
    return true;
}

function populateListenerProperties(){
	if(listenerId != "" && listenerId != null && listenerId!="null"&&listenerId!="NULL"){
		var listener = task.getListener(listenerId);
		_listener_event_type.combobox('setValue',listener.event);
		var serviceType = listener.serviceType;
		jq('input[name="listenerServiceType"]').each(function(i){
			if(this.value==serviceType){
				this.checked=true;
				changeListenerServiceType(this);
				if(this.value=='javaClass'){
					jq('#listenerServiceClass').val(listener.serviceClass);
				}else if(this.value=='expression'){
					jq('#listenerServiceExpression').val(listener.serviceExpression);
				}
				return false;
			}
		});
		var fields = listener.fields;
		var _listener_fields_grid_data=[];
		for(var i=0;i<fields.getSize();i++){
			var field = {
					id:fields.get(i).id,
					fieldName:fields.get(i).name,
					type:fields.get(i).type,
					value:fields.get(i).value,
					action:''
					};
			_listener_fields_grid_data[i]=field;
		}
		_task_listener_fields_dg.datagrid('loadData',_listener_fields_grid_data);
	}
}
function closeTaskListenerWin(){
	_listener_win.window('close');
}
//-->
</script>
<table>
		<tr>
			<td align="right">事件:</td>
			<td>
				<select id="listenerEventType" name="listenerEventType">
					<option value="create">Create</option>
					<option value="assignment">Assignment</option>
					<option value="complete">Complete</option>
				</select>
			</td>
		</tr>
		<tr>
			<td></td>
			<td align="left">
				<input type="radio" id="listenerServiceType" name="listenerServiceType" value="javaClass" checked="checked" onclick="changeListenerServiceType(this)">java类
				<input type="radio" id="listenerServiceType" name="listenerServiceType" value="expression" onclick="changeListenerServiceType(this)">表达式
			</td>
		</tr>
		<tr>
			<td id="listenerServiceLabel" align="right">java类:</td>
			<td>
				<input type="text" id="listenerServiceClass" name="listenerServiceClass" size="80" value=""/>
				<input type="text" id="listenerServiceExpression" name="listenerServiceExpression" size="80" style="display: none;" value=""/>
			</td>
		</tr>
		<tr>
			<td align="right">Fields:</td>
			<td>
				<table id="task-listeners-fields-list">
					<thead>
					<tr>
					<th field="id" hidden="true"></th>
					<th field="fieldName" width="200" align="middle" sortable="false" editor="{
						type:'validatebox',
						options:{
						required:true,
						validType:'length[1,100]'
					}}">Field Name</th>
					<th field="type" width="100" align="middle" sortable="false" editor="{
						type:'combobox',
						options:{
							editable:false,
							data:[{id:'string',text:'String',selected:true},{id:'expression',text:'Expression'}],
							valueField:'id',
							textField:'text'
					}}">Type</th>
					<th field="value" width="200" align="middle" sortable="false" editor="{
						type:'validatebox',
						options:{
						validType:'length[1,100]'
					}}">Value</th>
					<th field="action" width="80" align="middle" formatter="listenerFieldsActionFormatter">Action</th>
					</tr>
					</thead>
				</table>
			</td>
		</tr>
		<tr>
			<td colspan="2" align="center">
				<a href="##" id="fieldSaveBt" onclick="saveListenerConfig()">保存</a>
				<a href="##" id="fieldCancelBt" onclick="closeTaskListenerWin()">取消</a>
			</td>
		</tr>
</table>