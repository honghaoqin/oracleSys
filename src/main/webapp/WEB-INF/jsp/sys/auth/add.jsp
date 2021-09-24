<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<!DOCTYPE HTML>
<html>
<head>
<meta charset="utf-8">
<meta name="renderer" content="webkit|ie-comp|ie-stand">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport"
	content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<meta http-equiv="Cache-Control" content="no-siteapp" />
<LINK rel="Bookmark" href="/favicon.ico">
<LINK rel="Shortcut Icon" href="/favicon.ico" />
<%@ include file="/commons/head.jsp"%>
<title>添加权限</title>
</head>
<body>
	<article class="page-container">
		<form action="${ctx}/sys/Auth/add.do" method="post"
			class="form form-horizontal" id="callForm" name="callForm">
			<div class="row cl">
				<label class="form-label col-xs-4 col-sm-3"><span
					class="c-red">*</span>权限代码：</label>
				<div class="formControls col-xs-8 col-sm-9">
					<input type="text" class="input-text" placeholder="权限代码"
						name="formMap.AUTH_ID" id="AUTH_ID" value="${formMap.AUTH_ID}">
				</div>
			</div>
			<div class="row cl">
				<label class="form-label col-xs-4 col-sm-3"><span
					class="c-red">*</span>权限名称：</label>
				<div class="formControls col-xs-8 col-sm-9">
					<input type="text" class="input-text" placeholder="权限名称"
						name="formMap.NAME" id="NAME" value="${formMap.NAME}">
				</div>
			</div>
			<div class="row cl">
				<label class="form-label col-xs-4 col-sm-3">上级权限：</label>
				<div class="formControls col-xs-8 col-sm-9">
					<input type="hidden" id="PARENT_ID" name="formMap.PARENT_ID"
						value="${formMap.PARENT_ID}"> <input type="text"
						id="PARENT_NAME" name="formMap.PARENT_NAME"
						value="${formMap.PARENT_NAME}" valuefield="PARENT_ID"
						class="selectTextInput autocomplete input-text">
					<ssi:listbox value="auth" id="PARENT_NAME" />
				</div>
			</div>
			
			
			<div class="row cl">
				<label class="form-label col-xs-4 col-sm-3">图标：</label>
				<div class="formControls col-xs-8 col-sm-9">
					<input type="text" class="input-text" placeholder="图标"
						name="formMap.ICONS" id="ICONS" value="${formMap.ICONS}">
				</div>
			</div>

			<div class="row cl">
				<label class="form-label col-xs-4 col-sm-3"><span
					class="c-red">*</span>参数：</label>
				<div class="formControls col-xs-8 col-sm-9">
					<input type="text" class="input-text" placeholder="参数"
						name="formMap.PARAM" id="PARAM" value="${formMap.PARAM}">
				</div>
			</div>
			<div class="row cl">
				<label class="form-label col-xs-4 col-sm-3"><span
					class="c-red">*</span>菜单：</label>
				<div class="formControls col-xs-8 col-sm-9">
					<span class="select-box"> <select class="select"
						name="formMap.MENU" id="MENU" size="1">
							<option value="0" selected="selected">否</option>
							<option value="1">是</option>

					</select></span>
				</div>
			</div>
			<div class="row cl">
				<label class="form-label col-xs-4 col-sm-3">跳转：</label>
				<div class="formControls col-xs-8 col-sm-9">
					<span class="select-box"> <select class="select"
						name="formMap.TARGET" id="TARGET" size="1">
							<option value="" selected="selected">否</option>
							<option value="_blank">是</option>

					</select></span>
              </div>
			</div>

			<div class="row cl">
				<label class="form-label col-xs-4 col-sm-3">备注：</label>
				<div class="formControls col-xs-8 col-sm-9">
					<textarea name="beizhu" cols="" rows="" class="textarea"
						placeholder="说点什么...最少输入10个字符" onKeyUp="textarealength(this,100)"></textarea>
					<p class="textarea-numberbar">
						<em class="textarea-length">0</em>/100
					</p>
				</div>
			</div>
			<div class="row cl">
				<div class="col-xs-8 col-sm-9 col-xs-offset-4 col-sm-offset-3">
					<input class="btn btn-primary radius" type="submit"
						value="&nbsp;&nbsp;提交&nbsp;&nbsp;">
				</div>
			</div>
		</form>
	</article>
<%@ include file="/commons/foot.jsp"%>
<!--请在下方写此页面业务相关的脚本-->
	<script type="text/javascript">
		$(function() {
			$('.skin-minimal input').iCheck({
				checkboxClass : 'icheckbox-blue',
				radioClass : 'iradio-blue',
				increaseArea : '20%'
			});

			$("#callForm").validate(
					{
						rules : {
							'formMap.LOGIN_ID' : {
								required : true,
								minlength : 2,
								maxlength : 16
							},
							'formMap.NAME' : {
								required : true
							},
							'formMap.PSW' : {
								required : true
							},
							'formMap.START_DT' : {
								required : true
							},
							'formMap.END_DT' : {
								required : true
							}
						},
						onkeyup : false,
						focusCleanup : true,
						success : "valid",
						submitHandler : function(form) {
							$.ajax({
								url : $(form).attr("action") + "?"
										+ Math.random(),
								type : "POST", // 请求的方式:"POST" 或者 "GET"
								dataType : "JSON", // 数据返回的格式
								async : false,
								data : $(form).serialize(),
								success : function(data) {
									alert(data["MSG"]);
									if (data["MSG"] == '数据新增成功!') {
										parent.gotoList('${ctx}');
										var index = parent.layer.getFrameIndex(window.name);
										parent.layer.close(index);
									}

								},
								error : function() {
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