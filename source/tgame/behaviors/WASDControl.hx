package tgame.behaviors;
import flixel.FlxG;
import tgame.Behavior;
import tgame.critters.Critter;
import tgame.critters.DarkLord;

/**
 * ...
 * @author q
 */
class WASDControl extends Behavior
{

	public function new() 
	{
		super();
	}
	
	override public function update(_critter:Critter) 
	{
		if (FlxG.keys.pressed.A)
			_critter.moveToward(Critter.LEFT);
		else if (FlxG.keys.pressed.D)
			_critter.moveToward(Critter.RIGHT);
		else
			_critter.moveToward(0);
			
		if (FlxG.keys.pressed.W)
			_critter.jump();
	}
	
}