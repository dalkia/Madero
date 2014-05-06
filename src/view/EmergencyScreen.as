package view 
{
	import model.NonCausalEpisode;
	/**
	 * ...
	 * @author Juanola
	 */
	public class EmergencyScreen extends ComputerScreen 
	{
		
	
		public function EmergencyScreen(nonCausalEpisode : NonCausalEpisode) 
		{
			super();
			title_txt.text = nonCausalEpisode.title;
			description_txt.text = nonCausalEpisode.description;
		}
		
	}

}