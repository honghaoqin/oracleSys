//从一个select选择到另一个select
//参数：源select的id，目的select的id，是否删除源的选项（默认是），是否将选项添加到目的（默认是），是否允许重复添加相同选项（默认不允许），是否移动全部（默认不是）。
function selectTo(fromId,toId,bRemove,bAdd,bDblAdd,bAll){
	if(!fromId || !toId || fromId=="" || toId=="")return;
	if(bRemove == null || bRemove == "")bRemove = true;
	if(bAdd == null || bAdd == "")bAdd = true;
	if(bDblAdd == null || bDblAdd == "" || !bAdd)bDblAdd = false;
	if(bAll == null || bAll == "")bAll = false;
//	if(!bAdd)bDblAdd = false;
	var oFrom = document.getElementById(fromId);
	var oTo = document.getElementById(toId);
	if(oFrom.selectedIndex == -1 && !bAll)return;
	var iLen = oFrom.length;
	for(j=iLen-1;j>-1;j--){
		if(!oFrom.options(j).selected && !bAll)continue;
		var oOption = document.createElement("option");
		oOption.text = oFrom.options(j).text;
		oOption.value = oFrom.options(j).value;
		if(bRemove)oFrom.remove(j);
		if(!bDblAdd){
			var bExist = false;
			for(i=0;i<oTo.length;i++){
				if(oTo.options(i).text == oOption.text && oTo.options(i).value == oOption.value){
					bExist = true;
					break;
				}
			}
			if(bExist)continue;
		}
		if(bAdd)oTo.add(oOption);
	}
	if(bRemove)oFrom.selectedIndex = oFrom.length-1;
}

//下拉数据对象
function selectGroup(canRemove){
	this.selects = [];
	this.canRemove = canRemove;		//参数：是否允许根据选择动态更新数据，如果是，则reAddOptions和removeOptions函数有效
}
selectGroup.prototype.add = function(sValue){
	var oDS = new dicSelect(sValue);
	this.selects[this.selects.length] = oDS;
	return oDS;
}
selectGroup.prototype.getDS = function(sValue,sText){
	if(!sValue || sValue=="" || !sText || sText=="")return;
	var oSel,oDic;
	for(k=0;k<this.selects.length;k++){
		oSel = this.selects[k];
		for(j=0;j<oSel.dic.length;j++){
			if(oSel.dic[j].key == sValue && oSel.dic[j].text == sText)
				return oSel;
		}
	}
	return false;
}
//从select中获取option添加
selectGroup.prototype.reAddOptions = function(sSelId){
//	if(!this.canRemove)return;
	if(!sSelId || sSelId=="")return;
	var oDS;
	var oSel = document.getElementById(sSelId);
	for(i=0;i<oSel.length;i++){
		if(oSel.options(i).selected){
			oDS = this.getDS(oSel.options(i).value,oSel.options(i).text);
			if(oDS){
				oDS.readd(oSel.options(i).value);
			}
		}
	}
}
//删除一个select中选择的选项
selectGroup.prototype.removeOptions = function(sValue,sSelId){
//	if(!this.canRemove)return;
	if(!sValue || sValue=="" || !sSelId || sSelId=="")return;
	var oDS;
	for(i=0;i<this.selects.length;i++){
		if(this.selects[i].value == sValue){
			oDS = this.selects[i];
			break;
		}
	}
	if(!oDS)return;
	var oSel = document.getElementById(sSelId);
	for(i=0;i<oSel.length;i++){
		if(oSel.options(i).selected)
			oDS.remove(oSel.options(i).value);
	}
}
//选择一个select，改变另一个select的option
selectGroup.prototype.changeOptions = function(sValue,sSelId){
	if(!sValue || sValue=="" || !sSelId || sSelId=="")return;
	for(i=0;i<this.selects.length;i++){
		if(sValue == this.selects[i].value){
			var oSel = document.getElementById(sSelId),oOption;
			oSel.length = 0;
			var oDic = this.selects[i].dic;
			for (j=0;j<oDic.length;j++){
				if(oDic[j].removed)continue;
				oOption = document.createElement("option");
				oOption.value = oDic[j].key;
				oOption.text = oDic[j].text;
				oSel.add(oOption);
			}
			break;
		}
	}
}
//选项集合，对应一个select的所有选项
function dicSelect(value){
	this.value = value;
	this.dic = [];
}
dicSelect.prototype.add = function(key,text){
	this.dic[this.dic.length] = new dicOption(key,text);
}
dicSelect.prototype.remove = function(key){
	for(i=0;i<this.dic.length;i++){
		if(this.dic[i].key == key){
			this.dic[i].removed = true;
//			alert(this.dic[i].removed)
//			break;
			return true;
		}
	}
//	for(i=0;i<this.dic.length;i++){
//			alert(this.dic[i].removed)
//	}
	return false;
}
dicSelect.prototype.readd = function(key){
	for(k=0;k<this.dic.length;k++){
		if(this.dic[k].key == key){
			this.dic[k].removed = false;
			return true;
		}
	}
	return false;
}
dicSelect.prototype.exist = function(key){
	for(i=0;i<this.dic.length;i++){
		if(this.dic[i].key == key){
			return true;
		}
	}
	return false;
}
//选项
function dicOption(key,text){
	this.key = key;
	this.text = text;
	this.removed = false;
}