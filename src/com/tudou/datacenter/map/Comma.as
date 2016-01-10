package com.tudou.datacenter.map
{
	import com.tudou.datacenter.asset.TimeNum;
	import flash.display.BitmapData;
	import flash.filters.BlurFilter;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	
	/**
	 * ...
	 * @author 8088
	 */
	public class Comma extends BitmapData
	{
		
		public function Comma(color:uint=0xFFFFFF)
		{
			super(4, 18, true, 0);
			
			var num:TimeNum = new TimeNum();
			
			var red:int = int(((color & 0xFF0000) >> 16).toString(10));
			var green:int = int(((color & 0x00FF00) >> 8).toString(10));
			var blue:int = int((color & 0x0000FF).toString(10));
			
			var colorTransform:ColorTransform = new ColorTransform(1, 1, 1, 1, red-255, green-255, blue-255);
			
			this.draw(num, new Matrix(1, 0, 0, 1, -109, 0), colorTransform, null, null, true);
		}
	
	}

}