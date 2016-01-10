package com.tudou.utils 
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import com.tudou.events.TweenEvent;
	import com.tudou.utils.Scheduler;
	import com.tudou.events.SchedulerEvent;
	/**
	 * 基于调度器的过度类
	 * @private
	 * @author 8088
	 */
	public class Tween extends EventDispatcher
	{
		protected var scheduler:Scheduler;
		protected var duration:Number;
		protected var toVars:Object;
		protected var targetValue:Object;
		protected var easeFunction:Function;
		protected var fromVars:Object;
		
		public function Tween(target:Object = null):void
		{
			easeFunction = linear;
			targetValue = target;
		}
		
		/**
		 * 根据key取目标对象的初始值
		 */
		protected function snapshotTargetKeys(value:Object):Object
        {
            var key:String = null;
            var obj:Object = {};
            for (key in value)
            {
                obj[key] = this.target[key];
            }
            return obj;
        }
		
        override public function dispatchEvent(evt:Event):Boolean
        {
            if (hasEventListener(evt.type))
            {
                return super.dispatchEvent(evt);
            }
            return false;
        }
		
        protected function update(evt:SchedulerEvent):Tween
        {
            var key:String = null;
            var o:DisplayObject = null;
            var e:* = this.easeFunction(Math.min(evt.elapsed / duration, 1));
            for (key in toVars)
            {
                if (!isNaN(toVars[key]))
                {
                    targetValue[key] = fromVars[key] + (toVars[key] - fromVars[key]) * e;
                }
            }
			
            dispatchEvent(new TweenEvent(TweenEvent.UPDATE));
            return this;
        }
		
        protected function cancelScheduler() : Tween
        {
            if (scheduler)
            {
                scheduler.removeEventListener(SchedulerEvent.TICK, update);
                scheduler.removeEventListener(SchedulerEvent.END, finish);
                scheduler.stop();
                scheduler = null;
            }
            return this;
        }
		
		public function from(value:Object) : Tween
        {
            return this.to(value);
        }
		
		public function to(value:Object, time:Number = 0) : Tween
        {
            if (!targetValue)
            {
                return this;
            }
            toVars = value;
            duration = time;
            if (!duration)
            {
                dispatchEvent(new TweenEvent(TweenEvent.START));
                return finish();
            }
            fromVars = snapshotTargetKeys(value);
            return this.play();
        }
		private var _delay:Number = 0;
		public function delay(ms:Number = 0):Tween
		{
			_delay = ms;
			return this;
		}
		
		public function finish(evt:SchedulerEvent = null):Tween
        {
            var key:String = null;
            cancelScheduler();
			_delay = 0;
            for (key in toVars)
            {
                target[key] = toVars[key];
            }
            dispatchEvent(new TweenEvent(TweenEvent.UPDATE));
            dispatchEvent(new TweenEvent(TweenEvent.END));
            return this;
        }
		
		public function play():Tween
        {
            cancelScheduler();
			startupScheduler();
            return this;
        }
		
		private function startupScheduler():void
		{
			Scheduler.setTimeout( _delay
				, function():void
					{
						scheduler = new SchedulerSource(duration);
						scheduler.addEventListener(SchedulerEvent.TICK, update);
						scheduler.addEventListener(SchedulerEvent.END, finish);
						dispatchEvent(new TweenEvent(TweenEvent.START));
					}
				);
		}
		
		public function pause():Tween
        {
            return cancelScheduler();
        }
		
		public function cancel():Tween
        {
            var key:String = null;
            cancelScheduler();
            for (key in fromVars)
            {
                target[key] = fromVars[key];
            }
            dispatchEvent(new TweenEvent(TweenEvent.END));
            return this;
        }
		
		/**
		 * 淡入
		 */
		public function fadeIn(ms:Number = 500) : Tween
        {
            var durationValue:* = ms;
            return from({visible:true}).to({alpha:1}, durationValue);
        }
		
		/**
		 * 淡出
		 */
		public function fadeOut(ms:Number = 500) : Tween
        {
            var durationValue:* = ms;
            return to({alpha:0, visible:false}, durationValue);
        }
		
		public function ease(f:Function):Tween
        {
            this.easeFunction = f;
            return this;
        }
		
		public function easeOut():Tween
        {
            return this.ease(Tween.easeOut);
        }
		
		public function easeIn():Tween
        {
            return this.ease(Tween.easeIn);
        }
		
		public static function easeOut(num:Number):Number
        {
            return (easeIn((num - 1)) + 1);
        }
		
		public static function easeIn(num:Number):Number
        {
            return num * num * num;
        }
		
		public static function linear(num:Number):Number
        {
            return num;
        }
		
		public static var SchedulerSource:Class = Scheduler;
		
		public function get target():Object
        {
            return targetValue;
        }
		
		public function set target(value:Object) : void
        {
            cancelScheduler();
            targetValue = value;
            return;
        }
	}

}