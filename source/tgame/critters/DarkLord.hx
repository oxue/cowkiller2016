package tgame.critters;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.util.FlxMath;
import flixel.util.FlxPoint;
import openfl.Assets;
import tgame.behaviors.WASDControl;
import tgame.projectile.Fireball;

/**
 * ...
 * @author q
 */
class DarkLord extends Critter
{
	private var trail:FlxTrail;
	private var dashing:Bool;
	private var dashTime:Int;
	private var dashTotal:Int;
	private var dashSpeed:Int;
	
	public function new(X:Float=0, Y:Float=0) 
	{	
		super(X, Y,  Assets.getBitmapData("assets/images/darklord.png"));
		setSpeed(50);
		setJumpPower(180);
		
		trail = new FlxTrail(this, this.pixels, 5, 2, 0.6, 0.02);
		//trail.exists = true;
		FlxG.state.add(trail);
		
		dashing = false;
		dashTime = 0;
		dashTotal = 20;
		dashSpeed = 500;
		
		health = 10000;
	}
	
	override public function update():Void 
	{		
		
		
		super.update();
		if (dashTime > 5)
		{
			dashTime --;
			velocity.x = dashSpeed * ((facing == FlxObject.LEFT)?-1:1);
			velocity.y = 0;
		}else if (dashTime > 0)
		{
			dashTime --;
		}else{
			acceleration.y = Critter.stdGrav;
			trail.exists = false;
			dashing = false;
		}
		
		if (Math.abs(velocity.x) > 450)
		trail.exists = true;
		trail.postUpdate();
	}
	
	public function fireBall(_x:Float, _y:Float, _aff:Int = 1)
	{
		var f:Fireball = new Fireball(x, y, new FlxPoint(_x - x, _y - y));
		FlxG.state.add(f);
		
		if (_aff == 1)
		World.curWorld.enemyHazards.add(f);
		if (_aff == 2)
		World.curWorld.friendlyHazards.add(f);

		
	}
	
	public function dash()
	{
		if (dashing)
		return;
		trail.exists = true;
		dashTime = dashTotal;
		dashing = true;
	}
	
}