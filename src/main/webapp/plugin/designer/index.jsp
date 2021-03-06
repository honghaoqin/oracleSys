<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
  <meta content="text/html; charset=UTF-8" http-equiv="content-type">
		  <title>流程设计</title>
		  <!-- framework CSS -->
<link href="themes/default/css/style.css" type="text/css" rel="stylesheet" title="blue"/>

<!-- JQuery EasyUi CSS-->
<link type="text/css" href="js/jquery-easyui/themes/default/easyui.css" rel="stylesheet" title="blue">
<link href="js/jquery-easyui/themes/icon.css" type="text/css" rel="stylesheet"/>

<!-- JQuery validate CSS-->
<link href="js/validate/jquery.validate.extend.css" type="text/css" rel="stylesheet"/>

<!-- JQuery AutoComplete -->
<link rel="stylesheet" type="text/css" href="js/jquery-autocomplete/jquery.autocomplete.css" />
<!--<link rel="stylesheet" type="text/css" href="js/jquery-autocomplete/lib/thickbox.css" />-->

<!-- JQuery-->
<script src="js/jquery-1.4.4.min.js" type="text/javascript"></script>
<!--<script src="js/jquery-1.6.min.js" type="text/javascript"></script>-->

<!-- JQuery EasyUi JS-->
<script src="js/jquery-easyui/jquery.easyui.min.js" type="text/javascript"></script>
<!-- JQuery validate JS-->
<script src="js/validate/jquery.validate.js" type="text/javascript"></script>
<script src="js/validate/jquery.metadata.js" type="text/javascript"></script>
<script src="js/validate/jquery.validate.method.js" type="text/javascript"></script>
<script src="js/validate/jquery.validate.extend.js" type="text/javascript"></script>

<!-- JQuery form Plugin -->
<script src="js/jquery.form.js" type="text/javascript"></script>

<!-- JSON JS-->
<script src="js/json2.js" type="text/javascript"></script>

<!-- JQuery AutoComplete -->
<script type='text/javascript' src='js/jquery-autocomplete/lib/jquery.bgiframe.min.js'></script>
<script type='text/javascript' src='js/jquery-autocomplete/lib/jquery.ajaxQueue.js'></script>
<!--<script type='text/javascript' src='js/jquery-autocomplete/lib/thickbox-compressed.js'></script>-->
<script type='text/javascript' src='js/jquery-autocomplete/jquery.autocomplete.min.js'></script>

<!-- framework JS -->
<script src="js/skin.js" type="text/javascript"></script>
		  <link href="js/designer/designer.css" type="text/css" rel="stylesheet"/>
  			
        <!-- common, all times required, imports -->
        <SCRIPT src='js/draw2d/wz_jsgraphics.js'></SCRIPT>          
        <SCRIPT src='js/draw2d/mootools.js'></SCRIPT>          
        <SCRIPT src='js/draw2d/moocanvas.js'></SCRIPT>                        
        <SCRIPT src='js/draw2d/draw2d.js'></SCRIPT>


        <!-- example specific imports -->
        <SCRIPT src="js/designer/MyCanvas.js"></SCRIPT>
        <SCRIPT src="js/designer/ResizeImage.js"></SCRIPT>
		<SCRIPT src="js/designer/event/Start.js"></SCRIPT>
		<SCRIPT src="js/designer/event/End.js"></SCRIPT>
		<SCRIPT src="js/designer/connection/MyInputPort.js"></SCRIPT>
		<SCRIPT src="js/designer/connection/MyOutputPort.js"></SCRIPT>
		<SCRIPT src="js/designer/connection/DecoratedConnection.js"></SCRIPT>
		<SCRIPT src="js/designer/task/Task.js"></SCRIPT>
		<SCRIPT src="js/designer/task/UserTask.js"></SCRIPT>
		<SCRIPT src="js/designer/task/ManualTask.js"></SCRIPT>
		<SCRIPT src="js/designer/task/ServiceTask.js"></SCRIPT>
		<SCRIPT src="js/designer/gateway/ExclusiveGateway.js"></SCRIPT>
		<SCRIPT src="js/designer/gateway/ParallelGateway.js"></SCRIPT>
		<!--shimh begin-->
		<SCRIPT src="js/designer/task/BusinessRuleTask.js"></SCRIPT>
		<SCRIPT src="js/designer/task/MailTask.js"></SCRIPT>
		<SCRIPT src="js/designer/task/ReceiveTask.js"></SCRIPT>
		<SCRIPT src="js/designer/task/ScriptTask.js"></SCRIPT>
		<SCRIPT src="js/designer/boundaryevent/TimerBoundary.js"></SCRIPT>
		<SCRIPT src="js/designer/boundaryevent/ErrorBoundary.js"></SCRIPT>
		<!--shimh end-->
		<SCRIPT src="js/designer/designer.js"></SCRIPT>	
</head>
<script type="text/javascript">
<!--
var processDefinitionId="";
var processDefinitionName="";
var processDefinitionVariables="";
var _process_def_provided_listeners="";
var is_open_properties_panel = false;
jq(function(){

	try{
		_task_obj = jq('#task');
		_designer = jq('#designer');
		_properties_panel_obj = _designer.layout('panel','east');
		_properties_panel_obj.panel({
			onOpen:function(){
				is_open_properties_panel = true;
			},
			onClose:function(){
				is_open_properties_panel = false;
			}
		});
		_process_panel_obj = _designer.layout('panel','center');
		_task_context_menu = jq('#task-context-menu').menu({});
		//_designer.layout('collapse','east');
		_properties_panel_obj.panel('refresh','processProperties.jsp');
		jq('.easyui-linkbutton').draggable({
					proxy:function(source){
						var n = jq('<div class="draggable-model-proxy"></div>');
						n.html(jq(source).html()).appendTo('body');
						return n;
					},
					deltaX:0,
					deltaY:0,
					revert:true,
					cursor:'auto',
					onStartDrag:function(){
						jq(this).draggable('options').cursor='not-allowed';
					},
					onStopDrag:function(){
						jq(this).draggable('options').cursor='auto';
					}	
		});
		jq('#paintarea').droppable({
					accept:'.easyui-linkbutton',
					onDragEnter:function(e,source){
						jq(source).draggable('options').cursor='auto';
					},
					onDragLeave:function(e,source){
						jq(source).draggable('options').cursor='not-allowed';
					},
					onDrop:function(e,source){
						//jq(this).append(source)
						//jq(this).removeClass('over');
						var wfModel = jq(source).attr('wfModel');
						var shape = jq(source).attr('shape');
						if(wfModel){
							var x=jq(source).draggable('proxy').offset().left;
							var y=jq(source).draggable('proxy').offset().top;
							var xOffset    = workflow.getAbsoluteX();
		                    var yOffset    = workflow.getAbsoluteY();
		                    var scrollLeft = workflow.getScrollLeft();
		                    var scrollTop  = workflow.getScrollTop();
		                  //alert(xOffset+"|"+yOffset+"|"+scrollLeft+"|"+scrollTop);
		                    addModel(wfModel,x-xOffset+scrollLeft,y-yOffset+scrollTop,shape);
						}
					}
				});
		//jq('#paintarea').bind('contextmenu',function(e){
			//alert(e.target.tagName);
		//});
	
	}catch(e){
		alert(e.message);
	};
	jq(window).unload( function () { 
		window.opener._list_grid_obj.datagrid('reload');
	} );
});
function addModel(name,x,y,icon){
	var model = null;
	if(icon!=null&&icon!=undefined)
		model = eval("new draw2d."+name+"('"+icon+"')");
	else
		model = eval("new draw2d."+name+"()");
	model.generateId();
	workflow.addModel(model,x,y);
}

function openEventProperties(id){
	alert(1);
	if(!is_open_properties_panel)
		_designer.layout('expand','east');
	_properties_panel_obj.panel('refresh','eventProperties.jsp?id='+id);
}
function openTaskProperties(id){
	alert(2);
	if(!is_open_properties_panel)
		_designer.layout('expand','east');
	_properties_panel_obj.panel('refresh','taskProperties.jsp?id='+id);
}
function openGatewayProperties(id){
	alert(3);
	if(!is_open_properties_panel)
		_designer.layout('expand','east');
	_properties_panel_obj.panel('refresh','gatewayProperties.jsp?id='+id);
}
function openProcessProperties(id){
	alert(4);
	if(!is_open_properties_panel)
		_designer.layout('expand','east');
	_properties_panel_obj.panel('refresh','processProperties.jsp?id='+id);
}
function openFlowProperties(id){
	alert(5);
	if(!is_open_properties_panel)
		_designer.layout('expand','east');
	_properties_panel_obj.panel('refresh','flowProperties.jsp?id='+id);
}
//shimh begin
function openScriptTask(id){
	alert(6);
	if(!is_open_properties_panel)
		_designer.layout('expand','east');
	_properties_panel_obj.panel('refresh','scriptTask.jsp?id='+id);
}



function deleteModel(id){
	alert(7);
	var task = workflow.getFigure(id);
	workflow.removeFigure(task);
}
function redo(){
	workflow.getCommandStack().redo();
}
function undo(){
	workflow.getCommandStack().undo();
}
function saveProcessDef(){
	alert(8);
	var xml = workflow.toXML();
	//alert(workflow.process.getVariablesJSONObject());
	//alert(workflow.process.getVariablesJSONObject());
	//return;
	jq.ajax({
		url:"${ctx}/wf/procdef/procdef!saveProcessDescriptor.action",
		type: 'POST',
		data:{
			processDescriptor:xml,
			processName:workflow.process.name,
			processVariables:workflow.process.getVariablesJSONObject()
		},
		dataType:'json',
		error:function(){
			//$.messager.alert("<s:text name='label.common.error'></s:text>","<s:text name='message.common.save.failure'></s:text>","error");
			return "";
		},
		success:function(data){
			if(data.result){
				jq.messager.alert('Info','Save Successfully!','info');
			}else{
				jq.messager.alert('Error',data.message,'error');
			}
		}	
	}); 
	
}
function exportProcessDef(obj){
	alert(9);
	//obj.href="${ctx}/wf/procdef/procdef!exportProcessDef.action?procdefId="+processDefinitionId+"&processName="+processDefinitionName;
}
//-->
</script>

<body id="designer" class="easyui-layout">
	<div region="west" split="true" iconCls="palette-icon" title="流程元素" style="width:150px;">
		<div class="easyui-accordion" fit="true" border="false">
				<div id="event" title="事件" iconCls="palette-menu-icon" class="palette-menu">
					<a href="##" class="easyui-linkbutton" plain="true" iconCls="start-event-icon">开始</a><br>
					<a href="##" class="easyui-linkbutton" plain="true" iconCls="end-event-icon">结束</a><br>
				</div>
				<div id="task" title="任务" iconCls="palette-menu-icon" selected="true" class="palette-menu">
					<a href="##" class="easyui-linkbutton" plain="true" iconCls="user-task-icon" wfModel="UserTask">用户任务</a><br>
					<a href="##" class="easyui-linkbutton" plain="true" iconCls="manual-task-icon" wfModel="ManualTask">手动任务</a><br>
					<a href="##" class="easyui-linkbutton" plain="true" iconCls="service-task-icon" wfModel="ServiceTask">服务任务</a><br>
					
					<a href="##" class="easyui-linkbutton" plain="true" iconCls="script-task-icon"  wfModel="ScriptTask" >脚本任务1</a><br>
					<a href="##" class="easyui-linkbutton" plain="true" iconCls="mail-task-icon"  wfModel="MailTask" >邮件任务1</a><br>
					<a href="##" class="easyui-linkbutton" plain="true" iconCls="receive-task-icon"  wfModel="ReceiveTask" >接收任务1</a><br>
					<a href="##" class="easyui-linkbutton" plain="true" iconCls="business-rule-task-icon" wfModel="BusinessRuleTask">业务规则任务1</a><br>
					<a href="##" class="easyui-linkbutton" plain="true" iconCls="subprocess-icon" wfModel="CallActivity">子流程1</a><br>
					<a href="##" class="easyui-linkbutton" plain="true" iconCls="callactivity-icon">调用活动?</a><br>
					
				</div>
				<div id="gateway" title="网关" iconCls="palette-menu-icon" class="palette-menu">
					<a href="##" class="easyui-linkbutton" plain="true" iconCls="parallel-gateway-icon" wfModel="ParallelGateway" >同步</a><br>
					<a href="##" class="easyui-linkbutton" plain="true" iconCls="exclusive-gateway-icon" wfModel="ExclusiveGateway" >分支</a><br>
				</div>
				
				<div id="boundary-event" title="边界事件" iconCls="palette-menu-icon" class="palette-menu">
					<a href="##" class="easyui-linkbutton" plain="true" iconCls="timer-boundary-event-icon" wfModel="TimerBoundary" >时间边界事件1</a><br>
					<a href="##" class="easyui-linkbutton" plain="true" iconCls="error-boundary-event-icon"  wfModel="ErrorBoundary">错误边界事件1</a><br>
				</div>
		</div>
	</div>
	<div id="process-panel" region="center" split="true"  iconCls="process-icon" title="流程">
		
				<script>
					function parseProcessDescriptor(data){ 
						var descriptor = jq(data);
						var definitions = descriptor.find('definitions');
						var process = descriptor.find('process');
						var startEvent = descriptor.find('startEvent');
						var endEvent = descriptor.find('endEvent');
						var userTasks = descriptor.find('userTask');
						var exclusiveGateway = descriptor.find('exclusiveGateway');
						var parallelGateway = descriptor.find('parallelGateway');
						var lines = descriptor.find('sequenceFlow');
						var shapes = descriptor.find('bpmndi\\:BPMNShape');
						var edges = descriptor.find('bpmndi\\:BPMNEdge');
						workflow.process.category=definitions.attr('targetNamespace');
						workflow.process.id=process.attr('id');
						workflow.process.name=process.attr('name');
						var documentation = trim(descriptor.find('process > documentation').text());
						if(documentation != null && documentation != "")
							workflow.process.documentation=documentation;
						var extentsion = descriptor.find('process > extensionElements');
						if(extentsion != null){
							var listeners = extentsion.find('activiti\\:executionListener');
							workflow.process.setListeners(parseListeners(listeners,"draw2d.Process.Listener","draw2d.Process.Listener.Field"));
						}
						jq.each(processDefinitionVariables,function(i,n){
								var variable = new draw2d.Process.variable();
								variable.name=n.name;
								variable.type=n.type;
								variable.scope=n.scope;
								variable.defaultValue=n.defaultValue;
								variable.remark=n.remark;
								workflow.process.addVariable(variable);
							});
						startEvent.each(function(i){
								var start = new draw2d.Start("js/designer/icons/type.startevent.none.png");
								start.id=jq(this).attr('id');
								start.eventId=jq(this).attr('id');
								start.eventName=jq(this).attr('name');
								shapes.each(function(i){
									var id = jq(this).attr('bpmnElement');
									if(id==start.id){
										var x=parseInt(jq(this).find('omgdc\\:Bounds').attr('x'));
										var y=parseInt(jq(this).find('omgdc\\:Bounds').attr('y'));
										workflow.addFigure(start,x,y);
										return false;
									}
								});
							});
						endEvent.each(function(i){
								var end = new draw2d.End("js/designer/icons/type.endevent.none.png");
								end.id=jq(this).attr('id');
								end.eventId=jq(this).attr('id');
								end.eventName=jq(this).attr('name');
								shapes.each(function(i){
									var id = jq(this).attr('bpmnElement');
									if(id==end.id){
										var x=parseInt(jq(this).find('omgdc\\:Bounds').attr('x'));
										var y=parseInt(jq(this).find('omgdc\\:Bounds').attr('y'));
										workflow.addFigure(end,x,y);
										return false;
									}
								});
							});
						
						userTasks.each(function(i){
							alert(4);
								var task = new draw2d.UserTask();
								var tid = jq(this).attr('id');
								task.id=tid;
								var tname = jq(this).attr('name');
								var assignee=jq(this).attr('activiti:assignee');
								var candidataUsers=jq(this).attr('activiti:candidateUsers');
								var candidataGroups=jq(this).attr('activiti:candidateGroups');
								var formKey=jq(this).attr('activiti:formKey');
								if(assignee!=null&&assignee!=""){
									task.isUseExpression=true;
									task.performerType="assignee";
									task.expression=assignee;
								}else if(candidataUsers!=null&&candidataUsers!=""){
									task.isUseExpression=true;
									task.performerType="candidateUsers";
									task.expression=candidataUsers;
								}else if(candidataGroups!=null&&candidataGroups!=""){
									task.isUseExpression=true;
									task.performerType="candidateGroups";
									task.expression=candidataGroups;
								}
								if(formKey!=null&&formKey!=""){
									task.formKey=formKey;
								}
								var documentation = trim(jq(this).find('documentation').text());
								if(documentation != null && documentation != "")
									task.documentation=documentation;
								task.taskId=tid;
								task.taskName=tname;
								if(tid!= tname)
									task.setContent(tname);
								var listeners = jq(this).find('extensionElements').find('activiti\\:taskListener');
								task.setListeners(parseListeners(listeners,"draw2d.Task.Listener","draw2d.Task.Listener.Field"));
								var performersExpression = jq(this).find('potentialOwner').find('resourceAssignmentExpression').find('formalExpression').text();
								if(performersExpression.indexOf('user(')!=-1){
									task.performerType="candidateUsers";
								}else if(performersExpression.indexOf('group(')!=-1){
									task.performerType="candidateGroups";
								}
								var performers = performersExpression.split(',');
								jq.each(performers,function(i,n){
									var start = 0;
									var end = n.lastIndexOf(')');
									if(n.indexOf('user(')!=-1){
										start = 'user('.length;
										var performer = n.substring(start,end);
										task.addCandidateUser({
												sso:performer
										});
									}else if(n.indexOf('group(')!=-1){
										start = 'group('.length;
										var performer = n.substring(start,end);
										task.addCandidateGroup(performer);
									}
								});
								shapes.each(function(i){
									var id = jq(this).attr('bpmnElement');
									if(id==task.id){
										var x=parseInt(jq(this).find('omgdc\\:Bounds').attr('x'));
										var y=parseInt(jq(this).find('omgdc\\:Bounds').attr('y'));
										workflow.addModel(task,x,y);
										return false;
									}
								});
							});
						exclusiveGateway.each(function(i){
								var gateway = new draw2d.ExclusiveGateway("js/designer/icons/type.gateway.exclusive.png");
								var gtwid = jq(this).attr('id');
								var gtwname = jq(this).attr('name');
								gateway.id=gtwid;
								gateway.gatewayId=gtwid;
								gateway.gatewayName=gtwname;
								shapes.each(function(i){
									var id = jq(this).attr('bpmnElement');
									if(id==gateway.id){
										var x=parseInt(jq(this).find('omgdc\\:Bounds').attr('x'));
										var y=parseInt(jq(this).find('omgdc\\:Bounds').attr('y'));
										workflow.addModel(gateway,x,y);
										return false;
									}
								});
							});
						parallelGateway.each(function(i){
							var gateway = new draw2d.ExclusiveGateway("js/designer/icons/type.gateway.parallel.png");
							var gtwid = jq(this).attr('id');
							var gtwname = jq(this).attr('name');
							gateway.id=gtwid;
							gateway.gatewayId=gtwid;
							gateway.gatewayName=gtwname;
							shapes.each(function(i){
								var id = jq(this).attr('bpmnElement');
								if(id==gateway.id){
									var x=parseInt(jq(this).find('omgdc\\:Bounds').attr('x'));
									var y=parseInt(jq(this).find('omgdc\\:Bounds').attr('y'));
									workflow.addModel(gateway,x,y);
									return false;
								}
							});
						});
						lines.each(function(i){
								var lid = jq(this).attr('id');
								var name = jq(this).attr('name');
								var condition=jq(this).find('conditionExpression').text();
								var sourceRef = jq(this).attr('sourceRef');
								var targetRef = jq(this).attr('targetRef');
								var source = workflow.getFigure(sourceRef);
								var target = workflow.getFigure(targetRef);
								edges.each(function(i){
										var eid = jq(this).attr('bpmnElement');
										if(eid==lid){
											var startPort = null;
											var endPort = null;
											var points = jq(this).find('omgdi\\:waypoint');
											var startX = jq(points[0]).attr('x');
											var startY = jq(points[0]).attr('y');
											var endX = jq(points[1]).attr('x');
											var endY = jq(points[1]).attr('y');
											var sports = source.getPorts();
											for(var i=0;i<sports.getSize();i++){
												var s = sports.get(i);
												var x = s.getAbsoluteX();
												var y = s.getAbsoluteY();
												if(x == startX&&y==startY){
													startPort = s;
													break;
												}
											}
											var tports = target.getPorts();
											for(var i=0;i<tports.getSize();i++){
												var t = tports.get(i);
												var x = t.getAbsoluteX();
												var y = t.getAbsoluteY();
												if(x==endX&&y==endY){
													endPort = t;
													break;
												}
											}
											if(startPort != null&&endPort!=null){
												var cmd=new draw2d.CommandConnect(workflow,startPort,endPort);
												var connection = new draw2d.DecoratedConnection();
												connection.id=lid;
												connection.lineId=lid;
												connection.lineName=name;
												if(lid!=name)
													connection.setLabel(name);
												if(condition != null && condition!=""){
													connection.condition=condition;
												}
												cmd.setConnection(connection);
												workflow.getCommandStack().execute(cmd);
											}
											return false;
										}
									});
							});
						if(typeof setHightlight != "undefined"){
							setHightlight();
						}
					}
					function parseListeners(listeners,listenerType,fieldType){
						var parsedListeners = new draw2d.ArrayList();
						listeners.each(function(i){
							var listener = eval("new "+listenerType+"()");
							
							listener.event=jq(this).attr('event');
							var expression = jq(this).attr('expression');
							var clazz = jq(this).attr('class');
							if(expression != null && expression!=""){
								listener.serviceType='expression';
								listener.serviceExpression=expression;
							}else if(clazz != null&& clazz!=""){
								listener.serviceType='javaClass';
								listener.serviceExpression=clazz;
							}
							var fields = jq(this).find('activiti\\:field');
							fields.each(function(i){
								var field = eval("new "+fieldType+"()");
								field.name=jq(this).attr('name');
								//alert(field.name);
								var string = jq(this).find('activiti\\:string').text();
								var expression = jq(this).find('activiti\\:expression').text();
								//alert("String="+string.text()+"|"+"expression="+expression.text());
								if(string != null && string != ""){
									field.type='string';
									field.value=string;
								}else if(expression != null && expression!= ""){
									field.type='expression';
									field.value=expression;
								}
								listener.setField(field);
							});
							parsedListeners.add(listener);
						});
						return parsedListeners;
					}
				</script>
				<div id="process-definition-tab">
							<div id="designer-area" title="设计" style="POSITION: absolute;width:100%;height:100%;padding: 0;border: none;overflow:auto;">
								<div id="paintarea" style="POSITION: absolute;WIDTH:2000px; HEIGHT:2000px" ></div>
							</div>
							<div id="xml-area" title="源码" style="width:100%;height:100%;overflow:hidden;overflow-x:hidden;overflow-y:hidden;">
								<textarea id="descriptorarea" rows="38" style="width: 100%;height:100%;padding: 0;border: none;" readonly="readonly"></textarea>
							</div>
				</div>
				<script type="text/javascript">
					<!--
					var workflow;
					jq('#process-definition-tab').tabs({
						fit:true,
						onSelect:function(title){
							if(title=='设计'){
								
							}else if(title=='源码'){
								jq('#descriptorarea').val(workflow.toXML());

							}
						}
					});
					function openProcessDef(){
						jq.ajax({
							url:"test.xml",
							dataType:'xml',
							error:function(){
								alert("<s:text name='label.common.error'></s:text>","System Error","error");
								return "";
							},
							success:parseProcessDescriptor	
						}); 
					}
				
					function createCanvas(disabled){
						try{
							//initCanvas();
							workflow  = new draw2d.MyCanvas("paintarea");
							workflow.scrollArea=document.getElementById("designer-area");
							if(disabled)
								workflow.setDisabled();
							if(typeof processDefinitionId != "undefined" && processDefinitionId != null &&  processDefinitionId != "null" && processDefinitionId != "" && processDefinitionId != "NULL"){
								openProcessDef();
							}else{
								var id = "process"+Sequence.create();
								//var id = workflow.getId();
								workflow.process.category='http://www.hpi.com';
								workflow.process.id=id;
								workflow.process.name=id;
								workflow.process.documentation="流程描述";
								
								// Add the start,end,connector to the canvas
								 var startObj = new draw2d.Start("js/designer/icons/type.startevent.none.png");
								  startObj.setId("start");
								 workflow.addFigure(startObj, 200,50);
								  
								 var endObj   = new draw2d.End("js/designer/icons/type.endevent.none.png");
								  endObj.setId("end");
								 workflow.addFigure(endObj,200,400);
							} 
						}catch(e){
							alert(e.message);
						}
					}
					//-->
				</script>
	</div>
	<div id="properties-panel" region="east" split="true" iconCls="properties-icon" title="流程属性" style="width:280px;">
		
	</div>
	
	<!-- toolbar -->
	 <div id="toolbar-panel" region="north" border="false" style="height: 55px; background: #d8e4fe;" title="工具栏">
   <input type="hidden" name="processId" id="processId" value="0">
   <img width="25" height="25" title="创建流程" src="image/save1.png" onclick="saveProcessDef()" class="buttonStyle" />
   <img width="25" height="25" title="上一步" src="image/back.png" onclick="undo()" class="buttonStyle" />
   <img width="25" height="25" title="下一步" src="image/next.png" onclick="redo()" class="buttonStyle" />
   <img width="25" height="25" title="导出" src="image/printer.png" onclick="exportProcessDef(this)" class="buttonStyle" />
  </div>
	
	<!-- task context menu -->
	<div id="task-context-menu" class="easyui-menu" style="width:120px;">
		<div id="properties-task-context-menu" iconCls="properties-icon">属性</div>
		<div id="delete-task-context-menu" iconCls="icon-remove">删除</div>
	</div>
	<!-- form configuration window -->
  <div id="form-win" title="表单配置" style="width: 720px; height: 300px;">
  </div>
  <!-- form configuration window -->
  <div id="variable-win" title="变量配置" style="width: 720px; height: 300px;">
  </div>
  <!-- listener configuration window -->
  <div id="listener-win" title="监听配置" style="width: 720px; height: 300px;">
  </div>
  <!-- candidate configuration window -->
  <div id="task-candidate-win" title="任务配置" style="width: 720px; height: 300px;">
  </div>
</body>
</html>
<script type="text/javascript">
<!--
	createCanvas(false);
//-->
</script>