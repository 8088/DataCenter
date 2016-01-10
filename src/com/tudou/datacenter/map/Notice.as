package com.tudou.datacenter.map 
{
	import com.tudou.datacenter.util.HashMap;
	import com.tudou.events.SchedulerEvent;
	import com.tudou.utils.Scheduler;
	import com.tudou.datacenter.asset.NoticeBg;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.Timer;
	/**
	 * 公告栏
	 * 
	 * @author 8088
	 */
	public class Notice extends Sprite
	{
		private var bmd:BitmapData;
		private var showing:Boolean;
		private var msgBox:MsgBox;
		private var dubMsgBmd:BitmapData;
		private var timer:Timer;
		private var sourceX:Number = 0.0;
		private var bmp:Bitmap;
		private var cur_id:String;
		
		public function Notice() 
		{
			var bg:NoticeBg = new NoticeBg();
			addChild(bg);
			
			bmd = new BitmapData(600, 32, true, 0);
			bmp = new Bitmap(bmd);
			bmp.x = 85;
			bmp.y = 4;
			addChild(bmp);
			
			msgBox = new MsgBox();
			msgBox.addEventListener(Event.CHANGE, onChange);
			msgBox.addEventListener(Event.COMPLETE, onComplete);
			
			timer = new Timer(15);
			timer.addEventListener(TimerEvent.TIMER, rotateMsg);
			
		}
		
		private function onChange(evt:Event):void
		{
			clear();
			
			var temp:BitmapData = new BitmapData(msgBox.width, msgBox.height, true, 0);
			temp.draw(msgBox);
			
			var w:Number = 0;
			if (temp.width > bmd.width) {
				w = temp.width * 2;
			}
			else {
				w = temp.width;
			}
			
			dubMsgBmd = new BitmapData(w, temp.height, true, 0);
			dubMsgBmd.lock();
			dubMsgBmd.copyPixels(temp, new  Rectangle(0, 0, temp.width, temp.height), new Point());
			if (temp.width > bmd.width) dubMsgBmd.copyPixels(temp, new  Rectangle(0, 0, temp.width, temp.height), new Point(temp.width, 0));
			dubMsgBmd.unlock();
			
			temp.dispose();
			temp = null;
			
			if(!timer.running) timer.start();
			
			if (!showing) {
				dispatchEvent(new Event(Event.OPEN));
				showing = true;
			}
			
			dispatchEvent(evt);
		}
		
		private function onComplete(evt:Event):void
		{
			clear();
			
			if (showing) showing = false;
			
			dispatchEvent(evt);
		}
		
		private function rotateMsg(evt:TimerEvent):void
		{
			sourceX += 1; 
			if (sourceX > dubMsgBmd.width / 2 || msgBox.width < bmd.width) 
			{ 
				sourceX = 0; 
			}
			
			bmd.copyPixels(dubMsgBmd, 
								new Rectangle(sourceX, 0, bmd.width, bmd.height), 
								new Point(0, 0)); 
			evt.updateAfterEvent();
			
			if (msgBox.width < bmd.width) {
				timer.stop();
			}
		}
		
		private function clear():void
		{
			if (dubMsgBmd) {
				dubMsgBmd.dispose();
				dubMsgBmd = null;
			}
			
			if (bmd) {
				bmd.dispose();
				bmd = null;
				bmd = new BitmapData(600, 32, true, 0);
				bmp.bitmapData = bmd;
			}
			
			if (timer)
			{
				timer.stop();
			}
			
		}
		
		public function add(msg:Object):void
		{
			msgBox.add(msg);
		}
		
		public function del(key:String):void
		{
			msgBox.del(key);
		}
		
		public function get isshow():Boolean {
			return showing;
		}
		
		public function clock():void {
			msgBox.clock();
		}
		
		public function get lastKey():String{
			return msgBox.last_key;
		}
		
		public function get msgMap():HashMap{
			return msgBox.msgMap;
		}
		
		public function get valueMap():HashMap{
			return msgBox.valueMap;
		}
		
		
	}

}