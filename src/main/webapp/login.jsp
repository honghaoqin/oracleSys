<%@ page contentType="text/html;charset=UTF-8"%>
<%@page import="com.ssi.sys.model.SysSessionUser"%>
<%@ include file="/commons/taglibs.jsp"%>
<c:set var="csspath" value='/hui' />
<!DOCTYPE HTML>
<html>
<head>
<meta charset="utf-8">
<meta name="renderer" content="webkit|ie-comp|ie-stand">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<meta http-equiv="Cache-Control" content="no-siteapp" />
<!--[if lt IE 9]>
<script type="text/javascript" src="${csspath}/lib/html5.js"></script>
<script type="text/javascript" src="${csspath}/lib/respond.min.js"></script>
<script type="text/javascript" src="${csspath}/lib/PIE_IE678.js"></script>
<![endif]-->
<link href="${csspath}/static/h-ui/css/H-ui.min.css" rel="stylesheet" type="text/css" />
<link href="${csspath}/static/h-ui.admin/css/H-ui.login.css" rel="stylesheet" type="text/css" />
<link href="${csspath}/static/h-ui.admin/css/style.css" rel="stylesheet" type="text/css" />
<link href="${csspath}/lib/Hui-iconfont/1.0.7/iconfont.css" rel="stylesheet" type="text/css" />
<!--[if IE 6]>
<script type="text/javascript" src="${csspath}/static/h-ui/js/DD_belatedPNG_0.0.8a-min.js" ></script>
<script>DD_belatedPNG.fix('*');</script>
<![endif]-->
<title>后台登录 </title>
<meta name="keywords" content="">
<meta name="description" content="">
</head>
<script>
function checkForm(){
	if($("#LOGIN_ID").val().length<=0){
		alert("请输入用户名!");
		return false;
	}
	if($("#PSW").val().length<=0){
		alert("请输入密码!");
		return false;
	}
	return true;
}
function setFocus(){
	$("#LOGIN_ID").focus();
}
function gotoSubmit() {
if (checkForm()) {
	$("#callForm").submit();
	}
  }
</script>
<body>
<input type="hidden" id="TenantId" name="TenantId" value="" />
<div class="header"></div>
<div class="loginWraper">
  <div id="loginform" class="loginBox">
    <form  name="callForm" id="callForm"   class="form form-horizontal" action="${ctx}/sys/Login/login.do" method="post">
      <div class="row cl">
        <label class="form-label col-xs-3"><i class="Hui-iconfont">&#xe60d;</i></label>
        <div class="formControls col-xs-8">
          <input value="admin" name="formMap.LOGIN_ID"  id="LOGIN_ID"  type="text" placeholder="账户" class="input-text size-L">
        </div>
      </div>
      <div class="row cl">
        <label class="form-label col-xs-3"><i class="Hui-iconfont">&#xe60e;</i></label>
        <div class="formControls col-xs-8">
          <input name="formMap.PSW" id="PSW" value="123456"   type="password" placeholder="密码" class="input-text size-L">
        </div>
      </div>
      <div class="row cl">
        <div class="formControls col-xs-8 col-xs-offset-3">
          <input class="input-text size-L" type="text" placeholder="验证码" onblur="if(this.value==''){this.value='验证码:'}" onclick="if(this.value=='验证码:'){this.value='';}" value="验证码:" style="width:150px;">
          <img src="images/VerifyCode.aspx.png"> <a id="kanbuq" href="javascript:;">看不清，换一张</a> </div>
      </div>
      <div class="row cl">
        <div class="formControls col-xs-8 col-xs-offset-3">
          <label for="online">
            <input type="checkbox" name="formMap.ONLINE" id="ONLINE" value="">使我保持登录状态</label>
        </div>
      </div>
      <div class="row cl">
        <div class="formControls col-xs-8 col-xs-offset-3">
          <input onclick="gotoSubmit()" type="button" class="btn btn-success radius size-L" value="&nbsp;登&nbsp;&nbsp;&nbsp;&nbsp;录&nbsp;">&nbsp;&nbsp;&nbsp;&nbsp;
          <input name="" type="reset" class="btn btn-default radius size-L" value="&nbsp;取&nbsp;&nbsp;&nbsp;&nbsp;消&nbsp;">
        </div>
      </div>
    </form>
  </div>
</div>
<div class="footer">Copyright 广州立白企业集团有限公司</div>
<script type="text/javascript" src="${csspath}/lib/jquery/1.9.1/jquery.min.js"></script> 
<script type="text/javascript" src="${csspath}/static/h-ui/js/H-ui.js"></script> 
<script>
<%
	String actionErrorMessage = (String)request.getAttribute("ActionErrorMessage");
	String actionMessage = (String)request.getAttribute("ActionMessage");
	if(actionErrorMessage!=null && actionErrorMessage.length()>0){
		out.print("alert('错误："+actionErrorMessage+"');");
	}
	if(actionMessage!=null && actionMessage.length()>0){
		out.print("alert('"+actionMessage+"');");
	}
%>
</script>	
</body>
</html>

