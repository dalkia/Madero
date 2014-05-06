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
		private var currentDay : int;
		private var eventManager : EventManager;
		private var finalizationDay : int;
		
		
		public function Main() 
		{			
			createMainScreen();	
			createProfiles();	
			createTimeManager();
			createMainSimulationScreen();	
			eventManager = new EventManager();
			finalizationDay = 10;
		}
		
		
		private function createTimeManager():void{
			timeManager = new TimeManager(8, this, 4);
		}
		
		private function createMainSimulationScreen():void {
			mainSimulationScreen = new MainSimulationScreen(this);
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
			currentDay++;
			if (currentDay != finalizationDay) {
				mainSimulationScreen.day_txt.text = "Day " + currentDay;
				mainSimulationScreen.removeEmergencies();
				var newConflicts : Array = conflictManager.prepareConflictsForDay(timeManager.currentDay);		
				for (var j : int = 0; j < teamManager.team.teamArray.length; j++) {
					var currentTeamMember = teamManager.team.teamArray[j];
					var currentConflicts = newConflicts[j];
					for (var i : int = 0; i < currentConflicts.length; i++) {
						mainSimulationScreen.addEmail(currentTeamMember.profileName, currentConflicts[i].title, currentConflicts[i].description,currentConflicts[i]);
					}
				}
				for (var j:int = 0; j < eventManager.nonCausalEpisodeForDay[currentDay].length; j++) {
					mainSimulationScreen.addNonCausalEpisode(eventManager.nonCausalEpisodeForDay[currentDay][j]);
					incomeManager.applyPenalty(eventManager.nonCausalEpisodeForDay[currentDay][j].penalty);
				}
				
			}else {
				mainSimulationScreen.day_txt.text = "GAME OVER";
				timeManager.endTimers();
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
		
		public function startSimulation() {
			currentDay = 1;
			removeChild(carouselManager);
			addChild(mainSimulationScreen);
			mainSimulationScreen.day_txt.text = "Day " + currentDay;
			createConflicts();
			createNonCausalEpisodes();
			createCausalEpisodes();
		}
		
		public function applyPenalty(incomeModifier:int):void 
		{
			incomeManager.applyPenalty(incomeModifier);
		}
		
		private function createConflicts():void{
			var personalConflictXMLLoader:URLLoader = new URLLoader();
			personalConflictXMLLoader.load(new URLRequest("../resources/xml/Conflicts.xml"));
			personalConflictXMLLoader.addEventListener(Event.COMPLETE, processConflictsXML);	
			
			
			var interPersonalConflictsXMLLoader:URLLoader = new URLLoader();
			interPersonalConflictsXMLLoader.load(new URLRequest("../resources/xml/InterConflicts.xml"));
			interPersonalConflictsXMLLoader.addEventListener(Event.COMPLETE, processInterConflictsXML);
			
		}
		
		private function createNonCausalEpisodes() {
			var nonCausalEpisodesXMLLoader:URLLoader = new URLLoader();
			nonCausalEpisodesXMLLoader.load(new URLRequest("../resources/xml/NonCausalEpisodes.xml"));
			nonCausalEpisodesXMLLoader.addEventListener(Event.COMPLETE, processNonCausalEpisodes);	
		}
		
		private function createCausalEpisodes() {
			
			
		}
		
		private function processNonCausalEpisodes(e:Event):void {
			eventManager.loadNonCausalEpisodes(new XML(e.target.data));
		}
		
		private function processConflictsXML(e:Event):void {
			conflictManager = new ConflictManager(teamManager, timeManager);	
			conflictManager.createPersonalConflicts(new XML(e.target.data),teamManager.team.teamArray);
			incomeManager.team = teamManager.team.teamArray;
			//El Time manager esta mal aca, tenes que hacer una carga de algun tipo, asi es un pito
			timeManager.startTimers();
		}
		
		private function processInterConflictsXML(e: Event):void{
			conflictManager.createInterPersonalConflicts(new XML(e.target.data),teamManager.team.teamArray);
		}
		
		
	}

}