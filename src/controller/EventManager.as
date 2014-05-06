package controller  {
	
import model.NonCausalEpisode;
	
	public class EventManager {

		private var causalEvents : Array;
		private var _nonCausalEpisodeForDay : Array;
		
		public function EventManager() {
			causalEvents = new Array();
			nonCausalEpisodeForDay = new Array(10);
			for(var i : int = 0;i<10;i++){
				nonCausalEpisodeForDay[i] = new Array();
			}
		}
		
		public function loadNonCausalEpisodes(xmlNonCausalEpisodes : XML){
			var nonCausalEpisodesLength : int = xmlNonCausalEpisodes.event.length();
			for (var i : int = 0; i < nonCausalEpisodesLength; i++) {
				var nonCausalEpisode : NonCausalEpisode = new NonCausalEpisode(xmlNonCausalEpisodes.event[i].title, xmlNonCausalEpisodes.event[i].description, xmlNonCausalEpisodes.event[i].incomeModifier,xmlNonCausalEpisodes.event[i].penalty);
				_nonCausalEpisodeForDay[xmlNonCausalEpisodes.event[i].day].push(nonCausalEpisode);
			}
		}
		
		public function get nonCausalEpisodeForDay():Array 
		{
			return _nonCausalEpisodeForDay;
		}
		
		public function set nonCausalEpisodeForDay(value:Array):void 
		{
			_nonCausalEpisodeForDay = value;
		}

	}
	
}
