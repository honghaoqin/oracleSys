<%@page import="com.ssi.framework.utils.TreeUtils"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<html>
<head>
<!-- <meta http-equiv="X-UA-Compatible" content="IE=7"> -->
<%@ include file="/commons/head.jsp"%>
<script type="text/javascript" src="${csspath}/js/treeview/treeview.js"></script>
<link type="text/css" rel="stylesheet"
	href="${csspath}/js/treeview/treeview.css"></link>
<script type="text/javascript">
	function $ctt(c){
		var isc = $(c).is(':checked');
		chk(c.parentNode.parentNode,isc);
	}
	function chk(o,isc){
		$(o).children("ul").find("input[type='checkbox']").attr("checked",isc);
		if(isc){
			$(o).parent().parentsUntil(".treeview","li").children("span").children("input[type='checkbox']").attr("checked",isc);
		}
	}
	AjaxTreeView.config.onclick=function(o,a){
		var isc = $(a).prev().is(':checked');
		isc=!isc;
		$(a).prev().attr("checked",isc);
		chk(o,isc);
	}
</script>
</head>
<body>
	<div class="bodyDiv">
		<!-- UI Structure Begin "当前位置" -->
		<div class="position">
			<div class="positon_L">
				<div class="position_C">当前位置：组织机构</div>
			</div>
		</div>
		<!-- UI Structure End "当前位置" -->
		
		<!-- UIStructureEnd "工具条" -->
		<!-- UIStructureBegin "滚动内容区域" -->
		<div class="contentDiv">
			<div class="tableFix">
				<!-- UI Structure Begin "信息列表表格" -->
				
				<table cellspacing=0 cellpadding=0>
			<tbody>
				
				<tr>
					<td>
						<!--begin: 祥表内容-->
						<div style="width: 300px; height: 500px; overflow: auto"
							class="treeview">
							<ul>
								<li class="open lastopen">
									<div class="hit open-hit lastopen-hit" onclick="$att(this);"></DIV>
									<span class="folder"><A onclick='$atc(this)' href="#">组织机构</A>
								</span> <ssi:tree value="resultList" idKey="DEPT_ID"
										parentKey="PARENT_ID" valueKey="DEPT_ID" textKey="NAME"
										checkedKey="CHECKED" type="1" body="true" />
								</li>
							</ul>
						</div> 
						<!--begin: 祥表内容-->
					</td>
				</tr>
			</tbody>
		</table>
		  </div>
		</div>
		<!-- UIStructureEnd "滚动内容区域" -->

	</div>

</body>
</html>