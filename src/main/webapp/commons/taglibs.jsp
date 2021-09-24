<%@page import="com.ssi.util.SystemConfig"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="/ssi-tags" prefix="ssi"%>

<c:set var="csspath" value='<%=SystemConfig.getProperty("css_path") %>' />
<c:if test="${pageContext.request.contextPath == '/'}">
	<c:set var="ctx" value="" />
</c:if>
<c:if test="${pageContext.request.contextPath != '/'}">
	<c:set var="ctx" value="${pageContext.request.contextPath}" />
</c:if>	