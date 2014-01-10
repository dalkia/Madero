package model 
{
	/**
	 * ...
	 * @author Juanola
	 */
	public class Conflict 
	{
		
		private var _description : String;
		
		
		public function Conflict(description : String) 
		{
			_description = description;
		}
		
		public function get description():String{
			return _description;
		}
		
	}

}