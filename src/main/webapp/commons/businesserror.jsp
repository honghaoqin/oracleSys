<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<HTML>
<HEAD>
<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
<meta http-equiv="Cache-Control" content="no-store" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="Expires" content="0" />

<link type="text/css" href="<c:url value="/css/base.jsp"/>"
	rel="stylesheet">
<title>业务错误</title>
</head>
<script language="javascript">
   var time=5;  
   function timedown()
   {
    time=time-1;
    if (time<0){
		 history.go(-1);
	 }
    else{
		document.getElementById("second").innerHTML = time;
	} 
   }  
   setInterval("timedown()",1000);
</script>
<body style="text-align: center">
	<br>
	<h3 style="color: blue;">
		业务错误：
		<s:property value="exception.message" />
	</h3>
	
	<span id=second lang="zh-cn">
   5
</span>
<span lang="zh-cn">秒后<a onclick="javascript:history.go(-1);" href="#">返回上一页</a></span>
</body>
</html>