package com.tudou.datacenter.heatmap 
{
	import com.tudou.utils.Debug;
	import flash.display.*;
	import flash.net.*;
	import flash.events.*;
	import flash.text.*;
	import flash.utils.Timer;
	import flash.system.*;
	
	import com.gskinner.motion.*;
	import com.gskinner.motion.plugins.*;
	import com.gskinner.motion.easing.*;
	
	
	/*********************************
	 * AS3.0 asfla_MapChart CODE
	 * BY 8088 2010-02-23
	 * MSN:flasher.jun@hotmail.com
	 * Blog:www.asfla.com
	**********************************/
	public class HeatMap extends MovieClip
	{
		public static const version:String = "HeatMap 1.0";
		public var map_h_w_v:Number = 0.6;
		public var logo;
		
		private var xml_path:String;
		private var stage_w:Number;
		private var stage_h:Number;
		private var loading:Loading;
		//private var dataVO:chartVO;
		
		private var bg:Sprite;
		private var chart:Sprite;
		private var bmpUrl:String;
		private var amfChannelUrl:String;
		private var pointBmpD:BitmapData;
		private var pointBmp:Bitmap;
		private var show_point:Boolean = true;
		
		private var lon_os:Number = 63.6;//经度偏移
		private var lat_os:Number = 54.12;//纬度偏移
		
		private var remoteTimer:Timer;
		private var timer_delay:Number = 500;
		private var dataMap:DataMap;
		//测试数据
		private var test_ary:Array = [
										{lon:116.388306, lat:39.928894 },
										{lon:126.649994, lat:45.75 },
										{lon:106.552795, lat:29.562805 },
										{lon:121.4086, lat:31.00505 },
										{lon:113.25, lat:23.1167 },
										{lon:110.20, lat:20 }
									 ];
		private var test_obj:Object = { total:3456789,
										add:test_ary,
										clear:[]
									  };
		public function HeatMap()
		{
			if (this.loaderInfo.parameters.xmlPath != null) {
				xml_path = this.loaderInfo.parameters.xmlPath;
			}else {
				xml_path = "../xml/map_config.xml";
			}
			stop();
			this.addEventListener(Event.ADDED_TO_STAGE, addToStageHandler);
		}
		
		private function addToStageHandler(evt:Event):void {
			InitStage();
			Main();
			this.removeEventListener(Event.ADDED_TO_STAGE, addToStageHandler);
		}
		private function InitStage():void {
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.quality = StageQuality.HIGH;
			stage.frameRate	= 31;
			stage_h	= stage.stageHeight;
			stage_w	= stage.stageWidth;
			var cr:Copyright = new Copyright(this);
		}
		private function Main():void {
			loading = new Loading();
			loading.txt.text ="初始化场景..";
			loading.x = int((stage_w - loading.width) * .5);
			loading.y = int((stage_h - loading.height) * .5);
			addChild(loading);
			this.loaderInfo.addEventListener(ProgressEvent.PROGRESS,mapLoadProgress);
		}
		private function mapLoadProgress(evt:ProgressEvent):void {
			if(framesLoaded == totalFrames){
				evt.target.removeEventListener(ProgressEvent.PROGRESS, mapLoadProgress);
				LoadConfig();
			}else {
				loading.txt.text ="初始化场景.."+evt.bytesLoaded+ "/"+evt.bytesTotal;
			}
        }
		private function LoadConfig():void {
			var xml_loader:URLLoader = new URLLoader();
			var xml_request:URLRequest = new URLRequest(xml_path);
			
			xml_loader.addEventListener(Event.COMPLETE, loadedConfigHandler);
			try {
                xml_loader.load(xml_request);
            } catch (error:Error){
                trace("Unable to load requested document.");
            }
		}
		private function loadedConfigHandler(evt:Event):void {
			var loader:URLLoader = URLLoader(evt.target);
			if (loader != null) {
				var my_xml:XML = new XML(loader.data);
				bmpUrl = my_xml.bmpurl.toString();
				amfChannelUrl = my_xml.amfchannelurl.toString();
				loadBmp(bmpUrl);
			} else {
				trace("menuXML error！");
			}
			loader.removeEventListener(Event.COMPLETE, loadedConfigHandler);
			
		}
		private function loadBmp(url:String):void {
			var request:URLRequest = new URLRequest(url);
			var context:LoaderContext = new LoaderContext();
			context.checkPolicyFile = true;
			var bmpLoader:Loader = new Loader();
			
			configureListeners(bmpLoader.contentLoaderInfo);
			
			try{
				bmpLoader.load(request,context);
			}catch (error) {
				Debug.log("载入数据出错: " + error.message + "\n");
			}
		}
		private function configureListeners(dispatcher:IEventDispatcher):void {
            dispatcher.addEventListener(Event.COMPLETE, completeHandler);
            dispatcher.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
            dispatcher.addEventListener(Event.OPEN, openHandler);
            dispatcher.addEventListener(ProgressEvent.PROGRESS, progressHandler);
        }
		private function openHandler(evt:Event):void {
			loading.txt.text = "载入数据..";
		}
		private function progressHandler(evt:ProgressEvent):void {
			loading.txt.text ="载入数据.."+evt.bytesLoaded+ "/"+evt.bytesTotal;
		}
		private function completeHandler(evt:Event):void {
			removeChild(loading);
			loading = null;
			
			pointBmp = evt.target.loader.content as Bitmap;
			pointBmpD = pointBmp.bitmapData;
			nextFrame();
			init();
		}
		private function ioErrorHandler(evt:Event):void {
			trace("ioError: " + evt);
		}
		private function init():void {
			
			onResize();
			initHeatMap();
			
			
			this.stage.addEventListener(Event.RESIZE, onResize);	
			stage.mouseChildren = false;
			stage.doubleClickEnabled = true;
			this.stage.addEventListener(MouseEvent.DOUBLE_CLICK, dubClickHandler);
		}
		
		private function initHeatMap():void {
			dataMap = new DataMap();
			dataMap.alpha = .5;
			dataMap.setBG(1000, 600);
			this.addEventListener(Event.ENTER_FRAME, onEnterFrameHandler);
			
			map.addChild(dataMap);
		}
		private function onEnterFrameHandler(evt:Event):void {
			var _x =500 + int(Math.random()*50);
			var _y =140+ int(Math.random()*30);
			dataMap.updatePoints(_x, _y);
		}
		private function dubClickHandler(evt:MouseEvent):void {			
			if (stage.displayState == StageDisplayState.NORMAL) {
				stage.displayState = StageDisplayState.FULL_SCREEN;
			}else {
				stage.displayState = StageDisplayState.NORMAL;
			}
		}
		private function onResize(evt:Event=null):void {
			stage_h	= stage.stageHeight;
			stage_w	= stage.stageWidth;
			if (map) {
				map.width = stage_w;
				map.height = map.width*map_h_w_v;
				if (map.height>stage_h) {
					map.height = stage_h;
					map.width = map.height/map_h_w_v;
				}
				map.x = (stage_w - map.width)/2;
				map.y = (stage_h - map.height)/2;
			}
			if (logo) {
				logo.x = stage_w - 115;
				logo.y = stage_h - 105;
			}
			if (numBox) {
				numBox.x = 20;
				numBox.y = stage_h - 50;
			}
		}
		
		
		
		//OVER
	}	
}