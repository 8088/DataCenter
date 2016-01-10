package com.tudou.datacenter.map 
{
	import __AS3__.vec.Vector;
	import com.tudou.bmp.BitmapFrameInfo;
	import com.tudou.bmp.BitmapSprite;
	/**
	 * 地图
	 * 
	 * @author 8088
	 */
	public class MapSprite extends BitmapSprite
	{
		
		public function MapSprite(frameInfo:Vector.<BitmapFrameInfo> = null) 
		{
			this.mouseChildren = false;
			this.mouseEnabled = false;
			this.tabChildren = false;
			this.tabEnabled = false;
			
			super(frameInfo);
		}
		
	}

}