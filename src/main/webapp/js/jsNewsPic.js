function getid(obj)//取对应id的元素
{
	return document.getElementById(obj);
}

function getNames(obj,name,tij)//取obj元素下标签为tij的元素并要求满足name属性=name;返回一个数组
{	
	var p = getid(obj);
	var plist = p.getElementsByTagName(tij);
	var rlist = new Array();
	for(i=0;i<plist.length;i++)
	{
		if(plist[i].getAttribute("name") == name)
		{
			rlist[rlist.length] = plist[i];
		}
	}
	return rlist;
}

function ri(obj)//取得对应的小图列表中当前元素对应的序号
{
	var p = getid("simg").getElementsByTagName("td");
	for(i=0;i<p.length;i++)
	{
		if(obj == p[i])
		{
			return i;
		}
	}
}

function ci(obj)//小图选择框的处理函数
{
	var p = getid("simg").getElementsByTagName("td");
	for(i=0;i<p.length;i++)
	{
		if(obj ==p[i])
		{
			p[i].className = "s";
		}
		else
		{
			p[i].className = "";
		}
	}
}
function fiterplay(obj,num,t,name)//类似页卡的函数.设置对应内容的隐藏和显示 obj:元素的id  name:元素对应的name属性的值, t:对应内容的标签 num:当前选择的元素的序号
{
	var fitlist = getNames(obj,name,t);
	for(i=0;i<fitlist.length;i++)
	{

		if(i == num)
		{
			fitlist[i].className = "dis";
		}
		else
		{
			fitlist[i].className = "undis";
		}
	}
}
	  
		
function play(obj,n1,n2)//播放的函数
{
	var p = obj.parentNode.getElementsByTagName("td");
	var bimg = getid(n1);
	var infos = getid(n2);
	var num = ri(obj);
	try	//ie下的处理部分
	{
		with(bimg)
		{
			filters[0].Apply();	//接收滤镜
			ci(obj); //变幻小图的选择.可以放在try以外.
			fiterplay(n1,num,"div","f");//设置滤镜中对应部分的显示和隐藏
			filters[0].play();	//播放滤镜
			//alert(p[0].innerHTML)
		}
	with(infos)
		{
			filters[0].Apply();	//接收滤镜
			ci(obj); //变幻小图的选择.可以放在try以外.
			fiterplay(n2,num,"div","f");//设置滤镜中对应部分的显示和隐藏
			filters[0].play();	//播放滤镜
		}
	}
	catch(e)//ff下的处理部分
	{
			ci(obj);
			fiterplay(n1,num,"div","f");
			fiterplay(n2,num,"div","f");
	}
}
var n=0;
function clearAuto() {clearInterval(autoStart);};
function setAuto(){autoStart=setInterval("auto(n)", 4000)}
function auto()
{
	var x = getid("simg").getElementsByTagName("td");
	n++;
	if(n>x.length-1)n=0;
	play(x[n],"bimg","infos");
} 

 setAuto();