<%@page import="org.apache.commons.lang.ObjectUtils"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@page import="com.ssi.codegen.ConnectionFactory"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.sql.*"%>
<%@ page import="javax.naming.*"%>
<%@ include file="/commons/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=7">
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title><ssi:p value="SYS_NAME" /></title> <%@ include
		file="/commons/head.jsp"%>
	<script language="Javascript" type="text/javascript"
		src="${ctx}/js/edit_area/edit_area_full.js"></script>
	<script>function subformbdc()
{
	if(document.sqlform.pwd.value=="")
	{
		alert('密码不能为空，请重新输入！');
		document.sqlform.pwd.focus();
		return false;
	}
	if (document.sqlform.sql.value=="")
	{
		alert('SQL语句不能为空，请重新输入！');
		document.sqlform.sql.focus();
		return false;
	} 
}
editAreaLoader.init({
	id: "sql"	// id of the textarea to transform		
	,start_highlight: true	// if start with highlight
	,allow_toggle: false
	,language: "en"
	,syntax: "sql"	
});

$(function() {
	$("#SQL_CHECKBOX").change(function() {
		if (!this.checked) {
			$(".addForm").show();
			$(".addBtnDiv").show();
		} else {
			$(".addForm").hide();
			$(".addBtnDiv").hide();
		}
	});
});
function  hidediv(){
	$(".addForm").hide();
	$(".addBtnDiv").hide();
	$("#SQL_CHECKBOX").attr("checked", true); 
}
</script>
</head>
<body>
	<div class="pageIframe">
		<form name="sqlform" action="${ctx}/sys/Login/toSql.do" method="post"
			onSubmit="return subformbdc()">

			<div class="pageNow">您现在的位置是：SQL操作平台</div>
			<div class="h10"></div>
			<div class="listTitle">
				<h2 class="fl">
					SQL操作平台<input type="checkbox" id="SQL_CHECKBOX"   value="1">
				</h2>
				<div class="fr"></div>
			</div>
			<div class="addForm">
				<table class="addTable" width="100%" border="0" cellspacing="0"
					cellpadding="5">
					<tr>
						<td width="105" align="center">数据库：</td>
						<td colspan="3"><select name="driverClass" id="driverClass">
								<option value="<%=ConnectionFactory.driverClass%>">oracle</option>
						</select></td>
					</tr>
					<tr>
						<td width="105" align="center">地址：</td>
						<td colspan="3"><input name="url" type="text" id="url"
							size="45" value="<%=ConnectionFactory.url%>"></td>
					</tr>

					<tr>
						<td width="105" align="center">管理员：</td>
						<td colspan="3"><input name="user" type="text" id="user"
							value="<%=ConnectionFactory.user%>" size="10"></td>
					</tr>
					<tr>
						<td width="105" align="center">密码：</td>
						<td colspan="3"><input name="pwd" type="password" id="pwd"
							value="<%=ObjectUtils.toString(request.getParameter("pwd"))%>"
							size="10"></td>
					</tr>


					<tr>
						<td height="80" align="center">SQL语句：</td>
						<td height="80" colspan="3"><textarea name="sql" cols="80"
								rows="20" id="sql"><%=ObjectUtils.toString(request.getParameter("sql"))%></textarea></td>
					</tr>
				</table>
			</div>
			<div class="addBtnDiv">
				<input type="submit" class="btn1 btn2" value="提交" /> <input
					type="reset" class="btn1 btn2" value="重置" /> <input type="button"
					class="btn1 btn2" onclick="hidediv()" value="隐藏" />
			</div>

		</FORM>
		<div class="pageList">
			<table class="tableCSS sortable" cellpadding="0" cellspacing="1"
				border="0">
				<tr>
					<%
						//接收数据

						String errorStr = "";
						if (null != request.getParameter("pwd")&&null!=request.getParameter("sql")) {
							request.setCharacterEncoding("UTF-8");
							String pwd = request.getParameter("pwd");
							String driverClass = request.getParameter("driverClass");
							String url = request.getParameter("url");
							String user = request.getParameter("user");
							String sql = request.getParameter("sql");
							if (sql != null && !sql.equals("")) {
								sql = sql.trim().toLowerCase();
							} else {
								sql = "no";
							}
							String dotype = "";
							if (sql.indexOf("select") != -1) {
								dotype = "select";
							} else if (sql.indexOf("insert") != -1) {
								dotype = "insert";
							} else if (sql.indexOf("update") != -1) {
								dotype = "update";
							} else if (sql.indexOf("delete") != -1) {
								dotype = "delete";
							} else if (sql.indexOf("alter") != -1) {
								dotype = "alter";
							} else if (sql.indexOf("create") != -1) {
								dotype = "create";
							} else if (sql.indexOf("drop") != -1) {
								dotype = "drop";
							} else if (sql.indexOf("commit") != -1) {
								dotype = "commit";
							} else if (sql.indexOf("rollback") != -1) {
								dotype = "rollback";
							} else {
								dotype = "no";
							}

							//判断是否合法调用
							boolean passFlag = false;
							String tempSQL = "";
							Connection conn = null;
							if (conn == null || conn.isClosed()) {
								Class.forName(driverClass);
								try {
									conn = DriverManager.getConnection(url, user, pwd);
								} catch (Exception e) {
									e.printStackTrace();
									errorStr += e.getMessage() + "<br>";
								}

							}

							Statement stmt = null;

							PreparedStatement pstmt = null;
							ResultSet rs = null;
							int rowCount = 1, colNum = -1, rowCountTemp = 0;
							ResultSetMetaData rsmd = null;

							//检测密码
							if (pwd != null && pwd.equals(ConnectionFactory.password)) {
								passFlag = true;
							} else {
								errorStr += "对不起，密码不对！<br>";
							}

							try {

								//检测删除操作
								if (!sql.equals("no") && dotype.equals("delete")) {
									if (!(sql.indexOf("where") > 0)) {
										errorStr += "对不起，删除操作没有where条件，禁止执行！<br>";
										passFlag = false;
									} else {
										tempSQL = "select * "
												+ sql.substring(sql.indexOf("from"),
														sql.length());
										stmt = conn.createStatement();
										rs = stmt.executeQuery(tempSQL);
										while (rs.next()) {
											rowCountTemp++;
										}

										errorStr += "记录数：" + rowCountTemp + "<br><br>";

										if (rowCountTemp <= 0) {
											errorStr += "检测语句：" + tempSQL + "<br><br>";
											errorStr += "对不起，在表中找不到记录，无法删除！<br>";
											passFlag = false;
										}
										if (rowCountTemp > 10) {
											errorStr += "检测语句：" + tempSQL + "<br><br>";
											errorStr += "对不起，删除记录大于10条，禁止执行！<br>";
											passFlag = false;
										}
										if (rowCountTemp >= 1 && rowCountTemp <= 10)
											passFlag = true;

										if (stmt != null)
											stmt.close();
										if (rs != null)
											rs.close();
									}
								}

								//开始分类型执行操作
								//insert update delete操作
								String sqlstr = sql;
								if (passFlag == true
										&& !sql.equals("no")
										&& (dotype.equals("insert")
												|| dotype.equals("update")
												|| dotype.equals("delete")
												|| dotype.equals("alter")
												|| dotype.equals("create")
												|| dotype.equals("drop")
												|| dotype.equals("commit") || dotype
													.equals("rollback"))) {
									errorStr += "SQL语句：" + sqlstr + "<br><br>";
									stmt = conn.createStatement();
									stmt.executeQuery(sqlstr);
									if (stmt != null)
										stmt.close();
									errorStr += "成功执行！<br>";
								}
								//select操作
								if (passFlag == true && !sql.equals("no")
										&& dotype.equals("select")) {

									pstmt = conn.prepareStatement(sqlstr);
									rs = pstmt.executeQuery();
									rsmd = rs.getMetaData();
									if (rsmd != null) {
										colNum = rsmd.getColumnCount();
									}
					%>

					<%
						for (int i = 1; i <= colNum; i++) {
										out.println("<th>" + rsmd.getColumnLabel(i)
												+ "</th>");
									}
					%>
				</tr>
				<%
					while (rs.next() && rowCount < 1000) {
				%>
				<tr>
					<%
						for (int i = 1; i <= colNum; i++) {
											out.println("<td>"
													+ ObjectUtils.toString(rs.getString(i))
													+ "</td>");
										}
					%>
				</tr>
				<%
					rowCount++;
								}

								errorStr += "成功执行！<br>";
							}

							//清理战场
							if (pstmt != null)
								pstmt.close();
							if (rs != null)
								rs.close();
							if (conn != null)
								conn.close();

						} catch (Exception e) {
							e.printStackTrace();
							errorStr += e.getMessage() + "<br>";
						}

						//out.println(errorStr);
						if (dotype.equals("no")) {
							//out.println("对不起，不是select insert update delete alter create drop commit rollback中的一个操作！");
							errorStr = "对不起，不是select insert update delete alter create drop commit rollback中的一个操作！";
						}

					}
				%>
			</table>
			<font color="red"><%=errorStr%></font>

		</div>
	</div>
</body>
</html>