package tgame.critters;

import flixel.effects.FlxFlicker;
import flixel.effects.particles.FlxTypedEmitter.Bounds;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.util.FlxSignal.FlxTypedSignal;
import openfl.Assets;

/**
 * ...
 * @author q
 */
class Critter extends FlxSprite
{
	
	public static inline var LEFT:Int = 1;
	public static inline var RIGHT:Int = 2;
	
	public static inline var stdGrav:Int = 600;
	
	private var speed:Int;
	private var jumpPower:Int;
	private var behaviors:Array<Behavior>;
	
	public function new(X:Float=0, Y:Float=0, _graphic:Dynamic = null) 
	{
		super(X, Y);
		
		behaviors = [];
		acceleration.y = stdGrav;
		solid = true;
		if (_graphic != null)
		loadGraphic(_graphic);
		
		setFacingFlip(FlxObject.RIGHT, false, false);
		setFacingFlip(FlxObject.LEFT, true, false);
		
		setSpeed(1);
		setJumpPower(160);
	}
	
	override public function hurt(Damage:Float):Void 
	{
		super.hurt(Damage);
	}
	
	public function addBehavior(_beh:Behavior):Void
	{
		behaviors.push(_beh);
	}
	
	public function getSpeed():Int
	{
		return speed;
	}
	
	public function setSpeed(_speed:Int):Void
	{
		speed = _speed;
		drag.x = speed * 8;
		maxVelocity.x = speed;
	}
	
	public function moveToward(_flag:Int):Void
	{
		if (_flag == LEFT)
		{
			acceleration.x = -drag.x;
			facing = FlxObject.LEFT;
		}
		if (_flag == RIGHT)
		{
			acceleration.x = drag.x;
			facing = FlxObject.RIGHT;
		}
		if (_flag == 0)
		{
			acceleration.x = 0;
		}
	}
	
	public function getJumpPower():Int
	{
		return jumpPower;
	}
	
	public function setJumpPower(_power:Int):Void
	{
		jumpPower = _power;
	}
	
	public function jump(_factor:Float = 1)
	{
		if (isTouching(FlxObject.DOWN))
			velocity.y = -jumpPower * _factor;
	}
	
	override public function update():Void 
	{		
		for (beh in behaviors)
		{
			beh.update(this);
		}
		
		if (FlxFlicker.isFlickering(this))
		color = 0xff7777;
		else 
		color = 0xffffff;
		
		super.update();
	}
	
}