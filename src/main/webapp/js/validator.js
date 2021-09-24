/*************************************************
	Validator v1.05
	code by 我佛山人
	wfsr@msn.com
*************************************************/
 Validator = {
	Require : /.+/,
	Email : /^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/,
	Phone : /^((\(\d{3}\))|(\d{3}\-))?(\(0\d{2,3}\)|0\d{2,3}-)?[1-9]\d{6,7}([\-0-9]+)?[^\D]{1}$/,
	Mobile : /^1[358]{1}\d{9}$/,
	Url : /^http:\/\/[A-Za-z0-9]+\.[A-Za-z0-9]+[\/=\?%\-&_~`@[\]\':+!]*([^<>\"\"])*$/,
	IdCard : "this.IsIdCard(value)",
	Currency : /^\d+(\.\d+)?$/,
	Number : /^\d+$/,
	Fxzt : /^[1-2]*$/,
	Dygyw: /^[A-Za-z][A-Za-z0-9]*$/,
	NumEng: /^[_A-Za-z0-9]+$/,
	Month : /^0[1-9]|1[0-2]$/,
	Zip : /^[1-9]\d{5}$/,
	QQ : /^[1-9]\d{4,8}$/,
	Integer : /^[-\+]?\d+$/,
	Double : /^[-\+]?\d+(\.\d+)?$/,
	English : /^[A-Za-z]+$/,
	Chinese :  /^[\u0391-\uFFE5]+$/,
	Username : /^[a-z]\w{3,}$/i,
	UnSafe : /^(([A-Z]*|[a-z]*|\d*|[-_\~!@#\$%\^&\*\.\(\)\[\]\{\}<>\?\\\/\'\"]*)|.{0,5})$|\s/,
	IsSafe : function(str){return !this.UnSafe.test(str);},
	SafeString : "this.IsSafe(value)",
	Filter : "this.DoFilter(value, getAttribute('accept'))",
	Limit : "this.limit(value.length,getAttribute('min'),  getAttribute('max'))",
	LimitB : "this.limit(this.LenB(value), getAttribute('min'), getAttribute('max'))",
	Date : "this.IsDate(value, getAttribute('min'), getAttribute('format'))",
	Repeat : "value == document.getElementsByName(getAttribute('to'))[0].value",
	Range : "getAttribute('min') <= (value|0) && (value|0) <= getAttribute('max')",
	Min : "getAttribute('min') <= (value|0)",
	Max : "(value|0) <= getAttribute('max')",
	Compare : "this.compare(value,getAttribute('operator'),getAttribute('to') || document.getElementById(getAttribute('toId')).value)",
	Custom : "this.Exec(value, getAttribute('regexp'))",
	Group : "this.MustChecked(getAttribute('name'), getAttribute('min'), getAttribute('max'))",
	ErrorItem : [document.forms[0]],
	ErrorMessage : ["错误原因：\t\t\t\t"],
	
	validateEle : function(theEle,dataType_de,msg_de){ //验证单个元素, 调用方式:Validator.validateEle($("#file2")[0],"Require,Filter","上传文件不能为空,且必须是xls文档")
		if(theEle==null){
			return false;
		}
		with(theEle){
			var _dataTypes = "";
			var _msg = "";
			if(dataType_de && typeof(dataType_de) != "undefined" && dataType_de != null && dataType_de != ""){
				_dataTypes = dataType_de;
			}else{
				_dataTypes = getAttribute("dataType");
			}
			if(msg_de && typeof(msg_de) != "undefined" && msg_de != null && msg_de != ""){
				_msg = msg_de;
			}else{
				_msg = getAttribute("msg");
			}
			if(_dataTypes == null || _dataTypes=="")  return;
			var _dts = _dataTypes.split(",");
			if(_dts==null || _dts.length == 0){
				alert(_msg);
				return false;
			}
			loop:for(var dtsi = 0;dtsi<_dts.length; dtsi++){
				var _dataType = _dts[dtsi];
				if(_dataType == null || _dataType=="")  continue;
				if(_dataType!="Require" && value == "") continue;
				if(_dataType=="Require" && value.replace(/[ ]/g,'') == "") {
					style.backgroundColor="#FF7777";
					alert(_msg);
					return false;
				}
				this.ClearState(theEle);
				switch(_dataType){
					case "IdCard" :
					case "Date" :
					case "Repeat" :
					case "Range" :
					case "Min" :
					case "Max" :
					case "Compare" :
					case "Custom" :
					case "Group" : 
					case "Limit" :
					case "LimitB" :
					case "SafeString" :
					case "Filter" :
						if(!eval(this[_dataType]))	{
							style.backgroundColor="#FF7777";
							alert(_msg);
							return false;
							//break loop;
						}else{
							//$(theEle).qtip().destroy();
						}
						break;
					default :
						if(!this[_dataType].test(value)){
							style.backgroundColor="#FF7777";
							alert(_msg);
							return false;
//							break loop;
						}else{
							//$(theEle).qtip().destroy();
						}
						break;
				}
			
			}
		}
		return true;
	},
	Validate : function(theForm, mode){
		var obj = theForm || event.srcElement;
		var count = obj.elements.length;
		this.ErrorMessage.length = 1;
		this.ErrorItem.length = 1;
		this.ErrorItem[0] = obj;
		for(var i=0;i<count;i++){
			with(obj.elements[i]){
				var _dataTypes = getAttribute("dataType");
				if(_dataTypes == null || _dataTypes=="")  continue;
				var _dts = _dataTypes.split(",");
				if(_dts==null || _dts.length == 0){
					continue;
				}
				loop:for(var dtsi = 0;dtsi<_dts.length; dtsi++){
					var _dataType = _dts[dtsi];
					if(_dataType == null || _dataType=="")  continue;
					if(_dataType!="Require" && value == "") continue;
					
					this.ClearState(obj.elements[i]);
					switch(_dataType){
						case "IdCard" :
						case "Date" :
						case "Repeat" :
						case "Range" :
						case "Min" :
						case "Max" :
						case "Compare" :
						case "Custom" :
						case "Group" : 
						case "Limit" :
						case "LimitB" :
						case "SafeString" :
						case "Filter" :
							if(!eval(this[_dataType]))	{
								this.AddError(i, getAttribute("msg"));
								break loop;
							}
							break;
						default :
							if(!this[_dataType].test(value)){
								this.AddError(i, getAttribute("msg"));
								break loop;
							}
							break;
					}
				
				}
			}
		}
		if(this.ErrorMessage.length > 1){
			mode = mode || 2;
			var errCount = this.ErrorItem.length;
			switch(mode){
			case 2 :
				for(var i=1;i<errCount;i++){
					//this.ErrorItem[i].style.color = "red";
					this.ErrorItem[i].style.backgroundColor="#FF7777";
				}
			case 1 :
				alert(this.ErrorMessage.join("\n"));
				try{
					this.ErrorItem[1].focus();
				}catch (e) {
				}
				
				break;
			case 3 :
				for(var i=1;i<errCount;i++){
				try{
					var span = document.createElement("SPAN");
					span.id = "__ErrorMessagePanel";
					span.style.color = "red";
					this.ErrorItem[i].parentNode.appendChild(span);
					span.innerHTML = this.ErrorMessage[i].replace(/\d+:/,"*");
					}
					catch(e){alert(e.description);}
				}
				try{
					this.ErrorItem[1].focus();
				}catch (e) {
				}
				break;
			default :
				alert(this.ErrorMessage.join("\n"));
				break;
			}
			return false;
		}
		return true;
	},
	limit : function(len,min, max){
		min = min || 0;
		max = max || Number.MAX_VALUE;
		return min <= len && len <= max;
	},
	LenB : function(str){
		return str.replace(/[^\x00-\xff]/g,"**").length;
	},
	ClearState : function(elem){
		with(elem){
			var bg = ""+style.backgroundColor;
			if(bg.toUpperCase() == "#FF7777"){
				style.backgroundColor = "";
			}
			var lastNode = parentNode.childNodes[parentNode.childNodes.length-1];
			if(lastNode.id == "__ErrorMessagePanel")
				parentNode.removeChild(lastNode);
		}
	},
	AddError : function(index, str){
		this.ErrorItem[this.ErrorItem.length] = this.ErrorItem[0].elements[index];
		this.ErrorMessage[this.ErrorMessage.length] = this.ErrorMessage.length + ":" + str;
	},
	Exec : function(op, reg){
		return new RegExp(reg,"g").test(op);
	},
	compare : function(op1,operator,op2){
		switch (operator) {
			case "NotEqual":
				return (op1 != op2);
			case "GreaterThan":
				return (op1 > op2);
			case "GreaterThanEqual":
				return (op1 >= op2);
			case "LessThan":
				return (op1 < op2);
			case "LessThanEqual":
				return (op1 <= op2);
			default:
				return (op1 == op2);            
		}
	},
	MustChecked : function(name, min, max){
		var groups = document.getElementsByName(name);
		var hasChecked = 0;
		min = min || 1;
		max = max || groups.length;
		for(var i=groups.length-1;i>=0;i--)
			if(groups[i].checked) hasChecked++;
		return min <= hasChecked && hasChecked <= max;
	},
	DoFilter : function(input, filter){
return new RegExp("^.+\.(?=EXT)(EXT)$".replace(/EXT/g, filter.split(/\s*,\s*/).join("|")), "gi").test(input);
	},
	IsIdCard : function(sId){
		return /^\d{17}(\d|x)$/i.test(sId);
	},
	IsDate : function(op, formatString){
		formatString = formatString || "ymd";
		var m, year, month, day;
		switch(formatString){
			case "ymd" :
				m = op.match(new RegExp("^((\\d{4})|(\\d{2}))([-./])(\\d{1,2})\\4(\\d{1,2})$"));
				if(m == null ) return false;
				day = m[6];
				month = m[5]*1;
				year =  (m[2].length == 4) ? m[2] : GetFullYear(parseInt(m[3], 10));
				break;
			case "dmy" :
				m = op.match(new RegExp("^(\\d{1,2})([-./])(\\d{1,2})\\2((\\d{4})|(\\d{2}))$"));
				if(m == null ) return false;
				day = m[1];
				month = m[3]*1;
				year = (m[5].length == 4) ? m[5] : GetFullYear(parseInt(m[6], 10));
				break;
			default :
				break;
		}
		if(!parseInt(month)) return false;
		month = month==0 ?12:month;
		var date = new Date(year, month-1, day);
        return (typeof(date) == "object" && year == date.getFullYear() && month == (date.getMonth()+1) && day == date.getDate());
		function GetFullYear(y){return ((y<30 ? "20" : "19") + y)|0;}
	}
 }
