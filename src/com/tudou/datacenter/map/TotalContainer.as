package com.tudou.datacenter.map 
{
	import com.tudou.datacenter.asset.MapTitle;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	/**
	 * 实时 指标总数
	 * 
	 * @author 8088
	 */
	public class TotalContainer extends Sprite
	{
		private var dayTotal:NumTotal;
		private var total1:NumTotal;
		private var total2:NumTotal;
		private var total3:NumTotal;
		private var localTime:LocalTime;
		private var pubTime:String = "2013-12-26";
		
		public function TotalContainer()
		{
			this.graphics.beginFill(0, .16);
			this.graphics.drawRoundRect(0, 0, 200, 110, 5, 5);
			this.graphics.endFill();
			
			var format:TextFormat = new TextFormat();
			format.font = "Arial";
			format.color = 0xCCCCCC;
			format.align = TextFormatAlign.LEFT;
			format.size = 12;
			
			var timeTxt:TextField = new TextField();
			timeTxt.height = 20;
			timeTxt.width = 100;
			timeTxt.x = 10;
			timeTxt.y = 13;
			timeTxt.defaultTextFormat = format;
			timeTxt.text = "产品运行";
			addChild(timeTxt);
			
			dayTotal = new NumTotal(4);
			dayTotal.numstr = getDays(pubTime);
			dayTotal.x = 66;
			dayTotal.y = 15;
			addChild(dayTotal);
			
			var tTxt:TextField = new TextField();
			tTxt.height = 20;
			tTxt.width = 20;
			tTxt.x = 115;
			tTxt.y = 15;
			tTxt.defaultTextFormat = format;
			tTxt.text = "天";
			addChild(tTxt);
			
			localTime = new LocalTime();
			localTime.x = 138;
			localTime.y = 15;
			addChild(localTime);
			
			
			var txt1:TextField = new TextField();
			txt1.height = 20;
			txt1.width = 100;
			txt1.x = 10;
			txt1.y = 48;
			txt1.defaultTextFormat = format;
			txt1.text = "用户访问";
			addChild(txt1);
			
			total1 = new NumTotal();
			total1.numstr = "0";
			total1.x = 93;
			total1.y = 50;
			addChild(total1);
			
			var txt2:TextField = new TextField();
			txt2.defaultTextFormat = format;
			txt2.height = 20;
			txt2.width = 100;
			txt2.x = 10;
			txt2.y = 79;
			txt2.text = "频道浏览";
			addChild(txt2);
			
			total2 = new NumTotal();
			total2.numstr = "0";
			total2.x = 93;
			total2.y = 82;
			addChild(total2);
			
			//订阅
			var bg:Shape = new Shape();
			bg.y = 114;
			bg.graphics.beginFill(0, .95);
			bg.graphics.drawRoundRect(0, 0, 200, 40, 5, 5);
			bg.graphics.endFill();
			addChild(bg);
			
			var txt3:TextField = new TextField();
			txt3.textColor = 0x70c5f5;
			txt3.height = 20;
			txt3.width = 100;
			txt3.x = 10;
			txt3.y = 122;
			txt3.text = "累计订阅";
			addChild(txt3);
			
			total3 = new NumTotal(7, 0x30aff6, .3);
			total3.numstr = "0";
			total3.x = 104;
			total3.y = 125;
			addChild(total3);
			
		}
		
		private function getDays(pub:String):String{
			var days:String = "";
			
			days = String(int((new Date().time - new Date(2013, 11, 26).time)/86400000));
			
			return days;
		}
		
		public function set uv(num:String):void
		{
			total1.numstr = num;
		}
		
		public function set pv(num:String):void
		{
			total2.numstr = num;
		}
		
		public function set sub(num:String):void
		{
			total3.numstr = num;
		}
		
		public function showTime():void
		{
			localTime.showTime();
		}
	}

}