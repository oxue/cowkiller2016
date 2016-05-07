package tgame;
import flixel.FlxG;
import tgame.critters.DarkLord;

/**
 * ...
 * @author qwerber
 */
class HUD
{
	private var target:DarkLord;
	private var healthBar:ValueBar;
	
	public function new(_target:DarkLord) 
	{
		target = _target;
		healthBar = new ValueBar(100);
		FlxG.state.add(healthBar);
	}
	
	public function update()
	{
		healthBar.setValue(cast target.health);
	}
	
}