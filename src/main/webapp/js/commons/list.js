    function checkSelected(mutil,className){
		if(mutil==null){
			mutil = false;
		}
		var checkedSizes = $("input[class='"+className+"']:checked").length;
		if(checkedSizes==0){
			if(mutil){
				alert("请选择一条或多条记录");
			}else{
				alert("请选择一条记录");
			}
			return false;
		}else if(!mutil && checkedSizes>1){
			alert("请选择一条记录");
			return false;
		}
		return true;
	}
	function selectAll(c,className){
		$("."+className).attr("checked",c);
	}
  function checkSelected(mutil){
		if(mutil==null){
			mutil = false;
		}
		var checkedSizes = $("input[class='IDS']:checked").length;
		if(checkedSizes==0){
			if(mutil){
				alert("请选择一条或多条记录");
			}else{
				alert("请选择一条记录");
			}
			return false;
		}else if(!mutil && checkedSizes>1){
			alert("请选择一条记录");
			return false;
		}
		return true;
	}
	function selectAll(c){
		$(".IDS").attr("checked",c);
	}
	
	function doGotoPage(ctx){
		gotoList(ctx);
	}
	function loading(ctx,id){
		$("#"+id).html("<img alt='数据加载中' src='"+ctx+"/images/loading.gif'>数据加载中...");
	}

	function gotoList(ctx) {
		$("#listForm").submit();
	}
	