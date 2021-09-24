<%@ page contentType="text/html;charset=UTF-8" isErrorPage="true"%>
<%@page import="java.io.StringWriter"%>
<%@page import="java.io.PrintWriter"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/struts-tags" prefix="s" %>
<%@ taglib uri="/ssi-tags" prefix="ssi" %>

<c:if test = "${pageContext.request.contextPath == '/'}">
	<c:set var="ctx" value=""/>
</c:if>
<c:if test = "${pageContext.request.contextPath != '/'}">
	<c:set var="ctx" value="${pageContext.request.contextPath}"/>
</c:if>


<HTML>
<HEAD>
<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
<meta http-equiv="Cache-Control" content="no-store"/>
<meta http-equiv="Pragma" content="no-cache"/>
<meta http-equiv="Expires" content="0"/>

<link type="text/css" href="${ctx}/css/base.css" rel="stylesheet">
<script type="text/javascript" src="${ctx}/js/jquery-1.7.2.min.js"></script>

<link type="text/css" rel="stylesheet" href="${ctx}/js/dp.SyntaxHighlighter/Styles/SyntaxHighlighter.css"></link>
<script type="text/javascript"  src="${ctx}/js/dp.SyntaxHighlighter/Scripts/shCore.js"></script>
<script type="text/javascript" src="${ctx}/js/dp.SyntaxHighlighter/Scripts/shBrushJava.js"></script>

<script type="text/javascript">
	$(document).ready(function(){
		dp.SyntaxHighlighter.ClipboardSwf = '${ctx}/js/dp.SyntaxHighlighter/Scripts/clipboard.swf';
		dp.SyntaxHighlighter.HighlightAll('code1');
		dp.SyntaxHighlighter.HighlightAll('code2');
		
		$('#code2div').hide();
		$("#detalLink").toggle(
			function(){
				$('#code2div').show();
			},
			function(){
				$('#code2div').hide();
			}
		);
	});
</script>

<title>Insert title here</title>
</head>
<body>
	<br>
	<h3 style="color: red;">
	对不起,发生系统内部错误,不能处理你的请求:<br>
	</h3>
	<div align="left">
	<pre name="code1" class="java" >
	<s:property value="exception.message"/>
	<%try{out.println(exception.getMessage());}catch(Exception e){} %>
	</pre>
	</div>
	<div align="left">
	<a href="#" id="detalLink">点击查看详细信息：</a>
	<div id="code2div">
	<pre name="code2" class="java">
		<s:property value="exceptionStack"/>
		<%
		try{
			StringWriter swriter = new StringWriter();
			PrintWriter pWriter = new PrintWriter(swriter);
			exception.printStackTrace(pWriter);
			out.println(swriter.toString());
		 }catch(Exception e){
			 
		 } %>
	</pre>
	</div>
	</div>
	
</body>
</html>