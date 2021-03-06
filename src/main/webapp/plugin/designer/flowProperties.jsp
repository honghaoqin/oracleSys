<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script type="text/javascript">
<!--
var fid = "<%=request.getParameter("id")%>";
var line = workflow.getLine(fid);
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
	jq('#line-listeners-list').datagrid({
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
	    		_listener_win.window('refresh','flowListenerConfig.jsp');
	    		//alert(_listener_frame.document.body.innerHTML);
	        }
	    }]
	});
	populateLineProperites();
});
function listenerActionBt(value,rowData,rowIndex){
	var id = rowData.id;
	var e = '<img onclick="editListener(\''+id+'\')" src="image/edit.gif" title="'+"修改"+'" style="cursor:hand;"/>';   
    var d = '<img onclick="deleteListener(\''+id+'\')" src="image/delete.gif" title="'+"删除"+'" style="cursor:hand;"/>';
	return e+'&nbsp;'+d;
}
function editListener(id){
	_listener_win.window('open');
	_listener_win.window('refresh','flowListenerConfig.jsp');
}
function deleteListener(id){
	line.deleteListener(id);
	loadLineListeners();
}
function saveLineProperties(){
	//alert(tid);
	line.lineId=jq('#id').val();
	line.lineName=jq('#name').val();
	line.setLabel(jq('#name').val());
	line.condition=jq('#condition').val();
	jq.messager.alert('Info','Save Successfully!','info');
}
function populateLineProperites(){
	jq('#id').val(line.lineId);
	jq('#name').val(line.lineName);
	jq('#condition').val(line.condition);
}
function loadLineListeners(){
	var listeners = line.listeners;
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
	jq('#line-listeners-list').datagrid('loadData',listener_grid_data);
}
//-->
</script>
<div id="line-properties-layout" class="easyui-layout" fit="true">
	<div id="line-properties-toolbar-panel" region="north" border="false" style="height:30px;background:#E1F0F2;">
		<a href="##" id="sb2" class="easyui-linkbutton" plain="true" iconCls="icon-save" onclick="saveLineProperties()">保存</a>
	</div>
	<div id="line-properties-panel" region="center" border="true">
		<div class="easyui-accordion" fit="true" border="false">
			<div id="general" title="流程属性面板" selected="true" class="properties-menu">
				<table id="general-properties">
					<tr>
						<td align="right">Id:</td>
						<td><input type="text" id="id" name="id" size="28" value=""/></td>
					</tr>
					<tr>
						<td align="right">Name:</td>
						<td><input type="text" id="name" name="name" size="28" value=""/></td>
					</tr>
					<tr>
						<td align="right">Condition:</td>
						<td><input type="text" id="condition" name="condition" size="28" value=""/></td>
					
					</tr>
				</table>
			</div>
		</div>
	</div>
</div>