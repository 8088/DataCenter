package com.tudou.datacenter.util
{
	public class StringUtil
	{
		
		public static function getLeft(str:String, pos:String) : String{
			if(isTrimEmpty(str)){
				return null;
			}
			var idx:int = str.indexOf(pos);
			if(idx != -1){
				return str.substr(0, idx);
			}
			return null;
		}
		
		public static function getRight(str:String, pos:String) : String{
			if(isTrimEmpty(str)){
				return null;
			}
			var idx:int = str.lastIndexOf(pos);
			if(idx != -1){
				return str.substr(pos.length + idx);
			}
			return null;
		}
		
		public static function getRightOutter(str:String, pos:String) : String{
			if(isTrimEmpty(str)){
				return null;
			}
			var idx:int = str.indexOf(pos);
			if(idx != -1){
				return str.substr(pos.length + idx);
			}
			return null;
		}
		
		public static function isTrimEmpty(str:String):Boolean{
			return str == null || str.replace(/^\s*|\s*$/g, "").split(" ").join("").length == 0;
		}
		
		public static function trim(str:String) : String{
			return str.replace(/^\s*|\s*$/g, "").split(" ").join("");
		}
	}
}