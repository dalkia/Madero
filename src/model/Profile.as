package model 
{
	import flash.display.MovieClip;
	import view.ProfileCard;
	import model.Conflict;
	/**
	 * ...
	 * @author Juanola
	 */
	public class Profile 
	{
		
		private var _proactivity : int;
		private var stress : int;
		private var _profileCard: ProfileCard;
		private var _profileName : String;
		private var _currentConflicts : Array;
		
		public function Profile(proactiviy :int,profileCard : ProfileCard, nameA : String) 
		{
			_proactivity = proactiviy;			
			_profileCard = profileCard;
			_profileName = nameA;
			_profileCard.setProactivity(_proactivity);
			_profileCard.setProfileName(_profileName);
			_profileCard.profile = this;
			_currentConflicts = new Array();
		}
		
		public function get profileCard() : ProfileCard {
			return _profileCard;
		}
		
		public function get proactivity() : int {
			return _proactivity;
		}
		
		public function get profileName():String{
			return _profileName;
		}
		
		public function addConflict(conflict : Conflict):void{
			_currentConflicts.push(conflict);
		}
		
		public function get currentConflicts():Array{
			return _currentConflicts;
		}
		
	}

}