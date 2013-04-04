/**
 * Copyright © 2011 Influxis All rights reserved.
**/
package com.influxis.views{
	import flash.display.MovieClip;
	import flash.text.TextField;
	
	public class StatusPanelView extends MovieClip{
		protected var sMsg:String
		//UI
		public var txt:TextField
		
		public function StatusPanelView() {
			
		}		
		public function set msg( p_s:String ):void
		{
			sMsg = p_s;			
			this.txt.text = sMsg;
		}
		public function get msg():String
		{
			return sMsg;
		}
		public function set enableChildern( p_b:Boolean ):void
		{
			okButton.visible = p_b;			
		}
		public function get enableChildern():Boolean
		{
			return okButton.visible;
		}
	}
	
}
