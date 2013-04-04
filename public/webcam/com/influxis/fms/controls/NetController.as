/**
 * Copyright © 2011 Influxis All rights reserved.
**/
package com.influxis.fms.controls
{
	import flash.events.EventDispatcher;
	import flash.events.Event;
	import flash.events.NetStatusEvent;
	import flash.net.NetConnection;
	import flash.net.Responder;
	
	import com.influxis.events.SimpleEvent

	public class NetController extends EventDispatcher
	{
		public static const CONNECTED:String 		= "connected";
		public static const DISCONNECTED:String 	= "disconnected";
		public static const SERVER_RESPONSE:String	= "server_response"
		public static const CLIENT_CALLED:String	= "client_called"

		public var netConnection:NetConnection;
		public var responder:Responder;
		public var path:String;
		public var id:String;

		public function NetController()
		{
			this.init();
		}
		/*
		** Called from client, the init method creates a NetConnection instance and 
		** a Responder in charge of handling server-side responses.
		*/
		public function init():void
		{
			netConnection = new NetConnection();
			netConnection.addEventListener( NetStatusEvent.NET_STATUS, netConnectionHandler );
			netConnection.client = this;

			responder = new Responder(serverResponseHandler);
		}
		/*
		** Called from client, the connect method checks for a valid string and 
		** then attempts a connection to the server by calling the NetConnections connect method.
		*/
		public function connect(p_string:String=null):void
		{
			if (p_string != null)
			{
				path = p_string;
				netConnection.connect(this.path);
			}			
		}
		/*
		** Called from client, the close method checks the NetConnecttion and if connected closes the NetConnection.
		*/
		public function close():void
		{
			if (netConnection.connected)
			{
				netConnection.close()
			}
		}
		/*
		** Called from client, the call method calls a method on server-side. The call method accepts two parameters;
		** the first is a string, defining the method to be called on the server and the second is an optional parameter
		** that can be of any ActionScript type.
		*/
		public function call(p_string:String, p_argument:*=null):void
		{
			var funct:String = p_string;
			
			if( p_argument != null ){
				netConnection.call( funct, responder, p_argument ) 
			}else{
				netConnection.call( funct, responder ) 
			}			
		}
		// called by server
		public function toClient(p_object):void
		{
			var code:String = p_object.code;
			var data:Object = p_object.data;
			
			if (p_object != null)
			{
				dispatchEvent(new SimpleEvent(NetController.CLIENT_CALLED, code, data));
			}			
		}
		/*
		** The netConnectionHandler handles the NetStatusEvent event type dispatched by the NetConnection class.
		*/
		protected function netConnectionHandler(p_e:NetStatusEvent):void
		{
			var code:String = p_e.info.code;
			switch (code)
			{
				case "NetConnection.Connect.Success" :
					this.call("connected");
					break;
				case "NetConnection.Connect.Closed" :
					dispatchEvent(new Event(NetController.DISCONNECTED));
					break;
			}
		}
		/*
		** The serverResponseHandler handles return values from the server-side.
		*/
		protected function serverResponseHandler(p_object:Object):void
		{
			var code:String = p_object.code;
			var data:Object = p_object.data; 
						
			if (p_object != null)
			{
				if(code == "Client.Connection.Success"){
					this.id = data.id;
					dispatchEvent(new Event(NetController.CONNECTED));
				}else{
					dispatchEvent(new SimpleEvent(NetController.SERVER_RESPONSE, code, data));	
				}
			}
		}		
		
		//GETTERS AND SETTERS
		
		/*
		** client_id proptery when requested by the client provides the id variable.
		*/
		public function get client_id():String
		{	
			return this.id;
			
		}
		//util method
		private function tracer(p_msg: * ):void
		{
			trace("#NetController#  " + p_msg);
		}
	}

}