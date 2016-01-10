package com.tudou.bmp 
{
	import __AS3__.vec.Vector;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * 位图缓存Sprite基类
	 */
	public class BitmapSprite extends Sprite
	{
		/**
		 * 根据位图帧信息序列构建位图Sprite
		 * 
		 * @param frameInfo 位图帧信息序列(只有1幀);
		 */
		public function BitmapSprite(frameInfo:Vector.<BitmapFrameInfo> = null):void
		{
			bitmap = new Bitmap();
			init();
			this.frameInfo = frameInfo;
			
			addEventListener(Event.ADDED_TO_STAGE, updatePlayStatus);
			addEventListener(Event.REMOVED_FROM_STAGE, updatePlayStatus);
		}
		
		protected function init():void
		{
			this.x = 0;
			this.y = 0;
			this.alpha = 1;
			this.rotation = 0;
			this.visible = true;
			this.scaleX = 1;
			this.scaleY = 1;
			
			addChild(bitmap);
		}
		
		protected function updatePlayStatus(evt:Event = null):void
		{
			if (stage != null&&v_frame != null)
			{
				var f_info:BitmapFrameInfo = v_frame[0];
				bitmap.bitmapData = f_info.bitmapData;
				bitmap.x = f_info.x;
				bitmap.y = f_info.y;
			}
		}
		
		/**
		 * 获取或设置位图是否启用平滑处理
		 */
		public function get smoothing():Boolean 
		{ 
			return bitmap.smoothing; 
		}
		
		public function set smoothing(value:Boolean):void
		{
			bitmap.smoothing = value;
		}
		
		/**
		 * 位图帧
		 */
		public function get frameInfo():Vector.<BitmapFrameInfo> 
		{ 
			return v_frame;  
		}
		
		/**
		 * 位图帧序列
		 */
		public function set frameInfo(value:Vector.<BitmapFrameInfo>):void
		{
			v_frame = value;
			bitmap.bitmapData = null;
			updatePlayStatus();
		}
		
		/**
		 * 回收
		 */
		public function recycle():void
		{
			dispose();
			init();
		}
		
		/**
		 * 销毁对象，释放资源
		 */
		protected function dispose():void
		{
			this.frameInfo = null;
			
			if(contains(bitmap))
			removeChild(bitmap);
		}
		
		protected var bitmap:Bitmap;
		protected var v_frame:Vector.<BitmapFrameInfo>;
		
	}

}