// ��ʾ/�������нű� by csd

function shLeft(obj) {
	var leftNavSite = document.getElementById("leftSite")
	if (leftNavSite.style.display == "none"){
		leftNavSite.style.display = "";
		obj.className = "toLeftBar";
	}
	else {
		leftNavSite.style.display = "none";
		obj.className = "toRightBar";
	}
		
	
}
