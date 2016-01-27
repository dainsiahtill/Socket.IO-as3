package com.titan.socketio.events 
{
	import com.titan.socketio.data.Packet;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author DainSiahTill
	 */
	public class TransportEvent extends Event 
	{
		
		public static const OPEN:String = "trans_open";
		
		public static const CLOSE:String = "trans_close";
		
		public static const ERROR:String = "trans_error";
		
		public static const DATA:String = "trans_data";
		
		public static const PACKET:String = "trans_packet";
		
		public var data:Object;
		public var packet:Packet;
		public var error:Error;
		
		public function TransportEvent(type:String, data:Object = null, packet:Packet = null, error:Error = null) 
		{ 
			super(type, false, false);
			
			this.data = data;
			this.packet = packet;
			this.error = error;
		} 
		
	}
	
}