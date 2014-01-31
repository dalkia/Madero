package controller {
	
	import model.Team;
	import model.Profile;
	
	public class TeamManager {
		
		private var _team : Team;
		

		public function TeamManager(teamSize : int) {
			_team = new Team();
		}
		
		public function addToTeam(profile : Profile){
			_team.teamArray.push(profile);
		}
		
		public function get team():Team{
			return _team;
		}
		
		public function addConflicts(conflicts : Array):void{
			for(var i : int = 0; i < _team.teamArray.length;i++){
				for(var j : int = 0 ; j < conflicts[i].length ; j++){
					_team.teamArray[i].addConflict(conflicts[i][j]);
				}
			}
		}
		
		public function applyPenalties():void {
			for(var i : int = 0; i < _team.teamArray.length;i++){				
				_team.teamArray[i].applyPenalty();
			}
		}

	}
	
}
