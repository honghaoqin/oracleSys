<%@ page contentType="text/html;charset=UTF-8"%>
<%@page import="com.ssi.sys.model.SysSessionUser"%>

<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
<meta http-equiv="Cache-Control" content="no-store"/>
<meta http-equiv="Pragma" content="no-cache"/>
<meta http-equiv="Expires" content="0"/>
<link type="text/css" href="${csspath}/css/jquery.qtip.min.css" rel="stylesheet">
<link type="text/css" href="${csspath}/css/jquery.autocomplete.css" rel="stylesheet">
<link type="text/css" href="${csspath}/css/skin/qq/ymPrompt.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="${csspath}/css/jquery.multiselect.css" />
<link rel="stylesheet" type="text/css" href="${csspath}/css/jquery.multiselect.filter.css" />
<link rel="stylesheet" type="text/css" href="${csspath}/css/jquery-ui.css" />
<link rel="stylesheet" type="text/css" href="${csspath}/css/sorttable.css" />	
<script type="text/javascript" src="${csspath}/js/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="${csspath}/js/jquery-ui.js"></script>
<script type="text/javascript" src="${csspath}/js/jquery.multiselect.min.js"></script>
<script type="text/javascript" src="${csspath}/js/jquery.multiselect.filter.min.js"></script>
<script type="text/javascript" src="${csspath}/js/jquery.qtip.min.js"></script>
<script type="text/javascript" src="${csspath}/js/jquery.autocomplete.js"></script>
<script type="text/javascript" src="${csspath}/js/jquery.jqautocomplete.js"></script>
<script type="text/javascript" src="${csspath}/js/validator.js"></script>
<script type="text/javascript" src="${csspath}/js/base.js"></script>
<script type="text/javascript" src="${csspath}/js/qjprompt.js"></script>
<script type="text/javascript" src="${csspath}/js/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="${csspath}/js/sorttable.js"></script>

<link href="${csspath}/skin/style/main.css" rel="stylesheet" type="text/css" />
<link href="${csspath}/skin/blue/blueOther.css" rel="stylesheet" type="text/css" />
<script language="javascript" type="text/javascript" src="${csspath}/skin/script/fun.js"></script>


<script type="text/javascript">
var application_path = query_webpath = "${ctx}";
<%
SysSessionUser sessionUser = (SysSessionUser) request.getSession().getAttribute(SysSessionUser.SESSION_KEY);
if(sessionUser == null){
%>
top.location="${ctx}/sys/Login/toLogin.do";
<%
return;
}
%>
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
function openwindow(url,windowwidth,windowheight){
	var screenwidth = screen.width;// or availWidth 
	var screenheight = screen.height;// or availHeight
	var left = (screenwidth-windowwidth)/2; 
	var top = (screenheight-windowheight)/2;
	window.open(url,'newwindow','top='+top+',left='+left+',height='+windowheight+',width='+windowwidth+',status=yes,toolbar=no,resizable=yes,menubar=no,location=no,scrollbars=yes');
}
/**
 * 医院接口
 *FATHER 医院的id对象值
 *FATHER_NAME医院名称的id对象值
 *radio 不为空(或不为空字符)时单选 为空时多选
 */
function selectHospital(FATHER,FATHER_NAME,radio){
	var ids = $("#"+FATHER).val();
	var url = "${ctx}/base/Hospital/select.do?formMap.ids="+ids+"&formMap.showName="+FATHER_NAME+"&formMap.showId="+FATHER+"&formMap.radio="+radio;
	openwindow(url,1200,500);
	return false;
}
/**
 * 医调委接口
 *FATHER 医院的id对象值
 *FATHER_NAME医院名称的id对象值
 *radio 不为空(或不为空字符)时单选 为空时多选
 */
function selectCommittee(FATHER,FATHER_NAME,radio){
	var ids = $("#"+FATHER).val();
	var url = "${ctx}/base/Committee/select.do?formMap.ids="+ids+"&formMap.showName="+FATHER_NAME+"&formMap.showId="+FATHER+"&formMap.radio="+radio;
	openwindow(url,1200,500);
	return false;
}
</script>