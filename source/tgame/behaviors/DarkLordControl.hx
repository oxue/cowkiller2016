package tgame.behaviors;

import flixel.FlxG;
import tgame.Behavior;
import tgame.critters.Critter;
import tgame.critters.DarkLord;

/**
 * ...
 * @author q
 */
class DarkLordControl extends Behavior
{

	public function new() 
	{
		super();
		
	}
	
	
	override public function update(_critter:Critter) 
	{
		var d:DarkLord = cast _critter;
		if (FlxG.keys.justPressed.SHIFT)
			d.dash();
		if (FlxG.keys.justPressed.Q)
			d.fireBall(FlxG.mouse.x, FlxG.mouse.y);
	}
}