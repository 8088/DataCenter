package com.tudou.datacenter.map 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import flash.utils.Timer;
	/**
	 * LocalTime
	 * 
	 * @author 8088
	 */
	public class LocalTime extends Sprite
	{
		
		public function LocalTime() 
		{
			var nbmd:NumBmd = new NumBmd();
			
			hour1 = new NumBmp(nbmd);
			hour2 = new NumBmp(nbmd);
			hour2.x = hour1.width;
			
			var dot:DotBmd = new DotBmd();
			dotBmp = new Bitmap(dot);
			dotBmp.x = hour2.width + hour2.x;
			
			minute1 = new NumBmp(nbmd);
			minute1.x = dotBmp.width + dotBmp.x;
			
			minute2 = new NumBmp(nbmd);
			minute2.x = minute1.width + minute1.x;
			
			addChild(hour1);
			addChild(hour2);
			addChild(dotBmp);
			addChild(minute1);
			addChild(minute2);
			
		}
		
		public function showTime():void
		{
			var now:Date = new Date();
			var h:int = now.getHours();
			var m:int = now.getMinutes();
			if (_cur_h != h)
			{
				var h1:int = h < 10 ? 0 : int(h / 10);
				var h2:int = h < 10 ? h : int(h % 10);
				hour1.num = h1;
				hour2.num = h2;
			}
			if (_cur_m != m)
			{
				var m1:int = m < 10 ? 0 : int(m / 10);
				var m2:int = m < 10 ? m : int(m % 10);
				minute1.num = m1;
				minute2.num = m2;
			}
			
			dotBmp.visible = !dotBmp.visible;
			
			_cur_h = h;
			_cur_m = m;
		}
		
		
		private var hour1:NumBmp;
		private var hour2:NumBmp;
		private var dotBmp:Bitmap;
		private var minute1:NumBmp;
		private var minute2:NumBmp;
		
		private var _cur_h:int = -1;
		private var _cur_m:int = -1;
		
	}

}