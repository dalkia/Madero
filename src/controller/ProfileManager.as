package controller 
{
	import model.Profile;
	import view.ProfileCard;
	import flash.utils.*;
	/**
	 * ...
	 * @author Juanola
	 */
	public class ProfileManager 
	{
		
		private var profileXML : XML;
		private var totalProfiles : int;
		private var _profiles : Array;
		
		public function ProfileManager(profileXML : XML) 
		{
			this.profileXML = profileXML;
			var totalProfiles : int = profileXML.profile.length(); 
			_profiles = new Array(totalProfiles);
			for (var i: int = 0; i < totalProfiles; i++) {				
				var profileCard:Class = getDefinitionByName(profileXML.profile[i].movieClip) as Class;				
				var proactivity : int = int(profileXML.profile[i].proactivity);
				var stress : int = int(profileXML.profile[i].stress);
				var s:ProfileCard = new profileCard();
				var profile : Profile = new Profile(proactivity,stress ,s, profileXML.profile[i].name);
				_profiles[i] = profile;
			}
		}
		
		public function get profiles() : Array 
		{
			return _profiles;
		}
		
	}

}