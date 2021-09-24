<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<div class="logo">
	<ssi:p value="SYS_NAME" />
</div>
<div class="div0">
	<div class="bg">
		今天是：<%=(new SimpleDateFormat("yyyy年MM月dd日")).format(new Date())%>&nbsp;&nbsp;欢迎您：${sessionScope._SESSION_USER_.name}&nbsp;&nbsp;<a onclick="changePassword();">密码修改</a>&nbsp;&nbsp;<a onclick="relogon()" >退出登录  </a>&nbsp;&nbsp;
	</div>
</div>
<script type="text/javascript">
var bRelogon  = false;
function relogon(){
	bRelogon = true;
	if (confirm("注意：离开本页面，你将注销或退出本系统！")){
		window.top.location.href="${ctx}/sys/Login/logout.do";
	}else{
		bRelogon = false;
	}
}

function changePassword(){
	var url='${ctx}/sys/Xgmm/toEdit.do';
	var props2 = "status=yes,toolbar=no,menubar=no,location=no,resizable=no,scrollbars=yes";
	var tmp = url + "?formMap.USER_ID=${sessionScope._SESSION_USER_.userId}";
	var newwin = window.open(tmp,"xgmm",props2+","+getSizeAndLocation());
}

function getSizeAndLocation(){
    var sizeAndLocation = "";
    var h = 220;
    var w = 350;
    var lft = 0;
    var tp = 0;
    lft = (screen.width - w)/2;
    tp = (screen.height -h)/2;
    sizeAndLocation="width="+w+
            ",height="+h+
            ",left="+lft+
            ",top="+tp;
    return sizeAndLocation;
}
</script>