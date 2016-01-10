package  com.tudou.bmp 
{
	import __AS3__.vec.Vector;
	import flash.display.BitmapData;
	/**
	 * 位图帧信息
	 */
	public class BitmapFrameInfo
	{
		/**
		 * 存储位图帧信息序列
		 * @param	id
		 * @param	data
		 */
		static public function storeBitmapFrameInfoInfo(id:String, data:Vector.<BitmapFrameInfo>):void
		{
			map_data[id] = data;
		}
		
		
		/**
		 * 获取位图帧信息序列
		 * @param	id
		 * @return
		 */
		static public function getBitmapFrameInfoInfo(id:String):Vector.<BitmapFrameInfo>
		{
			return map_data[id];
		}
		
		public var x:Number;
		public var y:Number;
		
		public var bitmapData:BitmapData;
		
		private static const map_data:Object = { };
		
	}

}