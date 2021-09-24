<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<!DOCTYPE HTML>
<html>
<head>
<meta charset="utf-8">
<meta name="renderer" content="webkit|ie-comp|ie-stand">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<meta http-equiv="Cache-Control" content="no-siteapp" />
<LINK rel="Bookmark" href="/favicon.ico" >
<LINK rel="Shortcut Icon" href="/favicon.ico" />
<%@ include file="/commons/head.jsp"%>
<title>添加用户</title>
</head>
<body>
<article class="page-container">
	<form action="${ctx}/sys/Role/edit.do" method="post" class="form form-horizontal" id="callForm" name="callForm">
	  <input type="hidden" name="formMap.ROLE_ID" id="ROLE_ID" value="${resultMap.ROLE_ID}">
		<div class="row cl">
			<label class="form-label col-xs-4 col-sm-3"><span class="c-red">*</span>角色名称：</label>
			<div class="formControls col-xs-8 col-sm-9">
				<input type="text" class="input-text"  placeholder="用户名" name="formMap.NAME" id="NAME" value="${resultMap.NAME}">
			</div>
		</div>
		<div class="row cl">
			<div class="col-xs-8 col-sm-9 col-xs-offset-4 col-sm-offset-3">
				<input class="btn btn-primary radius" type="submit" value="&nbsp;&nbsp;提交&nbsp;&nbsp;">
			</div>
		</div>
	</form>
</article>

<%@ include file="/commons/foot.jsp"%>

<!--请在下方写此页面业务相关的脚本--> 
<script type="text/javascript">
$(function(){
	$('.skin-minimal input').iCheck({
		checkboxClass: 'icheckbox-blue',
		radioClass: 'iradio-blue',
		increaseArea: '20%'
	});
	
	$("#callForm").validate({
		rules:{
			'formMap.NAME':{
				required:true
			}
		},
		onkeyup:false,
		focusCleanup:true,
		success:"valid",
		submitHandler:function(form){
				$.ajax({
					url     : $(form).attr("action")+"?"+Math.random(),
					type    :   "POST",                     // 请求的方式:"POST" 或者 "GET"
					dataType:   "JSON",                     // 数据返回的格式
					async	:    false, 
					data: $(form).serialize(),
					success :   function(data){
						alert(data["MSG"]);
						if(data["MSG"]=='数据修改成功!'){
							parent.gotoList('${ctx}');
							var index = parent.layer.getFrameIndex(window.name);
							parent.layer.close(index);
						}
						
					},
				    error:function(){
					alert("系统异常,请联系系统管理员！");
				  }
				 });
			
		}
	});
});
</script> 
<!--/请在上方写此页面业务相关的脚本-->
</body>
</html>