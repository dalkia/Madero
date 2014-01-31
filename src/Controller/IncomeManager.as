package controller {
	
	import model.Profile;
	import model.Team;
	
	public class IncomeManager {

		//private var _initialIncome : int;
		private var _team : Array;
		private var _income : int;
		
		
		public function IncomeManager(initialIncome : int) {
			_income = initialIncome;
		}
		
		public function increaseIncome():int{
			for each(var profile:Profile  in _team){
				_income += profile.proactivity - profile.stress;
			}
			return _income;
		}
		
		public function set team(team : Array):void{
			_team = team;
		}

	}
	
}
