package com.tudou.datacenter.map 
{
	import com.tudou.datacenter.asset.MapTitle;
	import flash.display.Shape;
	import flash.display.Sprite;
	/**
	 * 实时监控图标题
	 * 
	 * @author 8088
	 */
	public class Title extends Sprite
	{
		private var asset:MapTitle;
		private var line:Shape;
		private var totalNum:TNumTotal;
		public function Title()
		{
			this.mouseChildren = false;
			this.graphics.beginFill(0, 0);
			this.graphics.drawRect(0, 0, 240, 140);
			this.graphics.endFill();
			
			asset = new MapTitle();
			addChild(asset);
			
			line = new Shape();
			line.graphics.beginFill(0xFFFFFF, .12);
			line.graphics.drawRect(0, 66, 240, 1);
			line.graphics.endFill();
			addChild(line);
			
			totalNum = new TNumTotal();
			totalNum.x = 0;
			totalNum.y = 70;
			addChild(totalNum);
			
			asset.powerTxt.visible = false;
			
		}
		
		public function set total(num:String):void
		{
			totalNum.numstr = num;
			
			if (!asset.powerTxt.visible) asset.powerTxt.visible = true;
		}
	}

}