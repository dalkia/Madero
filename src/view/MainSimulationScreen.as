package view 
{
	import flash.display.MovieClip;
	import flash.events.Event;	
	import flash.events.MouseEvent;
	import fl.containers.ScrollPane;
	import model.Conflict;
	import model.Solution;
	//import view.EMailView;
	
	/**
	 * ...
	 * @author Juanola
	 */
	public class MainSimulationScreen extends MovieClip 
	{
		
		public var mailList : Array;
		public var mailDisplay : MovieClip;
		public var computerView : ComputerView;
		
		
		public function MainSimulationScreen() 
		{
			mailDisplay = new MovieClip();
			mailList = new Array();
			//bigComputer_mc.mailScrollPane_sp.scrollDrag = true;
			computerView = new ComputerView(this);			
			littleComputer_mc.addEventListener(MouseEvent.CLICK, openBigComputer);			
		}
		
		public function setTotalMoneyText(totalMoney : int) : void {
			totalMoney_txt.text = "$ " + totalMoney.toString();
		}
		
		public function openBigComputer(e : Event) : void {			
			addChild(computerView);
			//bigComputer_mc.removeChild(bigComputer_mc.solutionsScrollPane_sp);
		}
		
		public function removeBigComputer() : void {
			removeChild(computerView);
		}
		
		public function addEmail(sender : String, content : String, conflict : Conflict) {
			/*
			var email : MovieClip = new mailTemplate_mc();
			email.addEventListener(MouseEvent.CLICK, displaySolutions);
			email.mailText_mc.text = "from: " + sender + " subject: " + content;
			email.userData = conflict;
			email.y = mailList.length * email.height;
			mailDisplay.addChild(email);
			mailList.push(email);	
			bigComputer_mc.mailScrollPane_sp.update();
			*/
		}
		
		public function displaySolutions(e : Event) {
			/*
			bigComputer_mc.removeChild(bigComputer_mc.mailScrollPane_sp);
			bigComputer_mc.addChild(bigComputer_mc.solutionsScrollPane_sp);			
			var solutionDisplay : MovieClip = new MovieClip;
			var asco : int = 0;
			for each(var solution : Solution in e.target.userData) {
				/*
				var email : MovieClip = new EMailView;
				email.addEventListener(MouseEvent.CLICK, closeSolutions);
				email.mailText_mc.text = solution.solutionDescription;
				email.y = asco * email.height;
				asco++;
				solutionDisplay.addChild(email);
				
			}
			bigComputer_mc.solutionsScrollPane_sp.source = solutionDisplay;
			bigComputer_mc.solutionsScrollPane_sp.update();
			*/
		}
		
		public function closeSolutions(e : Event):void {
		//	bigComputer_mc.removeChild(bigComputer_mc.solutionsScrollPane_sp);
		//	bigComputer_mc.addChild(bigComputer_mc.mailScrollPane_sp);		
		}
		
	}

}