
function gotoHistory(ctx){
	location=ctx+"/sys/Menu/index.do?formMap.PARENT_ID=B_HOSPITAL&formMap.firstChildId=HOSPITAL&0.26051286405246366";
}


function openDialog(url,windowwidth,windowheight){
window.showModalDialog(url,obj,'dialogHeight:'+windowheight+'px;dialogWidth:'+windowwidth+'px;status:no;');
}
function openwindow(url,windowwidth,windowheight){
	var screenwidth = screen.width;// or availWidth 
	var screenheight = screen.height;// or availHeight
	var left = (screenwidth-windowwidth)/2; 
	var top = (screenheight-windowheight)/2;
	window.open(url,'','top='+top+',left='+left+',height='+windowheight+',width='+windowwidth+',status=yes,toolbar=no,resizable=yes,menubar=no,location=no,scrollbars=yes');
}
/**
 * 医院接口
 *FATHER 医院的id对象值
 *FATHER_NAME医院名称的id对象值
 *radio 不为空(或不为空字符)时单选 为空时多选
 *INSURE 是否是投保设置
 */
function selectHospital(FATHER,FATHER_NAME,radio,INSURE){
	var ids = $("#"+FATHER).val();
	
	var times = new Date().getTime();
	var params="&rd="+times;
	if(INSURE!=null && $.trim(INSURE)!=""){
		params+="&formMap.INSURE=1";//设置投保的信息
	}
	var url = application_path+"/base/Hospital/select.do?formMap.ids="+ids+"&formMap.showName="+FATHER_NAME+"&formMap.showId="+FATHER+"&formMap.radio="+radio+params;
	openwindow(url,1200,500);
	return false;
}
/**
 * 医院接口
 *FATHER 医院的id对象值
 *FATHER_NAME医院名称的id对象值
 *radio 不为空(或不为空字符)时单选 为空时多选
 *INSURE 是否是投保设置
 */
function selectHos(FATHER,FATHER_NAME,radio,INSURE){
	var ids = $("#"+FATHER).val();
	
	var times = new Date().getTime();
	var params="&rd="+times;
	if(INSURE!=null && $.trim(INSURE)!=""){
		params+="&formMap.INSURE=1";//设置投保的信息
	}
	var url = application_path+"/base/Hospital/selectHos.do?formMap.ids="+ids+"&formMap.showName="+FATHER_NAME+"&formMap.showId="+FATHER+"&formMap.radio="+radio+params;
	openwindow(url,800,400);
	return false;
}
/**
 * 医调委接口
 *FATHER 医院的id对象值
 *FATHER_NAME医院名称的id对象值
 *radio 不为空(或不为空字符)时单选 为空时多选
 *json 不为空表示 自己回调函数设置返回值 
 */
function selectCommittee(FATHER,FATHER_NAME,radio,json){
	var ids = $("#"+FATHER).val();
	var params = "";
	if(json!=null && json!=''){
		params+="&formMap.json="+json;
	}
	var url = application_path+"/base/Committee/select.do?formMap.ids="+ids+"&formMap.showName="+FATHER_NAME+"&formMap.showId="+FATHER+"&formMap.radio="+radio;
	openwindow(url,1200,500);
	return false;
}
/**
 * type type为数字的时候设置为formMap.type的直接参数 不是数字的时候为id的名字
 * radio 不为空(或不为空字符)时单选 为空时多选
 * rid 0或1时不返回id与name返回多个信息  0为配置调解员或数据员时设置返回数据 1时为书记员或调解员介入时用    5 返回id和name
 * FATHER 选择后返回的id对象
 * FATHER_NAME 选择后返回的 name的对象
 * */
function selectCommissioner(type,radio,rid,FATHER,FATHER_NAME){
	var typevalue =  /^\d+$/;
	if(!typevalue.test(type)){//不是数字
		type = $("#"+type).val();
	}
	var params = "";
	if(rid=="1"){
		params+="&formMap.showId="+FATHER+"&formMap.showName="+FATHER_NAME+"&formMap.ids="+$("#"+FATHER).val();
	}else{//默认已经选择的
		if($.trim(FATHER)!="" && $("#"+FATHER).val()!="undefined")
		  params+="&formMap.ids="+$("#"+FATHER).val();
	}
	var url = application_path+"/base/Commissioner/select.do?formMap.TYPE="+type+"&formMap.radio="+radio+"&formMap.rid="+rid+params;
	openwindow(url,1200,500);
	return false;
}
//checkbox单选
function selectRadio(obj){
	if(obj.checked){
		$("input[class='IDS']:checked").each(function(i){
			var newobj=$(this);
		    if(newobj.val()!=obj.value){
		    	newobj.attr("checked",false);
		    }
		});
	}
}
/**
医学专家接口
radio 为空或空字符为多选 不为空为单选
id为选择的id的对象 作为参数
 */
function selectMedExpert(radio,id){
	var params="";
	if(id!=null && id!=""){
		params+="&formMap.ids="+$("#"+id).val();
	}
	var url = application_path+"/base/Medicalexperts/select.do?formMap.radio="+radio+params;
	openwindow(url,1200,500);
	return false;
}
/**
法律专家接口
radio 为空或空字符为多选 不为空为单选
id为选择的id的对象 作为参数
 */
function selectLawExpert(radio,id){
	var params="";
	if(id!=null && id!=""){
		params+="&formMap.ids="+$("#"+id).val();
	}
	var url = application_path+"/base/Legalexperts/select.do?formMap.radio="+radio+params;
	openwindow(url,1200,500);
	return false;
}
/**
 * 案管中心接口
 *radio 不为空(或不为空字符)时单选 为空时多选
 *返回值格式：[{CASECENTER_ID:'1000',NAME:'张三'},{CASECENTER_ID:'2000',NAME:'李四'}],其它字段以此类推
 */
function selectCaseceneter(radio){
	 var url = application_path+"/base/Casecenter/select.do?formMap.radio="+radio;
	 var answer = window.showModalDialog(url,null, 
                       "dialogWidth:1200px; dialogHeight:600px; center:yes; status:no; help:no;");
	 if (answer!='')
		 return answer;
   return false;
}
/**
案管中心人员接口
radio 为空或空字符为多选 不为空为单选
id为选择的id的对象 作为参数
 */
function selectCasePerson(radio,id){
	var params="";
	if(id!=""){
		params+="&formMap.ids="+$("#"+id).val();
	}
	var url = application_path+"/base/Caseperson/select.do?formMap.radio="+radio+params;
	openwindow(url,1200,500);
	return false;
}
/**科室接口
 * radio为空或空字符时多选 不为空时单选
*/
function selectDept(radio,id){
	var params="";
	if(id!=""){
		params+="&formMap.ids="+$("#"+id).val();
	}
	var url = application_path+"/base/Department/select.do?formMap.radio="+radio+params;
	openwindow(url,1200,500);
	return false;
}
/**
 * 保单接口
 *FATHER 返回的id 可填
 *FATHER_NAME返回的name 可填
 *radio 不为空(或不为空字符)时单选 为空时多选
 *selectName 是否查询名字 
 */
function selectInsure(FATHER,FATHER_NAME,radio){
	var ids = (FATHER!=null && FATHER!="")?$("#"+FATHER).val():"";
	var times = new Date().getTime();
	var params="&"+times;
	var url = application_path+"/base/Insure/select.do?formMap.ids="+ids+"&formMap.showName="+FATHER_NAME+"&formMap.showId="+FATHER+"&formMap.radio="+radio+params;
	openwindow(url,1200,500);
	return false;
}
function selectJdgz(FATHER,Hrid,radio){
	var ids = (FATHER!=null && FATHER!="")?$("#"+FATHER).val():"";
	var rid = (Hrid!=null && Hrid!="")?$("#"+Hrid).val():"";
	var times = new Date().getTime();
	var params="&"+times;
	var url = application_path+"/hospital/Jdandgz/select.do?formMap.ids="+ids+"&formMap.HREPORT_ID="+rid+"&formMap.showId="+FATHER+"&formMap.radio="+radio+params;
	openwindow(url,1200,500);
	return false;
}
function selectUser(FATHER,FATHER_NAME,radio){
	var ids = (FATHER!=null && FATHER!="")?$("#"+FATHER).val():"";
	var times = new Date().getTime();
	var params="&"+times;
	var url = application_path+"/sys/User/select.do?formMap.ids="+ids+"&formMap.showName="+FATHER_NAME+"&formMap.showId="+FATHER+"&formMap.radio="+radio+params;
	openwindow(url,1000,500);
	return false;
}
/**
 * 
 * @param table 表名 
 * @param talbe_id 表主键id
 * @param username 职务(获取某个职务类型的用户)
 * @returns {Boolean}
 */
function toApprove(table,talbe_id,username,status){
	var times = new Date().getTime();
	var params="&"+times;
	if(status!=null && status!=""){
		params+="&formMap.LC_STATUS="+status;
	}
	var url = application_path+"/sys/ActApprove/approve.do?formMap.TABLENAME="+table+"&formMap.TABLE_ID="+talbe_id+"&formMap.NAME="+username+params;
	openwindow(url,500,300);
	return false;
}
/**
 * 
 * @param table
 * @param talbe_id
 * @param username
 * @param status 
 * @param u 是否需要下拉选择用户
 * @returns {Boolean}
 */
function leadApprove(table,talbe_id,username,status,u,num){
	var times = new Date().getTime();
	var params="&"+times;
	if(status!=null && status!=""){
		params+="&formMap.LC_STATUS="+status;
	}
	if(u!=null && u!=""){
		params+="&formMap.U="+u;
	}
	if(num!=null && num!=""){
		params+="&formMap.num="+num;
	}
	var url = application_path+"/sys/ActApprove/leadApprove.do?formMap.TABLENAME="+table+"&formMap.TABLE_ID="+talbe_id+"&formMap.NAME="+username+params;
	openwindow(url,500,300);
	return false;
}
function zbApprove(table,talbe_id,username,status,u,num){
	var times = new Date().getTime();
	var params="&"+times;
	if(status!=null && status!=""){
		params+="&formMap.LC_STATUS="+status;
	}
	if(u!=null && u!=""){
		params+="&formMap.U="+u;
	}
	if(num!=null && num!=""){
		params+="&formMap.num="+num;
	}
	var url = application_path+"/sys/ActApprove/zbApprove.do?formMap.TABLENAME="+table+"&formMap.TABLE_ID="+talbe_id+"&formMap.NAME="+username+params;
	openwindow(url,500,300);
	return false;
}
function zbBack(table,talbe_id,username,status,u,num){
	var times = new Date().getTime();
	var params="&"+times;
	if(status!=null && status!=""){
		params+="&formMap.LC_STATUS="+status;
	}
	if(u!=null && u!=""){
		params+="&formMap.U="+u;
	}
	if(num!=null && num!=""){
		params+="&formMap.num="+num;
	}
	var url = application_path+"/sys/ActApprove/zbBack.do?formMap.TABLENAME="+table+"&formMap.TABLE_ID="+talbe_id+"&formMap.NAME="+username+params;
	openwindow(url,500,300);
	return false;
}
/**
 * 
 * @param table
 * @param talbe_id
 * @param username
 * @param status
 * @returns {Boolean}
 */
function toApprove2(table,talbe_id,username,status){
	var times = new Date().getTime();
	var params="&formMap.num==2&"+times;
	if(status!=null && status!=""){
		params+="&formMap.LC_STATUS="+status;
	}
	var url = application_path+"/sys/ActApprove/approve.do?formMap.TABLENAME="+table+"&formMap.TABLE_ID="+talbe_id+"&formMap.NAME="+username+params;
	openwindow(url,500,300);
	return false;
}
/**
 * 转交
 * @param table
 * @param talbe_id
 * @param username
 * @param status
 * @returns {Boolean}
 */
function zjApp(table,talbe_id,username,status,u){
	var times = new Date().getTime();
	var params="&formMap.num==2&"+times;
	if(status!=null && status!=""){
		params+="&formMap.LC_STATUS="+status;
	}
	if(u!=null && u!=""){
		params+="&formMap.U="+u;
	}
	var url = application_path+"/sys/ActApprove/zjApprove.do?formMap.TABLENAME="+table+"&formMap.TABLE_ID="+talbe_id+"&formMap.NAME="+username+params;
	openwindow(url,500,300);
	return false;
}
function zqApp(table,talbe_id,username,status){
	var times = new Date().getTime();
	var params="&"+times;
	if(status!=null && status!=""){
		params+="&formMap.LC_STATUS="+status;
	}
	var url = application_path+"/sys/ActApprove/zqApprove.do?formMap.TABLENAME="+table+"&formMap.TABLE_ID="+talbe_id+"&formMap.NAME="+username+params;
	openwindow(url,500,300);
	return false;
}
function newzb(table,talbe_id,username,status){
	var times = new Date().getTime();
	var params="&"+times;
	if(status!=null && status!=""){
		params+="&formMap.LC_STATUS="+status;
	}
	var url = application_path+"/sys/ActApprove/newZb.do?formMap.TABLENAME="+table+"&formMap.TABLE_ID="+talbe_id+"&formMap.NAME="+username+params;
	openwindow(url,500,300);
	return false;
}