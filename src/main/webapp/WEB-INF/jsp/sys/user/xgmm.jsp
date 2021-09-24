<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<%@ page import="java.text.SimpleDateFormat,java.util.List,java.util.Map,java.util.Date"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
<meta http-equiv="Cache-Control" content="no-store" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="Expires" content="0" />
<link type="text/css" href="<c:url value="/css/base.css"/>"
	rel="stylesheet">
<script type="text/javascript"
	src="<c:url value="/js/jquery-1.7.2.min.js"/>"></script>
<script type="text/javascript"
	src="<c:url value="/js/JavaScriptLibrary.js"/>"></script>

<title>修改密码</title>
</head>
<script>
	function checkForm() {
		var obj = document.getElementById("userid");
		if (obj != null && obj.value.length == 0) {
			alert("用户名输入有误,不能为空!");
			obj.select();
			return false;
		}
		obj = document.getElementById("oldpassword");
		if (obj != null && obj.value.length < 4) {
			alert("旧密码输入有误,密码长度至少4位!");
			obj.select();
			return false;
		}
		var obj1 = document.getElementById("newpassword");
		if (obj1 != null && obj1.value.length < 4) {
			alert("新密码输入有误,密码长度至少4位!");
			obj1.select();
			return false;
		}
		var obj2 = document.getElementById("affirmpassword");
		if (obj2 != null && obj2.value.length < 4) {
			alert("新密码确认输入有误,密码长度至少4位!");
			obj2.select();
			return false;
		}
		if(obj1.value != obj2.value){
			alert("两次密码必须一致");
			return false;
		}
		return true;
	}
	window.onload=function(){
		var msg = "${msg}";
		if(msg !=""){
			alert(msg);
			window.close();
		}
	}
</script>
<body>

	<table class="tTitle" cellpadding="0" cellspacing="0">
		<tr>
			<td height="25" class="dTitle" colspan="2">重新设置用户密码</td>
		</tr>
	</table>
	<table width="100%" border="1" cellspacing="0"
		bordercolorlight="#C0C0C0" bordercolordark="#FFFFFF"
		class="edit_table">
		<form id="PasswordFormId" name="PasswordForm"  method="post"
				action="${ctx}/sys/Xgmm/login.do" onsubmit="return checkForm();">
			<tr>
  				<td style="color:red;text-align:center;font-size:9pt;" colspan="2">${errormsg}</td>
  			</tr>  
			<tr>
				<td class="edit_table_td_must_title0">用户名</td>
				<td class="edit_table_td_input"><input type="text"
					class="commonTextInputNoHTC" name="formMap.USER_ID" 
					value="${formMap.USER_ID }" id="userid"></td>
			</tr>
			<tr>
				<td class="edit_table_td_must_title0">旧密码</td>
				<td class="edit_table_td_input"><input type="password"
					class="commonTextInputNoHTC" name="formMap.PSW" id="oldpassword"></td>
			</tr>
			<tr>
				<td class="edit_table_td_must_title0">新密码</td>
				<td class="edit_table_td_input"><input type="password"
					class="commonTextInputNoHTC" name="formMap.newpas" id="newpassword"></td>
			</tr>
			<tr>
				<td class="edit_table_td_must_title0">新密码确认</td>
				<td class="edit_table_td_input"><input type="password"
					class="commonTextInputNoHTC" name="affirmpassword" id="affirmpassword"></td>
			</tr>
			<tr>
				<td class="edit_table_td_title">温馨提示</td>
				<td class="edit_table_td_input">所以项必须录入,密码长度至少4位。</td>
			</tr>
	</table>
	<table class="tTitle" cellpadding="0" cellspacing="0"
		style="margin-top: 5px;">
		<tr>
			<td align="center"><input type="submit" class="button"
				value="保存">&nbsp;&nbsp; <input
				type="reset" class="button" value="清除"></td>
		</tr>
	</table>

</body>
<input type="hidden" name="flag" value="0">
</html>
