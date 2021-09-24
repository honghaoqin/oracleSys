<%@page import="com.ssi.framework.utils.TreeUtils"%>
<%@page import="org.apache.commons.lang.ObjectUtils"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<!doctype html>
<html>
<meta charset="utf-8">
<title></title>
<head>
<link href="${csspath}/gstyle/listpage.css" rel="stylesheet" type="text/css">
<script language="JavaScript" type="text/javascript" src="${csspath}/js/jquery-1.7.2.min.js"></script>
<script language="JavaScript" type="text/JavaScript" src="${csspath}/gstyle/uiDefine.js"></script>
<script language="JavaScript" type="text/JavaScript" src="${csspath}/js/dataRowEventSet.js"></script>
<script language="JavaScript" type="text/JavaScript" src="${csspath}/js/leftFrame.js"></script>
<script language="JavaScript" type="text/javascript" src="${csspath}/js/general.js"></script>
<script language="JavaScript" type="text/javascript" src="${csspath}/js/cookie.js"></script>
</head>
<body>
	<div class="bodyDiv">

		<!-- UIStructureBegin "主要内容区域" -->
		<div class="pageMain">
			<div class="layListpage">
				<div class="col1">
					<!-- UIStructureBegin "panel" -->
					<div class="pnlLeftFrame" id="pnlLeftFrame">
						<!-- UIStructureBegin "head" -->
						<div class="pnlHead">
							<div class="pnlHead_L">
								<div class="pnlHead_R">
									<div class="pnlHead_C">
										<div class="pnlTitle" id="pnlTitle">${resultMap.pnlTitle}</div>
										<div class="pnlTool"></div>
									</div>
								</div>
							</div>
						</div>
						<!-- UIStructureEnd "head" -->
						<div class="pnlBody">
							<!-- UIDataBegin "content" -->
							<div class="pnlContent" id="scrDiv">
								<div style="zoom:1;">
									<table border="0" cellspacing="0" cellpadding="0"
										class="outlookBar normalBar" id="outlookBar">
										<% 
										if(null!=request.getAttribute("resultList")){
										List<Map> resultList=(List)request.getAttribute("resultList");
										String  active="";
										if(null!=resultList&&!resultList.isEmpty()){
											for(int i=0;i<resultList.size();i++){
											   if(i==0){active="_active";
												 }else{active="";}	
												Map auth=resultList.get(i);
												if(null!=auth&&!auth.isEmpty()){
													%>
												<tr>
												  <td class="outlookItemTd<%=active%>">
													<table border="0"
															cellspacing="0" cellpadding="0" class="outlookItem<%=active%>"
															id="outlookItem<%=i+1%>">
															<tr class="outlookHead">
																<td><div class="outlookTitle">
																		<span class="outlookSwitch"></span><span
																			class="outlookIcon iconReaded"></span><%=ObjectUtils.toString(auth.get("NAME"))%>
																	</div></td>
															</tr>
															<%
															List<Map> childList = (List) auth.get(TreeUtils.CHILD);
															if(null!=childList&&!childList.isEmpty()){
															%>
															<tr class="outlookBody">
															   <td>
																  <div class="outlookCont">
																	  <ul class="infoList navList">
																		<%
																		for(int j=0;j<childList.size();j++){
																			Map  childMap=childList.get(j);
																			if(null!=childMap&&!childMap.isEmpty()){
																			%>
																			<li class="infoItem" id="infoItem_<%=i+1%>_<%=j+1%>">
																				<div class="infoTitle navItem2">
																					<span class="navSwitch"></span>
																					    <a onclick="loadright('${ctx}<%=ObjectUtils.toString(childMap.get("PARAM"))%>')"><%=ObjectUtils.toString(childMap.get("NAME"))%></a>
																				</div>
																			</li>	
																			<% 	
																			}
																		}
																	  %>
																	    </ul>
																	</div>
																</td>
															 </tr>
															<%}%>
															
															
														</table>
													  </td>
										          </tr>	
												 <% 
													
												}
												
											}
											
										 }
										}
										%>
									</table>
								</div>
							</div>
							<!-- UIDataBegin "content" -->
							<div class="pnlBody_B">
								<div class="pnlBody_BL">
									<div class="pnlBody_BR">
										<div class="pnlBody_BC"></div>
									</div>
								</div>
							</div>
						</div>
						<!-- UIStructureEnd "panel" -->
					</div>
					<!-- UIStructureEnd "panel" -->
				</div>
			</div>
		</div>
		<!-- UIStructureEnd "主要内容区域" -->
	</div>
<script type="text/javascript">
		function loadright(url) {
		$("#mainIframe",parent.document.body).attr("src",url);
		}
		var dheight=$(document).height();
		if(dheight>500){
			$("#leftIframe",parent.document.body).height(dheight);
			$("#colCtr",parent.document.body).height(dheight);	
		}
		//$("#mainIframe",parent.document.body).attr("src","${ctx}${resultMap.param}");
</script>	
</body>
</html>




