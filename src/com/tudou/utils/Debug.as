package com.tudou.utils
{
	import flash.events.StatusEvent;
	import flash.net.LocalConnection;
	import flash.external.ExternalInterface;
	/**
	 +------------------------------------------------
	 * AIR Debug CODE as3.0 debug 
	 +------------------------------------------------ 
	 * @author 8088 at 2011-07-18
	 * version: 0.1
	 * link: www.asfla.com
	 * mail: flasher.jun@gmail.com
	 +------------------------------------------------
	 */
	public class Debug {
		
		public static const NAME		:String = 'Debug';
		public static const VERSION		:String = '0.1';
		
		public static var ignoreStatus		:Boolean = true;
		public static var secure			:Boolean = false;
		public static var secureDomain		:String	 = '*';
		public static var allowLog			:Boolean = true;
		
		private static const DOMAIN			:String = 'com.asfla.Checkbug';
		private static const TYPE			:String = 'app';
		private static const CONNECTION		:String = 'checkbug';
		private static const LOG_OPERATION	:String = 'debug';
		public static const DEFAULT_COLOR	:uint 	= 6710886;
		
		public static var RED			:uint = 0xCC0000;
		public static var GREEN			:uint = 0x00CC00;
		public static var BLUE			:uint = 0x6666CC;
		public static var PINK			:uint = 0xCC00CC;
		public static var YELLOW		:uint = 0xCCCC00;
		public static var LIGHT_BLUE	:uint = 0x00CCCC;
		
		private static var lc				:LocalConnection = new LocalConnection();
		private static var hasEventListeners:Boolean 		 = false;
		
		public static function log (msg:*, color:uint = DEFAULT_COLOR) :Boolean
		{
			var _msg:String;
			if (typeof(msg) == "string")
			{
				_msg = String(msg);
			}
			else {
				if(msg!=null) 
				{
					_msg = msg.toString();
				}
				else {
					log("The msg is null!");
					return false;
				}
			}
			_msg = "[SWF LOG] " + _msg;
			CONFIG::FLASH_SHOWLOG{
				trace(_msg);
				/*if (ExternalInterface.available) {
					ExternalInterface.call("ShowLog", _msg);
				}*/
			}
			return send(_msg, color);
		}
		
		private static function send(value:*, prop:* ):Boolean
		{
			if (!secure) lc.allowInsecureDomain('*');
			else 		lc.allowDomain(secureDomain);
			if (!hasEventListeners) {
				if ( ignoreStatus ) lc.addEventListener(StatusEvent.STATUS, ignore);
				else 				lc.addEventListener(StatusEvent.STATUS, status);
				hasEventListeners = true;
			}
			if(allowLog){
				try {
					lc.send ( TYPE + '#' + DOMAIN + ':' + CONNECTION , LOG_OPERATION, value, prop );
					return true;
				} catch (e:*) {
					return false;
				}
			}
			return false;
		}
		
		private static function status(e:StatusEvent):void
		{
			trace( 'Checkbug status:\n' + e.toString() );
		}
		
		private static function ignore(e:StatusEvent):void { }
		
	}
	
}