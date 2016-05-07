package tgame.behaviors;

import flixel.FlxG;
import flixel.system.debug.DebuggerUtil;
import flixel.system.debug.FlxDebugger;
import tgame.Behavior;
import tgame.critters.Critter;
import tgame.critters.DarkLord;
import tgame.World;
import util.Calc;

/**
 * ...
 * @author qwerber
 */
class EnemyDarkLord extends Behavior
{

	private var time:Int;
	private var randRange:Int;
	private var timer:Int;
	var fac:Float;
	
	public function new() 
	{
		super();
		timer = 400;
		time = 0;
		
		fac = 1;
		randRange =  200;
	}
	
	override public function update(_critter:Critter) 
	{
		var d = cast(_critter, DarkLord);
		var ax = World.curWorld.darkLord1.x;
		var ay = World.curWorld.darkLord1.y;
		var dx = (ax - d.x);
		var dy = d.y - ay;
		/*if (dy < -120) ay -= 80; 
		//if (Math.abs(dx) < 150) ay *= 0.5; 
			
		if (dx * dx > randRange * randRange)
		{
			//if (Math.abs(dx) - randRange > 50) d.dash();
			if (d.x < ax) _critter.moveToward(Critter.RIGHT);
			else _critter.moveToward(Critter.LEFT);
		}else _critter.moveToward(0);*/
		
		++time;
		
		if (time >= timer)
		{
			//d.dash();
			
			time -=  cast (Math.random() * 200);
			
			
				
			
			var dissq = dx*dx + dy*dy;
			var a = -100;
			var v = 200;
			
			var dx = Math.abs(ax - d.x);
			var dy = d.y - ay;
			
			
			var f:Float -> Float = 
				function(vy) {
					return ((vy + Math.sqrt(vy*vy + 2*a*dy))/(-a))-(dx/Math.sqrt(v*v-vy*vy));
				};
				trace(dx, dy);
			var vely = Calc.bisectionSolver(f, 199, 180);
			
			var velx = Math.sqrt(40000 - vely * vely);
			trace(dx, dy, velx, vely);
			ay -= (Math.abs(dx) - Math.abs(dy)) * Math.pow(Math.abs(dx) / 300, fac);
			ax += Math.random() * 30 - 15;
			ay += Math.random() * 30 - 15;
			d.fireBall(-velx + d.x, -vely + d.y, 2);
		}
		
		if (FlxG.keys.justPressed.Z) fac += 0.05;
		if ( FlxG.keys.justPressed.X) fac -= 0.05;
		
	}	
}