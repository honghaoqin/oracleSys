<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<%@ page import="java.util.Map"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="java.util.Date"%>
<%@page import="java.io.File"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=7">
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" /><%@ include
	file="/commons/head.jsp"%>
<%!
String getFormatSize(double size) {
	double kiloByte = size/1024;
	if(kiloByte < 1) {
		return size + " Byte(s)";
	}
	double megaByte = kiloByte/1024;
	if(megaByte < 1) {
		BigDecimal result1 = new BigDecimal(Double.toString(kiloByte));
		return result1.setScale(2, BigDecimal.ROUND_HALF_UP).toPlainString() + " KB";
	}
	
	double gigaByte = megaByte/1024;
	if(gigaByte < 1) {
		BigDecimal result2  = new BigDecimal(Double.toString(megaByte));
		return result2.setScale(2, BigDecimal.ROUND_HALF_UP).toPlainString() + " MB";
	}
	
	double teraBytes = gigaByte/1024;
	if(teraBytes < 1) {
		BigDecimal result3 = new BigDecimal(Double.toString(gigaByte));
		return result3.setScale(2, BigDecimal.ROUND_HALF_UP).toPlainString() + " GB";
	}
	BigDecimal result4 = new BigDecimal(teraBytes);
	return result4.setScale(2, BigDecimal.ROUND_HALF_UP).toPlainString() + " TB";
}
%>
<script type="text/javascript">
	function tishi(va){
		va.value="数据备份中，请耐心等待10秒左右";
		va.disabled=true;
		$("#callForm").attr("action","${ctx}/sys/Backup/beiFen.do").submit();
	}
	$(function(){
		$("#MSG_CHECKBOX_1").change(function() {
			if (this.checked) {
				$("#MSG_LIST").hide();
			} else {
				$("#MSG_LIST").show();
			}
		});
		$("#MSG_CHECKBOX_2").change(function() {
			if (this.checked) {
				$("#MSG_LIST").show();	
			} else {
				$("#MSG_LIST").hide();
			}
		});
		
	});
	function  suanxin(){
		$("#callForm").attr("action","${ctx}/sys/Backup/list.do").submit();
	}
	
	
</script>

</head>
<body>
	<div class="pageIframe">

		<FORM name="callForm" id="callForm" action="${ctx}/sys/Dept/list.do"
			method=post>
			<div class="pageNow">您现在的位置是：数据库备份</div>

			<div class="tool">
				<ul>

					<li class="li_other"><input type="button" class="btn1"
						onclick="suanxin();" value="刷新" /> <INPUT name="button"
						value="备份数据" type="button" onclick="tishi(this);"></li>

				</ul>
			</div>

			<c:if test="${formMap.ERROR==true }">
				<h2 class="formTitle">
					错误日志：<input type="checkbox" id="MSG_CHECKBOX_1">
				</h2>
				<table class="addTable" width="100%" border="0" cellspacing="0"
					cellpadding="5" id="MSG_LIST">
					<tr>
						<td align="left" style="color: red;">${formMap.MSG}</td>
					</tr>
				</table>
			</c:if>
			<c:if test="${formMap.ERROR==false }">
				<h2 class="formTitle">
					备份日志：<input type="checkbox" id="MSG_CHECKBOX_2">
				</h2>
				<table class="addTable" width="100%" border="0" cellspacing="0"
					cellpadding="5" id="MSG_LIST" style="display:none">
					<tr>
						<td align="left" style="color: blue;">${formMap.MSG}</td>



					</tr>
				</table>
			</c:if>

			<div class="pageList">
				<table class="tableCSS" cellpadding="0" cellspacing="1" border="0">
					<tr>

						<th>序号</th>
						<th>文件名</th>
						<th>大小</th>
						<th>备份时间</th>
						<th>下载</th>

					</tr>
					<c:forEach items="${zips}" var="file" varStatus="st">
						<% File f = (File)pageContext.getAttribute("file"); 
				   Date d = new Date(f.lastModified());
				   pageContext.setAttribute("createDate", d);
				   pageContext.setAttribute("fileSize", getFormatSize(f.length()));
				%>
						<tr>
							<td>${st.count}</td>
							<td>${file.name}</td>
							<td>${fileSize}</td>
							<td><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss"
									value="${createDate}" /></td>
							<td><a
								href="${ctx}/download/${fn:replace(file.absolutePath,'\\','/')}">下载</a>
							</td>
						</tr>
					</c:forEach>

				</table>
			</div>
		</FORM>
	</div>
</body>
</html>