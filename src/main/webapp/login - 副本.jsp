<%@ page contentType="text/html;charset=UTF-8"%>
<%@page import="com.ssi.sys.model.SysSessionUser"%>
<%@ include file="/commons/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<TITLE><ssi:p value="SYS_NAME" /></TITLE>
<script type="text/javascript" src="${csspath}/js/jquery-1.7.2.min.js"></script>
<style type="text/css">
<!--
body,td,th {
	font-family: Verdana, Arial, Helvetica, sans-serif, 宋体, 微软雅黑;
	font-size: 12px;
	color: #000000;
}
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
	background-repeat: repeat-x;
	background-color: #0944A2;
}
a {cursor: pointer;}
.STYLE1 {
	color: #FFFFFF
}
.logo {
	font-size: 33px;
	font-family: "微软雅黑";
	color: #FFF;
	font-weight: bold;
	text-shadow: 1px 1px 2px #666;
}
.STYLE5 {
	font-size: 14px;
	font-weight: bold;
	color: #FFFFFF;
}
-->
</style>
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
function sub() {
if (checkForm()) {
	$("#loginForm").submit();
	}
  }
</script>
</head>


<body>
	<FORM method=post name="loginForm" id="loginForm" 
		action="${ctx}/sys/Login/login.do">
		<div align="center"
			style="background-image:url(${csspath}/skin/login/images//login_02.jpg); background-repeat:repeat-x">
			<table width="999" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td height="135" align="left"
						background="${csspath}/skin/login/images/login_04.jpg" class="logo"><ssi:p
							value="SYS_NAME" /></td>
				</tr>
				<tr>
					<td height="462" align="center" valign="top"
						background="${csspath}/skin/login/images/login_06.jpg"
						style="background-repeat: no-repeat"><table width="999"
							border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td height="89" colspan="3">&nbsp;</td>
							</tr>
							<tr>
								<td width="574" height="38" align="right"><img
									align="absmiddle" src="${csspath}/skin/login/images/user.gif"
									width="26" height="35" /><span class="STYLE5"> 用 户</span>&nbsp;&nbsp;&nbsp;</td>
								<td align="left"><input style="width: 160px; height: 18px;"
									type="text" onfocus=javascript:this.select(); tabIndex=1
									onkeyup="if(event.keyCode==13){sub();}"
									value="admin" name="formMap.LOGIN_ID"  id="LOGIN_ID"/></td>
								<td width="244" align="left" valign="middle"><a
									href="javascript:sub();"><img
										src="${csspath}/skin/login/images/login.gif" width="94"
										height="31" border="0" /></a></td>
							</tr>
							<tr>
								<td height="38" align="right"><img align="absmiddle"
									src="${csspath}/skin/login/images/pw.gif" width="23" height="38" /><span
									class="STYLE5"> 密 码</span>&nbsp;&nbsp;&nbsp;</td>
								<td align="left"><input style="width: 160px; height: 18px;"
									id="PSW" onfocus=javascript:this.select(); tabIndex=2
									onkeyup="if(event.keyCode==13){sub();}"
									name="formMap.PSW" value="123456" size=14 type=password /></td>
								<td align="left" valign="middle"><a
									href="javascript:loginForm.reset()"><img
										src="${csspath}/skin/login/images/reset.gif" width="94"
										height="31" border="0" /></a></td>
							</tr>
							<tr>
								<td height="46">&nbsp;</td>
								<td align="left">&nbsp;</td>
								<td align="left" class="STYLE5">
									<%
										String ip = request.getLocalAddr();
										if ("192.168.2.96".equals(ip)) {
											out.print("正式系统");
										} else if ("192.168.2.243".equals(ip)) {
											out.print("测试系统");
										} else {
											out.print("开发系统");
										}
									%>
								</td>
							
							</tr>
						</table></td>
				</tr>
			</table>
		</div>
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td height="30" align="center" bgcolor="#0a44a2"><span
					class="STYLE1"></span></td>
			</tr>
		</table>
	</FORM>
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


