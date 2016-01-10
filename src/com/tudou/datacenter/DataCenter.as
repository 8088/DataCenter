package com.tudou.datacenter
{
	import __AS3__.vec.Vector;
	import com.tudou.datacenter.asset.Info;
	import com.tudou.datacenter.asset.MapScale;
	import com.tudou.datacenter.map.LinkQRcode;
	import com.tudou.datacenter.map.Mercator;
	import com.tudou.datacenter.map.Notice;
	import com.tudou.datacenter.map.Title;
	import com.tudou.datacenter.map.TotalContainer;
	import com.tudou.events.TweenEvent;
	import com.tudou.utils.Tween;
	import com.tudou.utils.FPS;
	import com.tudou.events.SchedulerEvent;
	import com.tudou.utils.Debug;
	import com.tudou.utils.Scheduler;
	import com.tudou.datacenter.asset.Map;
	import com.tudou.datacenter.asset.Star;
	import com.tudou.datacenter.map.Offset;
	import com.tudou.datacenter.map.MapSprite;
	import com.tudou.datacenter.map.StarMovie;
	import com.tudou.datacenter.net.SocketProxy;
	import com.tudou.datacenter.net.tstp.DataBean;
	import com.tudou.datacenter.net.tstp.DataBeanBuffer;
	import com.tudou.ui.RightMenu;
	import com.tudou.ui.ShortcutKeys;
	import com.tudou.bmp.BitmapCacher;
	import com.tudou.bmp.BitmapFrameInfo;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageAspectRatio;
	import flash.display.StageDisplayState;
	import flash.display.StageQuality;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.FullScreenEvent;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.events.StageOrientationEvent;
	import flash.events.StatusEvent;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.net.Socket;
	import flash.system.Security;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	import flash.utils.ByteArray;
	import flash.utils.Timer;
	
	/**
	 * 数据监控中心 v_0.1.1
	 * @author 8088
	 */
	public class DataCenter extends Sprite 
	{
		//测试数据
		private var test_ary:Array = 
			[ { lon:116.388306, lat:39.928894 } /*北京*/
			, { lon:121.4086, lat:31.005005 } /*上海*/
			, { lon:104.06671, lat:30.666702 } /*成都*/
			, { lon:87.58331, lat:43.800003 } /*乌鲁木齐*/
			, { lon:110.341705, lat:20.045807 } /*海口*/
			, { lon:121.524994, lat:25.0392 } /*台北*/
			, { lon:91.100006, lat:29.649994 } /*拉萨*/
			, { lon:113.25, lat:23.1167 } /*广州*/
			, { lon:126.649994, lat:45.75 } /*哈尔滨*/
			, { lon:125.322815, lat:43.880005 } /*长春*/
			, { lon:123.4328, lat:41.792206 } /*沈阳*/
			, { lon:102.71829, lat:25.038895 } /*昆明*/
			, { lon:106.552795, lat:29.562805 } /*重庆*/
			, { lon:113.5325, lat:34.683594 } /*郑州*/
			];
			
		private var msg1:Object = {
				id: "test1",
				text: "测试测试测试测试1！",
				url: "http://www.tudou.com",
				stime: "2014-0-20 10:30:00",
				etime: "2014-0-20 10:40:20"
			}
		private var msg2:Object = {
				id: "test2",
				text: "测试测试测试测测试2！",
				url: "http://www.tudou.com",
				stime: "2014-0-20 10:30:00",
				etime: "2014-0-20 10:40:30"
			}
		private var msg3:Object = {
				id: "test3",
				text: "测试测试测试测试3！",
				url: "http://www.tudou.com",
				stime: "2014-0-20 10:30:00",
				etime: "2014-0-20 10:40:00"
			}
		private var msg4:Object = {
				id: "test4",
				text: "测试测试测试测试4！",
				url: "http://www.tudou.com",
				stime: "2014-0-20 10:30:00",
				etime: "2014-0-20 10:40:10"
			}
		private var msg5:Object = {
				id: "test5",
				text: "测试测试测试测试5！",
				url: "http://www.tudou.com",
				stime: "2014-0-20 10:30:00",
				etime: "2014-0-20 10:40:40"
			}
		private var msgs:Array = [msg1, msg2, msg3, msg4, msg5];
		
		public function DataCenter():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
			
			// touch or gesture?
			Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
			
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			initStage();
			
			initElements();
			
			contentSocketServer();
			
			//启动一个时钟
			var clockTimer:Scheduler = Scheduler.setInterval(1000, onClock);
			
			//测试
			/*
			var showStarTimer:Timer = new Timer(1, 0);
			showStarTimer.addEventListener(TimerEvent.TIMER, testHandler);
			showStarTimer.start();
			
			var countReceiveDataBeanTimer:Timer = new Timer(1000, 0);
			countReceiveDataBeanTimer.addEventListener(TimerEvent.TIMER, testClock);
			countReceiveDataBeanTimer.start();
			*/
			
		}
		
		private function testHandler(evt:TimerEvent = null):void {
			for (var i:int = 0; i < 10; i++) {
				var obj:Object = test_ary[int(Math.random() * test_ary.length)]
				
				var lon:Number = obj.lon;
				var lat:Number = obj.lat;
				
				point = Offset.round(Mercator.projection(lon, lat), 4);
				
				var _x:Number = point.x;
				var _y:Number = point.y;
				if (_x > 1280 || _y > 720 || _x < 0 || _y < 0) return;
				
				
				//星星
				if(activate) showStar(_x, _y);
				
				//留点
				addPoint(_x, _y);
			}
		}
		
		private var clear_point:Boolean;
		private function onClock(evt:SchedulerEvent):void
		{
			var h:Number = new Date().getHours();
			if (h == 2&&!clear_point) {
				pointBmpD.dispose();
				pointBmpD = null;
				pointBmpD = new BitmapData(map_w, map_h, true, 0);
				pointBmp.bitmapData = pointBmpD;
				clear_point = true;
			}
			else {
				clear_point = false;
			}
			
			totalc.showTime();
			
			if(notice) notice.clock();
		}
		
		private var server_data_ln:int = 0; //每秒种服务器发来的数据
		private var n_i:int //公告数量
		private function testClock(evt:TimerEvent = null):void {
			Debug.log("服务器1秒发来的数据个数: " + server_data_ln);
			server_data_ln = 0;
			
			if(n_i<msgs.length){
				notice.add(msgs[n_i]);
				n_i++;
			}
			else {
				notice.del("13901862957071");
			}
		}
		
		private function initStage():void
		{
			stage_w = stage.stageWidth;
			stage_h = stage.stageHeight;
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.quality = StageQuality.HIGH;
			stage.stageFocusRect = false;
			stage.frameRate	= DEFAULT_FRAME_RATE;
			stage.addEventListener(Event.RESIZE, stageResizeHandler);
			stage.addEventListener(Event.ACTIVATE, stageActivateHandler);
			stage.addEventListener(Event.DEACTIVATE, stageDeactivateHandler);
			//android 不支持此方法
			//stage.setOrientation(StageOrientation.ROTATED_LEFT);
			stage.setAspectRatio(StageAspectRatio.LANDSCAPE);
			
			
			//快捷键
			var shortcuts:ShortcutKeys = ShortcutKeys.getInstance(this.stage);
			shortcuts.addEventListener(StatusEvent.STATUS, statusHandler);
			
			//右键菜单
			/*rightMenu = new RightMenu(this);
			this.mouseEnabled = true;
			rightMenu.add("POWER BY Yaoming Liujunli");
			rightMenu.addEventListener(StatusEvent.STATUS, statusHandler);*/
		}
		
		private function statusHandler(evt:StatusEvent):void
		{
			switch(evt.code) {
				case "setFullScreen":
					toggleFullScreen(true);
					break;
				case "quitFullScreen":
					toggleFullScreen(false);
					break;
				
			}
		}
		
		private function clickTitle(evt:MouseEvent):void
		{
			var screen:Boolean = (stage.displayState == StageDisplayState.NORMAL);
			toggleFullScreen(screen);
		}
		
		private function toggleFullScreen(f:Boolean):void
		{
			if (f)
			{
				stage.displayState = StageDisplayState.FULL_SCREEN;
			}
			else {
				stage.displayState = StageDisplayState.NORMAL;
			}
		}
		
		private function stageResizeHandler(evt:Event):void
		{
			stage_w = int(stage.stageWidth);
			stage_h = int(stage.stageHeight);
			//..
			if (map) setMapLayout();
			
			if (title && contains(title)) {
				title.x = int((stage_w - title.width)*.5)+20;
				title.y = 40+ 150*(map.scaleY-1);
			}
			
			if (mapScale) {
				mapScale.x = 25;
				mapScale.y = stage_h - 40;
			}
			
			if (info&&contains(info))
			{
				info.x = int((stage_w - 262) * .5);
				info.y = int((stage_h - 45) * .5);
			}
			
			if(totalc&&contains(totalc))
			{
				totalc.x = stage_w - totalc.width - 20;
				totalc.y = stage_h - totalc.height - 20;
			}
			
			if(notice&&contains(notice)){
				if(notice.isshow) notice.y = stage_h - notice.height - 20;
				else notice.y = stage_h;
			}
			
			if(qrcode&&contains(qrcode)){
				qrcode.y = int(stage_h - qrcode.height - 64);
			}
		}
		
		private function stageActivateHandler(evt:Event):void
		{
			activate = true;
		}
		
		private function stageDeactivateHandler(evt:Event):void
		{
			activate = false;
		}
		
		private function initElements():void
		{
			var mapAsset:Map = new Map();
			var mapInfo:Vector.<BitmapFrameInfo> = BitmapCacher.cacheBitmapFrameInfo(mapAsset, true);
			
			map = new MapSprite(mapInfo);
			addChild(map);
			setMapLayout();
			
			var starAsset:Star = new Star();
			starInfo = BitmapCacher.cacheBitmapFrameInfo(starAsset, true);
			
			//点图
			pointBmpD = new BitmapData(map_w, map_h,true,0);
			pointBmp  = new Bitmap(pointBmpD);
			map.addChild(pointBmp);
			
			//地图比例尺
			mapScale = new MapScale();
			mapScale.x = 20;
			mapScale.y = stage_h - 20;
			addChild(mapScale);
			
			//地图主题
			title = new Title();
			title.x = int((stage_w - title.width)*.5)+20;
			title.y = 40 + 150 * (map.scaleY - 1);
			title.buttonMode = true;
			title.addEventListener(MouseEvent.CLICK, clickTitle);
			addChild(title);
			
			info = new Info();
			
			//其他数据总数
			totalc = new TotalContainer();
			totalc.x = stage_w - totalc.width - 20;
			totalc.y = stage_h - totalc.height - 20;
			addChild(totalc);
			
			//公告
			notice = new Notice();
			notice.x = 30;
			notice.y = stage_h;
			notice.addEventListener(Event.OPEN, showNotice);
			//notice.addEventListener(Event.CHANGE, changeNotice);
			notice.addEventListener(Event.COMPLETE, hideNotice);
			addChild(notice);
			
			noticeTween = new Tween(notice);
			noticeTween.addEventListener(TweenEvent.END, tweenEnd);
			
			//二维码
			qrcode = new LinkQRcode();
			qrcode.x = 30;
			qrcode.y = int(stage_h - qrcode.height - 64);
			addChild(qrcode);
			
			var fps:FPS = new FPS();
			addChild(fps);
		}
		
		private function tweenEnd(evt:TweenEvent):void
		{
			if (notice.isshow && notice.y != (stage_h - notice.height - 20))
			{
				notice.y = stage_h - notice.height - 20;
			}
			else if(!notice.isshow&&notice.y != stage_h){
				notice.y = stage_h;
			}
		}
		
		private function showNotice(evt:Event):void
		{
			noticeTween.to( { y:stage_h - notice.height - 20 }, 400);
		}
		
		private function hideNotice(evt:Event):void
		{
			noticeTween.to( { y:stage_h }, 300);
			qrcode.url = null;
		}
		
		private function setMapLayout():void
		{
			if (stage_w >= stage_h) {
				if (stage_w / stage_h > 16 / 9) {
					map.width = stage_w;
					map.height = int(map.width * 9 / 16);
				}
				else {
					map.height = stage_h;
					map.width = int(map.height * 16 / 9);
				}
			}
			
			map.x = int((stage_w - map.width) * .53);
			map.y = int((stage_h - map.height) * .2);
		}
		
		private function showStar(_x:Number, _y:Number):void
		{
			var star:StarMovie = new StarMovie(starInfo);
			star.x = _x;
			star.y = _y
			map.addChild(star);
		}
		
		private function addPoint(_x:Number, _y:Number):void {
			if (!show_point) return;
			if (!pointBmpD) return;
			pointBmpD.lock();
			pointBmpD.setPixel32(_x, _y, Number("0x" + (55 + (Math.random() * 200)).toString(16) + "E1F2FF"));
			pointBmpD.unlock();
		}
		private function clearPoint(_x:Number, _y:Number):void {
			if(pointBmpD)pointBmpD.setPixel32(_x, _y, 0);
		}
		
		private function contentSocketServer():void
		{
			if (!socket) {
				buffer = new DataBeanBuffer(encoding);
				socket = new SocketProxy();
				socket.addEventListener(Event.CLOSE, closeHandler);
				socket.addEventListener(Event.CONNECT, connectHandler);
				socket.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
				socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
				socket.addEventListener(ProgressEvent.SOCKET_DATA, socketDataHandler);
			}
			socket.connect(host, port);
		}
		
		private function closeHandler(evt:Event):void {
			Debug.log("Connection closed");
			connetion(false);
			reconnect();
		}
		
		private function connectHandler(evt:Event):void {
			Debug.log("Successful connection");
			connetion(true);
			if (connecting && reconnectTimer) reconnectTimer.stop();
			if (contains(info))
			{
				info.txt.text = "连接成功";
				removeChild(info);
			}
		}
		
		private function ioErrorHandler(evt:Event):void {
			Debug.log("ioError: " + evt);
			connetion(false);
			reconnect();
		}
		private function reconnectHandler(evt:SchedulerEvent):void {
			Debug.log("Reconnection--->" + host + ":" + port);
			if (contains(info)) info.txt.text = "正在尝试重连..";
			if(socket) socket.connect(host, port);
		}
		private function securityErrorHandler(evt:SecurityErrorEvent):void {
			Debug.log("SecurityError info: " + evt);
			connetion(false);
			reconnect();
		}
		private function socketDataHandler(evt:ProgressEvent):void {
			try{
				if (socket.bytesAvailable < 1) return;
				
				var bytes:ByteArray = socket.readBytes();
				var dataBeans:Vector.<DataBean> = buffer.fillBytes(bytes, 0, bytes.length);
				var ln:int = dataBeans.length;
				server_data_ln += ln;
				if (ln > 0) {
					for(var i:int = 0; i < ln; i++){
						parseData(dataBeans[i]);
					}
				}
				
				/*
				Scheduler.setTimeout(1, function(evt:SchedulerEvent):void {
					socket.writeByte(1);
					socket.flush();
				});
				*/
				
				socket.writeByte(1);
				socket.flush();
				
			}catch (e:Error) {
				return;
			}
		}
		
		private function connetion(b:Boolean):void
		{
			show_point = b;
			connecting = b;
		}
		
		private function reconnect():void
		{
			if (connecting) return;
			if (reconnectTimer && reconnectTimer.isRunning()) return;
			//显示提示 10秒后重连
			if (!contains(info))
			{
				info.txt.text = "服务器断开，10秒后尝试重连..";
				info.x = int((stage_w - 262) * .5);
				info.y = int((stage_h - 45) * .5);
				addChild(info);
			}
			else {
				info.txt.text = "连接失败，10秒后再次尝试连接..";
			}
			
			reconnectTimer = Scheduler.setTimeout(10000, reconnectHandler);
			
		}
		
		/**
		 * 接收到数据时被触发
		 */
		private function parseData(dataBean:DataBean):void
		{
			var type:String = dataBean.getHeaderString("type");
			//输出接收到的单条数据对象
			//Debug.log(dataBean)
			
			if (type == "msg") onMessage(dataBean);
			else if (type == "del-msg") delMessage(dataBean);
			else onPoint(dataBean, type);
			
		}
		
		private function onMessage(dataBean:DataBean):void
		{
			Debug.log("Receive a Notice:\n" + dataBean);
			
			var msg:Object = { };
			msg.id = dataBean.getHeaderString("id");
			msg.text = dataBean.getHeaderString("text");
			msg.url = dataBean.getHeaderString("url");
			msg.stime = dataBean.getHeaderString("stime");
			msg.etime = dataBean.getHeaderString("etime");
			
			
			var star:int = int(msg.stime);
			var end:int = int(msg.etime);
			var now:int = int((new Date().time) / 1000);
			if (end < now) return;
			
			notice.add(msg);
			
			if (now > star && now < end)
			{
				qrcode.url = msg.url;
				qrcode.y = int(stage_h - qrcode.height - 64);
			}
		}
		
		private function delMessage(dataBean:DataBean):void
		{
			var key:String = dataBean.getHeaderString("id");
			
			notice.del(key);
			qrcode.url = null;
		}
		
		private function onPoint(dataBean:DataBean, type:String):void
		{
			var type:String = type;
			var count:String = dataBean.getHeaderString("count");
			
			//总数
			switch(type) {
				case "pv":
					totalc.pv = count;
					break;
				case "uv":
					title.total = count;
					totalc.uv = count;
					break;
				case "sub":
					totalc.sub = count;
					break;
			}
			
			
			var lon:Number = Number(dataBean.getHeaderString("lon"));
			var lat:Number = Number(dataBean.getHeaderString("lat"));
			
			point = Offset.round(Mercator.projection(lon, lat), 3);
			
			var _x:Number = point.x;
			var _y:Number = point.y;
			if (_x > 1280 || _y > 720 || _x < 0 || _y < 0) return;
			
			
			//星星
			if(activate) showStar(_x, _y);
			
			//留点
			addPoint(_x, _y);
			
		}
		
		
		//private var host:String = "10.155.9.49";
		private var host:String = "220.181.74.176";
		private var port:int = 8810;
		private var socket:SocketProxy;
		private var buffer:DataBeanBuffer;
		private const encoding:String = "utf-8";
		
		private var map:MapSprite;
		private var map_w:int = 1280;
		private var map_h:int = 720;
		private var starInfo:Vector.<BitmapFrameInfo>;
		private var show_point:Boolean = true;
		private var pointBmpD:BitmapData;
		private var pointBmp:Bitmap;
		private var point:Point;
		private var reconnectTimer:Scheduler;
		private var connecting:Boolean;
		private var mapScale:MapScale;
		private var title:Title;
		private var info:Info;
		private var totalc:TotalContainer;
		private var clockTimer:Scheduler;
		private var notice:Notice;
		private var noticeTween:Tween;
		private var qrcode:LinkQRcode;
		
		
		private var stage_w:Number = 0;
		private var stage_h:Number = 0;
		private var activate:Boolean = true;
		private static const DEFAULT_FRAME_RATE:int = 24;
		private static const NAME:String = "Tudou data monitor center.";
		
	}
	
}