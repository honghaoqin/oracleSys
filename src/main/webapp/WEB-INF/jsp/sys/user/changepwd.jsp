<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
<%@ include file="/commons/taglibs.jsp"  %>
<%@ include file="/commons/head.jsp"  %>
<script type="text/javascript">
function   Trim(m){   
	  while((m.length>0)&&(m.charAt(0)==' '))   
	  m   =   m.substring(1, m.length);   
	  while((m.length>0)&&(m.charAt(m.length-1)==' '))   
	  m = m.substring(0, m.length-1);   
	  return m;   
	  }
function checkPassword(){
	var newPassword = Trim(document.getElementById("newPassword").value);
	var newPasswordAgain = Trim(document.getElementById("newPasswordAgain").value);

	if(newPassword!=newPasswordAgain){
	
		alert("两次密码输入不一致,请重新输入!");
		document.getElementById("newPassword").value="";
		document.getElementById("newPasswordAgain").value="";
	return false;	
	}else{
		return true;
	}
}
function savedata(){
	 var callForm = document.getElementById("callForm");
  if(checkPassword()){
		if(Validator.Validate(callForm)){
			callForm.submit();
		}
	}
}


</script>
</head>
<body>
<form id="callForm" method="post" action="${ctx}/sys/User/changepwd.do" >
<div class="addForm">
		<table class="addTable" width="100%" border="0" cellspacing="0" cellpadding="5">
		<tr align="left"><td>旧&nbsp;密&nbsp;码     <input id="oldPassword" name="formMap.oldPassword" type="password" dataType="Require" msg="原始密码不能为空" maxlength="12"/></td></tr>
		<tr><td>新&nbsp;密&nbsp;码     <input id="newPassword" name="formMap.newPassword" type="password" dataType="Require" msg="新密码不能为空" maxlength="12"/></td></tr>
		<tr><td>确认密码     <input id="newPasswordAgain"  type="password"  dataType="Require" msg="确认密码不能为空" maxlength="12"/></td></tr>
		
		</table>
		
	</div>	
	<div class="addBtnDiv"><input type="button" value="确定" onclick="savedata()" class="btn1 btn2"  /></div>
	
	</form>
</body>
</html>