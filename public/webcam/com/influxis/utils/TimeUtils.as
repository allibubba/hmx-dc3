/**
 * Copyright © 2011 Influxis All rights reserved.
**/
package com.influxis.utils{
	import flash.events.EventDispatcher;

	public class TimeUtils extends EventDispatcher {

		public static var TimeEvent:String="Time.TimeEvent";
		public static var TIME:String="time";
		private var sTime:String;
		public function Time():void {

		}
		private function tenDec( val:Number ):String {
			if (isNaN(val)) {
				return null;
			}
			var sVal:String=val.toString();
			if (val<10) {
				sVal="0"+sVal;
			}
			return sVal;
		}
		private function decomposeSeconds(seconds:Number):Array {
			var result:Array=new Array(0);

			var secsInMin:Number=60;
			var secsInHr:Number=3600;

			// Hours
			var h:Number=Math.floor(seconds/secsInHr);
			var leftover:Number = ((h == 0) ? seconds : seconds-(h*secsInHr));
			result[0]=tenDec(h);

			// Minutes
			var m:Number=Math.floor(leftover/secsInMin);
			leftover = ((m == 0) ? leftover : leftover-(m*secsInMin));
			result[1]=tenDec(m);

			// Seconds
			result[2]=tenDec(Math.floor(leftover));

			// Milliseconds
			result[3] = tenDec( Math.round((leftover-Math.floor(leftover))*1000) );

			return result;
		}
		public function setDisplayTime( p_n:Number ):String {
			var a:Array=decomposeSeconds(p_n);
			var s:String;
			if (a[0]=="00") {
				s=a[1]+":"+a[2];
			} else {
				s=a[0]+":"+a[1]+":"+a[2];
			}
			var o:Object = new Object();
			sTime=s;
			o={time:sTime};
			return sTime;
		}
	}
}