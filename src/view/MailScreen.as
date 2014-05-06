package view 
{
	import fl.containers.ScrollPane;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;
	import model.Conflict;
	import flash.display.MovieClip;
	import model.Solution;
	/**
	 * ...
	 * @author Juanola
	 */
	public class MailScreen extends ComputerScreen 
	{
		
		private var keyboard : Keyboard;
		private var keyboardOn : Boolean;
		private var currentConflict : Conflict;
		private var currentSolution : Solution;
		private var mainSimulationScreen : MainSimulationScreen;
		
		
		public function MailScreen(mainSimulationScreen : MainSimulationScreen) 
		{
			super();
			this.mainSimulationScreen = mainSimulationScreen;
			keyboard = new Keyboard();
			keyboard.x = -5;
			keyboard.y = 300;
			keyboardOn = false;
		}
		
		public function createEmails(mailList:Array):void 
		{
			var mailScrollPane : ScrollPane  = new ScrollPane();
			mailScrollPane.width = 512;
			mailScrollPane.height = 300;
			mailScrollPane.x = 170;
			mailScrollPane.y = 105;
			mailScrollPane.scrollDrag = false;
			var totalMailList : MovieClip = new MovieClip();
			for(var i : int = 0;i<mailList.length;i++){
				mailList[i].y = 45*i;
				totalMailList.addChild(mailList[i]);
			}
			mailScrollPane.source = totalMailList;
			//mailScrollPane.update();		
			addChildAt(mailScrollPane,2);
		}
		
		public function displayEmail(conflict:Conflict):void 
		{
			currentConflict = conflict;			
			removeChildAt(2);
			var emailView : EMailView = new EMailView;
			emailView.x = 170;
			emailView.y = 105;
			addChildAt(emailView,2);
			emailView.from_txt.text = currentConflict.owner;
			emailView.title_txt.text = currentConflict.title;
			emailView.to_txt.text = "Yo";
			emailView.description_txt.text = currentConflict.description;	
			emailView.startSolution_mc.addEventListener(MouseEvent.CLICK, openPossibleSolutions);
		}
		
		public override function closeScreen():void {			
			if (keyboardOn) {
				removeChild(keyboard);
				keyboardOn = false;
			}
			removeChildAt(2);			
		}
		
		public function openPossibleSolutions(e : Event):void {
			keyboard.firstSolution.solutionTitle_txt.text = currentConflict.solutions[0].title;
			keyboard.firstSolution.userdata = currentConflict.solutions[0];
			keyboard.firstSolution.addEventListener(MouseEvent.CLICK, solutionSelected);
			if (currentConflict.solutions[1] != null) {
				keyboard.secondSolution.solutionTitle_txt.text = currentConflict.solutions[1].title;
				keyboard.secondSolution.userdata = currentConflict.solutions[1];
				keyboard.secondSolution.addEventListener(MouseEvent.CLICK, solutionSelected);
			}else{
				keyboard.secondSolution.solutionTitle_txt.text = "";
			}
			if (currentConflict.solutions[2] != null) {
				keyboard.thirdSolution.solutionTitle_txt.text = currentConflict.solutions[2].title;
				keyboard.thirdSolution.userdata = currentConflict.solutions[2];
				keyboard.thirdSolution.addEventListener(MouseEvent.CLICK, solutionSelected);
			}else{
				keyboard.thirdSolution.solutionTitle_txt.text = "";
			}
			if (currentConflict.solutions[3] != null) {
				keyboard.fourthSolution.solutionTitle_txt.text = currentConflict.solutions[3].title;
				keyboard.fourthSolution.userdata = currentConflict.solutions[3];
				keyboard.fourthSolution.addEventListener(MouseEvent.CLICK, solutionSelected);
			}else{
				keyboard.fourthSolution.solutionTitle_txt.text = "";
			}			
			keyboard.sendSolution.addEventListener(MouseEvent.CLICK, sendSolution);
			addChild(keyboard);
			
			keyboardOn = true;
		}
		
		public function solutionSelected(e: Event):void{
			currentSolution = e.currentTarget.userdata;
			removeChildAt(2);
			var emailView : EMailView = new EMailView;
			emailView.x = 170;
			emailView.y = 105;
			addChildAt(emailView,2);
			emailView.from_txt.text = "Yo";
			emailView.title_txt.text = currentSolution.title;
			emailView.to_txt.text = currentConflict.owner;
			emailView.description_txt.text = currentSolution.description;	
		}
		
		public function sendSolution(e : Event):void{
			mainSimulationScreen.applyPenalty(currentSolution.incomeModifier);
			mainSimulationScreen.removeEmail(currentConflict);
			closeScreen();
		}
		
	}

}