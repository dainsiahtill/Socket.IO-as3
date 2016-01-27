package
{
	import com.titan.socketio.SocketIO;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author DainSiahTill
	 */
	public class Main extends Sprite 
	{
		
		public function Main() 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			var socket:SocketIO = new SocketIO();
			socket.connect("http://virtualcontrol2.duapp.com/socket.io/");
			
			socket.on("connect", function ():void 
			{
				
			});
		}
		
	}
	
}