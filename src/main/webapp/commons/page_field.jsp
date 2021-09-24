<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<script type="text/javascript">
function checkPageSize(ele){
	var pageTotal = ${page.totalCount};
	if(ele.value!=""){
		if(parseInt(ele.value) <=0 || parseInt(ele.value) > pageTotal){
			ele.value = "${page.pageSize}";
		}
		$("#page_pageSize").val(ele.value);
	}
}

function checkPageNumber(ele){
	var totalpages = ${page.pages};
	if(ele.value!=""){
		if(parseInt(ele.value) <=0 || parseInt(ele.value) > totalpages){
			ele.value = "${page.pageNumber}";
		}
		$("#page_pageNumber").val(ele.value);
	}
}
function gotoPage(pg){
	if(pg!=null && pg!=""){
		$("#page_pageNumber").val(pg);
	}
	doGotoPage('${ctx}');
}
function exportPageExcel(){
	doExportPageExcel('${ctx}');
}
</script>
<input type="hidden" id="page_pageSize" name="page.pageSize" value="${page.pageSize}">
<input type="hidden" id="page_pageNumber" name="page.pageNumber" value="${page.pageNumber}">
<input type="hidden" value="like" id="xxx_matchmode_4" name="formMap.xxx_matchmode" <c:if test = "${formMap.xxx_matchmode == 'like' || formMap.xxx_matchmode == null}">CHECKED</c:if> />
