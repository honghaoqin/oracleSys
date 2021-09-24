<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/struts-tags" prefix="s" %>
<center>
<div style="height: 10px;"></div>
<DIV class=list_table_pageSplitInfo>
	总共有&nbsp;${page.pages}&nbsp;页&nbsp;${page.totalCount} 条记录&nbsp;
	每页显示<INPUT
		class="numberTextInput"
		dataType="Integer" msg="每页显示必须是数字,不能大于总记录数${page.totalCount},确定请按回车。"
		onkeydown="javascript:if (this.value!='' && event.keyCode==13) {gotoPage();}" onkeyup="value=value.replace(/[^0-9]/g,'');checkPageSize(this)"
		size=3 value="${page.pageSize}" length="3">条记录&nbsp;&nbsp;&nbsp;
		
		<c:choose>
		      <c:when test='${page.pageNumber <= 1}'>
		        <SPAN style="COLOR: #cccccc">首页</SPAN>&nbsp;&nbsp;
				<SPAN style="COLOR: #cccccc">上一页</SPAN>&nbsp;&nbsp;
		      </c:when>
		      <c:otherwise>
				<A href="#" onclick="gotoPage(1);">首页</A>&nbsp;&nbsp;&nbsp;
				<A href="#" onclick="gotoPage(${page.pageNumber-1});">上一页</A>&nbsp;&nbsp;
		      </c:otherwise>
		</c:choose>
		
		<c:choose>
		      <c:when test='${page.pageNumber >= page.pages}'>
		        <SPAN style="COLOR: #cccccc">下一页</SPAN>&nbsp;&nbsp;
				<SPAN style="COLOR: #cccccc">尾页</SPAN>&nbsp;&nbsp;
		      </c:when>
		      <c:otherwise>
				<A href="#" onclick="gotoPage(${page.pageNumber+1});">下一页</A>&nbsp;&nbsp;&nbsp;
				<A href="#" onclick="gotoPage(${page.pages});">尾页</A>&nbsp;&nbsp;
		      </c:otherwise>
		</c:choose>
		
		
		第<INPUT
		class="numberTextInput"
		dataType="Integer" msg="页码必须是数字,不能大于总页数${page.pages},确定请按回车。"
		onkeydown="javascript:if (this.value!='' && event.keyCode==13) {gotoPage();}"  onkeyup="value=value.replace(/[^0-9]/g,'');checkPageNumber(this)"
		size=4 value="${page.pageNumber}" length="5">页&nbsp;
		
		
		<IMG style="CURSOR: hand" onclick="gotoPage()" src="${csspath}/images/go.gif">&nbsp;&nbsp;
		<IMG style="CURSOR: hand" onclick="exportPageExcel();" src="${csspath}/images/excel.gif">
</DIV>
</center>