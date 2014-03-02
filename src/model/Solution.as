package model 
{
	/**
	 * ...
	 * @author Juanola
	 */
	public class Solution 
	{
		
		private var _solutionDescription : String;
		private var _incomeModifier : int;
		private var _nextConflict : int;
		
		public function Solution(solution : String, incomeModifier : int, nextConflict : int) 
		{
			_solutionDescription = solution;
			_incomeModifier = incomeModifier;
			_nextConflict = nextConflict;
		}
		
		
		public function get solutionDescription() : String {
			return _solutionDescription;
		}
		
		public function get incomeModifier() : int {
			return _incomeModifier;
		}
		
		public function get nextConflict() : int{
			return _nextConflict;
		}
	}

}