package  
{

	import com.gskinner.motion.GTween;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import utils.SimpleZSorter;
	import utils.Math2;
	import fl.motion.easing.*;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	/**
	 * ...
	 * @author Juanola
	 */
	public class CarouselManager extends Sprite
	{
		
		private var container: Sprite;
		private var anglePer:Number;
		
		public var clock_mc:MovieClip;
		public var cover:MovieClip;
		
		public function CarouselManager() 
		{
			init();
			loadCards();
			createTimer();
		}
		
		private function createTimer():void {
			clock_mc.timer_txt.text = 60;
			trace("hola");
			var timer:Timer = new Timer(1000, 60);
			timer.addEventListener(TimerEvent.TIMER, runTimer);
			timer.start();			
		}
		
		function runTimer(e:TimerEvent):void{
			clock_mc.timer_txt.text = clock_mc.timer_txt.text - 1;
		} 
		
		private function loadCards():void {
			var workingCards : Array = new Array(8);
			anglePer = (Math.PI * 2) / workingCards.length;
			
			workingCards[0] = new catalinaCard_mc;
			workingCards[1] = new martaCard_mc;
			workingCards[2] = new martinCard_mc;
			workingCards[3] = new nicolasCard_mc;
			workingCards[4] = new robertoCard_mc;
			workingCards[5] = new tomasCard_mc;
			workingCards[6] = new valentinaCard_mc;
			workingCards[7] = new victoriaCard_mc;
			
			for (var i:int = 0; i < workingCards.length; i++) {
				workingCards[i].buttonMode = true;				
				workingCards[i].addEventListener(MouseEvent.CLICK, onClick);
				

		
				
				workingCards[i].angle = (i * anglePer) - Math.PI / 2;
				workingCards[i].x = Math.cos(workingCards[i].angle ) * 450;
				workingCards[i].z = Math.sin(workingCards[i].angle ) * 450;
				workingCards[i].rotationY = 360/workingCards.length * -i;
				
				container.addChild(workingCards[i]);
			}
		}
		
		private function onClick(e:MouseEvent):void {
			
			//var tw:GTween = new GTween(container, 0.8, { rotationY:Math2.toDeg(e.currentTarget.angle + Math.PI / 2), z:100 },
			//											{ease:Exponential.easeInOut } );
			
			var tw:GTween = new GTween(container, 0.8, { rotationY:Math2.toDeg(e.currentTarget.angle + Math.PI / 2)},
														{ease:Exponential.easeInOut } );
		}
		
		
		private function init():void
		{
			container = new Sprite();
			container.x = 800/2;
			container.y = 600/2;
			container.z = 400;
			addChild(container);
			
			this.addEventListener(Event.ENTER_FRAME, loop);
			cover.addEventListener(MouseEvent.CLICK, stageClick);
			
		}
		
		private function stageClick(e:MouseEvent) {
			var tw:GTween = new GTween(container, 0.8, { z: 400},{ease:Exponential.easeInOut } );
			
		}
		
		private function loop(e:Event):void {
			SimpleZSorter.sortClips(container);
		}
		
		
	}

}