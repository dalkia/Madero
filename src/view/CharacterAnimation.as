package view 
{
	import flash.display.MovieClip;
	/**
	 * ...
	 * @author Juanola
	 */
	public class CharacterAnimation 
	{
		
		private var _normalAnimation : MovieClip;
		private var _happyAnimation : MovieClip;
		private var _angryAnimation : MovieClip;
		
		public function CharacterAnimation(normalAnimation : MovieClip, happyAnimation : MovieClip, angryAnimation : MovieClip) 
		{
			_normalAnimation = normalAnimation;
			_happyAnimation = happyAnimation;
			_angryAnimation = angryAnimation;
		}
		
	}

}