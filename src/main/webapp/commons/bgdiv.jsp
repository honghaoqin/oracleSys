<%@ page contentType="text/html;charset=UTF-8"%>
<link type="text/css" href="${ctx}/css/BgDiv.css" rel="stylesheet">
<script type="text/javascript">
//定时器
var se, m = 0, h = 0, s = 0;
function second() {
    if (s > 0 && (s % 60) == 0) { m += 1; s = 0; }
    if (m > 0 && (m % 60) == 0) { h += 1; m = 0; }
    t = (h <= 9 ? "0" + h : h) + ":" + (m <= 9 ? "0" + m : m) + ":" + (s <= 9 ? "0" + s : s);
    document.getElementById("nowtime").innerHTML = t;
    s += 1;
}

function showdiv() {
	 $("#BgDiv").css({ display: "block", height: $(document).height() });
	          var yscroll = document.documentElement.scrollTop;
	          $("#DialogDiv").css("top", "200px").css("display", "block").css("width","250px");
	          //$("#DialogDiv").css("display", "block");
	 document.documentElement.scrollTop = 0;    
	 se = setInterval("second()", 1000);
}
</script>
<div id="BgDiv"></div>
<div id="DialogDiv" style='display: none'>
	<div class="formdiv">
		<div><img src="${ctx}/images/waiting.gif" style="float:left"/><div style="float:left">数据处理中，请稍候...</div><div id="nowtime" style="float:left"></div></div>
	</div>
</div>