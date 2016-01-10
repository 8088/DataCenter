package com.tudou.datacenter.map 
{
	import __AS3__.vec.Vector;
	import com.tudou.bmp.BitmapFrameInfo;
	import com.tudou.bmp.BitmapMovie;
	import flash.display.Bitmap;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * 闪烁的星星动画
	 * @author 8088
	 */
	public class StarMovie extends BitmapMovie
	{
		
		public function StarMovie(frameInfo:Vector.<BitmapFrameInfo> = null) 
		{
			this.mouseChildren = false;
			this.mouseEnabled = false;
			this.tabChildren = false;
			this.tabEnabled = false;
			
			super(frameInfo);
		}
		
		override public function nextFrame():void
		{
			if (curIndex == maxIndex) dispose();
			else gotoFrame(curIndex + 1);
		}
		
		override protected function dispose():void
		{
			super.dispose();
			
			if (parent && parent is DisplayObjectContainer) {
				if (parent.contains(this)) parent.removeChild(this);
			}
			
		}
		
	}

}