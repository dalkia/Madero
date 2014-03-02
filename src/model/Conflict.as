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
		private var _id : int;
		
		
		public function Conflict(id:int, description : String, penalty : Penalty, possibleSolutions : Array) 
		{
			_id = id;
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
		
		public function get id() : int {
			return _id;
		}
		
		public function get possibleSolutions() : Array {
			return _possibleSolutions;
		}
		
	}

}