<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<div class="page">
	共${page.totalCount}条记录
	<input class="inputPage" type="hidden" dataType="Integer"
		msg="每页显示必须是数字,不能大于总记录数${page.totalCount},确定请按回车。"
		onkeydown="javascript:if (this.value!='' && event.keyCode==13) {gotoList('${ctx}');return false;}"
		onkeyup="value=value.replace(/[^0-9]/g,'');checkPageSize(this)" size=3
		value="${page.pageSize}" length="3">
	<c:choose>
		<c:when test='${page.pageNumber <= 1}'>
			<span style="color: #cccccc">首页</span>&nbsp;&nbsp;
				<span style="color: #cccccc">上一页</span>&nbsp;&nbsp;
		      </c:when>
		<c:otherwise>
			<a href="#" onclick="gotoPage(1);">首页</a>&nbsp;&nbsp;&nbsp;
				<a href="#" onclick="gotoPage(${page.pageNumber-1});">上一页</a>&nbsp;&nbsp;
		      </c:otherwise>
	</c:choose>
	<c:choose>
		<c:when test='${page.pageNumber >= page.pages}'>
			<span style="color: #cccccc">下一页</span>&nbsp;&nbsp;
				<span style="color: #cccccc">尾页</span>&nbsp;&nbsp;
		      </c:when>
		<c:otherwise>
			<a href="#" onclick="gotoPage(${page.pageNumber+1});">下一页</a>&nbsp;&nbsp;&nbsp;
				<a href="#" onclick="gotoPage(${page.pages});">尾页</a>&nbsp;&nbsp;
		      </c:otherwise>
	</c:choose>
</div>
