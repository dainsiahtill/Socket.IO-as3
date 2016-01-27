package com.titan.socketio.parsers 
{
	import com.titan.socketio.data.Packet;
	
	/**
	 * ...
	 * @author DainSiahTill
	 */
	public interface IParser 
	{
		function decodePacket(data:*, dataFormat:String):Packet
		function encodePacket(packet:Packet):Packet
		function decodePayload(data:*, dataFormat:String, callback:Function):void;
		function encodePayload(packets:Array):void;
	}
	
}