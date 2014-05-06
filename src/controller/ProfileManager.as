package controller 
{
	import flash.display.MovieClip;
	import model.Profile;
	import view.CharacterAnimation;
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
				var normalAnimation:Class = getDefinitionByName(profileXML.profile[i].normalAnimation) as Class;
				var nA:MovieClip = new normalAnimation();
				var happyAnimation:Class = getDefinitionByName(profileXML.profile[i].happyAnimation) as Class;
				var hA:MovieClip = new happyAnimation();
				var angryAnimation:Class = getDefinitionByName(profileXML.profile[i].angryAnimation) as Class;
				var aA:MovieClip = new angryAnimation();
				var characterAnimation : CharacterAnimation = new CharacterAnimation(nA,hA,aA);
				var profile : Profile = new Profile(proactivity,stress ,s, profileXML.profile[i].name,characterAnimation);
				_profiles[i] = profile;
			}
		}
		
		public function get profiles() : Array 
		{
			return _profiles;
		}
		
	}

}