package model 
{
	import flash.display.MovieClip;
	import view.ProfileCard;
	/**
	 * ...
	 * @author Juanola
	 */
	public class Profile 
	{
		
		private var _proactivity : int;
		private var stress : int;
		private var _profileCard: ProfileCard;
		
		public function Profile(proactiviy :int,profileCard : ProfileCard) 
		{
			_proactivity = proactiviy;			
			_profileCard = profileCard;
			_profileCard.setProactivity(_proactivity);
		}
		
		public function get profileCard() : ProfileCard {
			return _profileCard;
		}
		
		public function get proactivity() : int {
			return _proactivity;
		}
		
	}

}