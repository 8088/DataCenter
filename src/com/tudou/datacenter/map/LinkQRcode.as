package com.tudou.datacenter.map 
{
	import com.tudou.utils.Tween;
	import com.tudou.qrcode.QRCode;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	/**
	 * ...
	 * @author 8088
	 */
	public class LinkQRcode extends Sprite
	{
		
		private var _link:String = "http://www.tudou.com";
		private var tween:Tween;
		private var bmp:Bitmap;
		private var qrCode:QRCode;
		
		public function LinkQRcode() 
		{
			this.mouseChildren = false;
			this.mouseEnabled = false;
			this.tabChildren = false;
			this.tabEnabled = false;
			
			var bmd:BitmapData = new BitmapData(110, 110, true, 0);
			
			qrCode = new QRCode();
            qrCode.encode(_link);
			
			bmp = new Bitmap(qrCode.bitmapData);
			bmp.alpha = 0;
			bmp.width = bmp.height = 110;
			addChild(bmp);
			
			tween = new Tween(bmp);
		}
		
		public function set url(str:String):void
		{
			_link = str;
			if (_link&&_link.length>10) {
				qrCode.encode(_link);
				bmp.bitmapData = qrCode.bitmapData;
				tween.delay(1000).to( { alpha:1 }, 600);
			}
			else {
				tween.to( { alpha:0 }, 400);
			}
		}
		
	}

}