package com.tudou.datacenter.map 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	/**
	 * ...
	 * @author 8088
	 */
	public class TNumBmp extends Bitmap
	{
		private var numBmd:TNumBmd;
		private var num_w:int = 32;
		private var num_h:int = 50;
		private var copy_point:Point;
		private var copy_rct:Rectangle;
		private var _n:int;
		public function TNumBmp(numbmd:TNumBmd)
		{
			numBmd = numbmd;
			var bmd:BitmapData = new BitmapData(num_w, num_h);
			copy_point = new Point(0, 0);
			copy_rct = new Rectangle(0, 0, num_w, num_h);
			bmd.copyPixels(numBmd, copy_rct, copy_point);
			super(bmd);
		}
		
		public function set num(n:int):void
		{
			if (_n == n) return;
			_n = n;
			if (_n > 9) _n = 0;
			copy_rct.y = _n * num_h;
			bitmapData.copyPixels(numBmd, copy_rct, copy_point);
		}
	}

}