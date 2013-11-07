package ThePackage.Crap 
{
	/**
	 * ...
	 * @author Jeremy Bond
	 */
	public class SpaceCrapFactory
	{
		
		public function makeSpaceCrap(type : int ) :Crap
		{
			var astroid : Crap;
			if (type == 0) 
			{
				astroid = new NormalCrap();
			}else {
				astroid = new StarCrap();
			}
			
			astroid.scaleX	=	0.5 + (Math.random() * 1);
			astroid.scaleY	=	astroid.scaleX;
			
			return astroid;
		}
		
	}

}