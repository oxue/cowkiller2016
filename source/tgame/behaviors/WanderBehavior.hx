package tgame.behaviors;

import flixel.FlxObject;
import tgame.Behavior;
import tgame.critters.Critter;

/**
 * ...
 * @author q
 */
class WanderBehavior extends Behavior
{

	private var time:Int;
	private var timer:Int;
	
	private var timeMin:Int;
	private var timeMax:Int;
	
	public function new(_timeMin:Int, _timeMax:Int) 
	{
		timer = cast FlxTerraGen.randBetween(cast _timeMin, cast _timeMax);
		timeMin = _timeMin;
		timeMax = _timeMax;
		
		time = 0;
		timer = 10;
		
		super();
	}
	
	override public function update(_critter:Critter) 
	{		
		if (_critter.isTouching(FlxObject.LEFT) || _critter.isTouching(FlxObject.RIGHT))
			_critter.jump();
				
		time += 1;
		if (time >= timer)
		{
			time = 0;
			timer = cast FlxTerraGen.randBetween(cast timeMin, cast timeMax);
			
			var r = Math.random();
		_critter.moveToward(r < 0.2 ? Critter.LEFT : 
						   (r < 0.4 ? Critter.RIGHT : 0));
		}
	}
	
}