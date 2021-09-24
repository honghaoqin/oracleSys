<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/commons/taglibs.jsp"  %>
<HTML>
<HEAD>
<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
<meta http-equiv="Cache-Control" content="no-store"/>
<meta http-equiv="Pragma" content="no-cache"/>
<meta http-equiv="Expires" content="0"/>

<link type="text/css" href="<c:url value="/css/base.css"/>" rel="stylesheet">
<script>
function relogon(){
	var url="${ctx}/sys/Login/logout.do";
	window.top.location.href=url;
}
var url="${ctx}/sys/Login/toLogin.do";
window.top.location.href=url;
</script>
</head>
<body>
<table width="70%"  border="0" align="center">
  <tr height="80">
	<td align="center">
		与服务器的连接已失效，请重新登录。<br>		
	</td>
  </tr>
  <tr height="80"> 
	<td align="center"><a href="#" onclick="relogon();">重新登陆</a></td>
  </tr>
</table>
</body>
</html>





