package controller 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import view.StartScreen;
	import controller.CarouselManager;
	import flash.utils.*;
	/**
	 * ...
	 * @author Juanola
	 */
	public class Main extends MovieClip 
	{
		
		private var startScreen : MovieClip;
		private var carouselManager : CarouselManager;
		
		
		private var profiles:Array;
		private var profileXML : XML;
		
		public function Main() 
		{			
			createMainScreen();	
			createProfiles();
			
		}
		
		private function createMainScreen() {
			startScreen = new StartScreen(this);
			addChild(startScreen);
		}
		
		private function createCarousel() {
			carouselManager = new CarouselManager(profiles);
		}
		
		private function createProfiles() {
			var profileXMLLoader:URLLoader = new URLLoader();
			profileXMLLoader.load(new URLRequest("../resources/xml/Profiles.xml"));
			profileXMLLoader.addEventListener(Event.COMPLETE, processProfilesXML);			
		}
		
		private function processProfilesXML(e:Event):void {
			profileXML = new XML(e.target.data);
			var totalProfiles : int = profileXML.profile.length(); 
			profiles = new Array(totalProfiles);
			for (var i: int = 0; i < totalProfiles; i++) {
				var profile:Class = getDefinitionByName(profileXML.profile[i].movieClip) as Class;
				var s:MovieClip = new profile();
				s.stats.gotoAndStop(int(profileXML.profile[i].proactivity));
				profiles[i] = s;
			}
			createCarousel();
		}
		
		public function startGame() {
			removeChild(startScreen);
			addChild(carouselManager);
		}
		
		
	}

}