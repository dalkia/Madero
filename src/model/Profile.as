package model 
{
	import flash.display.MovieClip;
	import view.CharacterAnimation;
	import view.ProfileCard;
	import model.Conflict;
	import model.Penalty;
	/**
	 * ...
	 * @author Juanola
	 */
	public class Profile 
	{
		
		private var _proactivity : int;
		private var _stress : int;
		private var _profileCard: ProfileCard;
		private var _profileName : String;
		private var _currentConflicts : Array;
		private var _characterAnimation : CharacterAnimation;
		
		public function Profile(proactiviy :int,stress : int,profileCard : ProfileCard, nameA : String, characterAnimation : CharacterAnimation) 
		{
			_proactivity = proactiviy;
			_stress = stress;
			_profileCard = profileCard;
			_profileName = nameA;
			_profileCard.setProactivity(_proactivity);
			_profileCard.setProfileName(_profileName);
			_profileCard.profile = this;
			_currentConflicts = new Array();
			_characterAnimation = characterAnimation;
		}
		
		public function get profileCard() : ProfileCard {
			return _profileCard;
		}
		
		public function get proactivity() : int {
			return _proactivity;
		}
		
		public function get stress() : int {
			return _stress;
		}
		
		public function get profileName():String{
			return _profileName;
		}
		
		public function addConflict(conflict : Conflict):void{
			_currentConflicts.push(conflict);
		}
		
		public function applyPenalty():void {
			for each(var conflict : Conflict in _currentConflicts) {
				_proactivity += conflict.penalty.proactivityPenalty;
				_stress += conflict.penalty.stressPenalty;
			}
		}
		
		public function get currentConflicts():Array{
			return _currentConflicts;
		}
		
	}

}