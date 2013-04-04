/**
 * Copyright © 2011 Influxis All rights reserved.
**/
package com.influxis.events {
	
	import flash.events.Event;
	
	public class ScrubEvent extends Event 
	{	
		public var code:String;
		public var value:Number;

		public function ScrubEvent(type:String, code:String, p_value:Number = undefined, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.value = p_value;
			this.code = code;
			
		}
		
		public override function clone():Event
		{
			return new ScrubEvent( type, code, value, bubbles, cancelable );
		};
		
		override public function toString():String
		{
			return formatToString( "ScrubEvent", "type", "code", "value", "bubbles", "cancelable" );
		};

	}
	
}
