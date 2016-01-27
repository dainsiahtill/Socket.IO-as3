package com.titan.socketio.data 
{
	import flash.utils.ByteArray;
	/**
	 * ...
	 * @author DainSiahTill
	 */
	public class Uint8Array 
	{
		public var data:Array;
		
		public function Uint8Array(bytes:ByteArray) 
		{
			data = [];
			
			bytes.position = 0;
			while (bytes.bytesAvailable) 
			{
				data[bytes.position] = bytes.readByte() & 0xff;
			}
		}
		
	}

}