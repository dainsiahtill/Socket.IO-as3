package com.titan.socketio 
{
	
	/**
	 * ...
	 * @author DainSiahTill
	 */
	public interface ISocketIO 
	{
		function connect(url:String):void;
		function on(event:String, func:Function):void;
		function emit(event:String, data:Object):void;
		function close():void;
	}
	
}