package model 
{
	/**
	 * ...
	 * @author Juanola
	 */
	public class Conflict 
	{
		
		private var _description : String;		
		private var _possibleSolutions : Array;
		private var _penalty : Penalty;
		
		
		public function Conflict(description : String, penalty : Penalty, possibleSolutions : Array) 
		{
			_description = description;
			_penalty = penalty;
			_possibleSolutions = possibleSolutions;
		}
		
		public function get description():String{
			return _description;
		}
		
		public function get penalty() : Penalty {
			return _penalty;
		}
		
		public function get possibleSolutions() : Array {
			return _possibleSolutions;
		}
		
	}

}