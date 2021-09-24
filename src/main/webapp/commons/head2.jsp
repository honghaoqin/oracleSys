<%@ page contentType="text/html;charset=UTF-8"%>
<%@page import="com.ssi.sys.model.SysSessionUser"%>
<meta http-equiv="Pragma" content="no-cache" />
<link href="${csspath}/gstyle/listpage.css" rel="stylesheet"
	type="text/css">
<script language="JavaScript" type="text/JavaScript"
	src="${csspath}/gstyle/uiDefine.js"></script>
<script language="JavaScript" type="text/javascript"
	src="${ctx}/js/jquery/jquery-1.7.2.min.js"></script>
<script language="JavaScript" type="text/JavaScript"
	src="${ctx}/js/dataRowEventSet.js"></script>
<script language="JavaScript" type="text/javascript"
	src="${ctx}/js/cookie.js"></script>
<script language="JavaScript" type="text/javascript"
	src="${ctx}/js/general.js"></script>

<link type="text/css" href="${ctx}/js/jquery/css/jquery.qtip.min.css"
	rel="stylesheet">
<link type="text/css"
	href="${ctx}/js/jquery/css/jquery.autocomplete.css" rel="stylesheet">
<link rel="stylesheet" type="text/css"
	href="${ctx}/js/jquery/css/jquery.multiselect.css" />
<link rel="stylesheet" type="text/css"
	href="${ctx}/js/jquery/css/jquery.multiselect.filter.css" />
<link rel="stylesheet" type="text/css"
	href="${ctx}/js/jquery/css/jquery-ui.css" />

<script type="text/javascript" src="${ctx}/js/jquery/jquery-ui.js"></script>
<script type="text/javascript"
	src="${ctx}/js/jquery/jquery.multiselect.min.js"></script>
<script type="text/javascript"
	src="${ctx}/js/jquery/jquery.multiselect.filter.min.js"></script>
<script type="text/javascript" src="${ctx}/js/jquery/jquery.qtip.min.js"></script>
<script type="text/javascript"
	src="${ctx}/js/jquery/jquery.autocomplete.js"></script>
<script type="text/javascript"
	src="${ctx}/js/jquery/jquery.jqautocomplete.js"></script>

<script type="text/javascript" src="${ctx}/js/map.js"></script>
<script type="text/javascript" src="${ctx}/js/validator.js"></script>
<script type="text/javascript"
	src="${ctx}/plugin/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="${ctx}/plugin/ymPrompt/ymPrompt.js"></script>
<link rel="stylesheet" id='skin' type="text/css"
	href="${ctx}/plugin/ymPrompt/skin/qq/ymPrompt.css" />
<script type="text/javascript" src="${ctx}/js/interface.js"></script>
<script type="text/javascript">
	//禁止退格键退出系统
	$(document).keydown(
			function(e) {
				var doPrevent;
				if (e.keyCode == 8) {
					var d = e.srcElement || e.target;
					if (d.tagName.toUpperCase() == 'INPUT'
							|| d.tagName.toUpperCase() == 'TEXTAREA') {
						doPrevent = d.readOnly || d.disabled;
					} else {
						doPrevent = true;
					}

				} else {
					doPrevent = false;
				}
               
				if (doPrevent)
					e.preventDefault();
			});

</script>
<style type="text/css">
a {
	cursor: pointer;
	text-decoration: none;
}
</style>