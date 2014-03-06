package view 
{
	import fl.containers.ScrollPane;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;
	import model.Conflict;
	import flash.display.MovieClip;
	/**
	 * ...
	 * @author Juanola
	 */
	public class MailScreen extends ComputerScreen 
	{
		
		private var keyboard : Keyboard;
		private var keyboardOn : Boolean;
		
		
		public function MailScreen() 
		{
			super();
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
			mailScrollPane.update();		
			addChildAt(mailScrollPane,2);
		}
		
		public function displayEmail(conflict:Conflict):void 
		{
			var currentConflict : Conflict = conflict;			
			removeChildAt(2);
			var emailView : EMailView = new EMailView;
			emailView.x = 170;
			emailView.y = 105;
			addChildAt(emailView,2);
			emailView.from_txt.text = currentConflict.owner;
			emailView.title_txt.text = currentConflict.title;
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
			addChild(keyboard);
			keyboardOn = true;
		}
		
	}

}