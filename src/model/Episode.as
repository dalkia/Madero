package model {
	
	public class Episode {
		
		private var _description : String;
		private var _proactivityModifier : int;
		private var _stressModifier : int;
		
		

		public function Episode(description : String, proactivityModifier : int, stressModifier : int) {
			_description = description;
			_proactivityModifier = proactivityModifier;
			_stressModifier = stressModifier;
		}

	}
	
}
