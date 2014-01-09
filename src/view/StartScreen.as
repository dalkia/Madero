package view
{
	
	import flash.display.MovieClip;
	import controller.Main;	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class StartScreen extends MovieClip {
				
		private var main : Main;
				
		public function StartScreen(main : Main) 
		{			
			this.main = main;
			startButton.addEventListener(MouseEvent.CLICK, startGame);
		}
		
		public function startGame(e : Event) {
			main.startGame();
		}
	}
	
}
