package com.influxis.utils
{
	import fl.controls.listClasses.CellRenderer;
	
	import flash.text.TextFormat;
	
	/**
	* Custom cellRenderer for comboBox list items.
	*/
	public class CustomCellRenderer extends CellRenderer
	{
		
		public function CustomCellRenderer()
		{
			super();
			//this.setStyle('embedFonts', true);
			this.setStyle('textFormat', new TextFormat("Arial", 12, 0xffffff));
		}
		
	}
	
}