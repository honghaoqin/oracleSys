<%@ page contentType="text/html;charset=UTF-8"%>
<%@page import="java.sql.Timestamp"%>
<%@ include file="/commons/taglibs.jsp"%>
<!doctype html>
<html>
<meta charset="utf-8"><meta name="viewport" content="width=device-width, initial-scale=1.0">
<title></title>
<%@ include file="/commons/head.jsp"%>
<script type="text/javascript" src="${ctx}/plugin/Charts/FusionCharts.js"></script>	
</head>
<body>
	<div class="bodyDiv formPage">
		<!--如果是录入页面，请在class里加上formPage-->
		<!-- UI Structure Begin "当前位置" -->
		<div class="position">
			<div class="positon_L">
				<div class="position_C">当前位置：开发说明</div>
			</div>
		</div>
		<!-- UI Structure End "当前位置" -->
		<!-- UIStructureBegin "滚动内容区域" -->
		<div class="contentDiv">
			<div class="tableFix">
				<!-- UI Structure Begin "表单录入" -->
				
				<select name="formMap.FC_GROUPS" id="FC_GROUPS" class="multiselect" multiple="multiple" >
											<option  title="1" value="1">送达人</option>
<option  title="2" value="2">处领导</option>
<option  title="3" value="3">承办人</option>

										</select>
				
				
				<pre>
	-------------------------------------
	数据库字段定义说明
	-------------------------------------	
	\${menu=SYS}     //菜单
	\${unique}       //是否唯一
	\${simpleSearch} //是否简单搜索
	\${search}       //是否高级搜索
	\${!add}         //是否可以增加(默认是可以)
	\${!edit}        //是否可以修改(默认是可以)
	\${!list}        //是否可以列表(默认是可以)
	\${checkbox}     //是否使用checkbox输入框
	\${password}     //是否使用password输入框
	\${uuid}         //uuid
	\${be}           //是否使用范围输入(通常是搜索时候)
	\${asc}          //排序
	\${desc}         //排序
	\${lb,dept,PARENT_NAME} //下拉列表
	\${select=dicttype}   //select下拉列表
	\${selectsql=dicttype} //selectsql下拉列表
	\${d} //日期
	\${t} //时间
	\${dt} //日期时间
	\${textarea} 
	\${dataType=Require}  //不能为空
	\${dataType=NumEng}  //只能输入数字和英文字符
	\${dataType=Double}  //必须是数值
	\${msg=不能为空}
	
	-------------------------------------
	通用字段 
	-------------------------------------
	UPDATED_BY     VARCHAR2(32)       更新人\${!add}\${!edit}\${!list}
	UPDATED_DATE   DATE               更新时间\${!add}\${!edit}\${!list}\${dt}
	CREATED_BY     VARCHAR2(32)       创建人\${!add}\${!edit}
	CREATED_DATE   DATE               创建时间\${!add}\${!edit}\${dt}
	REMARK         VARCHAR2(512)      备注\${!list}\${textarea}
	IS_DELETE      CHAR(1)            逻辑删除 \${!add}\${!edit}\${!list}                 1删除 0不删除
	YEAR           VARCHAR2(4)        年度\${search}
	PROVINCE_ID    VARCHAR2(32)       省\${search}\${select=provinceAuth}\${flag=true}\${dataType=Require}\${msg=不能为空}
	CITY_ID        VARCHAR2(32)       市\${search}\${select=}
	AREA_ID        VARCHAR2(32)       县\${search}\${select=}
	STATUS          CHAR(1)           审核状态${!add}${!edit}
	AJ_STATUS       char(2)           案件动态
	
	
	
	
	-------------------------------------
	HPI系统数据表
	-------------------------------------
		系统表
		-------
	   S_USER      用户表
	   S_ROLE      角色表
	   S_DICT      字典表
	   S_AUTH      权限表
	   S_RIGHT     表单权限
	   S_AUDIT_LOG 操作日志
	   S_LOGIN_LOG 登录日志
	   S_GROUP     用户组
	   S_DEPT      部门
	   S_FILE      文件上传表
	   S_ROLE_RIGHT 角色表单权限中间表   
	   S_ROLE_AUTH  角色权限中间表   
	   S_ROLE_USER  角色用户中间表   
	
	      基础数据表
	   -------   
	   B_PROVINCE              省
	   B_CITY                  市
	   B_AREA                  县
	   B_HOSPITAL              医院
	   B_COMMITTEE             医调委
	   B_COMMISSIONER          医调委人员
	   B_LEAVEHOSPITAL         出院人数调整因子
	   B_MEDICALINSTITUTIONS   医疗机构因子
	   B_MEDICALPERSONNEL      医务人员信息
	   B_OUTPATIENT            门诊因子
	   B_LEGALEXPERTS          法学专家
	   B_MEDICALEXPERTS        医学专家
	   B_PREMIUM               保费计算设置
	   B_REPARATION	                             赔偿限额设置
	   B_DEPARTMENT 	                  科室
	   B_NUM                   编号生成表
	   B_SCHEME                方案表
	   B_RENEWAL               续保因子表
	   B_INSURE               投保录入信息
	     业务逻辑
	  -------   
	               医院
	     -------          
	     H_HCOVER               投保基本信息
	     
	     H_HREPORT              医院报案
	     H_JRMEDIATOR           调解员介入
	     H_JRCLERK              书记员介入
	     H_DXCASE               内外评定性表
	     H_JDMEDIATOR           医院监督 调解员介入
	     H_JRCLERK              书记员介入
	     H_JRCOMMENT            其它部门介入-意见表
	     H_JRMEDIATOR           调解员介入
	     H_JROTHER              其它部门介入
	     H_USERMIX              人员调配(调解员 书记员)
	     H_BLCASE               病例
	-------------------------------------
	医院接口调用方法  
	-------------------------------------
	  如 ：&lt;button onclick="return selectHospital('FATHER','FATHER_NAME','1');"&gt;选择&lt;/button&gt;
	  FATHER 医院的id对象值
	  FATHER_NAME医院名称的id对象值
	  radio 不为空(或不为空字符)时单选 为空时多选
	-------------------------------------	
	 function selectHospital(FATHER,FATHER_NAME,radio){
			var ids = $("#"+FATHER).val();
			var url = "${ctx}/base/Hospital/select.do?ids="+ids+"&showName="+FATHER_NAME+"&showId="+FATHER+"&radio="+radio;
			openwindow(url,1200,500);
			return false;
	 }
	 -------------------------------------
	医调委接口调用方法  
	 -------------------------------------
	  如 ：&lt;button onclick="return selectHospital('FATHER','FATHER_NAME','1');"&gt;选择&lt;/button&gt;
	  FATHER 医院的id对象值
	  FATHER_NAME医院名称的id对象值
	  radio 不为空(或不为空字符)时单选 为空时多选
	-------------------------------------	
	 function selectHospital(FATHER,FATHER_NAME,radio){
			var ids = $("#"+FATHER).val();
			var url = "${ctx}/base/Hospital/select.do?ids="+ids+"&showName="+FATHER_NAME+"&showId="+FATHER+"&radio="+radio;
			openwindow(url,1200,500);
			return false;
	 }
	 -------------------------------------	
	 医调委接口
	 -------------------------------------	
    /**
	 *FATHER 医院的id对象值
	 *FATHER_NAME医院名称的id对象值
	 *radio 不为空(或不为空字符)时单选 为空时多选
	 */
	function selectCommittee(FATHER,FATHER_NAME,radio){
		var ids = $("#"+FATHER).val();
		var url = "${ctx}/base/Committee/select.do?ids="+ids+"&showName="+FATHER_NAME+"&showId="+FATHER+"&radio="+radio;
		openwindow(url,1200,500);
		return false;
	}
	//医学专家接口 直接在onclick="return selectMedExpert(radio,ids)"; radio为空字符是多选 不为空时单选 ids为默认选择的值的保存的对象 可以为空 例子看caseCenter/dxcase/add.jsp里面
	 -------------------------------------	
	  编码生成 ，
	  参考HospitalAction类的105行程序
	 -------------------------------------	
     String num=numService.getnum(表名称, 省ID);
     -------------------------------------	
	  拼音头
	 -------------------------------------	
	   参考HospitalAction类的112行程序
       PingYinUtil.getFirstSpell("汉字");
       
           数据权限
	 -------------------------------------	
	   参考HospitalAction类的47行程序
    this.formMap.put("JOIN_SQL", " join  S_USER_AUTH  on  a.HOSPITAL_ID=S_USER_AUTH.OBJ_ID" +
					                     " and  S_USER_AUTH.IS_QUERY=1 and S_USER_AUTH.TYPE_ID='"+HospitalService.NAMESPACE+"'" +
					                     " and  S_USER_AUTH.USER_ID='"+this.getSessionUser().getUserId()+"' ");	
       
       
       
	--控制显示宽度 能自动设置宽度 且不变形 min-width可以自己定义
	style="width:100%;min-width: 900px;"
	 -------------------------------------	
	 打印
	 -------------------------------------	
    <a href="${ctx}/sys/Jasper/getHtml.do" target="_blank">打印测试</a>
	<a href="${ctx}/sys/Jasper/javaBeantoTable.do" target="_blank">打印测试javabean传值pdf打印</a>
	<a href="${ctx}/sys/Jasper/getExcel.do" target="_blank">打印测试excel打印</a>
	<a href="${ctx}/sys/Jasper/javaBeantoTender.do" target="_blank">与java类交互测试</a>
	<a href="${ctx}/sys/Jasper/getPro.do" target="_blank">存储过程</a>
	<a href="${ctx}/sys/Jasper/getSubIreport.do" target="_blank">调用子报表</a>
	<a href="${ctx}/demo/ckeditor.jsp" target="_blank">ckeditor修改器</a>
	
	
     -------------------------------------	
	 初始化编码    type 即大写表名称 
	 -------------------------------------		
	Insert into b_num
	  (id, type, province_id, num)
	  select SYS_GUID(),
	         'B_HOSPITAL',
	         a.province_id,
	         to_number(a.short_id || '000000') num
	    from b_province a
	
	 -------------------------------------	
	 投保信息，案件基本信息 公用部分页面调用
	 参考/hpi/src/main/webapp/WEB-INF/jsp/sys/channel/collection.jsp
	 -------------------------------------	

    \$(document).ready(function(){
	\$("#loadmsg").load("\${ctx}/sys/Channel/loadmsg.do?formMap.HREPORT_ID=\${formMap.HREPORT_ID}&formMap.isShow=N&"+Math.random());
	});
	参数：isShow=N时，默认层隐藏，isShow=Y时，默认层打开
	
	
	 -------------------------------------	
	 用户在session可以取到的数据
	 -------------------------------------	
	<table>
	<tr><td> 用户ID:</td><td>${sessionScope._SESSION_USER_.userId}</td><td>\${sessionScope._SESSION_USER_.userId}</td></tr>       
	<tr><td> 登录账号:</td><td>${sessionScope._SESSION_USER_.loginId}</td><td>\${sessionScope._SESSION_USER_.loginId}</td></tr>
	<tr><td> 姓名:</td><td>${sessionScope._SESSION_USER_.name}</td><td>\${sessionScope._SESSION_USER_.name}</td></tr>
	<tr><td> 密码:</td><td>${sessionScope._SESSION_USER_.psw}</td><td>\${sessionScope._SESSION_USER_.psw}</td></tr>
	<tr><td> 职位:</td><td>${sessionScope._SESSION_USER_.zw}   </td><td>\${sessionScope._SESSION_USER_.zw}</td></tr>
	<tr><td> 省编号:</td><td>${sessionScope._SESSION_USER_.provinceId} </td><td>  \${sessionScope._SESSION_USER_.provinceId}</td></tr>
	<tr><td> 市编号:</td><td>${sessionScope._SESSION_USER_.cityId}</td><td>\${sessionScope._SESSION_USER_.cityId}</td></tr>
	<tr><td> 区县编号:</td><td>${sessionScope._SESSION_USER_.areaId}</td><td>\${sessionScope._SESSION_USER_.areaId}</td></tr>
	<tr><td> 机构主键:</td><td>${sessionScope._SESSION_USER_.ogrId}</td><td> \${sessionScope._SESSION_USER_.ogrId}</td></tr>
	<tr><td> 用户类型:</td><td>${sessionScope._SESSION_USER_.typeId}</td><td>  \${sessionScope._SESSION_USER_.typeId}</td></tr>
	<tr><td> 登录IP:</td><td>${sessionScope._SESSION_USER_.ip} </td><td> \${sessionScope._SESSION_USER_.ip}</td></tr>
	<tr><td> 浏览器版本:</td><td>${sessionScope._SESSION_USER_.browser}</td><td>  \${sessionScope._SESSION_USER_.browser}</td></tr>
	<tr><td> 列表分页数:</td><td>${sessionScope._SESSION_USER_.pageSize} </td><td> \${sessionScope._SESSION_USER_.pageSize}</td></tr>
	<tr><td> 样式版本:</td><td>${sessionScope._SESSION_USER_.stylesheet}</td><td>  \${sessionScope._SESSION_USER_.stylesheet}</td></tr>
	</table>
	
	 -------------------------------------	
	<a href="http://www.stepday.com/topic/?290" target="_blank">统计图</a>
	<a href="http://wenku.baidu.com/view/e5726cc7bb4cf7ec4afed040.html" target="_blank">统计图</a>
	
	 -------------------------------------
	 <table>
	     <tr>
			<td> 
				<div id="sssss"></div>
				<ssi:stat key="sssss"/>		
		    </td>
		</tr>
	 </table>	
	<a href="${ctx}/govment/Govment/index.do" target="_blank">政府首页</a>
	<a href="${ctx}/govment/Govment/rmtjjdxy_index.do" target="_blank">首页</a>

</pre>
			
				<!-- UI Structure End "表单录入" -->
			</div>
		</div>
		<!-- UIStructureEnd "滚动内容区域" -->
	</div>
</body>
</html>
