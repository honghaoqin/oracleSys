//ʵ��map
	/**
		 var map = new Map();
		 map.put("re","redhacker");
		 map.put("do","douguoqiang");
		 map.put("gq","dougq");
		 alert("map�Ĵ�СΪ��" + map.size())
		 alert("keyΪre��map�д洢�Ķ���Ϊ��" + map.get("re"));
		 map.remove("re");
		 alert("�Ƴ�keyΪre�Ķ���󣬻�ȡkeyΪre��map�д洢�Ķ���Ϊ��" + map.get("re"));
		 alert("map�Ƴ�һ��Ԫ�غ�Ĵ�СΪ��" + map.size());
		 alert("map�Ƿ���һ����map:" + map.isEmpty());
	**/
	function Map() {
		 var struct = function(key, value) {
			  this.key = key;
			  this.value = value;
		 }
		 
		 var put = function(key, value){
			  for (var i = 0; i < this.arr.length; i++) {
				   if ( this.arr[i].key === key ) {
					this.arr[i].value = value;
					return;
				   }
			  }
			 this.arr[this.arr.length] = new struct(key, value);
		 }
		 
		 var get = function(key) {
			  for (var i = 0; i < this.arr.length; i++) {
				   if ( this.arr[i].key === key ) {
					 return this.arr[i].value;
				   }
			  }
		  return null;
		 }
		 
		 var remove = function(key) {
			 var v;
			 for (var i = 0; i < this.arr.length; i++) {
			   v = this.arr.pop();
			   if ( v.key === key ) {
				continue;
			   }
			   this.arr.unshift(v);
			 }
		 }
		 
		 var size = function() {
		  return this.arr.length;
		 }
		 
		 var isEmpty = function() {
		  return this.arr.length <= 0;
		 }
		 this.arr = new Array();
		 this.get = get;
		 this.put = put;
		 this.remove = remove;
		 this.size = size;
		 this.isEmpty = isEmpty;
	}