package model {
	
	public class NonCausalEpisode extends Episode {
		
		private var _title : String;
		private var _description : String;
		private var _incomeModifier : int;
		private var _penalty:int;

		public function NonCausalEpisode(title: String, description : String, incomeModifier : int, penalty : int) {
			super();
			_title = title;
			_description = description;
			_incomeModifier = incomeModifier;
			_penalty = penalty;
		}
		
		public function get title():String 
		{
			return _title;
		}
		
		public function get description():String 
		{
			return _description;
		}
		
		public function get penalty():int 
		{
			return _penalty;
		}
		
		public function set penalty(value:int):void 
		{
			_penalty = value;
		}

	}
	
}
