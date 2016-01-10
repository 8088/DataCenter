package com.tudou.datacenter.net.tstp
{
	import __AS3__.vec.Vector;
	import com.tudou.datacenter.util.BytesUtil;
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	

	public class DataBeanBuffer
	{
		private var tempBytes:ByteArray = new ByteArray();
		private var encoding:String = "utf-8";
		
		public function DataBeanBuffer(encoding:String) {
			this.encoding = encoding;
		}
		
		private var i:int = 0;
		public function fillBytes2(bs:ByteArray, offst:int = 0 , len:int = -1):Vector.<DataBean>
		{
			bs.position = 0;
			if(-1 == len){
				len = bs.length - offst;
			}
			//bsBuffer.writeBytes(bs, offst, len);
			
			var temp:ByteArray = new ByteArray();
			temp.writeBytes(bs, offst, len);
			temp.endian = Endian.LITTLE_ENDIAN;
			
			var dataBeans:Vector.<DataBean> = new Vector.<DataBean>();
			i = 0;
			while(null != temp && temp.length >= 12){
				temp.position = 0;
				
				var version:uint = temp.readUnsignedInt();
				
				var headLenInt:uint = temp.readUnsignedInt();
				
				var dataLenInt:uint = temp.readUnsignedInt();
				
				if (version > 0) break;
				
				if(temp.bytesAvailable < headLenInt + dataLenInt){
					break;
				}
				var headData:ByteArray = new ByteArray();
				temp.readBytes(headData, 0, headLenInt);
				
				var data:ByteArray = new ByteArray();
				temp.readBytes(data, 0, dataLenInt);
				
				var dataBean:DataBean = new DataBean(encoding, version, headData, data);
				dataBeans.push(dataBean);
				i++;
				if (i > 1) temp.clear();
			}
			temp.clear();
			
			return dataBeans;
		}
		
		public function fillBytes(bs:ByteArray, offst:int = 0 , len:int = -1): Vector.<DataBean>{
			bs.position = 0;
			if(-1 == len){
				len = bs.length - offst;
			}
			
			tempBytes.position = tempBytes.length;
			tempBytes.writeBytes(bs, offst, len);
			
			var dataBeans:Vector.<DataBean> = new Vector.<DataBean>();
			while(null != tempBytes && tempBytes.length >= 12){
				var tmp:ByteArray = new ByteArray();
				tempBytes.position = 0;
				
				tmp.clear();
				tempBytes.readBytes(tmp, 0, 4);
				var version:int = BytesUtil.toInt(tmp);
				
				tmp.clear();
				tempBytes.readBytes(tmp, 0, 4);
				var headLenInt:int = BytesUtil.toInt(tmp);
				
				tmp.clear();
				tempBytes.readBytes(tmp, 0, 4);
				var dataLenInt:int = BytesUtil.toInt(tmp);
				
				if(tempBytes.bytesAvailable < headLenInt + dataLenInt){
					break;
				}
				
				var headData:ByteArray = new ByteArray();
				tempBytes.readBytes(headData, 0, headLenInt);
				
				var data:ByteArray = new ByteArray();
				tempBytes.readBytes(data, 0, dataLenInt);
				
				var dataBean:DataBean = new DataBean(encoding, version, headData, data);
				
				dataBeans.push(dataBean);
				
				tmp.clear();
				tmp.writeBytes(tempBytes, tempBytes.position, tempBytes.bytesAvailable);
				tempBytes = tmp;
			}
			
			return dataBeans;
		}
	}
}