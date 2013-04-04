/**
 * SizeUtils - Copyright © 2009 Influxis All rights reserved.
**/
package com.influxis.utils
{
	//Flash Classes
	import flash.display.DisplayObject;
	
	public class SizeUtils
	{
		public static const LEFT:String = "left";
		public static const RIGHT:String = "right";
		public static const CENTER:String = "center";
		public static const TOP:String = "top";
		public static const BOTTOM:String = "bottom";
		public static const MIDDLE:String = "middle";
		
		public static function movePosition( p_source:DisplayObject, p_nTotalWidth:Number, p_nTotalHeight:Number, p_sHPosition:String = "left", p_sVPosition:String = "top", p_nPadding:Number = 0 ): void
		{
			switch( p_sHPosition )
			{
				case LEFT :
					p_source.x = p_nPadding;
					break;
					
				case RIGHT :
					p_source.x = p_nTotalWidth - (p_source.width+p_nPadding);
					break;
					
				case CENTER :
					p_source.x = ((p_nTotalWidth/2)-(p_source.width/2));
					break;
			}
			
			switch( p_sVPosition )
			{
				case TOP :
					p_source.y = p_nPadding;
					break;
					
				case BOTTOM :
					p_source.y = (p_nTotalHeight - (p_source.height+p_nPadding));
					break;
					
				case MIDDLE :
					p_source.y = ((p_nTotalHeight/2)-(p_source.height/2));
					break;
			}
		}
		
		//Maintains aspect ratio of target item based on given measurements
		public static function maintainAspectRatio( p_source:DisplayObject, p_nWidth:Number, p_nHeight:Number, p_nOriginWidth:Number, p_nOriginHeight:Number ): void
		{
			var nNewHeight:Number, nNewWidth:Number;
			if( p_nHeight < p_nWidth ||  p_nHeight == p_nWidth)
			{
				nNewWidth = ( p_nHeight * (p_nOriginWidth / p_nOriginHeight) );
				nNewHeight = p_nHeight;
				if( nNewWidth > p_nWidth )
				{
					nNewHeight = ( p_nWidth * (p_nOriginHeight / p_nOriginWidth) );
					nNewWidth = p_nWidth;
				}
			}else if( p_nWidth < p_nHeight )
			{
				nNewHeight = ( p_nWidth * (p_nOriginHeight / p_nOriginWidth) );
				nNewWidth = p_nWidth;
			}
			
			p_source.width = nNewWidth;
			p_source.height = nNewHeight;
		}
	}
}