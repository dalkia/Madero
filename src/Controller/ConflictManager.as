package controller {
	
	import model.Penalty;
	import model.Profile;
	import model.Conflict;
	import model.Solution;
	import controller.TimeManager;
	
	public class ConflictManager {
		
		private var conflictsForDay : Array;
		private var pendingConflicts : Array;
		private var conflictXML : XML;
		private var _teamManager : TeamManager;
		private var _timeManager : TimeManager;
		

		public function ConflictManager(teamManager : TeamManager, timeManager : TimeManager) {
			conflictsForDay = new Array(10);
			pendingConflicts = new Array(4);
			for(var i : int = 0; i<10;i++){
				var conflictsPerPerson : Array = new Array(4);
				for(var j : int = 0; j<4;j++){
					var conflicts : Array = new Array();
					conflictsPerPerson[j] = conflicts;					
					
					var pendingConflictsPerPerson : Array = new Array();
					pendingConflicts[j] = pendingConflictsPerPerson;
				}
				conflictsForDay[i] = conflictsPerPerson;
			}
			_teamManager = teamManager;
			_timeManager = timeManager;
		}
		
		public function createPersonalConflicts(xmlConflicts : XML, names : Array):void{			
			var currentPerson : int = 0;
			for each(var profileName : Profile in names){
				var profileNameToAnalize : String = profileName.profileName;
				var conflictsLength : int = xmlConflicts.conflicts.(@owner==profileNameToAnalize).conflict.length();
				for (var i : int = 0; i < conflictsLength; i++) {
					var currentConflict = xmlConflicts.conflicts.(@owner == profileNameToAnalize).conflict[i];
					var currentPenalty = currentConflict.penalty;						
					var penalty : Penalty = new Penalty(currentPenalty.proactivity, currentPenalty.stress);						
					var solutions : Array = new Array;
					for (var j : int = 0; j < currentConflict.solutions.length; j++) {
						var solution : Solution = new Solution(currentConflict.solutions[j].text, currentConflict.solutions[j].incomeModifier, currentConflict.solutions[j].nextConflict); 
						solutions.push(solution);
					}
					var conflict : Conflict = new Conflict(currentConflict.@id, currentConflict.text, penalty, solutions);
					if (currentConflict.@autoActivated == "true") {						
						conflictsForDay[currentConflict.day][currentPerson].push(conflict);
					}else{
						pendingConflicts[currentPerson].push(conflict);
					}
				}
				currentPerson++;				
			}			
		}
		
		public function getConflictsForDay(day : int):Array{
			return conflictsForDay[day];
		}
		
		public function prepareConflictsForDay(day : int):Array{
			_teamManager.addConflicts(conflictsForDay[day]);
			return conflictsForDay[day];
		}		
		
		public function preparePendingConflict(person : int, conflictId : int){
			for(var i : int = 0;i<pendingConflicts[person].length ; i++){
				if(pendingConflicts[person][i].id == conflictId){
					conflictsForDay[_timeManager.currentDay + pendingConflicts[person][i].day][person].push(pendingConflicts[person][i]);
				}
			}
			
		}
		
		public function createInterPersonalConflicts(xmlConflicts : XML, names : Array):void{		
			var currentPerson : int = 0;
			var nameArray : Array = new Array();
			for(var i : int = 0;i<names.length;i++){
				nameArray.push(names[i].profileName);
				
			}
			for each(var profileNameToAnalize : String in nameArray){
				var conflictsLength : int = xmlConflicts.conflicts.(@owner==profileNameToAnalize).conflict.length();
				for (var i : int = 0; i < conflictsLength; i++) {
					var currentConflict = xmlConflicts.conflicts.(@owner == profileNameToAnalize).conflict[i];
					if(nameArray.indexOf(new String(currentConflict.@against)) >= 0){
						var currentPenalty = currentConflict.penalty;						
						var penalty : Penalty = new Penalty(currentPenalty.proactivity, currentPenalty.stress);						
						var solutions : Array = new Array;
						for (var j : int = 0; j < currentConflict.solutions.length; j++) {
							var solution : Solution = new Solution(currentConflict.solutions[j].text, currentConflict.solutions[j].incomeModifier, currentConflict.solutions[j].nextConflict); 
							solutions.push(solution);
						}
						var conflict : Conflict = new Conflict(currentConflict.@id, currentConflict.text, penalty, solutions);
						if (currentConflict.@autoActivated == "true") {						
							conflictsForDay[currentConflict.day][currentPerson].push(conflict);
						}else{
							pendingConflicts[currentPerson].push(conflict);
						}
					}
						
				}	
				currentPerson++;
			}
		}
		

	}
	
}
