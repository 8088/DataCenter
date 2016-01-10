package com.tudou.datacenter.util 
{
	/**
	 * ...
	 * @author 8088
	 */
	public class TimeUtil 
	{
		/*
		 * yyyy-MM-dd HH:mm:ss
		 */
		public static function toDate(str:String):Date {
			var yh:Array = str.split(" ");
			var ys:String = yh[0];
			var hs:String = yh[1];
			var ya:Array = ys.split("-");
			var ha:Array = hs.split(":");
			
			var yyyy:* = ya[0];
			var MM:* = ya[1];
			var dd:* = ya[2];
			var hh:* = ha[0];
			var mm:* = ha[1];
			var ss:* = ha[2];
			
			return new Date(yyyy, MM, dd, hh, mm, ss);
		}
		
		public static function toStr(date:Date):String {
			
			var t:String = "";
			var yyyy:* = date.getFullYear();
			var MM:* = date.getMonth() + 1;
			var dd:* = date.getDate();
			var hh:* = date.getHours();
			var mm:* = date.getMinutes();
			var ss:* = date.getSeconds();
				
			if(MM<10) MM ='0'+MM;
			if(dd<10) dd ='0'+dd;
			if(hh<10) hh ='0'+hh;
			if(mm<10) mm ='0'+mm;
			if(ss<10) ss ='0'+ss;
			t = yyyy + '-' + MM + '-' + dd + ' ' + hh + ':' + mm + ':' + ss;
			return t;
		}
	}
}