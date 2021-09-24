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
<script type="text/javascript" src="${ctx}/js/treeview/treeview.js"></script>
<link type="text/css" rel="stylesheet"  href="${ctx}/js/treeview/treeview.css"></link>
<title>权限分配</title>
<meta name="keywords" content="">
<meta name="description" content="">
</head>
<body>
<article class="page-container">
	<form action="${ctx}/sys/Role/assignAuth.do" method="post" class="form form-horizontal" id="callForm" name="callForm">
	 <div>
		  <!--begin: 祥表内容-->
							<input type="hidden" name="formMap.ROLE_ID" value="${formMap.ROLE_ID}">
							<div style="height: 500px; overflow: auto"
								class="treeview">
								<ul>
									<li class="open lastopen">
										<div class="hit open-hit lastopen-hit" onclick="$att(this);"></DIV>
										<span class="folder"> <input onclick="$ctt(this)"
											type="checkbox"> <A onclick='$atc(this)' href="#">权限</A>
									</span> <ssi:tree value="resultList" idKey="AUTH_ID"
											parentKey="PARENT_ID" valueKey="AUTH_ID" textKey="NAME"
											checkedKey="CHECKED" type="2" body="true" />
									</li>
								</ul>
							</div> <!--begin: 祥表内容-->	
			
			
			
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
	function $ctt(c) {
		var isc = $(c).is(':checked');
		chk(c.parentNode.parentNode, isc);
	}
	function chk(o, isc) {
		$(o).children("ul").find("input[type='checkbox']").attr("checked", isc);
		if (isc) {
			$(o).parent().parentsUntil(".treeview", "li").children("span")
					.children("input[type='checkbox']").attr("checked", isc);
		}
	}
	AjaxTreeView.config.onclick = function(o, a) {
		var isc = $(a).prev().is(':checked');
		isc = !isc;
		$(a).prev().attr("checked", isc);
		chk(o, isc);
	}

	
$(function(){
	$('.skin-minimal input').iCheck({
		checkboxClass: 'icheckbox-blue',
		radioClass: 'iradio-blue',
		increaseArea: '20%'
	});
	
	$("#callForm").validate({
		rules:{
			'formMap.ROLE_ID':{
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
							//$(form).ajaxSubmit();
							var index = parent.layer.getFrameIndex(window.name);
							parent.$('#btn-refresh').click();
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