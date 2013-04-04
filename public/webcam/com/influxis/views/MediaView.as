/**
 * Copyright © 2011 Influxis All rights reserved.
**/
package com.influxis.views {
	import flash.display.MovieClip;
	import fl.controls.ComboBox;
	import fl.data.DataProvider;
	
	import flash.events.Event;
	import com.influxis.events.SimpleEvent;
	import flash.events.MouseEvent;
	
	public class MediaView extends MovieClip {
		public static const CHANGE:String = "change";
		
		public var mdv:MovieClip
		
		public function MediaView() {
			cbCam.addEventListener(Event.CHANGE, onChangeHandler)
			cbMic.addEventListener(Event.CHANGE, onChangeHandler)
			
			closeButton.useHandCursor = true;
			closeButton.buttonMode = true;
			closeButton.mouseChildren = false;
			closeButton.addEventListener(MouseEvent.CLICK, onClickHandler);
		}
		
		protected function onChangeHandler( evt:Event ):void{
			var target = evt.target.name;
			var o = new Object();
			o.item = evt.target.selectedItem.label
			switch( target ){
				case "cbCam":
					dispatchEvent(new SimpleEvent(MediaView.CHANGE, "MediaView.Camera.Update", o));
					break;
				case "cbMic":
					dispatchEvent(new SimpleEvent(MediaView.CHANGE, "MediaView.Microphone.Update", o));
					break;
			}
		}
		protected function onClickHandler(evt:MouseEvent):void
		{
			this.visible = false;
		}
		public function set setCams(p_a:Array):void
		{
			//ComboBox
			var dp:DataProvider = new DataProvider(p_a);
			cbCam.dataProvider = dp
		}
		public function set setMics(p_a:Array):void
		{
			var dp:DataProvider = new DataProvider(p_a);
			cbMic.dataProvider = dp
		}
		
	}
	
}
