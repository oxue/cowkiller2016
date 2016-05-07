package;
import flash.Lib;
import flixel.FlxG;
import flixel.FlxGame;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.input.mouse.FlxMouse;
import flixel.system.FlxCollisionType;
import flixel.text.FlxText;
import flixel.tile.FlxTilemap;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import flixel.util.FlxPoint;
import openfl.Assets;
import tgame.behaviors.DarkLordControl;
import tgame.behaviors.EnemyDarkLord;
import tgame.behaviors.WanderBehavior;
import tgame.behaviors.WASDControl;
import tgame.critters.Cow;
import tgame.critters.Critter;
import tgame.critters.DarkLord;
import tgame.critters.Human;
import tgame.DialogueBox;
import tgame.FlxTerraGen;
import tgame.HUD;
import tgame.LightSource;
import tgame.World;

/**
 * A FlxState which can be used for the game's menu.
 */
class MenuState extends FlxState
{
	var focus:FlxObject;
	var speed = 10;
	var hud:HUD;

	private var world:World;
	private var l:LightSource;
	private var dark:DarkLord;
	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
		super.create();
		
		focus = new FlxObject(320,240);
		FlxTerraGen.initRand();
		set_bgColor(0xffD9FFFF);
		
		world = new World();
		World.curWorld = world;
		//world.prepareCows(100);
		world.tilemap = cast add(FlxTerraGen.generateTerramap(1024, 128));
		
		var d:DarkLord = new DarkLord(100, 100);
		world.solids.add(d);
		world.friendlyCritters.add(d);
		d.addBehavior(new WASDControl());
		d.addBehavior(new DarkLordControl());
		add(d);
		
		world.darkLord1 = d;
		
		var i = 3;
		while (i-->0)
		{
			var c:Cow = new Cow(0,0);
			c.reset(100 * i, 10);
			world.solids.add(c);
			world.enemyCritters.add(c);
			world.friendlyCritters.add(c);
			c.addBehavior(new WASDControl());
			add(c);
			
			var f:Human = new Human(10 + 50 * i, 10);
			world.solids.add(f);
			world.enemyCritters.add(f);
			world.friendlyCritters.add(f);
			add(f);
			f.addBehavior(new WanderBehavior(200, 300));
		}
		i = 1;
		while (i-->0)
		{
			var dling:DarkLord = new DarkLord(d.x+500 + i * 350, d.y);
			dling.addBehavior(new WanderBehavior(30, 50));
			dling.addBehavior(new EnemyDarkLord());
			world.solids.add(dling);
			world.enemyCritters.add(dling);
			add(dling);
		}
		
		//world.lm = new FlxLightMap(0, 0, world.tilemap);
		
		//l = new LightSource(20, 20, 0xff888888, 14);
		//world.lightSources.push(l);
		
		var dia = new DialogueBox();
		dia.setText("ASDAASDASDA");
		//Lib.current.stage.addChild(dia);
		
		FlxG.camera.follow(focus);
		FlxG.worldBounds.width = (cast world.tilemap).width;
		FlxG.worldBounds.height = (cast world.tilemap).height;
		
		hud = new HUD(d);
		
		dark = d;
	}
	
	/**
	 * Function that is called when this state is destroyed - you might want to 
	 * consider setting all objects this state uses to null to help garbage collection.
	 */
	override public function destroy():Void
	{
		super.destroy();
	}

	override public function draw():Void 
	{
		super.draw();
		
		//world.lm.draw();
	}
	
	/**
	 * Function that is called once every frame.
	 */
	override public function update():Void
	{
		if (FlxG.mouse.wheel != 0)
		{
			trace(FlxG.camera.zoom);
			FlxG.camera.zoom += (FlxG.mouse.wheel / Math.abs(FlxG.mouse.wheel)) * 0.2;
			FlxG.camera.width = cast (640 / FlxG.camera.zoom);
			FlxG.camera.height = cast (480 / FlxG.camera.zoom);
		}
		
		if (FlxG.keys.pressed.LEFT)
			focus.x -= speed;
			
		if (FlxG.keys.pressed.RIGHT)
			focus.x += speed;
			
		if (FlxG.keys.pressed.UP)
			focus.y -= speed;
			
		if (FlxG.keys.pressed.DOWN)
			focus.y += speed;
		super.update();
		world.overlap();
		//l.x = dark.getScreenXY().x / 8;
		//l.y = dark.getScreenXY().y / 8;
		//trace(l.x);
		//trace(l.y);
		hud.update();
	}	
}