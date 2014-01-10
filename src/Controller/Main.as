package controller 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
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
		
		
		
		public function Main() 
		{			
			createMainScreen();	
			createProfiles();	
			createTimeManager();
			
			
		}
		
		private function createTimeManager():void{
			timeManager = new TimeManager(8, this, 4);
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
		
		public function dayEnded():void{
			conflictManager.prepareConflictsForDay(timeManager.currentDay);
			trace("Termino el dia");
			for(var i : int = 0;i<teamManager.team.teamArray.length;i++){
				for(var j : int = 0;j<teamManager.team.teamArray[i].currentConflicts.length;j++){
					trace(teamManager.team.teamArray[i].currentConflicts[j].description);
				}
			}
		}
		
		public function incomeGenerated():void{
			incomeManager.increaseIncome();
		}
		
		public function startSimulation(){
			removeChild(carouselManager);
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