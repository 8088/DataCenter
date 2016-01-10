package com.tudou.datacenter.map 
{
	import com.tudou.datacenter.util.HashMap;
	import com.tudou.datacenter.util.TimeUtil;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	/**
	 * ...
	 * @author 8088
	 */
	public class MsgBox extends Sprite
	{
		public var msgMap:HashMap;
		public var valueMap:HashMap;
		public var last_key:String;
		private var format:TextFormat;
		
		public function MsgBox()
		{
			msgMap = new HashMap();
			
			valueMap = new HashMap();
			
			format = new TextFormat("微软雅黑", 20, 0xBBDDFF);
			
		}
		
		//追加
		private function push(msg:Object):void
		{
			var key:String = msg.id;
			if (valueMap.hasKey(key)) return;
			
			var txt:TextField = new TextField();
			txt.multiline = false;
			txt.wordWrap = false;
			txt.antiAliasType = AntiAliasType.ADVANCED;
			txt.width = 100;
			txt.height = 32;
			txt.defaultTextFormat = format;
			txt.text = "　◆ "+msg.text;
			txt.width = txt.textWidth;
			
			var bmd:BitmapData = new BitmapData(txt.width, txt.height, true, 0);
			bmd.draw(txt);
			
			var value:MsgBmp = new MsgBmp(bmd);
			value.id = key;
			if (!valueMap.isEmpty()) {
				var bmp:MsgBmp = valueMap.getValueByKey(last_key) as MsgBmp;
				if (bmp) {
					bmp.next = value;
					value.pre = bmp;
				}
			}
			changeLayout(value);
			addChild(value);
			valueMap.put(key, value);
			last_key = key;
			dispatchEvent(new Event(Event.CHANGE));
		}
		
		private function remove(msg:Object):void
		{
			var key:String = msg.id;
			del(key);
			dispatchEvent(new Event(Event.CHANGE));
		}
		
		private function changeLayout(bmp:MsgBmp):void {
			if (bmp.pre) {
				bmp.x = bmp.pre.x + bmp.pre.width;
			}
			else {
				bmp.x = 0;
			}
		}
		
		private function checkTime(msg:Object):void
		{
			//后端sqlite 没存日期，时间改成秒
			//var now:Date = new Date();
			var now:int = int((new Date().time) / 1000);
			
			if (now > msg.star && now < msg.end)
			{
				push(msg);
			}
			
			if (now > msg.end)
			{
				remove(msg);
			}
		}
		
		public function add(msg:Object):void
		{
			var key:String = msg.id;
			if (msgMap.hasKey(key)) return;
			
			//后端sqlite 没存日期，时间改成秒
			//msg.star = TimeUtil.toDate(msg.stime);
			//msg.end = TimeUtil.toDate(msg.etime);
			
			msg.star = int(msg.stime);
			msg.end = int(msg.etime);
			
			msgMap.put(key, msg);
		}
		
		public function del(key:String):void
		{
			if (!msgMap.hasKey(key)) return;
			
			var bmp:MsgBmp = valueMap.getValueByKey(key) as MsgBmp;
			if (bmp && contains(bmp))
			{
				if (bmp.next) {
					bmp.next.pre = bmp.pre;
				}
				if (bmp.pre) {
					bmp.pre.next = bmp.next;
				}
				
				bmp.bitmapData.dispose();
				removeChild(bmp);
			}
			msgMap.remove(key);
			valueMap.remove(key);
			
			if (valueMap.length) {
				var ln:int = valueMap.length;
				var keys:Array = valueMap.keys();
				for (var i:int = 0; i != ln; i++) {
					var mbmp:MsgBmp = valueMap.getValueByKey(keys[i]) as MsgBmp;
					changeLayout(mbmp);
				}
				last_key = keys[ln-1];
				dispatchEvent(new Event(Event.CHANGE));
			}
			else {
				last_key = "";
				dispatchEvent(new Event(Event.COMPLETE));
			}
		}
		
		public function clock():void {
			msgMap.eachValue(checkTime);
		}
		
		
		
	}

}