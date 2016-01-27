package com.titan.socketio.transports 
{
	import com.titan.socketio.data.Packet;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author DainSiahTill
	 */
	public interface ITransport 
	{
		function onOpen():void;
		function onClose():void;
		function onError(err:Error):void;
		function onData(data:Object):void;
		function onPacket(packet:Packet):void;
		
		function getReadyState():String;
		function setReadyState(state:String):void;
	}
	
}