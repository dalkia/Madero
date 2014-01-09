package view 
{
	import controller.CarouselManager;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import com.gskinner.motion.GTween;
	import com.utils.Math2;
	import fl.motion.easing.*;
	import view.ProfilePicture;
	
	/**
	 * ...
	 * @author Juanola
	 */
	public class ProfileCard extends MovieClip 
	{
		
		private var _container : Sprite;
		private var addToTeamIcon : MovieClip;
		private var _carouselManager : CarouselManager;
		
				
		
		public function ProfileCard() 
		{
			addToTeamIcon = new addToTeam_mc;
			addToTeamIcon.x = 116.05;
			addToTeamIcon.y = -203.75;
			addToTeamIcon.addEventListener(MouseEvent.CLICK, addToTeam);
			addChild(addToTeamIcon);		
			
				
			buttonMode = true;	
			addEventListener(MouseEvent.CLICK, onClick);
			
		}
		
		public function setProactivity(proactivity : int) {
			stats.gotoAndStop(proactivity);
		}
		
		public function addToTeam(e : Event) {			
			_carouselManager.addProfileToTeam(profilePictureToClone);			
		}
		
		private function onClick(e:MouseEvent):void {
			//For zooming in
			//var tw:GTween = new GTween(container, 0.8, { rotationY:Math2.toDeg(e.currentTarget.angle + Math.PI / 2), z:100 },
			//											{ease:Exponential.easeInOut } );
			
			var tw:GTween = new GTween(_container, 0.8, { rotationY:Math2.toDeg(e.currentTarget.angle + Math.PI / 2)},
														{ease:Exponential.easeInOut } );
		}
		
		public function set container(container:Sprite) {
			_container = container;
		}
		
		public function set carouselManager(carouselManager:CarouselManager) {
			_carouselManager = carouselManager;
		}
		
	}

}