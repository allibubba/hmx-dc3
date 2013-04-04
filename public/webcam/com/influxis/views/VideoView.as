/**
 * Copyright © 2011 Influxis All rights reserved.
**/
package  com.influxis.views {
	import com.influxis.utils.SizeUtils;
	
	import flash.display.MovieClip;
	import flash.media.Video;
	import flash.media.Camera;
	import flash.net.NetStream;
	
	public class VideoView extends MovieClip{
		//
		protected var _nWidth:Number = 320;
		protected var _nHeight:Number = 240;
		protected var _camera:Camera;
		//UI
		public var video:Video;
		public var bg:MovieClip;
		
		public function VideoView() {
			
		}
		public function setDimensions( p_nWidth:Number, p_nHeight:Number):void{
			this._nWidth = p_nWidth;
			this._nHeight = p_nHeight;
			
			SizeUtils.maintainAspectRatio( this.video, this.bg.width, this.bg.height, this._nWidth, this._nHeight );
			SizeUtils.movePosition( this.video, this.bg.width, this.bg.height, SizeUtils.CENTER, SizeUtils.MIDDLE );
		}
		public function clear():void{
			this.video.clear()
		}
		public function set camera(p_camera:Camera):void {
			_camera = p_camera;			
			if(_camera != null){
				this.video.clear();
				this.video.attachCamera(_camera)
			}			
		}
		public function get camera():Camera {
			return _camera;
		}		
		public function set stream(p_stream:NetStream):void {
			if(p_stream != null){
				this.video.clear();
				this.video.attachNetStream(p_stream)
			}			
		}
	}
	
}
