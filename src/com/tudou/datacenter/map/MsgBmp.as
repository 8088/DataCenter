package com.tudou.datacenter.map 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	/**
	 * ...
	 * @author 8088
	 */
	public class MsgBmp extends Bitmap
	{
		private var _pre:MsgBmp;
		private var _next:MsgBmp;
		private var _id:String;
		private var _star:int;
		
		public function MsgBmp(bitmapData:BitmapData = null, pixelSnapping:String = "auto", smoothing:Boolean = false):void
		{
			super(bitmapData, pixelSnapping, smoothing);	
		}
		
		public function get id():String
		{
			return _id;
		}
		
		public function set id(str:String):void
		{
			_id = str;
		}
		
		public function get pre():MsgBmp
		{
			return _pre;
		}
		
		public function set pre(m:MsgBmp):void
		{
			_pre = m;
		}
		
		public function get next():MsgBmp
		{
			return _next;
		}
		
		public function set next(m:MsgBmp):void
		{
			_next = m;
		}
	}

}