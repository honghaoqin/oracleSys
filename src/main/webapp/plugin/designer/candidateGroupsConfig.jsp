<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script type="text/javascript">
<!--
jq(function(){
	_task_candidate_win = jq('#task-candidate-win').window({
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
	_task_candidate_groups_list=jq('#task-candidate-groups-list').datagrid({
		title:"Candidate Groups",
		singleSelect:true,
		height:450,
		rownumbers:true,
		striped:true,
		toolbar:[{
	        text:'Add',
	        iconCls:'icon-add',
	        handler:function(){
				_task_candidate_win.window('open');
				_task_candidate_win.window('setTitle','Candidate User Config');
				_task_candidate_win.window('refresh','addCandidateGroup.jsp');
	        }
	    }]
	});
	loadTaskCandidateGroups();
});
function candidateGroupsBtFormatter(value,rowData,rowIndex){
	var name = rowData.name;
	//var e = '<img onclick="editForm('+id+')" src="image/edit.gif" title="'+"<s:text name='button.common.modify'></s:text>"+'" style="cursor:hand;"/>';   
    var d = '<img onclick="deleteCandidateGroup(\''+name+'\')" src="image/delete.gif" title="'+"删除"+'" style="cursor:hand;"/>';
	return d;
}
function deleteCandidateGroup(name){
	task.deleteCandidateGroup(name);
	loadTaskCandidateGroups();
}
function loadTaskCandidateGroups(){
	var candidateGroups = task.candidateGroups;
	var candidate_groups_grid_rows=[];
	//alert(listeners.getSize());
	for(var i=0;i<candidateGroups.getSize();i++){
		var candidateGroup = candidateGroups.get(i);
		var group = {
					name:candidateGroup,
					action:''
				};
		candidate_groups_grid_rows[i]=group;
	};
	//alert(listener_grid_rows);
	var candidate_groups_grid_data={
			total:candidateGroups.getSize(),
			rows:candidate_groups_grid_rows
	};
	_task_candidate_groups_list.datagrid('loadData',candidate_groups_grid_data);
}
//-->
</script>
<!--<div id="task-candidate-groups-panel">-->
								<table id="task-candidate-groups-list" name="task-candidate-groups-list">
								<thead>
								<tr>
								<th field="name" width="100" align="middle" sortable="false">名称</th>
								<th field="action" width="80" align="middle" formatter="candidateGroupsBtFormatter">Action</th>
								</tr>
								</thead>
								</table>
<!--</div>-->
