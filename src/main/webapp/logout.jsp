<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<script language="JavaScript" type="text/javascript" src="${csspath}/js/jquery-1.7.2.min.js"></script>
</head>
<body>
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
<script>
var cmsurl='<%=SystemConfig.getProperty("hpicms_path")%>';
$.post(cmsurl+"/logout.jspx", function(data) {
	var  hpiurl="<%=SystemConfig.getProperty("hpi_path")%>/sys/CasLogin/logout.do";
	$.post(hpiurl, function(data) {
		window.top.location.href = cmsurl;	
	});	
});		
</script>
</body>
</html>


