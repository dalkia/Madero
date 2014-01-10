package view 
{
	
	import controller.CarouselManager;
	import controller.ProfileManager;
	import model.Conflict;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import com.gskinner.motion.GTween;
	import com.utils.Math2;
	import fl.motion.easing.*;
	import view.ProfilePicture;
	import controller.TeamManager;
	import model.Profile;
	
	/**
	 * ...
	 * @author Juanola
	 */
	public class ProfileCard extends MovieClip 
	{
		
		private var _container : Sprite;
		private var addToTeamIcon : MovieClip;
		
		private var _carouselManager : CarouselManager;
		private var _teamManager : TeamManager;
		
		private var _name : String;
		
		private var _profile : Profile;
				
		
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
		
		public function setProfileName(nameA : String){
			_name = nameA;
		}
		
		public function addToTeam(e : Event) {	
			_carouselManager.addProfileToTeam(_name.substr(0,1));
			_teamManager.addToTeam(_profile);
						
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
		
		public function set teamManager(teamManager : TeamManager){
			_teamManager = teamManager;
		}
		
		public function set profile(profile : Profile){
			_profile = profile;
		}
		
		
	}

}