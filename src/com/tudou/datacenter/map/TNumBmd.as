package com.tudou.datacenter.map
{
	import com.tudou.datacenter.asset.NumberFont;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.text.AntiAliasType;
	import flash.text.Font;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	/**
	 * ...
	 * @author 8088
	 */
	public class TNumBmd extends BitmapData
	{
		
		public function TNumBmd()
		{
			super(32, 500, true, 0);
			
			var font:NumberFont = new NumberFont();
			Font.registerFont(NumberFont);
			
			var format:TextFormat = new TextFormat();
			format.font = font.fontName;
			format.color = 0xFFFFFF;
			format.align = TextFormatAlign.LEFT;
			format.size = 50;
			
			for (var i:int = 0; i != 10; i++) {
				var bmd:BitmapData = new BitmapData(32, 50, true, 0);
				var txt:TextField = new TextField();
				txt.embedFonts = true;
				txt.antiAliasType = AntiAliasType.ADVANCED;
				txt.width = 32;
				txt.height = 60;
				txt.defaultTextFormat = format;
				txt.text = i.toString();
				bmd.draw(txt, new Matrix(1, 0, 0, 1, -1, -6), null, null, null, true);
				this.copyPixels(bmd, new Rectangle(0, 0, bmd.width, bmd.height), new Point(0, i*50));
			}
			
			txt = null;
		}
	
	}

}