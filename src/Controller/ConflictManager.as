package controller {
	
	import model.Profile;
	import model.Conflict;
	
	public class ConflictManager {
		
		private var conflictsForDay : Array;
		private var conflictXML : XML;
		private var _teamManager : TeamManager;
		

		public function ConflictManager(teamManager : TeamManager) {
			conflictsForDay = new Array(10);
			for(var i : int = 0; i<10;i++){
				var conflictsPerPerson : Array = new Array(4);
				for(var j : int = 0; j<4;j++){
					var conflicts : Array = new Array();
					conflictsPerPerson[j] = conflicts;
				}
				conflictsForDay[i] =conflictsPerPerson;
			}
			_teamManager = teamManager;
		}
		
		public function createConflicts(xmlConflicts : XML, names : Array):void{
			var currentPerson : int = 0;
			for each(var profileName : Profile in names){
				var profileNameToAnalize : String = profileName.profileName;
				var conflictsLength : int = xmlConflicts.conflicts.(@owner==profileNameToAnalize).conflict.length();
				for(var i : int = 0;i<conflictsLength;i++){
					if(xmlConflicts.conflicts.(@owner==profileNameToAnalize).conflict[i].@autoActivated == "true"){
						var conflict : Conflict = new Conflict(xmlConflicts.conflicts.(@owner==profileNameToAnalize).conflict[i].text);
						conflictsForDay[xmlConflicts.conflicts.(@owner==profileNameToAnalize).conflict[i].day][currentPerson].push(conflict);
					}
				}
				currentPerson++;
				
			}
			
		}
		
		public function getConflictsForDay(day : int):Array{
			return conflictsForDay[day];
		}
		
		public function prepareConflictsForDay(day : int):void{
			_teamManager.addConflicts(conflictsForDay[day]);
		}
		

	}
	
}
