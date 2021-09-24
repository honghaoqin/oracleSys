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
<title>添加数据字典</title>
</head>
<body>
	<article class="page-container">
		<form action="${ctx}/sys/Dict/edit.do" method="post"
			class="form form-horizontal" id="callForm" name="callForm">
			<input type="hidden" name="formMap.DICT_ID"
					value="${resultMap.DICT_ID}" />
			<div class="row cl">
				<label class="form-label col-xs-4 col-sm-3"><span
					class="c-red">*</span>类型：</label>
				<div class="formControls col-xs-8 col-sm-9">
					<select class="input-text"
							name="formMap.TYPE" id="TYPE">
								<option></option>
								<ssi:select value="${resultMap.TYPE}" type="dicttype" />
						</select>
				</div>
			</div>
			<div class="row cl">
				<label class="form-label col-xs-4 col-sm-3"><span
					class="c-red">*</span>值：</label>
				<div class="formControls col-xs-8 col-sm-9">
					<input type="text" class="input-text" placeholder="值"
						name="formMap.VALUE" id="VALUE" value="${resultMap.VALUE}">
				</div>
			</div>
			

			<div class="row cl">
				<label class="form-label col-xs-4 col-sm-3"><span
					class="c-red">*</span>文本：</label>
				<div class="formControls col-xs-8 col-sm-9">
					<input type="text" class="input-text" placeholder="文本"
						name="formMap.TEXT" id="TEXT" value="${resultMap.TEXT}">
				</div>
			</div>
			
			<div class="row cl">
				<label class="form-label col-xs-4 col-sm-3"><span
					class="c-red">*</span>排序：</label>
				<div class="formControls col-xs-8 col-sm-9">
					<input type="text" class="input-text" placeholder="排序"
						name="formMap.SORT" id="SORT"
						value="${resultMap.SORT}">
				</div>
			</div>
			<div class="row cl">
				<label class="form-label col-xs-4 col-sm-3">缓存：</label>
				<div class="formControls col-xs-8 col-sm-9">
					<input type="checkbox" value="1"
							name="formMap.CACHE" id="CACHE" class="commonTextInput"
							checked="checked" />
				</div>
			</div>

			<div class="row cl">
				<label class="form-label col-xs-4 col-sm-3">描述：</label>
				<div class="formControls col-xs-8 col-sm-9">
					<textarea name="formMap.DES" id="DES" cols="" rows="" class="textarea"
						placeholder="说点什么...最少输入10个字符" onKeyUp="textarealength(this,100)">${resultMap.DES}</textarea>
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
									if (data["MSG"] == '数据修改成功!') {
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