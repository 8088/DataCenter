package com.tudou.datacenter.util
{
	import flash.utils.ByteArray;
	import flash.utils.Endian;

	public class BytesUtil
	{
		public function BytesUtil() {
		}
		
		public static function toBytes(n:int):ByteArray{
			var bs:ByteArray = new ByteArray();
			for(var i:int = 0; i < 4; i++){
				bs.writeByte(0xFF & (n >> i * 8));
			}
			return bs;
		}
		
		public static function toInt(bs:ByteArray):uint{
			var n:uint = 0;
			bs.position = 0;
			bs.endian = Endian.LITTLE_ENDIAN;
			n = bs.readUnsignedInt();
			return n;
		}
	}
}