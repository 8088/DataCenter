package com.tudou.datacenter.map
{
	import com.tudou.datacenter.asset.CommaFont;
	import com.tudou.datacenter.asset.NumberFont;
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	import flash.text.AntiAliasType;
	import flash.text.Font;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	/**
	 * ...
	 * @author 8088
	 */
	public class TComma extends BitmapData
	{
		
		public function TComma()
		{
			super(10, 50, true, 0);
			
			var font:CommaFont = new CommaFont();
			Font.registerFont(CommaFont);
			
			var format:TextFormat = new TextFormat();
			format.font = font.fontName;
			format.color = 0xEEEEEE;
			format.align = TextFormatAlign.CENTER;
			format.size = 36;
			
			var txt:TextField = new TextField();
			txt.embedFonts = true;
			txt.antiAliasType = AntiAliasType.ADVANCED;
			txt.width = 20;
			txt.height = 60;
			txt.defaultTextFormat = format;
			txt.text = ",";
			
			this.draw(txt, new Matrix(1, 0, 0, 1, -5, 8), null, null, null, true);
			
			txt = null;
		}
	
	}

}