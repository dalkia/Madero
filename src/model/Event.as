package model {
	
	public class Event {
		
		private var _description : String;
		private var _proactivityModifier : int;
		private var _stressModifier : int;
		
		

		public function Event(description : String, proactivityModifier : int, stressModifier : int) {
			_description = description;
			_proactivityModifier = proactivityModifier;
			_stressModifier = stressModifier;
		}

	}
	
}
