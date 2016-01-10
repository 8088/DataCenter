package com.tudou.datacenter.heatmap 
{
	import flash.display.Sprite;
	import flash.display.BitmapData;
	import flash.display.BlendMode;
	import flash.display.GradientType;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.filters.BlurFilter;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	/**
	 * 绘制热图
	 * @author 8088
	 */
	public class DataMap extends Sprite
	{
		private var gradientArray:Array = GradientArray.BLUE_WHITE;
		private var POINT:Point = new Point();
		private var point:Point = new Point();
		private var points:Array = [];
		private var itemRadius:int = 10;
		private var heatBitmapData:BitmapData;
		private var centerValue:Number;

		private var pointDictionary:Object;
		private var _dataProvider:Array;
		private var _w:int;
		private var _h:int;
		public function DataMap(w:int, h:int):void {
			_w = w;
			_h = h;
			heatBitmapData = new BitmapData(w, h, true, 0);
		}
		
		public function updatePoints(_x:Number, _y:Number):void
		{
			points.push(new Point(_x, _y));
			
			if (points.length > 10000) points.shift();
			
			drawHeatMap();
			
			var bgColor:Number = 0;
			var bgAlpha:Number = 0;
			graphics.clear();
			graphics.beginFill(bgColor, bgAlpha);
			graphics.drawRect(0, 0, _w, _h);
			graphics.endFill();
			
			if (heatBitmapData){
				graphics.beginBitmapFill(heatBitmapData);
				graphics.drawRect(0, 0, _w, _h);
				graphics.endFill();
			}
		}
		
		private function drawHeatMap():void
		{
			var cellSize:int = itemRadius * 2;
			var m:Matrix = new Matrix();
			m.createGradientBox(cellSize, cellSize, 0, -itemRadius, -itemRadius);
			var heatMapShape:Shape = new Shape();
			heatMapShape.graphics.clear();
			heatMapShape.graphics.beginGradientFill(GradientType.RADIAL, [51, 0], [1, 1], [0, 255], m);
			heatMapShape.graphics.drawCircle(0,0,itemRadius);
			heatMapShape.graphics.endFill();
			
			var heatMapItem:BitmapData = new BitmapData(heatMapShape.width, heatMapShape.height, true, 0x00000000);
			var translationMatrix:Matrix = new Matrix();
			translationMatrix.tx = itemRadius;
			translationMatrix.ty = itemRadius;
			heatMapItem.draw(heatMapShape, translationMatrix);
			
			if (! heatBitmapData||heatBitmapData.width!=_w||heatBitmapData.height!=_h) {
				heatBitmapData = new BitmapData(_w, _h, true, 0x00000000);
			} else {
				heatBitmapData.fillRect(new Rectangle(0, 0, heatBitmapData.width, heatBitmapData.height), 0x00000000);
			}
			var len:int=points.length;
			for each (var point:Point in points){
				translationMatrix.tx = point.x - itemRadius;
				translationMatrix.ty = point.y - itemRadius;
				heatBitmapData.draw(heatMapItem, translationMatrix, null, BlendMode.SCREEN);
			}
			heatMapItem.dispose();
			
			heatBitmapData.threshold(heatBitmapData, heatBitmapData.rect, POINT, "<=", 0x00000003, 0x00000000, 0x000000FF, true);
			
			heatBitmapData.paletteMap(heatBitmapData, heatBitmapData.rect, POINT, null, null, gradientArray, null);
			
			heatBitmapData.applyFilter(heatBitmapData, heatBitmapData.rect, POINT, new BlurFilter(4, 4));
		}
		//OVER
	}
	
}
