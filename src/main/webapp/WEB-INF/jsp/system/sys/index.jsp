<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<!doctype html>
<html>
<meta charset="utf-8">
<title></title>
<head>
<link href="${csspath}/gstyle/listpage.css" rel="stylesheet"
	type="text/css">
<script language="JavaScript" type="text/javascript"
	src="${csspath}/js/jquery-1.7.2.min.js"></script>
<script language="JavaScript" type="text/JavaScript"
	src="${csspath}/gstyle/uiDefine.js"></script>
<script language="JavaScript" type="text/JavaScript"
	src="${csspath}/js/dataRowEventSet.js"></script>
<script language="JavaScript" type="text/JavaScript"
	src="${csspath}/js/leftFrame.js"></script>
<script language="JavaScript" type="text/javascript"
	src="${csspath}/js/general.js"></script>
<script language="JavaScript" type="text/javascript"
	src="${csspath}/js/cookie.js"></script>

<script type="text/javascript" src="${ctx}/js/interface.js"></script>
<script type="text/javascript" src="${ctx}/js/validator.js"></script>
<script type="text/javascript"
	src="${ctx}/plugin/My97DatePicker/WdatePicker.js"></script>
</head>
<body>
	<!--"分辨率选项" begin-->
	<div id="sizeList" style="display: none;">
		<ul>
			<li><a onclick="changeSize(1600)">1600</a></li>
			<li><a onclick="changeSize(1366)">1366</a></li>
			<li><a onclick="changeSize(1280)">1280</a></li>
			<li><a onclick="changeSize(1024)">1024</a></li>
		</ul>
	</div>
	<!--"分辨率选项" end-->
	<div class="bodyDiv" id="bodyDiv">
		<div class="topDiv" id="topDiv">
			<div style="display: none" id="frameResize">可设置样式#frameResize初始化leftframe框架宽度</div>
			<!-- UIStructureBegin "banner" -->
			<div class="banner">
				<div class="banner_L">
					<div class="banner_R">
						<div class="w">
							<div class="logo" id="logo"></div>
							<div class="welcome">
								<font color="red">${sessionScope._SESSION_USER_.name}</font>,欢迎进入<ssi:p value="SYS_NAME" />！
							</div>
							<div class="topMenu">
								<div class="topMenu_L">
									<div class="topMenu_R">
										<div class="topMenu_C">
											<a class="pagesize" id="change_pagesize">分辨率大小<%=request.getSession().getAttribute("RESOLUTION")%><span class="selsize"></span></a><a
												class="topMenuItem iconLogin"  onclick="logout()"
												title="退出系统">退出</a> 
												
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<!-- UIStructureEnd "banner" -->
		</div>
		<!-- UIStructureBegin "导航栏" -->
		<div class="menu">
			<div class="menu_L">
				<div class="menu_R">
					<div class="w">
						<table border="0" cellspacing="0" cellpadding="0" class="menuBar"
							id="menuBar">
							<tr>
								<td class="menuItemTd">
									<div
										<s:if test='%{formMap.PARENT_ID==""}'>class="menuItem_active"</s:if>
										<s:else>class="menuItem"</s:else> id="menuItem1">
										<div class="menuItem_L">
											<div class="menuItem_R">
												<div class="menuItem_C">&nbsp;</div>
											</div>
										</div>
									</div>
								</td>
								<s:if test="resultList.size!=0">
									<s:iterator value="resultList" id="row" status="st">
										<td class="menuItemSpace">&nbsp;</td>
										<td class="menuItemTd">
											<div
												<s:if test="%{formMap.PARENT_ID==AUTH_ID}">class="menuItem_active"</s:if>
												<s:else>class="menuItem"</s:else> id="menuItem${st.index+2}">
												<div class="menuItem_L">
													<div class="menuItem_R">
														<div class="menuItem_C">
															<s:if test='%{null==PARAM||PARAM==""}'>
																<a onclick="loadleft('${row.AUTH_ID}')">${row.NAME}</a>
															</s:if>
															<s:else>
															<s:if test='%{TARGET=="left_right"}'>
															    <a onclick="loadPage('${row.PARAM}','${row.REMARK}')">${row.NAME}</a>
															</s:if><s:else>
															    <a href="${ctx}${row.PARAM}"
																	<s:if test='%{TARGET=="_blank"}'>target="${row.TARGET}"</s:if>>${row.NAME}</a>
																</s:else>
															</s:else>
														</div>
													</div>
												</div>
											</div>
										</td>
									</s:iterator>
								</s:if>
							</tr>
						</table>
					</div>
				</div>
			</div>
		</div>
		<!-- UIStructureEnd "导航栏" -->
		<!-- UI Structure Begin "当前位置" -->
		<div class="position2">&nbsp;</div>
		<!-- <div class="position">
        <div class="positon_L">
            <div class="position_C">当前位置：首页 <span class="posNext"></span> 医保首页 <span class="posNext"></span> 保险信息 <span class="posNext"></span> 医院基本信息</div>
        </div>
    </div> -->
		<!-- UI Structure End "当前位置" -->
		<!-- UIStructureBegin "主要内容区域" -->
		<div class="pageMain">
			<div class="layListpage">
				<div class="col1" id="leftCol">
					<iframe id="leftIframe" src="${ctx}${resultMap.leftUrl}"
						frameborder="0" scrolling="no" width="100%" height="500"></iframe>
				</div>
				<div class="colCtr" id="colCtr" style="height:500px;">
					<a class="shLeft" id="sHLeft"><span></span></a>
				</div>
				<div class="col2" id="mainCol">
					<iframe id="mainIframe" src="${ctx}${resultMap.rightUrl}"
						frameborder="0" scrolling="no" width="100%" height="500"></iframe>
				</div>
			</div>
		</div>
		<!-- UIStructureEnd "主要内容区域" -->
	</div>
	<script type="text/javascript">
		$(function() {
			$(".menuItem").click(
					function() {
						$("#menuBar div[class='menuItem_active']").removeClass(
								"menuItem_active").addClass("menuItem");
						$(this).removeClass("menuItem");
						$(this).addClass("menuItem_active");
					});
			$(".menuItem_active").click(
					function() {
						$("#menuBar div[class='menuItem_active']").removeClass(
								"menuItem_active").addClass("menuItem");
						$(this).removeClass("menuItem");
						$(this).addClass("menuItem_active");
					});
		});
		//页面分辨率大小
		var resolution =<%=request.getSession().getAttribute("RESOLUTION")%>;
		var  temp_resolution=0;
		//修改页面的分辨率
		function changeSize(size) {
			hideSize();
			var leftCol=$("#leftCol").width();
			$("#bodyDiv").width(size -temp_resolution- 24);
			$("#mainCol").width(size - leftCol-temp_resolution-54);
			if (resolution != size) {
				resolution = size;
				$.post("${ctx}/sys/User/updateResolution.do?formMap.RESOLUTION="
								+ size, {
							ra : Math.random()
						});
			}
			$("#change_pagesize").text("分辨率大小"+size);
			
		}
		function loadPage(leftUrl,rightUrl) {
			$("#mainIframe",parent.document.body).height(500);
			temp_resolution=50;
			var leftCol=$("#leftCol").width();
			if(leftCol==200){
				var mainCol=$("#mainCol").width();
				$("#leftCol").width(250);
				$("#mainCol").width(mainCol-50);
				
			}
			 $("#leftIframe",document.body).attr("src","${ctx}"+leftUrl); 
			 $("#mainIframe",document.body).attr("src","${ctx}"+rightUrl); 
			}
		function loadleft(parent_id) {
			temp_resolution=0;
			var leftCol=$("#leftCol").width();
			if(leftCol==250){
				var mainCol=$("#mainCol").width();
				$("#leftCol").width(200);
				$("#mainCol").width(mainCol+50);
			}
		 $("#leftIframe",document.body).attr("src","${ctx}/sys/Menu/left.do?formMap.PARENT_ID="+parent_id); 
		 $("#mainIframe",document.body).attr("src","${ctx}/sys/Menu/right.do?formMap.PARENT_ID="+parent_id); 
		}
		
		$("#bodyDiv").width(resolution -temp_resolution- 24);
		$("#mainCol").width(resolution -temp_resolution- 254);
		
		function  logout(){
			window.top.location.href ="${ctx}/sys/Login/logout.do";	
		}
		
		
	</script>
</body>
</html>


