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
		
		public function Solution(solution : String, incomeModifier : int) 
		{
			_solutionDescription = solution;
			_incomeModifier = incomeModifier;
		}
		
		
		public function get solutionDescription() : String {
			return _solutionDescription;
		}
		
		public function get incomeModifier() : int {
			return _incomeModifier;
		}
	}

}