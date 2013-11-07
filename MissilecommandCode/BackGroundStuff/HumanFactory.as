package ThePackage.BackGroundStuff 
{
	import adobe.utils.CustomActions;
	/**
	 * ...
	 * @author Jeremy Bond
	 */
	public class HumanFactory 
	{
		public function makeHuman(type:int): Human
		{
			var guy : Human;
			if (type == 0) 
			{
				guy = new RunnerGuy();
			}
			if(type == 1){
				guy = new WalkerGuy();
			}
			if(type == 2){
				guy = new RunnerWoman();
			}
			if(type == 3){
				guy = new WalkerWoman();
			}
			
			guy.scaleX	=	0.5 + (Math.random() * 1);
			guy.scaleY	=	guy.scaleX;
			guy.z = 100;
			
			
			return guy;
		}
		
	}

}