/**
 * Copyright © 2011 Influxis All rights reserved.
**/
package  {
	import flash.display.MovieClip;
	import flash.media.Camera;
	import flash.media.SoundTransform;
	import flash.utils.Timer;
	import flash.events.Event;
	import flash.events.TimerEvent;	
	import flash.external.*;
	
	import com.influxis.views.MediaView;
	import com.influxis.views.VideoView;
	import com.influxis.views.MenuView;
	import com.influxis.views.StatusPanelView;
	import com.influxis.events.SimpleEvent;
	import com.influxis.events.ActivityLevelEvent;	
	import com.influxis.controls.MediaManager;	
	import com.influxis.fms.controls.NetController;
	import com.influxis.fms.controls.StreamController;	
	
	
	public class Main extends MovieClip{		
		//connection path used to connect user and FMS server.
		public var rtmp:String = "rtmp://emgklovf.rtmphost.com/recorder";
		//Control
		protected var media:MediaManager;  // gets/handles the camera and microphone devices detected by the Flash Player.
		protected var con:NetController;   // creates and handles the connection between the client and Flash Media Server.
		protected var sc:StreamController; // creates and handles the stream used to record and playing back.
		//UI/View
		public var mdv:MediaView;          // displays the available the names for the camera and microphone devices provided by the MediaManager class.
		public var sp:StatusPanelView;     // displays various states and alerts built into the application.
		public var video:VideoView;        // video class used to display the chosen camera device.
		public var mv:MenuView;		       // interface controls.
		//Misc.
		protected var tm:Timer;
		protected var tmCountDown:Timer;
		protected var nDuration:Number = 0;
		protected var bRecMode:Boolean;
		protected var bSubmitted:Boolean = false;
		protected var nRecLimit:int = 30;// time in seconds
		/*
		** Within the Main constructor we display an initializing message
		** while we construct and add event listeners tp an instance of the MediaManager class.
		*/
		public function Main() {			
			this.sp.msg = "Initializing...";
			
			this.media = new MediaManager();
			this.media.addEventListener( MediaManager.READY, mediaHandler );
			this.media.addEventListener( MediaManager.CAM_CHANGE, mediaHandler );
			this.media.addEventListener( MediaManager.MIC_CHANGE, mediaHandler );
			this.media.addEventListener( MediaManager.MIC_VOLUME, micHandler );
			this.media.init();
			
			this.mdv.visible = false;
			this.sp.enableChildern = false;	
			
			/* 
			** Here nRecLimit is checked for a time limit. If a time limit is set then we display a new version of the
			** doFinish state.
			*/
			if(nRecLimit > 0){
				this.mv.doFinish(nRecLimit);
			}
		}
		/*
		** Within the init function the MediaView instance is popluated with a list/array of detected camera 
		** and microphone devices. The init function also creates and connect an instance of the NetController class.
		*/
		protected function init():void{
			this.sp.msg = "Connecting...";
			
			this.media.mic.soundTransform = new SoundTransform(0, 0);
			this.media.mic.setLoopBack(true);
			
			this.mdv.setCams = this.media.camList;
			this.mdv.setMics = this.media.micList;
			this.mdv.addEventListener(MediaView.CHANGE, mdvHandler);
			
			this.doCamera();
			
			this.con = new NetController();
			this.con.addEventListener( NetController.CONNECTED, conHandler );
			this.con.addEventListener( NetController.DISCONNECTED, conHandler );
			this.con.addEventListener( NetController.SERVER_RESPONSE, conssHandler );
			this.con.connect( rtmp );
		}
		/*
		** The doReady creates an instance of the StreamController class responsible for handling the NetStream.
		** Also within our doReady method we enable the interface the user will be using to interact with the application.
		*/
		protected function doReady():void{
			this.sp.msg = "Connected."
			this.sp.visible = false;
			this.sp.msg = "";
			
			this.sc = new StreamController();
			this.sc.addEventListener( StreamController.STATUS, scHandler );
			this.sc.streamName = this.con.client_id;
			
			trace(this.sc.streamName);
			
			
			this.tm = new Timer(500);
			this.tm.addEventListener(TimerEvent.TIMER, tmHandler)
			
			this.mv.addEventListener(MenuView.ON_CLICK, mvHandler);
			this.mv.addEventListener(MenuView.ON_SLIDE, mvHandler);
			this.mv.init();
						
			this.sp_mask.visible=false
		}
		/*
		** The doCamera method retreives the currently selected camera source from the MediaManager instance
		** and attaches it to the VideoView instance.
		*/
		protected function doCamera():void{			
			var cam:Camera = this.media.cam;
			this.video.camera = cam;			
			this.video.setDimensions(cam.width, cam.height);
		}
		
		
		/*
		** The doRecord connects the NetStream within the StreamController instance and begins recording from 
		** the set media sources.
		*/
		protected function doRecord():void{
			if(this.sc.netStream == null){
				this.sc.connect(this.con.netConnection);
				this.sc.netStream.attachCamera(this.media.cam);
				this.sc.netStream.attachAudio(this.media.mic)
			}			
			this.sc.doRecord();
			this.bRecMode = true;
			this.mdv.visible = false;
		}
		/*
		** The doTime method retrieves the publish and playback time of a stream and displays is via the MenuView instance. or playback.
		** If in playback mode doTime also updates the scrubber component.
		*/
		protected function doTime():void{
			var time:Number = Math.round(this.sc.time);
			this.mv.doTime(time)
			this.mv.doSeek(time)
			if(bRecMode){
				if(time >= nRecLimit){
					//stop
					this.sc.doClose();
				}
			}
		}
		/*
		** The onFinish method disables the mircophone activity listener, set the controls to the retake state and retrieves the file information for the recording.
		*/
		protected function onFinish():void{
			this.media.checkMicVolumeActivity = false;			
			this.mv.doRetake();		
			this.con.call("getFileInfo");
		}
		/*
		** The doRetake method closes the NetStream within the StreamController instance, enables the mircophone activity listener,and sets the controls to the finish state. 
		*/
		protected function doRetake():void{
			this.sc.doClose();
			this.doCamera();
			this.media.checkMicVolumeActivity = true;
			this.nDuration = 0;
			this.mv.doSeek(nDuration)
			
			if(nRecLimit > 0){
				this.mv.doFinish(nRecLimit);
			}else{
				this.mv.doFinish();
			}
		}
		/*
		** The doSubmit method displays a successfully submitted message to the client, then closes the connection 
		** to the server.
		*/
		protected function doSubmit():void{
			this.sp.msg = "Your recording has been successfully submitted."
			this.sp.visible = true;
			this.sp_mask.visible = true;
			this.bSubmitted = true;
			ExternalInterface.call("logVidId", this.sc.streamName);
			this.con.close();
			this.video.clear();
		}
		/*
		** The conHandler handles CONNECTED and DISCONNECTED event type dispatched by the NetController class.			
		*/
		protected function conHandler( p_e:Event ):void{
			var type = p_e.type;
			//trace(type)
			switch( type ){
				case NetController.CONNECTED:					
					this.doReady()
					break
				case NetController.DISCONNECTED:
					if(bSubmitted){
						this.sp.msg = "Your session is now over."
					}else{
						this.sp.msg = "Disconnected."
					}
					break
			}
		}
		/*
		** The conssHandler handles the SERVER_RESPONSE event type dispatched by the NetController class.			
		*/
		protected function conssHandler( p_e:SimpleEvent ):void{
			var code:String = p_e.code;
			switch( code ){
				case "Client.File.Information":
					this.nDuration = p_e.data.length;
					this.mv.doDuration(nDuration)
					break
				case "Client.Submit.Status":
					if(p_e.data.submitted == true){
						this.doSubmit()
					}
					break
			}
		}
		/*
		** The mediaHandler handles the READY, CAM_CHANGE, and MIC_CHANGE event types dispatched by the MediaManager class.		
		*/
		protected function mediaHandler( p_e:Event ):void{
			var type = p_e.type;
			switch( type ){
				case MediaManager.READY:
					this.init()				
					break
				case MediaManager.CAM_CHANGE:
					this.doCamera()					
					break
				case MediaManager.MIC_CHANGE:
					this.media.checkMicVolumeActivity = true;
					break
			}
		}
		/*
		** The mdvHandler handles the CHANGE event type dispatched by the MediaView class.		
		*/
		protected function mdvHandler( p_e:SimpleEvent ):void{
			var code:String = p_e.code;
			var data:Object = p_e.data
			switch( code ){
				case "MediaView.Camera.Update":				
					this.media.setCam(data.item);
					
					break;
				case "MediaView.Microphone.Update":
					this.media.setMic(data.item);
					break;
			}
		}
		/*
		** The scHandler handles the STATUS event type dispatched by the StreamController class.
		*/
		protected function scHandler( p_e:SimpleEvent ):void{
			var code:String = p_e.code;
			switch( code ){
				case "NetStream.Record.Start":
					this.mv.doRecord();
					this.tm.start();
					break
				case "NetStream.Record.Stop":
					this.onFinish();
					this.tm.stop();
					break
				case "NetStream.Play.Start":
					this.bRecMode = false;
					this.video.stream = sc.netStream;
					this.mv.doPlay();
					this.tm.start()
					break
				case "NetStream.Play.Complete":
					this.mv.doPause();
					this.mv.doTime(this.nDuration)
					this.tm.stop()
					break
				case "NetStream.Pause.Notify":
					this.mv.doPause();
					this.tm.stop()
					break
				case "NetStream.Seek.Notify":
					this.sc.doPlay()
					break
			}			
		}
		/*
		** The mvHandler handles the ON_CLICK and ON_SLIDE event types dispatched by the MenuView class. 
		*/
		protected function mvHandler( p_e:SimpleEvent ):void{
			var code:String = p_e.code;
			switch( code ){
				case "record":
					this.doRecord();
					break;
				case "media":
					this.mdv.visible = true;
					break;
				case "finish":
					this.sc.doClose();
					break
				case "play":
					this.sc.doPlay()
					break;
				case "pause":
					this.sc.doPause()
					break;
				case "slide.down":
					tm.stop()
					break;
				case "slide.up":
					var n:Number = Number(p_e.data)
					sc.doSeek(n)
					break;
				case "retake":
					this.doRetake();					
					break;
				case "submit":
					this.con.call("submit");
					break;
			}			
		}
		/*
		** The tmHandler handles the TIMER event type dispatched by the tm:Timer class.
		*/
		protected function tmHandler( p_e:TimerEvent ):void{
			this.doTime();	
		}
		/*
		** The micHandler handles the microphone activity level dispatched from the MediaManager.
		*/
		protected function micHandler( p_e:ActivityLevelEvent ):void{
			var level:Number = p_e.activityLevel;
			this.mv.doMic(level)
		}
	}
	
}
