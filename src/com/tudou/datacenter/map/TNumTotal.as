package com.tudou.datacenter.map 
{
	import __AS3__.vec.Vector;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	/**
	 * ...
	 * @author 8088
	 */
	public class TNumTotal extends Sprite
	{
		private var nbmd:TNumBmd;
		private var comma:TComma;
		private var ln:int;
		private var chars:Vector.<Bitmap>;
		private var nums:Vector.<TNumBmp>;
		
		public function TNumTotal() 
		{
			nbmd = new TNumBmd();
			comma = new TComma();
			chars = new Vector.<Bitmap>();
			nums = new Vector.<TNumBmp>();
		}
		
		public function set numstr(t:String):void
		{
			if (t.length != ln) {
				while (numChildren) removeChildAt(0);
				chars = new Vector.<Bitmap>();
				nums = new Vector.<TNumBmp>();
				ln = t.length;
				var n:int = ln-1;
				for (var i:int = 0; i != ln; i++) {
					var num:int = int(t.charAt(i));
					var nbmp:TNumBmp = new TNumBmp(nbmd);
					nbmp.num = num;
					if (i > 0) {
						var bmd:Bitmap = chars[chars.length-1] as Bitmap;
						nbmp.x = bmd.x + bmd.width;
					}
					chars.push(nbmp);
					nums.push(nbmp);
					addChild(nbmp);
					
					if (n!==0&&n % 3 == 0) {
						var cbmp:Bitmap = new Bitmap(comma);
						cbmp.x = nbmp.x + nbmp.width;
						chars.push(cbmp);
						addChild(cbmp);
					}
					n--;
					
				}
			}
			else {
				for (var j:int = 0; j != ln; j++) {
					var k:int = int(t.charAt(j));
					var numbmp:TNumBmp = nums[j] as TNumBmp;
					if (numbmp) numbmp.num = k;
				}
			}
			
		}
		
	}

}