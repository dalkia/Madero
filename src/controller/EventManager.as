package controller  {
	
	public class EventManager {

		private var causalEvents : Array;
		private var nonCausalEventForDay : Array;
		
		public function EventManager() {
			causalEvents = new Array();
			nonCausalEventForDay = new Array(10);
			for(var i : int = 0;i<10;i++){
				nonCausanEventForDay[i] = new Array();
			}
		}
		
		public function loadCausalEvents(xmlCausalEvents : XML){
			
		}

	}
	
}
