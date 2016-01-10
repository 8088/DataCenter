package com.tudou.datacenter.map 
{
	import flash.geom.Point;
	/**
	 * Mercator projection - 维基百科 
	 * 未完..
	 * http://en.wikipedia.org/wiki/Mercator_projection
	 * @author 8088
	 */
	public class Mercator 
	{
		private static const L:Number = 6381372 * Math.PI * 2; // 地球平均周长(6381372 * Math.PI * 2)
		private static const W:Number = L; // 平面展开后，x轴等于周长
		private static const H:Number = L/2; // y轴约等于周长一半(L / 2)
		private static const mill:Number = 2.3; // 投影中的一个常数，范围大约在正负2.3之间
		private static var lon_os:Number = 47.004;//经度偏移
		private static var lat_os:Number = 55.647;//纬度偏移
		
		public static function count(lon:Number, lat:Number):Point {
			var point:Point = new Point();
			var x:Number = lon * Math.PI / 180; // 将经度从度数转换为弧度
			var y:Number = lat * Math.PI / 180; // 将纬度从度数转换为弧度
			
			// 投影转换
			y = 1.25 * Math.log( Math.tan( 0.25 * Math.PI + 0.4 * y ) );
			
			// 弧度转为实际距离
			x = ( W / 2 ) + ( W / (2 * Math.PI) ) * x;
			y = ( H / 2 ) - ( H / ( 2 * mill ) ) * y;
			
			return point;
		}
		
		public static function projection(lon:Number, lat:Number):Point {
			var point:Point = new Point();
			var x:Number = (lon - lon_os) * 11.4;
			var c:Number = lat_os - lat;
			var y:Number = c * (18.6983 - (c * 0.1214));
			if (y > 400) y = (1 - (720 - y) / 320) * 46 + y;
			if (y > 680) x -= 12;
			point.x = x;
			point.y = y;
			return point;
		}
		
	}

}