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
		
		public var computerView : ComputerView;
		
		
		public function MainSimulationScreen() 
		{			
			computerView = new ComputerView(this);			
			littleComputer_mc.addEventListener(MouseEvent.CLICK, openBigComputer);			
		}
		
		public function setTotalMoneyText(totalMoney : int) : void {
			totalMoney_txt.text = "$ " + totalMoney.toString();
		}
		
		public function openBigComputer(e : Event) : void {		
			computerView.goToSelectionScreen();
			addChild(computerView);
			//bigComputer_mc.removeChild(bigComputer_mc.solutionsScrollPane_sp);
		}
		
		public function removeBigComputer() : void {
			removeChild(computerView);
		}
		
		public function addEmail(sender : String, title : String, description : String,conflict : Conflict) {			
			var email : MovieClip = new mailTemplate_mc();			
			email.mailText_mc.text = "from: " + sender + " subject: " + title;
			conflict.owner = sender;
			email.userData = conflict;
			computerView.addEmail(email);			
		}
		
		
		
		public function closeSolutions(e : Event):void {
		//	bigComputer_mc.removeChild(bigComputer_mc.solutionsScrollPane_sp);
		//	bigComputer_mc.addChild(bigComputer_mc.mailScrollPane_sp);		
		}
		
	}

}