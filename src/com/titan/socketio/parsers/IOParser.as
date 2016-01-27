package com.titan.socketio.parsers 
{
	import com.titan.socketio.data.Packet;
	import com.titan.socketio.data.Uint8Array;
	import flash.utils.ByteArray;
	/**
	 * ...
	 * @author DainSiahTill
	 */
	public class IOParser implements IParser 
	{
		
		public function IOParser() 
		{
			
		}
		
		public function decodePacket(data:*, dataFormat:String):Packet 
		{
			return null;
		}
		
		public function encodePacket(packet:Packet):Packet 
		{
			return null;
		}
		
		public function decodePayload(data:*, dataFormat:String, callback:Function):void 
		{
			if (dataFormat == "binary")
			{
				decodePayloadAsBinary(data, dataFormat, callback);
			}
			else if (dataFormat == "text")
			{
				if (data == "")
				{
					callback(new Error("空数据包"), 0, 1);
					return;
				}
			}
		}
		
		public function encodePayload(packets:Array):void 
		{
			
		}
		
		public function decodePayloadAsBinary(data:*, dataFormat:String, callback:Function):void 
		{
			var bufferTail:ByteArray = data as ByteArray;
			var buffers:Array = [];
			
			var numberTooLong:Boolean = false;
			while (bufferTail.bytesAvailable > 0) 
			{
				var tailArray:Uint8Array = new Uint8Array(bufferTail);
				var isString:Boolean = tailArray.data[0] == 0;
				
				var tmp:String = "";
				
				for (var i:int = 1; ; i++) 
				{
					if (tailArray.data[i] == 0xff)
					{
						break;
					}
					
					if (tmp.length > 310)
					{
						numberTooLong = true;
						break;
					}
					
					tmp += tailArray.data[i];
				}
				
				if (numberTooLong)
				{
					callback(new Error("content is too large!"), 0, 1);
				}
				
				bufferTail = sliceBytes(bufferTail, 2 + tmp.length);
				var msgLength:int = int(tmp);
				var msg:* = sliceBytes(bufferTail, 0, msgLength);
				
				if (isString)
				{
					msg = msg.readUTFBytes(msg.length);
				}
				
				buffers.push(msg);
				bufferTail = sliceBytes(bufferTail, msgLength);
			}
			
			var total:int = buffers.length;
			
			for (var j:int = 0; j < total; j++) 
			{
				var buffer:Object = buffers[j];
				var packet:Packet = decodePacket(buffer, dataFormat);
				callback(packet, j, total);
			}
		}
		
		private function sliceBytes(bytes:ByteArray, start:int = 0, end:int = 0):ByteArray
		{
			var len:int = bytes.length;
			end = end == 0?len:end;
			
			bytes.position = start;
			
			var newBytes:ByteArray = new ByteArray();
			for (var i:int = start; i < end; i++)
			{
				newBytes.writeByte(bytes.readByte());
			}
			
			newBytes.position = 0;
			
			return newBytes;
		}
		
	}

}