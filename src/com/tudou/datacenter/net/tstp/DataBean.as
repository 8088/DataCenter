package com.tudou.datacenter.net.tstp
{
	import com.tudou.datacenter.util.BytesUtil;
	import com.tudou.datacenter.util.StringUtil;
	import flash.utils.ByteArray;
	

	public class DataBean
	{
		//新建对象  
		public var headers:Object = new Object();  
		
		public var version:uint;
		public var data:ByteArray;
		public var encoding:String = "utf-8";
		
		public function DataBean(encoding:String, version:uint = 0, header:ByteArray = null, data:ByteArray = null) {
			if(null != encoding){
				this.encoding = encoding;
			}
			this.version = version;
			
			if(null != header){
				header.position = 0;
				var headString:String = null;
				try{
					headString = header.readMultiByte(header.bytesAvailable, this.encoding);
				} catch (err:Error){
					trace(err.message);
				}
				var ss:Array = headString.split("\n");
				for(var i:int = 0; i < ss.length; i++){
					var s:String = ss[i];
					if(StringUtil.isTrimEmpty(s)){
						continue;
					}
					var key:String = StringUtil.getLeft(s, "=");
					var value:String = StringUtil.getRightOutter(s, "=");
					value = value.replace(/\\n/, "\n");
					value = value.replace(/\\\\/, "\\");
					var h:HeaderBean = new HeaderBean(key, value);
					headers[key] = h;
				}
			}
			
			this.data = data;
		}
		
		public function toBytes():ByteArray{
			var s:String = "";
			for each(var o:HeaderBean in headers){
				// trace(o.key + "=" + o.value);
				s += o.key + "=" + o.value.replace(/\n/, "\n").replace(/\\/, "\\") + "\n";
			}
			var header:ByteArray = new ByteArray();
			header.writeMultiByte(s, encoding);
			
			var bs:ByteArray = new ByteArray();
			
			bs.writeBytes(BytesUtil.toBytes(version));
			
			bs.writeBytes(BytesUtil.toBytes(header.length));
			
			if(null != data){
				bs.writeBytes(BytesUtil.toBytes(data.length));
			}else{
				bs.writeBytes(BytesUtil.toBytes(0));
			}
			
			bs.writeBytes(header, 0, header.length);
			if(null != data){
				bs.writeBytes(data, 0, data.length);
			}
			bs.position = 0;
			return bs;
		}
		
		public function getHeader(key:String) : HeaderBean{
			return headers[key];
		}
		
		public function getHeaderString(key:String):String{
			var hb:HeaderBean = getHeader(key);
			if(null != hb){
				return hb.value;
			}
			return null;
		}
		
		public function setData(data:ByteArray):void{
			this.data = data;
		}
		
		public function addHeader(header:HeaderBean):void{
			this.headers[header.key] = header;
		}
		
		public function toString():String{
			var s:String = "Version: " + version;
			s += "\n" + "Header: {";
			for each(var o:HeaderBean in headers){
				s += "\n\t" + o.key + ": " + o.value;
			}
			s += "\n}";
			try{
				data.position = 0;
				s += "\nContent: " + data.readMultiByte(data.bytesAvailable, encoding);
			}catch(err:Error){
				trace(err.message);
			}
			return s;
		}
		
	}
}		