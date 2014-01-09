package controller
{

	import com.gskinner.motion.GTween;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import com.utils.SimpleZSorter;
	import com.utils.Math2;
	import fl.motion.easing.*;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import view.ProfileCard;
	import view.ProfilePicture;
	/**
	 * ...
	 * @author Juanola
	 */
	public class CarouselManager extends MovieClip 
	{
		
		private var container: Sprite;
		private var anglePer:Number;
		
		public var clock_mc:MovieClip;
		public var carouselView:MovieClip;
		
		private var profiles:Array;
		
		public function CarouselManager(profiles : Array) 
		{
			init();
			this.profiles = profiles;
			loadCards();
			//createTimer();
		}
		
		private function createTimer():void {
			clock_mc.timer_txt.text = 60;
			var timer:Timer = new Timer(1000, 60);
			timer.addEventListener(TimerEvent.TIMER, runTimer);
			timer.start();			
		}
		
		function runTimer(e:TimerEvent):void{
			clock_mc.timer_txt.text = clock_mc.timer_txt.text - 1;
		} 
		
		private function loadCards():void {	
			anglePer = (Math.PI * 2) / profiles.length;					
			for (var i:int = 0; i < profiles.length; i++) {	
				profiles[i].profileCard.carouselManager = this;
				profiles[i].profileCard.container = container;
				profiles[i].profileCard.angle = (i * anglePer) - Math.PI / 2;
				profiles[i].profileCard.x = Math.cos(profiles[i].profileCard.angle ) * 450;
				profiles[i].profileCard.z = Math.sin(profiles[i].profileCard.angle ) * 450;
				profiles[i].profileCard.rotationY = 360/profiles.length * -i;				
				container.addChild(profiles[i].profileCard);
			}
		}
		
		
		
		
		private function init():void
		{
			carouselView = new CarouselView;
			addChild(carouselView);
			
			container = new Sprite();
			container.x = 800/2;
			container.y = 275;
			container.z = 400;
			addChild(container);			
			
			this.addEventListener(Event.ENTER_FRAME, loop);
			//carouselView.addEventListener(MouseEvent.CLICK, stageClick);
			
		}
		
		/*
		For zooming out
		private function stageClick(e:MouseEvent) {
			var tw:GTween = new GTween(container, 0.8, { z: 400},{ease:Exponential.easeInOut } );
			
		}
		*/
		
		private function loop(e:Event):void {
			SimpleZSorter.sortClips(container);
		}
		
		public function addProfileToTeam(profilePicture : ProfilePicture) :void {
			profilePicture.x = 25.95;
			profilePicture.y = 485.8;
			addChild(profilePicture);
		}
		
		
	}

}