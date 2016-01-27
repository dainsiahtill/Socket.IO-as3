package com.titan.socketio.transports 
{
	import flash.net.URLVariables;
	/**
	 * ...
	 * @author DainSiahTill
	 */
	public class XHRTransport extends BaseTransport
	{
		
		public function XHRTransport(url:String) 
		{
			super(url);
		}
		
		public override function open():void 
		{
			super.open();
			
			var vars:URLVariables = new URLVariables();
			vars["EIO"] = 3;
			vars["transport"] = "polling";
			vars["t"] = new Date().getTime() + "-0";
			_polling.request(_url, vars);
		}
	}

}