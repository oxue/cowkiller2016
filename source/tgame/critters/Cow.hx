package tgame.critters;
import openfl.Assets;
import tgame.behaviors.WanderBehavior;

/**
 * ...
 * @author q
 */
class Cow extends Critter
{

	public function new(_x:Int, _y:Int) 
	{
		super(_x, _y, Assets.getBitmapData("assets/images/cow.png",true));
		setJumpPower( 160);
		setSpeed(25);
		health = 5;
		
		addBehavior(new WanderBehavior(100,200));
	}
	
	override public function reset(X:Float, Y:Float):Void 
	{
		health = 50;
		revive();
		super.reset(X, Y);
	}
	
}