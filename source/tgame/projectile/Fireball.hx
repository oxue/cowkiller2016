package tgame.projectile;
import flixel.effects.FlxFlicker;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.util.FlxPoint;
import openfl.Assets;
import tgame.critters.Critter;
import tgame.IHazardous;
import tgame.World;

/**
 * ...
 * @author q
 */
class Fireball extends FlxSprite implements IHazardous
{

	private var speed:Int;
	private var smoke:Smoke;
	var decaying:Bool;
	var decayTime:Int;
	
	public function new(_x:Float, _y:Float, _vel:FlxPoint) 
	{
		super(_x, _y, Assets.getBitmapData("assets/images/fireball.png", true));
		
		speed = 200;
		acceleration.y = 100;
		
		var dis = _vel.distanceTo(new FlxPoint());
		_vel.x /= dis;
		_vel.y /= dis;
		velocity = _vel;
		velocity.x *= speed;
		velocity.y *= speed;
		health = 1;
		
		decaying = false;
		decayTime = 80;
		
		smoke = new Smoke();
		smoke.start(false, 1, 0.1);
		smoke.setXSpeed( -30, 30);
		smoke.setYSpeed( -30, 15);
	}
	
	public function oneTime():Bool { return true; }
	
	override public function update():Void 
	{
		if (decaying)
		{
			decayTime--;
			if (decayTime <= 0)
			{
				super.destroy();
				smoke.destroy();
				return;
			}
		}
		super.update();
		smoke.at(this);
		smoke.update();
		if (overlaps(World.curWorld.tilemap))
		{
			//this.visible = false;
			destroy();
		}
	}
	
	override public function destroy():Void 
	{
		decaying = true;
		this.velocity = new FlxPoint();
		smoke.on = false;
	}
	
	public function damage(_c:FlxObject):Void
	{
		if (!decaying)
		{
			FlxFlicker.flicker(_c, 1);
			_c.hurt(10);
			if (Std.is(_c, Critter))
			(cast (_c, Critter)).jump(0.5);
		}
	}
	
	override public function draw():Void 
	{
		smoke.draw();
		if(!decaying)
		super.draw();
	}
	
}