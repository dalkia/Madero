package  
{

	import com.gskinner.motion.GTween;
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
			var octavioCards : Array = new Array(10);
			anglePer = (Math.PI * 2) / octavioCards.length;
			
			for (var i : int = 0; i < 10; i++) {
				octavioCards[i] = new octavioCard_mc;
			}
			
			for (var i:int = 0; i < octavioCards.length; i++) {
				octavioCards[i].buttonMode = true;				
				octavioCards[i].addEventListener(MouseEvent.CLICK, onClick);
				

				
				
				octavioCards[i].angle = (i * anglePer) - Math.PI / 2;
				octavioCards[i].x = Math.cos(octavioCards[i].angle ) * 450;
				octavioCards[i].z = Math.sin(octavioCards[i].angle ) * 450;
				octavioCards[i].rotationY = 36 * -i;
				
				container.addChild(octavioCards[i]);
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