/**
 *  SimpleEvent v1.0.0 - Copyright © 2007 Influxis All rights reserved.
 *	Last Updated          - 11/12/2007 1:44pm PST;
 *  Author                - Joe Lopez
 *  Description           - Event Container used to contain data from general events
**/

package com.influxis.events
{
	import flash.events.*;
	
	public class SimpleEvent extends Event
	{
		//Class Name
		public static const CLASS_NAME:String = "SimpleEvent";
		
		//Enable Debugger
		public static var DEBUG:Boolean = false;
		public static const SIMPLE_EVENT_CHANGE:String = "change";
		
		private var _oData:Object;
		private var _sCode:String;
		
		/**
		 * INIT API
		**/ 
		
		public function SimpleEvent( p_sType:String, p_sCode:String = null, p_oData:Object = null, p_bBubbles:Boolean = false, p_bCancelable:Boolean = false )
		{
			_oData = new Object();
			_oData = p_oData;
			_sCode = p_sCode;
			
			super( p_sType, p_bBubbles, p_bCancelable );
		}
		
		/**
		 * EVENT OVERRIDE API
		**/
		
		public override function clone() : Event
		{
			return new SimpleEvent( type, _sCode, _oData, bubbles, cancelable );
		}
		
		public override function toString() : String
		{
			return formatToString( "type", "bubbles", "cancelable", "eventPhase", "code", "data" );
		}
		
		/**
		 * GETTER / SETTER
		**/
		
		public function get code() : String
		{
			return _sCode;
		}
		
		public function get data(): Object
		{
			return _oData;
		}
		
		/**
		 * DEBUGGER
		**/
		
		private function tracer( p_msg:* ) : void
		{
			if( DEBUG )
			{
				trace( "#" + CLASS_NAME + "#  " + p_msg );
			};
		};
	}
}