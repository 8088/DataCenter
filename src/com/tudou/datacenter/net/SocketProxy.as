package com.tudou.datacenter.net 
{
	import com.tudou.utils.Debug;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.Socket;
	import flash.system.Security;
	import flash.utils.ByteArray;
	/**
	 * ...
	 * @author 8088
	 */
	public class SocketProxy extends EventDispatcher
	{
		private var socket:Socket; 
		private var _port:int = 8810;
		private var _host:String = "10.155.9.49"; 
		
		private var connectting:Boolean = false;
		
		public function connect(host:String, port:int) : void{ 
			this._host = host;
			this._port = port;
			/*Debug.log(Security.sandboxType);
			{
				//Debug.log("load crossdomain.xml...");
				Security.allowDomain(host);
				Security.loadPolicyFile("xmlsocket://" + host + ":843");
			}*/
			
			if(!socket){
				socket = new Socket();
				socket.addEventListener(Event.CLOSE, closeHandler);
				socket.addEventListener(Event.CONNECT, connectHandler);
				socket.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
				socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
				socket.addEventListener(ProgressEvent.SOCKET_DATA, socketDataHandler);
			}
			
			socket.connect(host, port);
		}
		
		private function connectHandler(evt:Event):void {
			connectting = true;
			dispatchEvent(evt);
		}
		
		private function ioErrorHandler(evt:IOErrorEvent):void {
			dispatchEvent(evt);
		}
		
		private function socketDataHandler(evt:ProgressEvent):void {
			dispatchEvent(evt); 
		}
		
		private function closeHandler(evt:Event):void {
			connectting = false;
			dispatchEvent(evt); 
		}
		
		private function securityErrorHandler(evt:SecurityErrorEvent):void
		{
			dispatchEvent(evt);
		}
		
		public function writeBytes(bytes:ByteArray):void { 
			socket.writeBytes(bytes); 
			socket.flush(); 
		}
		
		public function flush():void { 
			socket.flush(); 
		}
		
		public function readBytes():ByteArray { 
			var bs:ByteArray = new ByteArray();
			socket.readBytes(bs);
			return bs;
		}
		
		public function close():void {
			socket.close(); 
		}
		
		public function isConnectting():Boolean{
			return connectting;
		}
		
		
		public function get host():String { 
			return _host; 
		}
		
		public function get port():int { 
			return _port; 
		}
		
		public function get bytesAvailable():uint {
			return socket.bytesAvailable;
		}
		
		public function writeByte(value:int):void {
			socket.writeByte(value);
		}
	}

}