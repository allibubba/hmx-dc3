/**
 * Copyright © 2011 Influxis All rights reserved.
**/
package com.influxis.views {
	
	import flash.display.MovieClip;
	
	public class MicrophoneView extends MovieClip{
		
		//properties values
		protected var _value:Number = 0;
		protected var _max:Number = 1;
		protected var _enabled:Boolean = true;
		
		//UI
		public var mic_mask:MovieClip
		public var fill:MovieClip
		public var mic_background:MovieClip
				
		public function MicrophoneView() {
			// constructor code
			this.value = this._value = 1
		}
		//
		public function set value(p_n:Number):void {
			_value= _max * p_n;
			this.mic_mask.height = _value;
		}
		public function set maximum(p_n:Number):void {
			_max = this.mic_background.height / p_n;
		}		
		public function get maximum():Number {
			return this.mic_background.height/_max;
		}
	}
	
}
