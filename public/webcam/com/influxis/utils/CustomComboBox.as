package com.influxis.utils
{
	import fl.controls.ComboBox;
	import fl.controls.List;
	
	import flash.text.TextFormat;
	
	/**
	* Customized ComboBox component. Graphic changes have been made inside the component itself,
	* in the library, changes in textual display are made here.
	*/
	public class CustomComboBox extends ComboBox
	{
		private var _tf:TextFormat;
		
		public function CustomComboBox()
		{
			super();
			_tf = new TextFormat("Arial", 12, 0xffffff);
			
			//textField is the top text, in the closed combobox
			textField.setStyle('textFormat', _tf);
			
			//dropdown is the list that shows when you open the combobox
			dropdown.setStyle('cellRenderer', CustomCellRenderer);
		}
	}
}