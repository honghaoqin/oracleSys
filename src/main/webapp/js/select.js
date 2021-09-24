//��һ��selectѡ����һ��select
//������Դselect��id��Ŀ��select��id���Ƿ�ɾ��Դ��ѡ�Ĭ���ǣ����Ƿ�ѡ����ӵ�Ŀ�ģ�Ĭ���ǣ����Ƿ������ظ������ͬѡ�Ĭ�ϲ��������Ƿ��ƶ�ȫ����Ĭ�ϲ��ǣ���
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

//�������ݶ���
function selectGroup(canRemove){
	this.selects = [];
	this.canRemove = canRemove;		//�������Ƿ��������ѡ��̬�������ݣ�����ǣ���reAddOptions��removeOptions������Ч
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
//��select�л�ȡoption���
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
//ɾ��һ��select��ѡ���ѡ��
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
//ѡ��һ��select���ı���һ��select��option
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
//ѡ��ϣ���Ӧһ��select������ѡ��
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
//ѡ��
function dicOption(key,text){
	this.key = key;
	this.text = text;
	this.removed = false;
}