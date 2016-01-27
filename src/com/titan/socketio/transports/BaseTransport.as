package com.titan.socketio.transports 
{
	import com.titan.Polling;
	import com.titan.socketio.data.Packet;
	import com.titan.socketio.events.TransportEvent;
	import com.titan.socketio.parsers.IParser;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	[Event(name = "trans_open", type = "com.titan.socketio.events.TransportEvent")] 
	[Event(name = "trans_close", type = "com.titan.socketio.events.TransportEvent")] 
	[Event(name = "trans_error", type = "com.titan.socketio.events.TransportEvent")] 
	[Event(name = "trans_data", type = "com.titan.socketio.events.TransportEvent")] 
	[Event(name = "trans_packet", type = "com.titan.socketio.events.TransportEvent")] 
	/**
	 * ...
	 * @author DainSiahTill
	 */
	public class BaseTransport extends EventDispatcher implements ITransport 
	{	
		protected var _readyState:String;
		protected var _url:String;
		protected var _polling:Polling;
		
		public function BaseTransport(url:String) 
		{
			_url = url;
			_polling = Polling.getInstance();
		}
		
		public function onOpen():void 
		{
			_readyState = "open";
			
			dispatchEvent(new TransportEvent(TransportEvent.OPEN));
		}
		
		public function onClose():void 
		{
			dispatchEvent(new TransportEvent(TransportEvent.CLOSE));
		}
		
		public function onError(err:Error):void 
		{
			dispatchEvent(new TransportEvent(TransportEvent.ERROR, null, null, err));
		}
		
		public function onData(data:Object):void 
		{
			dispatchEvent(new TransportEvent(TransportEvent.DATA, data));
		}
		
		public function onPacket(packet:Packet):void 
		{
			dispatchEvent(new TransportEvent(TransportEvent.PACKET, null, packet));
		}
		
		public function open():void 
		{
			_readyState = "opening";
			
			_polling.setTransport(this);
		}
		
		
		public function getReadyState():String 
		{
			return _readyState;
		}
		
		public function setReadyState(state:String):void 
		{
			_readyState = state;
		}
		
	}

}