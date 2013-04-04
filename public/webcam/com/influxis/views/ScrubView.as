/**
 * Copyright © 2011 Influxis All rights reserved.
**/
package com.influxis.views {
	
	import com.influxis.events.ScrubEvent;
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;
	
	public class ScrubView extends MovieClip{
		//event
		public static var STATUS:String="status";	
		
		//properties values
		protected var _value:Number = 0;
		protected var _max:Number = 1;
		protected var _enabled:Boolean = true;
		
		//UI
		public var fill:MovieClip;
		public var track:MovieClip;
		
		public function ScrubView() {
			//tracer("constructor");
			this.fill.width  = 0;			
			this.track.buttonMode=true;
						
			this.init()
		}
		protected function init():void{
			 
			this.hit.addEventListener( MouseEvent.MOUSE_DOWN, scrubHandler);
			this.hit.addEventListener( MouseEvent.MOUSE_UP, scrubHandler);
			
		}
		protected function scrubHandler(evt:MouseEvent):void{
			//tracer(evt.type + " :: " + evt.localX)			
			var type = String(evt.type);
			switch (type) {
				case MouseEvent.MOUSE_DOWN :
					this.hit.addEventListener(MouseEvent.MOUSE_MOVE, scrubHandler);
					this.hit.addEventListener( MouseEvent.MOUSE_OUT, scrubHandler);
					
					stage.addEventListener(MouseEvent.MOUSE_UP, scrubHandler);
					
					dispatchEvent( new ScrubEvent( ScrubView.STATUS, "ScrubView.Slide.Down" ) );
					break;
				case MouseEvent.MOUSE_UP :
					this.fill.width = evt.localX;
					
					this.hit.removeEventListener(MouseEvent.MOUSE_MOVE, scrubHandler);
					this.hit.removeEventListener( MouseEvent.MOUSE_OUT, scrubHandler);
										
					stage.removeEventListener(MouseEvent.MOUSE_UP, scrubHandler);
					
					dispatchEvent( new ScrubEvent( ScrubView.STATUS, "ScrubView.Slide.Up", this.value ) );
					break;
				case MouseEvent.MOUSE_MOVE :
					this.fill.width = evt.localX;				
					break;
				case MouseEvent.MOUSE_OUT :			
					//
					break;				
			}
		}	
		public function set value(p_n:Number):void {
			_value= _max * p_n;
			this.fill.width = _value;
		}
		public function get value():Number {
			_value = this.fill.width / _max;
			return _value;
		}
		//
		public function set maximum(p_n:Number):void {
			_max = this.track.width / p_n;
		}		
		public function get maximum():Number {
			return this.track.width/_max;
		}
		//
		public override function set enabled( p_b:Boolean ):void
		{
			this._enabled = p_b;
			this.buttonMode = p_b;  
			this.mouseChildren = p_b;
			super.enabled = p_b;
		}		
		public override function get enabled():Boolean
		{
			return super.enabled;
		}
		//util functions 	
		
		private function tracer(p_o:*) {
			// constructor code
			trace("#### ScrubView #### " + p_o);
			
		}

	}
	
}
