package com.titan.socketio.events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author DainSiahTill
	 */
	public class EmitterEvent extends Event 
	{
		public var data:Object;
		
		public function EmitterEvent(type:String, data:Object) 
		{ 
			super(type, false, false);
			
			this.data = data;
		}
		
	}
	
}