package com.tudou.datacenter.util
{
	import flash.utils.Dictionary;
	/**
	 * 基于Dictionary的 Map 接口的实现。此实现提供(key->value)映射操作。
	 * 
	 * @author 8088
	 * @private
	 */
	public dynamic class HashMap
	{
		private var _length:int;
		private var content:Dictionary;
		private var queue:Array;
			
		public function HashMap(){
			_length = 0;
			content = new Dictionary();
			queue = [];
		}
		
		public function get length():int{
			return _length;
		}
		
		public function isEmpty():Boolean{
			return (_length==0);
		}
		
		/**
		 * 返回添加顺序的key列表
		 */
		public function keys():Array{
			return queue;
		}
		
		/**
		 * 对每个键调用f()处理函数
		 * @param f 调用的函数
		 */
		public function eachKey(f:Function):void{
			for(var i:* in content){
				f(i);
			}
		}
		
		/**
		 * 对每个值调用f()处理函数
		 * @param f 调用的函数
		 */ 	
		public function eachValue(f:Function):void{
			for each(var i:* in content){
				f(i);
			}
		}
		
		public function values():Array{
			var temp:Array = new Array(_length);
			var index:int = 0;
			
			for each(var i:* in content) {
				temp[index] = i;
				index ++;
			}
			return temp;
		}
		
		public function hasValue(value:*):Boolean{
			for each(var i:* in content){
				if(i === value){
					return true;
				}
			}
			return false;
		}
		
		public function hasKey(key:*):Boolean{
			if(content[key] != undefined){
				return true;
			}
			return false;
		}
		
		private function get(key:*):*{
			var value:* = content[key];
			if(value !== undefined){
				return value;
			}
			return null;
		}
		
		public function getValueByKey(key:*):*{
			return get(key);
		}
		
		/*
		 * 根据传递的(key->value)来操作字典
		 * 
		 */
		public function put(key:*, value:*):*{
			if(key == null){
				throw new ArgumentError("cannot put a value with undefined or null key!");
				return undefined;
			}else if(value == null){
				return remove(key);
			}else{
				var exist:Boolean = hasKey(key);
				if(!exist){
					_length++;
				}
				var oldValue:* = this.get(key);
				content[key] = value;
				queue[_length - 1] = key;
				return oldValue;
			}
		}
		
		public function remove(key:*):*{
			var exist:Boolean = hasKey(key);
			if(!exist){
				return null;
			}
			var temp:* = content[key];
			delete content[key];
			
			var index:int = queue.indexOf(key);
			if (index != -1)
			{
				var ary:Array = [];
				if(index + 1<_length) ary = queue.slice(index + 1);
				queue = queue.slice(0, index).concat(ary);
			}
			
			_length--;
			return temp;
		}
		
		public function clear():void{
			_length = 0;
			content = new Dictionary();
			queue = [];
		}
		
		public function clone():HashMap{
			var temp:HashMap = new HashMap();
			for(var i:* in content){
				temp.put(i, content[i]);
			}
			return temp;
		}
		
		public function toString():String{
			var ks:Array = keys();
			var vs:Array = values();
			var temp:String = "";
			var l:int = ks.length
			for(var i:int=0; i<l; i++){
				temp += ks[i]+":"+vs[i] + ";\n";
			}
			return temp;
		}		
	}
}