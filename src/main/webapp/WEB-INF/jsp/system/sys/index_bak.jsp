<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<!doctype html>
<html>
<meta charset="utf-8">
<title></title>
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
							<div class="welcome">欢迎进入HPI危机管理中心平台！</div>
							<div class="topMenu">
								<div class="topMenu_L">
									<div class="topMenu_R">
										<div class="topMenu_C">
											<a  class="pagesize">分辨率<span class="selsize"></span></a><a
												class="topMenuItem iconLogin" href="#" onClick=""
												title="HPI">登录</a> <a class="topMenuItem iconReg" href="#"
												onClick="unselectTab()" title="注册">注册</a> <a
												class="topMenuItem iconWizard" href="#"
												onClick="unselectTab()" title="网站导航">网站导航</a>
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
								<td class="menuItemTd"><div class="menuItem_active"
										id="menuItem1">
										<div class="menuItem_L">
											<div class="menuItem_R">
												<div class="menuItem_C">
													<a>首 页</a>
												</div>
											</div>
										</div>
									</div></td>

								<s:if test="resultList.size!=0">
									<s:iterator value="resultList" id="row" status="st">
										<td class="menuItemSpace">&nbsp;</td>
										<td class="menuItemTd"><div class="menuItem"
												id="menuItem${st.index+2}">
												<div class="menuItem_L">
													<div class="menuItem_R">
														<div class="menuItem_C">
															<a
																onclick="loadleft('${row.NAME}','${ctx}/sys/Menu/loadLeft.do?formMap.PARENT_ID=${row.AUTH_ID}')">${row.NAME}</a>
														</div>
													</div>
												</div>
											</div></td>
									</s:iterator>
								</s:if>
							</tr>
						</table>
					</div>
				</div>
			</div>
		</div>
		<!-- UIStructureEnd "导航栏" -->
		<div class="position2">&nbsp;</div>
		<!-- UIStructureBegin "主要内容区域" -->
		<div class="pageMain">
			<div class="layListpage">
				<div class="col1" id="leftCol">${resultMap.menuHTML}</div>
				<div class="colCtr">
					<a class="shLeft" id="sHLeft"><span></span></a>
				</div>
				<div class="col2" id="mainCol"></div>
			</div>
		</div>
		<!-- UIStructureEnd "主要内容区域" -->
	</div>
	<script type="text/javascript">
		$(document).ready(function() {
			//加载列表信息
			$("#mainCol").empty();
			$("#mainCol").load("${ctx}${resultMap.rightUrl}", {
				'formMap.RANDOM' : Math.random()
			}, function() {
			});
		});
		function loadright(url) {
			$("#mainCol").load(url, {
				'formMap.RANDOM' : Math.random()
			}, function() {
			});
		}
		$(function() {
			$(".menuItem").click(
					function() {
						$("#menuBar div[class='menuItem_active']").removeClass(
								"menuItem_active").addClass("menuItem");
						$(this).removeClass("menuItem");
						$(this).addClass("menuItem_active");
					});
		});
		function loadleft(name, url) {
			$.post(url, {
				ra : Math.random()
			}, function(data) {
				$("#leftCol").empty();
				$("#leftCol").html(data["menuHTML"]);
				$("#pnlLeftTitle").text(name);

				//导航项初始化
				initOI();
				//初始化左边导航列表鼠标事件绑定
				initCS();
				loadright("${ctx}/" + data["param"]);

			}, "json");
		}
		var resolution =<%=request.getSession().getAttribute("RESOLUTION")%>;
		function changeSize(size) {
			hideSize();
			$("#bodyDiv").width(size - 24);
			$("#mainCol").width(size - 254);
			if (resolution != size) {
				resolution = size;
				$.post(
						"${ctx}/sys/User/updateResolution.do?formMap.RESOLUTION="
								+ size, {
							ra : Math.random()
						});
			}
		}
		$("#bodyDiv").width(resolution - 24);
		$("#mainCol").width(resolution - 254);
	</script>
</body>
</html>


