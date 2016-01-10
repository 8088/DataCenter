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
	public class NumTotal extends Sprite
	{
		private var nbmd:NumBmd;
		private var comma:Comma;
		private var ln:int;
		private var chars:Vector.<Bitmap>;
		private var nums:Vector.<NumBmp>;
		private var bg_nums_x:Vector.<Number>;
		private var max_ln:int;
		private var bg_alpha:Number;
		
		public function NumTotal(max:int = 8, color:uint = 0xFFFFFF, bgAlpha:Number=0.12)
		{
			this.nbmd = new NumBmd(color);
			this.comma = new Comma(color);
			max_ln = max;
			bg_alpha = bgAlpha;
			chars = new Vector.<Bitmap>();
			nums = new Vector.<NumBmp>();
			bg_nums_x = new Vector.<Number>();
			
			
			var bgChars:Vector.<Bitmap> = new Vector.<Bitmap>();
			var n:int = max_ln-1;
			for (var i:int = 0; i != max_ln; i++) {
				var nbmp:NumBmp = new NumBmp(this.nbmd);
				nbmp.num = 8;
				nbmp.alpha = bg_alpha;
				if (i > 0) {
					var bmd:Bitmap = bgChars[bgChars.length-1] as Bitmap;
					nbmp.x = bmd.x + bmd.width;
				}
				bgChars.push(nbmp);
				bg_nums_x.push(nbmp.x);
				addChild(nbmp);
				
				if (n!==0&&n % 3 == 0) {
					var cbmp:Bitmap = new Bitmap(this.comma);
					cbmp.x = nbmp.x + nbmp.width;
					cbmp.alpha = bg_alpha;
					bgChars.push(cbmp);
					addChild(cbmp);
				}
				n--;
			}
		}
		
		public function set numstr(t:String):void
		{
			if (t.length != ln) {
				if (t.length > max_ln) {
					var _tn:int = max_ln;
					t = "";
					while (_tn) {
						t += "9";
						_tn--;
					}
				}
				while (chars.length) {
					removeChild(chars[0]);
					chars.shift();
				}
				chars = new Vector.<Bitmap>();
				nums = new Vector.<NumBmp>();
				ln = t.length;
				var n:int = ln-1;
				for (var i:int = 0; i != ln; i++) {
					var num:int = int(t.charAt(i));
					var nbmp:NumBmp = new NumBmp(nbmd);
					nbmp.num = num;
					if (i > 0) {
						var bmp:Bitmap = chars[chars.length-1] as Bitmap;
						nbmp.x = bmp.x + bmp.width;
					}
					else {
						nbmp.x = bg_nums_x[max_ln - ln];
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
					var numbmp:NumBmp = nums[j] as NumBmp;
					if (numbmp) numbmp.num = k;
				}
			}
			
		}
		
	}

}