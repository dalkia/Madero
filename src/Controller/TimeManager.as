package controller {
	
	import controller.Main;
	import flash.utils.Timer;
	import flash.events.Event;
	import flash.events.TimerEvent;
	
	public class TimeManager {

		private var _dayDuration : int;
		private var _incomeDuration : int;
		private var currentDayTime : int;
		private var _main : Main;
		
		private var dayTimer:Timer;
		private var incomeTimer: Timer;
		private var _currentDay : int;
		
		public function TimeManager(dayDuration : int, main : Main, incomeModifier : int) {
			_dayDuration = dayDuration * 1000;
			_main = main;
			_incomeDuration = _dayDuration / incomeModifier;
			_currentDay = 0;
		}
		
		public function dayEnded(e : Event):void{
			_currentDay++;
			_main.dayEnded();
		}
		
		public function incomeGenerated(e : Event):void{
			_main.incomeGenerated();
		}
		
		public function startTimers():void{
			dayTimer = new Timer(_dayDuration);
			dayTimer.start();
			dayTimer.addEventListener(TimerEvent.TIMER, dayEnded);
			
			incomeTimer = new Timer(_incomeDuration);
			incomeTimer.start();
			incomeTimer.addEventListener(TimerEvent.TIMER, incomeGenerated);
			incomeGenerated(null);
		}
		
		public function get currentDay():int{
			return _currentDay;
		}
		
		

	}
	
}
