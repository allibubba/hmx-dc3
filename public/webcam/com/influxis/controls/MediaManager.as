﻿/**
 * Copyright © 2010 Influxis All rights reserved.
 **/
package com.influxis.controls 
{
	import com.influxis.events.ActivityLevelEvent;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.media.Camera;
	import flash.media.Microphone;
	import flash.net.SharedObject;
	import flash.utils.Timer;
	
	
	public class MediaManager extends EventDispatcher
	{
		public static const MIC_CHANGE:String = 	"micChange";
		public static const CAM_CHANGE:String = 	"camChange";
		public static const READY:String = 			"ready";
		public static const MIC_VOLUME:String = 	"micVolume";
		public static const MIC_RATE_CHANGE:String = "micRateChange";
		public static const MIC_GAIN_CHANGE:String = "micGainChange";
		
		public static var DEFAULT_MIC_GAIN:Number = 	70;
		public static var DEFAULT_MIC_RATE:Number = 	15;
		public static var DEFAULT_CAM_WIDTH:Number = 	320;
		public static var DEFAULT_CAM_HEIGHT:Number = 	240;
		public static var DEFAULT_CAM_FPS:Number =		15;
		public static var DEFAULT_CAM_QUALITY:Number = 	80;
		public static var DEFAULT_CAM_BANDWIDTH:Number = 0;
		public static var DEFAULT_MIC_SILENCELEVEL:Number = 1;
		
		public var mic:Microphone;
		public var cam:Camera;
		public var volumeCheckSpeed:int =	 		100;
		public var isReady:Boolean = 				false;
		
		public var supressEcho:Boolean = 			true;
		
		protected var _selCamIndex:int;
		protected var _selMicIndex:int;
		protected var _checkMicVolumeActivity:Boolean = false;
		protected var _activityCheck:Timer;
		protected var so:SharedObject;
		
		//MIC settings
		protected var _gain:Number;
		protected var _micRate:Number;
		
		//CAM settings
		protected var _camWidth:Number;
		protected var _camHeight:Number;
		protected var _fps:Number;
		protected var _camQuality:Number;
		protected var _bw:Number;
		
		public function MediaManager()
		{
		}
		
		protected function updateMicGain():void
		{
			if( this.mic == null ) return;
			//tracer("updateMicGain "+this._gain);
			this.mic.gain = this._gain;
		}
		
		protected function updateMicRate():void
		{
			if( this.mic == null ) return;
			//tracer("updateMicRate "+this._micRate);
			this.mic.rate = this._micRate;
		}
		
		protected function updateCamMode():void
		{
			if( cam == null ) return;
			//tracer( "updateCamMode "+this._camWidth+", "+this._camHeight+", "+this._fps );
			this.cam.setMode( this._camWidth, this._camHeight, this._fps );
		}
		
		protected function updateCamQuality():void
		{
			if( cam == null ) return;
			//tracer( "updateCamQuality "+this._camQuality+", "+this._bw );
			this.cam.setQuality( this._bw, this._camQuality );
		}
		
		//dispatch event of activity.
		protected function updateVolumeActivity( p_e:TimerEvent=null ):void
		{
			if( mic == null ) return;
			var level:Number = mic.activityLevel/100;
			//trace(mic.activityLevel)
			if( level < 0 ) level = 0;
			dispatchEvent( new ActivityLevelEvent( MediaManager.MIC_VOLUME, level, mic ) );
		};
		
		
		//PUBLIC
		
		public function init():void
		{
			so = SharedObject.getLocal( "camSettings" );
			if( mic == null ) setMic( Microphone.getMicrophone().name );
			if( cam == null ) setCam( Camera.getCamera().name );
			
			isReady = true;
			this.dispatchEvent( new Event(MediaManager.READY) );
		};
		
		//sets a mic based on name.
		public function setMic( p_s:String ):void
		{
			//tracer("setMic "+p_s );
			var micNames:Array = Microphone.names;
			var micLen:int = micNames.length;
			if( micLen == 0 ) return;
			var micSelName:String = p_s;
			var micSelInt:int;
			for( var i:int=0; i<micLen; i++ ){
				if( micNames[i].indexOf( micSelName ) == 0 ){
					micSelInt = i;
					break;
				}
			}
			if( !isNaN(micSelInt) ) this.selectedMicIndex = micSelInt;
		}
		
		//sets a cam based on name.
		public function setCam( p_s:String ):void
		{
			//tracer("setCam "+p_s );
			//set mic based on id provided.
			var camNames:Array = Camera.names;
			var camLen:int = camNames.length;
			if( camLen == 0 ) return;
			
			var camSelName:String = p_s;
			var camSelInt:int = 0;
			for( var i:int=0; i<camLen; i++ ){
				if( camNames[i].indexOf( camSelName ) == 0 ){
					camSelInt = i;
					break;
				}
			}
			if( !isNaN(camSelInt) ) this.selectedCamIndex = camSelInt;
		}
		
		public function setCamSizeProps( p_width:Number, p_height:Number, p_fps:int=-1 ):void
		{
			//tracer( "camSizeProps "+p_width+", "+p_height+" "+p_fps );
			
			var update:Boolean = false;
			if( p_width != this._camWidth ){
				this._camWidth = p_width;
				update = true;
			}
			if( p_height != this._camHeight ){
				this._camHeight = p_height;
				update = true;
			}
			
			if( p_fps > -1 && p_fps != this._fps) {
				this._fps = p_fps;
				update = true;
			}
			if( update ){
				this.updateCamMode();
			}
			
		}
		
		public function setCamQuality( p_n:int, p_bw:int=-1 ):void
		{
			//tracer("setCamQuality");
			var update:Boolean = false;
			if( p_n != this._camQuality ){
				this._camQuality = p_n;
				update = true;
			}
			
			if( p_bw > -1 && p_bw != this._bw ){
				this._bw = p_bw;
				update = true;
			}
			if( update ){
				this.updateCamQuality();
			}
		}
		
		//GETTERS AND SETTERS
		
		//sets a mic based on index.
		public function set selectedMicIndex( p_n:int ):void
		{
			//update mic input.
			var m:Microphone = Microphone.getMicrophone( p_n );
			if( m == null ) return;
			mic = m;
			mic.setUseEchoSuppression( supressEcho );
			//setLoopBack to true and mute mic
			mic.setSilenceLevel(MediaManager.DEFAULT_MIC_SILENCELEVEL);
			_selMicIndex = p_n;
			
			//if check volume is true / false need to set.
			this.checkMicVolumeActivity = _checkMicVolumeActivity;
			
			//if local settings are null, 
			if( !isNaN(this._gain) ){
				//tracer("updated mic from last "+this._gain);
				this.updateMicGain();
			}
			else if( !isNaN(MediaManager.DEFAULT_MIC_GAIN) ){
				//tracer("updated mic from Defaults "+MediaManager.DEFAULT_MIC_GAIN);
				this._gain = MediaManager.DEFAULT_MIC_GAIN;
			}//if defaults are null set what is in actual media
			else {
				//tracer("updated from mic "+mic.gain);
				//set vars
				this._gain = mic.gain;
			}
			updateMicGain();
			dispatchEvent( new Event( MediaManager.MIC_CHANGE ) );
		};
		
		public function get selectedMicIndex():int
		{
			return _selMicIndex;
		}
		
		public function set selectedCamIndex( p_n:int ):void
		{
			//tracer("selectedCamIndex index "+_selCamIndex+" -> "+p_n);
			//update cam input
			var c:Camera = Camera.getCamera( (p_n).toString() );
			if( c == null ) return;
			cam = c;
			//update cam index.
			_selCamIndex = p_n;
			
			//if local settings are null, 
			if( !isNaN(this._camWidth) && !isNaN(this._camHeight) ){
				//tracer("updated cam from last "+this._camWidth);
			}
			else if( !isNaN(MediaManager.DEFAULT_CAM_WIDTH) && !isNaN(MediaManager.DEFAULT_CAM_HEIGHT) ){
				//tracer("updated cam from Defaults "+MediaManager.DEFAULT_CAM_WIDTH);
				_camWidth = MediaManager.DEFAULT_CAM_WIDTH;
				_camHeight = MediaManager.DEFAULT_CAM_HEIGHT;
				_fps = MediaManager.DEFAULT_CAM_FPS;
				_camQuality = MediaManager.DEFAULT_CAM_QUALITY;
				_bw = MediaManager.DEFAULT_CAM_BANDWIDTH;
			}//if defaults are null set what is in actual media
			else {
				//tracer("updated from camera "+cam.width);
				//set vars
				_camWidth = cam.width;
				_camHeight = cam.height;
				_fps = cam.fps;
				_camQuality = cam.quality;
				_bw = 0;//cam.bandwidth;
			}
			updateCamMode();
			updateCamQuality();
			dispatchEvent( new Event( MediaManager.CAM_CHANGE ) );
		};
		
		public function get selectedCamIndex():int
		{
			return _selCamIndex;
		}
		
		public function get camList():Array
		{
			return Camera.names;
		}
		
		public function get micList():Array
		{
			return Microphone.names;
		}
		
		//creates an interval to dispatch mic activity
		public function set checkMicVolumeActivity( p_b:Boolean ):void
		{
			this._checkMicVolumeActivity = p_b;
			if( _activityCheck != null ){
				if( _activityCheck.running ) {
					_activityCheck.stop();
					_activityCheck.removeEventListener( TimerEvent.TIMER, updateVolumeActivity );
				}
			}
			
			if( this._checkMicVolumeActivity ) {
				if( isNaN(volumeCheckSpeed) || volumeCheckSpeed < 100 ) volumeCheckSpeed = 100;
				_activityCheck = new Timer( volumeCheckSpeed, 0 );
				_activityCheck.addEventListener( TimerEvent.TIMER, updateVolumeActivity );
				_activityCheck.start();
				updateVolumeActivity();
			}
		}
		public function get checkMicVolumeActivity():Boolean
		{
			return this._checkMicVolumeActivity;
		}
		
		//MIC SETTINGS
		public function set micGain( p_int:int ):void
		{
			_gain = p_int < 0 ? 0 : p_int > 100 ? 100 : p_int;
			this.updateMicGain();
			dispatchEvent( new Event( MediaManager.MIC_GAIN_CHANGE ) );
		}
		public function get micGain():int
		{
			return this.mic == null ? 0 : this.mic.gain;
		}
		
		public function set micRate( p_n:int ):void
		{
			if( p_n == 0 ) return;
			_micRate = p_n;
			updateMicRate();
			dispatchEvent( new Event( MediaManager.MIC_RATE_CHANGE ) );
		}
		public function get micRate():int
		{
			return this.mic == null ? 0 : this.mic.rate;
		}
		
		//CAM SETTINGS
		
		public function set camFps( p_n:int ):void
		{
			if( p_n == this._fps ) return;
			this._fps = p_n;
			this.updateCamMode();
		}
		public function get camFps():int
		{
			return this._fps;
		}
		
		public function set camQuality( p_n:int ):void
		{
			this.setCamQuality( p_n );
		}
		public function get camQuality():int
		{
			return this.cam == null ? 0 : this.cam.quality;
		}
		
		public function set camBandwidth( p_n:int ):void
		{
			this.setCamQuality( this.cam == null ? MediaManager.DEFAULT_CAM_QUALITY : camQuality, p_n );
		}
		public function get camBandwidth():int
		{
			return this.cam == null ? -1 : this.cam.bandwidth;
		}
		
		public function get camWidth():int
		{
			return this.cam == null ? 0 : this.cam.width;
		}
		
		public function get camHeight():int
		{
			return this.cam == null ? 0 : this.cam.height;
		}
		
		private function tracer( p_msg:* ):void
		{
			//trace( "#MediaManager#  "+p_msg );
		}
	}
	
}