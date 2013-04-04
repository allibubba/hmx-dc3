/**
 * Copyright © 2011 Influxis All rights reserved.
**/
package com.influxis.fms.controls {
	
	import flash.events.EventDispatcher;
	import flash.events.Event;
	import flash.events.NetStatusEvent;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	
	import com.influxis.events.SimpleEvent;
	
	public class StreamController extends EventDispatcher {
		public static const STATUS:String = "status";		
		
		public var netStream:NetStream;
		public var netStreamClient:Object;
		
		protected var netConnection:NetConnection;
		protected var STREAM_NAME:String;
		protected var bPlaying:Boolean = false;
		
		
		public function StreamController() {
			// constructor code
		}
		/*
		** Called from client, the connect method creates checks if the NetConnection parameter recieved is connected prior
		** to creating/connecting the NetStream instance.
		*/
		public function connect(p_nc:NetConnection):void{
			netConnection = p_nc;
			
			if(netConnection.connected){
				netStream = new NetStream(netConnection);
				netStreamClient = new Object()
				netStream.client = netStreamClient;
				netStreamClient.onMetaData = onMetaData;
				netStreamClient.onPlayStatus = onPlayStatus;
				netStream.addEventListener( NetStatusEvent.NET_STATUS, statusHandler );
			}			
		}
		/*
		** Called from client, the doRecord method when called excutes the NetStream publish method. 
		*/
		public function doRecord():void{
			netStream.publish(STREAM_NAME, "record");
		}
		/*
		** Called from client, the doClose method when called excutes the NetStream close method. 
		*/
		public function doClose():void{
			netStream.close();
		}
		/*
		** Called from client, the doPlay method checks the playback status of the NetStream. If the NetStream  
		*/
		public function doPlay():void{
			if(bPlaying == false){
				netStream.play(STREAM_NAME);
				bPlaying = true
			}else{
				doResume();
			}
		}
		/*
		** Called from client, the doResume method when called excutes the NetStream resume method. 
		*/
		public function doResume():void{
			netStream.resume();
		}
		/*
		** Called from client, the doPause method when called excutes the NetStream pause method. 
		*/
		public function doPause():void{
			netStream.pause();
		}
		/*
		** Called from client, the doSeek method accepts a numeric parameter which is used when excuting the NetStream 
		** seek method. 
		*/
		public function doSeek(p_n:Number):void{
			netStream.seek(p_n);
		}
		/*
		** The statusHandler handles the NetStatusEvent event type dispatched by the NetStream class.
		*/
		protected function statusHandler( evt:NetStatusEvent ):void{
			var code = evt.info.code;
			dispatchEvent(new SimpleEvent(StreamController.STATUS, code));
		}
		/*
		** The onMetaData handles metaData information embedded in a media file when playedback.
		*/
		protected function onMetaData( evt:Object ):void{
			netStreamClient.data = evt;
			dispatchEvent(new SimpleEvent(StreamController.STATUS, "NetStream.MetaData.Loaded"));			
		}
		/*
		** The onPlayStatus handles the NetStream reponse for .
		*/
		protected function onPlayStatus( evt:Object ):void{
			var code = evt.code;
			dispatchEvent(new SimpleEvent(StreamController.STATUS, code));
			if(code == "NetStream.Play.Complete"){
				bPlaying = false;
			}
		}
		//Setters
		/*
		** The streamName property, sets the STREAM_NAME value.
		*/
		public function set streamName( p_s:String ):void
		{
			STREAM_NAME = p_s;
		}
		//Getters
		/*
		** The streamName property, when requested return the STREAM_NAME value.
		*/
		public function get streamName():String
		{
			return STREAM_NAME;
		}
		/*
		** The time property, when requested returns the NetStream current time value.
		*/
		public function get time():Number
		{
			return netStream.time;
		}
		/*
		** The totalTime property, when requested returns the duration of the media file being played back.
		*/
		public function get totalTime():Number
		{
			return netStreamClient.data.duration;
		}
	}
	
}
