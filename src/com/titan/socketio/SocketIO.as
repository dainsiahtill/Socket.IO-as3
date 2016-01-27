package com.titan.socketio 
{
	import com.titan.socketio.core.Emitter;
	import com.titan.socketio.events.EmitterEvent;
	import com.titan.socketio.events.TransportEvent;
	import com.titan.socketio.transports.BaseTransport;
	import com.titan.socketio.transports.ITransport;
	import com.titan.socketio.transports.WebSocketTransport;
	import com.titan.socketio.transports.XHRTransport;
	import flash.events.Event;
	/**
	 * ...
	 * @author DainSiahTill
	 */
	public class SocketIO implements ISocketIO
	{
		private var _transport:BaseTransport;
		
		private var _emitter:Emitter;
		
		private var _url:String;
		
		private var _readyState:String;
		
		public function SocketIO() 
		{
			_emitter = new Emitter();
		}
		
		public function connect(url:String):void 
		{
			_url = url;
			
			_transport = new XHRTransport(_url);
			_transport.addEventListener(TransportEvent.PACKET, onPacket);
			_transport.open();
		}
		
		public function onHandshake(params:Object):void
		{
			_transport = new WebSocketTransport(_url);
		}
		
		public function onPacket(e:TransportEvent):void
		{
			
		}
		
		public function on(event:String, func:Function):void 
		{
			_emitter.addEventListener(event, func);
		}
		
		public function emit(event:String, data:Object):void 
		{
			_emitter.dispatchEvent(new EmitterEvent(event, data));
		}
		
		public function close():void 
		{
			
		}
		
	}

}