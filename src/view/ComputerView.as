package view 
{
	import fl.containers.ScrollPane;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import model.Conflict;
	import model.NonCausalEpisode;
	import view.MainSimulationScreen;
	
	/**
	 * ...
	 * @author Juanola
	 */
	public class ComputerView extends MovieClip 
	{
		
		private var mainSimulationScreen : MainSimulationScreen;
		private var mailList : Array;
		private var mailScrollPane : ScrollPane;
		private var mailScreen : MailScreen;
		private var selectionScreen : SelectionScreen;
		private var emergencyScreen : EmergencyScreen;
		private var adminScreen : AdminScreen;
		private var closeBigComputer : CloseBigComputer;
		private var currentScreen : ComputerScreen;
		private var currentNonCausalEpisodes : Array;
		
		public function ComputerView(mainSimulationScreen : MainSimulationScreen) 
		{
			this.mainSimulationScreen = mainSimulationScreen;
			mailList = new Array();
			y = 24;
			//x = 800 / 2 - width / 2;
			x = 25;			
			closeBigComputer = new CloseBigComputer();
			closeBigComputer.x = 696.1;
			closeBigComputer.y = 24.55;			
			mailScreen = new MailScreen(mainSimulationScreen);
			selectionScreen = new SelectionScreen();
			adminScreen = new AdminScreen();
			currentNonCausalEpisodes = new Array();
			addChild(selectionScreen);
			addChildAt(closeBigComputer, 2);
			setMainScreenListeners();
			closeBigComputer.addEventListener(MouseEvent.CLICK, closeComputer);
			currentScreen = selectionScreen;
		}
		
		public function closeComputer(e : Event) : void {		
			currentScreen.closeScreen();
			mainSimulationScreen.removeBigComputer();
		}
		
		public function setMainScreenListeners():void{
			selectionScreen.mailShortcut_mc.addEventListener(MouseEvent.CLICK, openMailView);
			selectionScreen.emergencyShortcut_mc.addEventListener(MouseEvent.CLICK, openEmergencyView);
			selectionScreen.adminShortcut_mc.addEventListener(MouseEvent.CLICK, openAdminView);			
		}
		
		public function goToSelectionScreen():void {
			removeChildAt(1);
			addChildAt(selectionScreen, 1);
			currentScreen = selectionScreen;
		}
		
		public function openMailView(e : Event):void{
			removeChild(selectionScreen);
			mailScreen.createEmails(mailList);
			addChildAt(mailScreen, 1);			
			currentScreen = mailScreen;
		}
		
		public function openEmergencyView(e : Event):void{			
			removeChildAt(1);
			showNonCausalEpisodes();
			
			
			currentScreen = emergencyScreen;			
		}
		
		public function openAdminView(e : Event):void{
			removeChildAt(1);
			addChildAt(adminScreen, 1);
			currentScreen = adminScreen;
		}
		
		public function addEmail(email : MovieClip):void{
			email.addEventListener(MouseEvent.CLICK, displayEmail);
			mailList.push(email);			
		}
		
		public function displayEmail(e : Event) {	
			mailScreen.displayEmail(e.currentTarget.userData);			
			/*
			var solutionDisplay : MovieClip = new MovieClip;
			var asco : int = 0;
			for each(var solution : Solution in e.target.userData) {				
				var email : MovieClip = new EMailView;
				//email.addEventListener(MouseEvent.CLICK, closeSolutions);
				email.mailText_mc.text = solution.solutionDescription;
				email.y = asco * email.height;
				asco++;
				solutionDisplay.addChild(email);				
			}
			bigComputer_mc.solutionsScrollPane_sp.source = solutionDisplay;
			bigComputer_mc.solutionsScrollPane_sp.update();
			*/
		}
		
		public function updateView() : void {
			currentScreen.refreshScreen();
		}
		
		public function addNonCausalEpisode(nonCausalEpisode:NonCausalEpisode):void 
		{			
			currentNonCausalEpisodes.push(nonCausalEpisode);
		}
		
		private function showNonCausalEpisodes():void {
			if (currentNonCausalEpisodes.length != 0) {
				var nonCausalEpisodeView : EmergencyScreen = new EmergencyScreen(currentNonCausalEpisodes[0]);
				removeChildAt(1);
				addChildAt(nonCausalEpisodeView, 1);				
			}else {
				var noEmergency : NoEmergency = new NoEmergency();
				addChildAt(noEmergency, 1);
			}
			
		}
		
		public function removeEmergencies():void {
			currentNonCausalEpisodes.pop();
		}
		
		public function removeEmail(currentConflict:Conflict):void 
		{
			mailList.splice(mailList.indexOf(currentConflict),1); 
		}
		
	}

}