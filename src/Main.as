package
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import screens.GameOverScreen;
	import screens.GameScreen;
	import screens.IntroScreen;
	import sounds.SoundPlayer;
	import screens.WinScreen;
	
	
	/**
	 * ...
	 * @author Erwin Henraat
	 */
	public class Main extends MovieClip 
	{
		private var gameScreen:GameScreen
		private var introScreen:IntroScreen;
		private var gameOverScreen:GameOverScreen;
		private var soundPlayer:SoundPlayer;
		private var gameWin:WinScreen;
		
		public function Main() 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point			
			soundPlayer = new SoundPlayer(this);
			buildIntroSreen();	
		}
		private function buildIntroSreen():void
		{			
			introScreen = new IntroScreen();
			addChild(introScreen);
			introScreen.addEventListener(IntroScreen.START_GAME, startGame);
		}
		private function startGame(e:Event):void 
		{
			removeChild(introScreen);
			gameScreen = new GameScreen();
			addChild(gameScreen);
			gameScreen.addEventListener(GameScreen.GAME_OVER, onGameOver);
			gameScreen.addEventListener(GameScreen.GAME_WIN, onGameWin);
			
			
			
		}		
	
		private function onGameOver(e:Event):void 
		{
			removeChild(gameScreen);
			gameScreen.removeEventListener(GameScreen.GAME_OVER, onGameOver);
						
			gameOverScreen = new GameOverScreen();
			addChild(gameOverScreen);
			gameOverScreen.addEventListener(GameOverScreen.RESET, onReset);
			
			
			
		}		
		private function onReset(e:Event):void 
		{
			removeChild(gameOverScreen);
			gameOverScreen.removeEventListener(GameOverScreen.RESET, onReset);
			
			buildIntroSreen();
		}
		
		private function onGameWin(e:Event):void 
		{
			removeChild(gameScreen);
			gameScreen.removeEventListener(GameScreen.GAME_WIN, onGameWin);
      
			gameWin = new WinScreen();
			addChild(gameWin);
			gameWin.addEventListener(WinScreen.RESET2, onResetWin);
   
		}
		
		private function onResetWin(e:Event):void
		{
			gameWin.removeEventListener(WinScreen.RESET2, onResetWin);
			removeChild(gameWin);
			buildIntroSreen();
		}
	
	}
	
}