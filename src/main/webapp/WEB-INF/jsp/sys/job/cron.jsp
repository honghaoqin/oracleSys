<%@ page contentType="text/html;charset=UTF-8"%>
<%@page import="com.ssi.sys.model.SysSessionUser"%>
<%@ include file="/commons/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<TITLE><ssi:p value="SYS_NAME" /></TITLE>
<script type="text/javascript" src="${ctx}/js/jquery-1.7.2.min.js"></script>
<link rel="stylesheet" type="text/css" href="${ctx}/js/lightbox.css" />
<style type="text/css">
<!--
body,td,th {
	font-family: Verdana, Arial, Helvetica, sans-serif, 宋体, 微软雅黑;
	font-size: 12px;
	color: #000000;
}

-->
</style>
<script>
	function minuteChange(type){
		if(type==1){
			$("#minute1").attr("checked",true);
			$("#minute2").attr("checked",false);
			$("#minuteStart").attr("disabled",false);
			$("#minuteEnd").attr("disabled",false);
			$("input[name='minute']").each(function(){ 
				$(this).attr("disabled",true);
			});
		}else{
			$("#minute1").attr("checked",false);
			$("#minute2").attr("checked",true);
			$("#minuteStart").attr("disabled",true);
			$("#minuteEnd").attr("disabled",true);
			$("input[name='minute']").each(function(){ 
				$(this).attr("disabled",false);
			});
		}
	}
	function hourChange(type){
		if(type==1){
			$("#hour1").attr("checked",true);
			$("#hour2").attr("checked",false);
			$("#hourStart").attr("disabled",false);
			$("#hourEnd").attr("disabled",false);
			$("input[name='hour']").each(function(){ 
				$(this).attr("disabled",true);
			});
		}else{
			$("#hour1").attr("checked",false);
			$("#hour2").attr("checked",true);
			$("#hourStart").attr("disabled",true);
			$("#hourEnd").attr("disabled",true);
			$("input[name='hour']").each(function(){ 
				$(this).attr("disabled",false);
			});
		}
	}
	function dayChange(type){
		if(type==1){
			$("#day1").attr("checked",true);
			$("#day2").attr("checked",false);
			$("#dayStart").attr("disabled",false);
			$("#dayEnd").attr("disabled",false);
			$("input[name='day']").each(function(){ 
				$(this).attr("disabled",true);
			});
		}else{
			$("#day1").attr("checked",false);
			$("#day2").attr("checked",true);
			$("#dayStart").attr("disabled",true);
			$("#dayEnd").attr("disabled",true);
			$("input[name='day']").each(function(){ 
				$(this).attr("disabled",false);
			});
		}
	}
	function monthChange(type){
		if(type==1){
			$("#month1").attr("checked",true);
			$("#month2").attr("checked",false);
			$("#monthStart").attr("disabled",false);
			$("#monthEnd").attr("disabled",false);
			$("input[name='month']").each(function(){ 
				$(this).attr("disabled",true);
			});
		}else{
			$("#month1").attr("checked",false);
			$("#month2").attr("checked",true);
			$("#monthStart").attr("disabled",true);
			$("#monthEnd").attr("disabled",true);
			$("input[name='month']").each(function(){ 
				$(this).attr("disabled",false);
			});
		}
	}
</script>
</head>


<body>
	<FORM method=post name="loginForm" id="loginForm" 
		action="${ctx}/sys/Login/login.do" onsubmit="">
		<div>
			<h3>秒</h3>
		</div>
		<table>
			<c:forEach var="i" begin="0" end="59" step="1">
				<c:if test="${i==0}">
					<tr>
				</c:if>
				<c:if test="${i%20==0 &&i!=0}">
					</tr><tr>
				</c:if>
				<td>
					<input type="checkbox" value="${i}"/>${i}
				</td>
				<c:if test="${i==59 }">
					</tr>
				</c:if>
			</c:forEach>
		</table>
		<div>
			<h3>分钟</h3>
		</div>
		<input type="radio" id="minute1" onclick="minuteChange(1)"/>周期循环
		<table>
			<tr>
				<td>
					从第<input name="minuteStart" id="minuteStart" value="" type="text" size="10"	 />
					分钟开始，间隔
					<input name="minuteStart" id="minuteStart" value="" type="text" size="10"	 />
					分钟执行一次				
				</td>
			</tr>
		</table>
		<input type="radio" id="minute2" onclick="minuteChange(2)">手动指定
		<table>
			<c:forEach var="i" begin="0" end="59" step="1">
				<c:if test="${i==0}">
					<tr>
				</c:if>
				<c:if test="${i%20==0 &&i!=0}">
					</tr><tr>
				</c:if>
				<td>
					<input name="minute" type="checkbox"  value="${i}"/>${i}
				</td>
				<c:if test="${i==59 }">
					</tr>
				</c:if>
			</c:forEach>
			
		</table>
		<div>
			<h3>小时</h3>
		</div>
		<input type="radio" id="hour1" onclick="hourChange(1)"/>周期循环
		<table>
			<tr>
				<td>
					从第<input name="hourStart" id="hourStart" value="" type="text" size="10"	 />
					小时开始，间隔
					<input name="hourEnd" id="hourEnd" value="" type="text" size="10"	 />
					小时执行一次				
				</td>
			</tr>
		</table>
		<input type="radio" id="hour2" onclick="hourChange(2)"/>手动指定
		<table>
			<c:forEach var="i" begin="0" end="23" step="1">
				<c:if test="${i==0}">
					<tr>
				</c:if>
				<c:if test="${i%20==0 &&i!=0}">
					</tr><tr>
				</c:if>
				<td>
					<input type="checkbox" name="hour" value="${i}"/>${i}
				</td>
				<c:if test="${i==23 }">
					</tr>
				</c:if>
			</c:forEach>
			
		</table>
		<div>
			<h3>天</h3>
		</div>
		<input type="radio" id="day1" value="" onclick="dayChange(1)"/>周期循环
		<table>
			<tr>
				<td>
					从<input name="dayStart" id="dayStart" value="" type="text" size="10"	 />
					号开始，间隔
					<input name="dayEnd" id="dayEnd" value="" type="text" size="10"	 />
					天执行一次				
				</td>
			</tr>
		</table>
		<input type="radio" id="day2" value="" onclick="dayChange(2)"/>手动指定
		<table>
			<c:forEach var="i" begin="1" end="31" step="1">
				<c:if test="${i==1}">
					<tr>
				</c:if>
				<c:if test="${i%20==0 &&i!=0}">
					</tr><tr>
				</c:if>
				<td>
					<input type="checkbox" name="day" value="${i}"/>${i}
				</td>
				<c:if test="${i==31 }">
					</tr>
				</c:if>
			</c:forEach>
			
		</table>
		<div>
			<h3>月</h3>
		</div>
		<input type="radio" value="" id="month1" onclick="monthChange(1)"/>周期循环
		<table>
			<tr>
				<td>
					从<input name="monthStart" id="monthStart" value="" type="text" size="10"	 />
					月开始，间隔
					<input name="monthEnd" id="monthEnd" value="" type="text" size="10"	 />
					月执行一次				
				</td>
			</tr>
		</table>
		<input type="radio" value="" id="month2" onclick="monthChange(2)"/>手动指定
		<table>
			<c:forEach var="i" begin="1" end="12" step="1">
				<c:if test="${i==1}">
					<tr>
				</c:if>
				<c:if test="${i%20==0 &&i!=0}">
					</tr><tr>
				</c:if>
				<td>
					<input type="checkbox" name="month" value="${i}"/>${i}
				</td>
				<c:if test="${i==12}">
					</tr>
				</c:if>
			</c:forEach>
			
		</table>
		<div>
			<h3>周</h3>
		</div>
		
		<table>
			<c:forEach var="i" begin="1" end="7" step="1">
				<c:if test="${i==1}">
					<tr>
				</c:if>
				<c:if test="${i%20==0 &&i!=0}">
					</tr><tr>
				</c:if>
				<td>
					<input type="checkbox" value="${i}"/>
					<c:if test="${i==1}">周一</c:if>
					<c:if test="${i==2}">周二</c:if>
					<c:if test="${i==3}">周三</c:if>
					<c:if test="${i==4}">周四</c:if>
					<c:if test="${i==5}">周五</c:if>
					<c:if test="${i==6}">周六</c:if>
					<c:if test="${i==7}">周日</c:if>
				</td>
				<c:if test="${i==7}">
					</tr>
				</c:if>
			</c:forEach>
			
		</table>
		<div>
			<h3>表达式</h3>
		</div>
		
		<table>
			<tr>
				<td></td>
				<td>秒</td>
				<td>分</td>
				<td>时</td>
				<td>天</td>
				<td>月</td>
				<td>周</td>
			</tr>
			<tr>
				<td>表达式内容:</td>
				<td><input type="text"/></td>
				<td><input type="text"/></td>
				<td><input type="text"/></td>
				<td><input type="text"/></td>
				<td><input type="text"/></td>
				<td><input type="text"/></td>
			</tr>
			<tr>
				<td>Cron表达式:</td>
				<td colspan="5"><input style="width: 99.2%" type="text"/></td>
				
				<td><input type="button" value="解析到UI"/></td>
			</tr>
			<tr>
				<td colspan="7"><h3>计划执行时间列表</h3></td>
			</tr>
			<tr>
				<td >开始时间：</td>
				<td ><input  type="text" readonly="readonly"/></td>
				<td >结束时间：</td>
				<td colspan="4"><input  type="text" readonly="readonly"/></td>
			</tr>
			<tr>
				<td >执行时间：</td>
				<td colspan="6"><textarea cols="100" rows="10" readonly="readonly"></textarea></td>
			</tr>
		</table>
	</FORM>

</body>
</html>


