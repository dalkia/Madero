package controller 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import view.StartScreen;
	import controller.CarouselManager;
	
	/**
	 * ...
	 * @author Juanola
	 */
	public class Main extends MovieClip 
	{
		
		private var startScreen : MovieClip;
		private var carouselManager : CarouselManager;			
		private var profileManager : ProfileManager;
		
		
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
			carouselManager = new CarouselManager(profileManager.profiles);
		}
		
		private function createProfiles() {
			var profileXMLLoader:URLLoader = new URLLoader();
			profileXMLLoader.load(new URLRequest("../resources/xml/Profiles.xml"));
			profileXMLLoader.addEventListener(Event.COMPLETE, processProfilesXML);			
		}
		
		private function processProfilesXML(e:Event):void {
			profileManager = new ProfileManager(new XML(e.target.data));			
			createCarousel();
		}
		
		public function startGame() {
			removeChild(startScreen);
			addChild(carouselManager);
		}
		
		
	}

}