/**
 * Copyright © 2011 Influxis All rights reserved.
**/
package com.influxis.views
{

	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	//
	import com.influxis.events.SimpleEvent;
	import com.influxis.utils.TimeUtils;
	import flash.events.Event;
	import com.influxis.events.ScrubEvent;


	public class MenuView extends MovieClip
	{
		public static const ON_CLICK:String = "on click";
		public static const ON_SLIDE:String = "on slide";
		
		protected var tu:TimeUtils;

		public function MenuView()
		{
			tu = new TimeUtils();
			mi.maximum = 1;
			
			enablePlayHead(false);
		}
		public function init():void
		{		
			enableButtons(true)
		}
		public function enableButtons(p_b:Boolean):void
		{
			if(p_b == true){
				
			recordButton.useHandCursor = true;
			recordButton.buttonMode = true;
			recordButton.mouseChildren = false;
			recordButton.addEventListener(MouseEvent.CLICK, clickHandler);
			
			mediaButton.useHandCursor = true;
			mediaButton.buttonMode = true;
			mediaButton.mouseChildren = false;
			mediaButton.addEventListener(MouseEvent.CLICK, clickHandler);
			
			finishButton.useHandCursor = true;
			finishButton.buttonMode = true;
			finishButton.mouseChildren = false;
			finishButton.addEventListener(MouseEvent.CLICK, clickHandler);

			retakeButton.useHandCursor = true;
			retakeButton.buttonMode = true;
			retakeButton.mouseChildren = false;
			retakeButton.addEventListener(MouseEvent.CLICK, clickHandler);
			
			submitButton.useHandCursor = true;
			submitButton.buttonMode = true;
			submitButton.mouseChildren = false;
			
			playButton.useHandCursor = true;
			playButton.buttonMode = true;
			playButton.mouseChildren = false;
			
			pauseButton.useHandCursor = true;
			pauseButton.buttonMode = true;
			pauseButton.mouseChildren = false;
			
			}else if(p_b == false){
				recordButton.removeEventListener(MouseEvent.CLICK, clickHandler);
				mediaButton.removeEventListener(MouseEvent.CLICK, clickHandler);
				finishButton.removeEventListener(MouseEvent.CLICK, clickHandler);
				retakeButton.removeEventListener(MouseEvent.CLICK, clickHandler);
			}
		}
		public function enablePlayHead(p_b:Boolean):void
		{
			submitButton.visible = p_b;
			playButton.visible = p_b;
			pauseButton.visible = p_b;
			scrub.visible = p_b;
			durationDisplay.visible = p_b;			
			
			if (p_b == false)
			{
				submitButton.removeEventListener(MouseEvent.CLICK, clickHandler);
				playButton.removeEventListener(MouseEvent.CLICK, clickHandler);
				pauseButton.removeEventListener(MouseEvent.CLICK, clickHandler);
				scrub.removeEventListener(ScrubView.STATUS, slideHandler);				
			}
			else if (p_b == true)
			{
				submitButton.addEventListener(MouseEvent.CLICK, clickHandler);
				playButton.addEventListener(MouseEvent.CLICK, clickHandler);
				pauseButton.addEventListener(MouseEvent.CLICK, clickHandler);
				scrub.enabled = true;
				scrub.addEventListener(ScrubView.STATUS, slideHandler);
			}			
		}
		//
		public function doRecord():void
		{
			recordButton.visible = false;
			mediaButton.visible = false;
			finishButton.visible = true;
			retakeButton.visible = false;		
			recIndicator.visible = true;
			recIndicator.visible = true;
		}
		public function doFinish(p_number=null):void
		{
			recordButton.visible = true;
			mediaButton.visible = true;
			finishButton.visible = false;
			retakeButton.visible = false;
			recIndicator.visible = false;
			submitButton.visible = false;
			
			this.doMic(0);
			this.doTime(0);
			this.enablePlayHead(false);
			
			if(p_number){
				scrub.visible = true;
				durationDisplay.visible = true;
				doDuration(p_number)
				scrub.enabled = false;
			}else{
				//
			}
			
		}
		public function doRetake():void
		{
			recordButton.visible = false;
			finishButton.visible = false;
			retakeButton.visible = true;
			recIndicator.visible = false;
			submitButton.visible = true;
			
			this.doSeek(0)
			this.doTime(0)
			this.enablePlayHead(true)
			
		}
		public function doPlay():void
		{
			playButton.visible = false;
			pauseButton.visible = true;
		}
		public function doPause():void
		{
			playButton.visible = true;
			pauseButton.visible = false;
		}
		public function doTime(p_n:Number):void
		{
			timeDisplay.txt.text = tu.setDisplayTime(Math.round(p_n));
		}
		public function doDuration(p_n:Number):void
		{
			var n:Number = Math.round(p_n);
			scrub.maximum = n;
			durationDisplay.txt.text = tu.setDisplayTime(n);
		}
		public function doSeek(p_n:Number):void
		{
			var n:Number = Math.round(p_n);
			scrub.value = n;
		}
		public function doMic(p_n:Number):void
		{
			mi.value = p_n
		}
		//
		private function clickHandler(evt:MouseEvent):void
		{
			if (! this.enabled)
			{
				return;
			}
			var target:MovieClip = evt.target as MovieClip;
			
			switch ( target )
			{
				case this.recordButton :
					this.dispatchEvent(new SimpleEvent(MenuView.ON_CLICK, "record"));
					break;
				case this.mediaButton :
					this.dispatchEvent(new SimpleEvent(MenuView.ON_CLICK, "media"));
					break;
				case this.finishButton :
					this.dispatchEvent( new SimpleEvent( MenuView.ON_CLICK, "finish" ) );
					break;
				case this.retakeButton :
					this.dispatchEvent( new SimpleEvent( MenuView.ON_CLICK, "retake" ) );
					break;
				case this.playButton :
					this.dispatchEvent( new SimpleEvent( MenuView.ON_CLICK, "play" ) );
					break;
				case this.pauseButton :
					this.dispatchEvent( new SimpleEvent( MenuView.ON_CLICK, "pause" ) );
					break;
				case this.pauseButton :
					this.dispatchEvent( new SimpleEvent( MenuView.ON_CLICK, "pause" ) );
					break;
				case this.submitButton :
					this.dispatchEvent( new SimpleEvent( MenuView.ON_CLICK, "submit" ) );
					break;
			}
		}
		private function slideHandler(evt:ScrubEvent):void
		{
			if (evt.code == "ScrubView.Slide.Down")
			{
				this.dispatchEvent(new SimpleEvent(MenuView.ON_SLIDE, "slide.down"));
			}
			else if (evt.code == "ScrubView.Slide.Up")
			{
				//trace(evt.value)
				this.dispatchEvent(new SimpleEvent(MenuView.ON_SLIDE, "slide.up", evt.value));
			}
		}
	}

}