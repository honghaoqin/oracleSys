;(function($) {
	
$.fn.extend({
	jqautocomplete: function(urlOrData) {
		
		return this.each(function() {		
			$(this).autocomplete(urlOrData, {
				minChars: 0,
				max: 30,
				autoFill: true,
				mustMatch: true,
				matchContains: true,
				autoFill: true,
				width: 310,
				autoFill: false,
				
				//显示在下来列表的字符串
				formatItem: function(row, i, max) {
					//return row.code + "|" + row.detail +"|"+row.spell;
					return row.detail +"|"+row.spell;
				},
				/* 匹配的源字符串
				formatMatch: function(row, i, max) {
					return row.des;
				},
				*/
				/*
				//自动填充的值
				formatFill:function(row,v){
					return v+""+row.detail;
				},
				*/
				//选择后，显示在输入框的值
				formatResult: function(row) {
					return row.detail;
				}
			}).result(function(event, row, formatted){
				var valuefield= $("#"+this.id).attr("valuefield");
				if(valuefield==null || valuefield==""){
					alert("Error: Not found valuefield.");
					return;
				}
				if(row==null){
					$("#"+valuefield).val("");
				}else{
					$("#"+valuefield).val(row.code);//传到后台的值
				}
				//$(this).trigger("blur");
			});
			
		});
	}
});

})(jQuery);
