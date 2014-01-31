package controller 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import view.MainSimulationScreen;
	import view.StartScreen;
	import controller.CarouselManager;
	import controller.TeamManager;
	import controller.TimeManager;
	import controller.ConflictManager;
	
	/**
	 * ...
	 * @author Juanola
	 */
	public class Main extends MovieClip 
	{
		
		private var startScreen : MovieClip;
		private var carouselManager : CarouselManager;			
		private var profileManager : ProfileManager;
		private var teamManager : TeamManager;
		private var timeManager : TimeManager;
		private var incomeManager : IncomeManager;
		private var conflictManager : ConflictManager;
		private var mainSimulationScreen : MovieClip;
		
		
		public function Main() 
		{			
			createMainScreen();	
			createProfiles();	
			createTimeManager();
			createMainSimulationScreen();			
		}
		
		private function createTimeManager():void{
			timeManager = new TimeManager(8, this, 4);
		}
		
		private function createMainSimulationScreen():void {
			mainSimulationScreen = new MainSimulationScreen();
		}
		
		private function createMainScreen() {
			startScreen = new StartScreen(this);
			addChild(startScreen);
		}
		
		private function createTeamManager():void{
			teamManager = new TeamManager(4);
			for(var i : int = 0;i<profileManager.profiles.length;i++){
				profileManager.profiles[i].profileCard.teamManager = teamManager;
			}
		}
		
		private function createCarousel() {
			carouselManager = new CarouselManager(profileManager.profiles, this);
			
			
		}
		
		private function createProfiles() {
			var profileXMLLoader:URLLoader = new URLLoader();
			profileXMLLoader.load(new URLRequest("../resources/xml/Profiles.xml"));
			profileXMLLoader.addEventListener(Event.COMPLETE, processProfilesXML);			
		}
		
		private function createIncomeManager():void{
			incomeManager = new IncomeManager(10);
		}
		
		private function processProfilesXML(e:Event):void {
			profileManager = new ProfileManager(new XML(e.target.data));			
			createCarousel();
			createTeamManager();
			createIncomeManager();
		}
		
		
		
		public function startGame() {
			removeChild(startScreen);
			addChild(carouselManager);
		}
		
		public function dayEnded():void {					
			teamManager.applyPenalties();
			trace("Termino el dia");
			var newConflicts : Array = conflictManager.prepareConflictsForDay(timeManager.currentDay);			
			
			for (var j : int = 0; j < teamManager.team.teamArray.length; j++) {
				var currentTeamMember = teamManager.team.teamArray[j];
				var currentConflicts = newConflicts[j];
				for (var i : int = 0; i < currentConflicts.length; i++) {
					mainSimulationScreen.addEmail(currentTeamMember.profileName, currentConflicts[i].description, currentConflicts[i]);
				}
			}
		
			
			
			/*
			for (var i : int = 0; i < teamManager.team.teamArray.length; i++) {
				var currentTeamMember = teamManager.team.teamArray[i];
				for(var j : int = 0;j<currentTeamMember.currentConflicts.length;j++){				
					
				}
			}
			*/
		}
		
		
		
		public function incomeGenerated():void{
			var actualIncome : int = incomeManager.increaseIncome();
			mainSimulationScreen.setTotalMoneyText(actualIncome);
		}
		
		public function startSimulation(){
			removeChild(carouselManager);
			addChild(mainSimulationScreen);
			createConflicts();
		}
		
		private function createConflicts():void{
			var conflictXMLLoader:URLLoader = new URLLoader();
			conflictXMLLoader.load(new URLRequest("../resources/xml/Conflicts.xml"));
			conflictXMLLoader.addEventListener(Event.COMPLETE, processConflictsXML);	
		}
		
		private function processConflictsXML(e:Event):void {			
			conflictManager = new ConflictManager(teamManager);			
			conflictManager.createConflicts(new XML(e.target.data),teamManager.team.teamArray);
			
			incomeManager.team = teamManager.team.teamArray;
			timeManager.startTimers();
			
		}
		
		
	}

}