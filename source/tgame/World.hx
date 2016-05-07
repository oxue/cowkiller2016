package tgame;
import flixel.effects.FlxFlicker;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.group.FlxTypedGroup.FlxTypedGroup;
import flixel.tile.FlxTilemap;
import flixel.util.FlxColorUtil;
import tgame.critters.Cow;
import tgame.critters.Critter;
import tgame.critters.DarkLord;
import tgame.projectile.Smoke;

/**
 * ...
 * @author q
 */
class World
{

	public static var curWorld:World;
	
	public var friendlyCritters:FlxGroup;
	public var friendlyHazards:FlxGroup;
	public var enemyCritters:FlxGroup;
	public var enemyHazards:FlxGroup;
	public var solids:FlxGroup;
	
	public var smoke:Smoke;
	
	public var tilemap:FlxTilemap;
	public var lm:FlxLightMap;
	public var lightSources:Array<LightSource>;
		
	public var darkLord1:DarkLord;
	
	public function new() 
	{
		friendlyCritters = new FlxGroup();
		friendlyHazards  = new FlxGroup();
		enemyCritters = new FlxGroup();
		enemyHazards = new FlxGroup();
		//npcs = new FlxTypedGroup();
		solids = new FlxGroup(); 
		lightSources = new Array<LightSource>();
	}
	
	public function prepareCows(_num:Int):Void
	{
		while(_num-->0)
			friendlyCritters.add(new Cow(0, 0)).kill();
	}
	
	public function overlap()
	{
		FlxG.collide(tilemap, solids);
		FlxG.overlap(friendlyHazards, friendlyCritters, hurtCritter);
		FlxG.overlap(enemyHazards, enemyCritters, hurtCritter);
	}
	
	function hurtCritter(_b:IHazardous, _c:FlxSprite) 
	{
		_b.damage(_c);
		if (_b.oneTime())
		(cast _b).destroy();
	}
	
}