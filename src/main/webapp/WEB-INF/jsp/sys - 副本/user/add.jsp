<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<c:set var="csspath" value='/hui' />
<!--_meta 作为公共模版分离出去-->
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
<!--[if lt IE 9]>
<script type="text/javascript" src="${csspath}/lib/html5.js"></script>
<script type="text/javascript" src="${csspath}/lib/respond.min.js"></script>
<script type="text/javascript" src="${csspath}/lib/PIE_IE678.js"></script>
<![endif]-->
<link rel="stylesheet" type="text/css" href="${csspath}/static/h-ui/css/H-ui.min.css" />
<link rel="stylesheet" type="text/css" href="${csspath}/static/h-ui.admin/css/H-ui.admin.css" />
<link rel="stylesheet" type="text/css" href="${csspath}/lib/Hui-iconfont/1.0.7/iconfont.css" />
<link rel="stylesheet" type="text/css" href="${csspath}/lib/icheck/icheck.css" />
<link rel="stylesheet" type="text/css" href="${csspath}/static/h-ui.admin/skin/default/skin.css" id="skin" />
<link rel="stylesheet" type="text/css" href="${csspath}/static/h-ui.admin/css/style.css" />
<!--[if IE 6]>
<script type="text/javascript" src="${csspath}/static/h-ui/js/DD_belatedPNG_0.0.8a-min.js" ></script>
<script>DD_belatedPNG.fix('*');</script>
<![endif]-->
<!--/meta 作为公共模版分离出去-->
<title>添加用户</title>
</head>
<body>
<article class="page-container">
	<form action="${ctx}/sys/User/add.do" method="post" class="form form-horizontal" id="callForm" name="callForm">
		<div class="row cl">
			<label class="form-label col-xs-4 col-sm-3"><span class="c-red">*</span>用户名：</label>
			<div class="formControls col-xs-8 col-sm-9">
				<input type="text" class="input-text"  placeholder="用户名" name="formMap.LOGIN_ID" id="LOGIN_ID" value="${formMap.LOGIN_ID}">
			</div>
		</div>
		<div class="row cl">
			<label class="form-label col-xs-4 col-sm-3"><span class="c-red">*</span>姓名：</label>
			<div class="formControls col-xs-8 col-sm-9">
				<input type="text" class="input-text"  placeholder="姓名" name="formMap.NAME" id="NAME" >
			</div>
		</div>
		<div class="row cl">
			<label class="form-label col-xs-4 col-sm-3"><span class="c-red">*</span>密码：</label>
			<div class="formControls col-xs-8 col-sm-9">
				<input type="password" class="input-text"  placeholder="密码" name="formMap.PSW" id="PSW" value="${formMap.PSW}">
			</div>
		</div>
		
		<div class="row cl">
			<label class="form-label col-xs-4 col-sm-3"><span class="c-red">*</span>生效日期：</label>
			<div class="formControls col-xs-8 col-sm-9">
				<input type="text" class="input-text"  placeholder="生效日期" name="formMap.START_DT" id="START_DT" value="${formMap.START_DT}" 
				  onfocus="WdatePicker({minDate:'#F{$dp.$D(\'END_DT\')||\'%y-%M-%d\'}'})" >
			</div>
		</div>
		<div class="row cl">
			<label class="form-label col-xs-4 col-sm-3"><span class="c-red">*</span>失效日期：</label>
			<div class="formControls col-xs-8 col-sm-9">
				<input type="text" class="input-text"  placeholder="生效日期" name="formMap.END_DT" id="END_DT" value="${formMap.END_DT}" 
				   onfocus="WdatePicker({minDate:'#F{$dp.$D(\'START_DT\')||\'%y-%M-%d\'}'})" >
			</div>
		</div>
		<div class="row cl">
			<label class="form-label col-xs-4 col-sm-3"><span class="c-red">*</span>分页数：</label>
			<div class="formControls col-xs-8 col-sm-9">
				<input type="text" class="input-text"  placeholder="分页数" name="formMap.PAGE_SIZE" id="PAGE_SIZE" value="${formMap.PAGE_SIZE}" >
			</div>
		</div>
		
		<div class="row cl">
			<label class="form-label col-xs-4 col-sm-3">备注：</label>
			<div class="formControls col-xs-8 col-sm-9">
				<textarea name="beizhu" cols="" rows="" class="textarea"  placeholder="说点什么...最少输入10个字符" onKeyUp="textarealength(this,100)"></textarea>
				<p class="textarea-numberbar"><em class="textarea-length">0</em>/100</p>
			</div>
		</div>
		<div class="row cl">
			<div class="col-xs-8 col-sm-9 col-xs-offset-4 col-sm-offset-3">
				<input class="btn btn-primary radius" type="submit" value="&nbsp;&nbsp;提交&nbsp;&nbsp;">
			</div>
		</div>
	</form>
</article>

<!--_footer 作为公共模版分离出去--> 
<script type="text/javascript" src="${csspath}/lib/jquery/1.9.1/jquery.min.js"></script> 
<script type="text/javascript" src="${csspath}/lib/layer/2.1/layer.js"></script> 
<script type="text/javascript" src="${csspath}/lib/icheck/jquery.icheck.min.js"></script> 
<script type="text/javascript" src="${csspath}/lib/jquery.validation/1.14.0/jquery.validate.min.js"></script> 
<script type="text/javascript" src="${csspath}/lib/jquery.validation/1.14.0/validate-methods.js"></script> 
<script type="text/javascript" src="${csspath}/lib/jquery.validation/1.14.0/messages_zh.min.js"></script> 
<script type="text/javascript" src="${csspath}/static/h-ui/js/H-ui.js"></script> 
<script type="text/javascript" src="${csspath}/static/h-ui.admin/js/H-ui.admin.js"></script> 
<script type="text/javascript" src="${csspath}/lib/My97DatePicker/WdatePicker.js"></script> 
<!--/_footer /作为公共模版分离出去--> 

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
			'formMap.LOGIN_ID':{
				required:true,
				minlength:2,
				maxlength:16
			},
			'formMap.NAME':{
				required:true
			},
			'formMap.PSW':{
				required:true
			},
			'formMap.START_DT':{
				required:true
			},
			'formMap.END_DT':{
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
						if(data["MSG"]=='数据新增成功!'){
							//$(form).ajaxSubmit();
							var index = parent.layer.getFrameIndex(window.name);
							parent.$(".btn-refresh").click();
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