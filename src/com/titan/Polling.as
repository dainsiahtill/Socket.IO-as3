package com.titan 
{
	import com.titan.socketio.data.Packet;
	import com.titan.socketio.parsers.IOParser;
	import com.titan.socketio.parsers.IParser;
	import com.titan.socketio.transports.BaseTransport;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	/**
	 * ...
	 * @author DainSiahTill
	 */
	public class Polling 
	{
		private var _loader:URLLoader;
		
		private var _transport:BaseTransport;
		
		private var _parser:IParser;
		
		private static var _instance:Polling;
		
		public function Polling(parser:IParser = null) 
		{
			_loader = new URLLoader();
			_loader.addEventListener(Event.COMPLETE, onLoaderComplete);
			_loader.addEventListener(IOErrorEvent.IO_ERROR, onLoaderIoError);
			_loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onLoaderSecurityError);
			_loader.dataFormat = URLLoaderDataFormat.BINARY;
			
			_parser = parser || new IOParser();
		}
		
		public function setTransport(transport:BaseTransport):void
		{
			_transport = transport;
		}
		
		public function request(url:String, params:URLVariables = null):void 
		{
			var req:URLRequest = new URLRequest(url);
			req.data = params;
			req.method = "get";
			
			_loader.load(req);
		}
		
		private function onLoaderSecurityError(e:SecurityErrorEvent):void 
		{
			_transport.onError(new Error(e.text));
		}
		
		private function onLoaderIoError(e:IOErrorEvent):void 
		{
			_transport.onError(new Error(e.text));
		}
		
		private function onLoaderComplete(e:Event):void 
		{
			var loader:URLLoader = e.currentTarget as URLLoader;
			
			_parser.decodePayload(loader.data, loader.dataFormat, onDecodePayloadCallback);
		}
		
		private function onDecodePayloadCallback(result:*, index:int, total:int):void
		{
			if (_transport.getReadyState() == "opening")
			{
				_transport.onOpen();
			}
			
			if (result is Packet)
			{
				var packet:Packet = result as Packet;
				if (packet.type == "close")
				{
					_transport.onClose();
					return;
				}
				
				_transport.onPacket(packet);
			}
		}
		
		public static function getInstance():Polling
		{
			if (_instance == null)
			{
				_instance = new Polling();
			}
			
			return _instance;
		}
		
	}

}