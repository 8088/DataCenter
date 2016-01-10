package com.tudou.datacenter.map 
{
	import flash.geom.Point;
	/**
	 * 经纬度偏移
	 * @author 8088
	 */
	public class Offset
	{
		//矩形散列
		public static function rect(p:Point, l:uint = 0):Point
		{
			var point:Point = p;
			
			if (l) {
				point.x += Math.sin(Math.random() * 90) * Math.random() * l;
				point.y += Math.sin(Math.random() * 90) * Math.random() * l;
			}
			
			return point;
		}
		
		//圆形散列
		public static function round(p:Point, r:uint = 0):Point
		{
			var point:Point = p;
			
			if (r) {
				var a:Number = Math.random() * 90;
				var c:Number = Math.random() * r;
				
				var x:Number = Math.cos(a) * c
				var y:Number = Math.sin(a) * c;
				
				point.x += x;
				point.y += y;
			}
			
			return point;
		}
		
	}
}