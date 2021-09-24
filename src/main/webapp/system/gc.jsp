<%@ page contentType="text/html;charset=UTF-8"%>
<%@page import="java.sql.Timestamp"%>
<%@ include file="/commons/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=7">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title><ssi:p value="SYS_NAME" /></title>
<%@ include file="/commons/head.jsp"%>
<script type="text/javascript">
	window.onload=function(){
		window.setTimeout("location='gc.jsp'",1800000);
	}
	</script>
</head>
<body>
	<div class="pageIframe">
		<div class="pageNow">您现在的位置是：内存监控</div>
		<div class="h10"></div>
		<div class="listTitle">
			<h2 class="fl">内存监控</h2>
			<div class="fr"></div>
		</div>

		<div class="addForm">
			<table class="addTable" width="100%" border="0" cellspacing="0"
				cellpadding="5">
				<tr>
					<td align="right" width="150px">内存处理时间：</td>
					<td align="left"><%=(new Timestamp(System.currentTimeMillis())).toString()%>
					</td>
				</tr>
				<tr>
					<td align="right" >正在回收垃圾</td>
					<td align="left"><%System.gc();%>
					</td>
				</tr>
					<tr>
					<td align="right" >回收垃圾完成</td>
					<td align="left">
					</td>
				</tr>
				<%
				Runtime lRuntime = Runtime.getRuntime(); 
				long totalMemory = lRuntime.totalMemory();
				long freeMemory = lRuntime.freeMemory();
				long maxMemory = lRuntime.maxMemory();
				%>
				
					<tr>
					<td align="right" >Jdk使用情况统计：</td>
					<td align="left">
					</td>
				</tr>
					<tr>
					<td align="right" >Used Memory：</td>
					<td align="left">
					<%=(totalMemory-freeMemory)/(1024*1024)%>M (已使用的内存大小)
					</td>
				</tr>
					<tr>
					<td align="right" >Free Memory：</td>
					<td align="left">
					<%=freeMemory/(1024*1024)%>M (空闲的内存大小)
					</td>
				</tr>
				<tr>
					<td align="right" >Total Memory：</td>
					<td align="left">
					<%=totalMemory/(1024*1024)%>M (-Xms已占用的内存大小=已使用的内存大小+空闲的内存大小)
					</td>
				</tr>
				<tr>
					<td align="right" >Max   Memory: </td>
					<td align="left">
					<%=maxMemory/(1024*1024)%>M (-Xmx能使用操作系统的最大的内存)
					</td>
				</tr>
				<tr>
					<td align="right" >Available Processors : </td>
					<td align="left">
					<%=lRuntime.availableProcessors()%>
					</td>
				</tr>
			</table>
		</div>
	</div>
	<%
	System.out.println("************************************************************************");  
	System.out.println("*** Jdk使用情况统计 ***<br/>");  
	System.out.println("Used Memory: "+(totalMemory-freeMemory)/(1024*1024)+" M (已使用的内存大小)<br/>");  
	System.out.println("Free Memory: "+freeMemory/(1024*1024)+" M (空闲的内存大小)<br/>");  
	System.out.println("Total Memory: "+totalMemory/(1024*1024)+" M (-Xms已占用的内存大小=已使用的内存大小+空闲的内存大小)<br/>");  
	System.out.println("Max   Memory: "+maxMemory/(1024*1024)+" M (-Xmx能使用操作系统的最大的内存)<br/>");
	System.out.println("************************************************************************");  
	%>

</body>
</html>