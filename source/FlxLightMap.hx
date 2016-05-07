package ;

import flash.display.BlendMode;
import flash.geom.Rectangle;
import flash.Vector.Vector;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.tile.FlxTilemap;
import flixel.util.FlxColorUtil;
import flixel.util.FlxPoint;
import openfl.utils.ByteArray;
import tgame.Array2D;
import tgame.LightSource;
import tgame.World;

/**
 * ...
 * @author q
 */
class FlxLightMap extends FlxSprite
{

	private var targetTilemap:FlxTilemap;
	private var ambientValue:UInt;
	private var lightMap:Array2D<UInt>;
	
	private var lightMapW:Int;
	private var lightMapH:Int;
	
	public function new(X:Float=0, Y:Float=0, _targetTilemap:FlxTilemap) 
	{
		super(X, Y);
		scrollFactor = new FlxPoint();
		blend = BlendMode.MULTIPLY;
		targetTilemap = _targetTilemap;
		ambientValue = 0xff888888;
		
		var s = new FlxPoint(8, 8);
		lightMapW = cast FlxG.width + s.x;
		lightMapH = cast FlxG.height + s.y;
		
		lightMap = new Array2D<UInt>(cast(lightMapW / s.x), cast(lightMapH / s.x), 0xff555555);
		makeGraphic(Std.int(lightMapW / s.x), Std.int(lightMapH / s.x), 0xffffff00);
		
		scale.x = scale.y = 8;
		origin.x = origin.y = 0;
	}
	
	public function blitLight_add(_light:LightSource)
	{
		
		try{
		var r:Rectangle = 
			new Rectangle(_light.x - _light.radius, 
						  _light.y - _light.radius,
						  _light.computedLightmap.width,
						  _light.computedLightmap.height);
		var vs:ByteArray = pixels.getPixels(r);
		vs.position = 0;
		var dv:ByteArray = _light.computedLightmap.getPixels(_light.computedLightmap.rect);
		dv.position = 0;
		var i = vs.length - 1;
		while (i>0)
		{
			var a:UInt = dv.readUnsignedByte();
			var b:UInt = vs.readUnsignedByte();
			var val:UInt = a + b ; 
			vs.position-=1;
			if (val >= 255)
			val = 255;
			vs.writeByte(val);
			i-=1;
		}
		vs.position = 0;
		pixels.setPixels(r, vs);
		}catch (e:Dynamic) {
			
		}
	}
	
	override public function draw():Void 
	{
		var pos = targetTilemap.getScreenXY();
		var ts = new FlxPoint(8, 8);
		
		this.x = pos.x % ts.x;
		this.y = pos.y % ts.y;
		
		var tileX = Std.int( -pos.x / ts.x);
		var tileY = Std.int( -pos.y / ts.x);
		var i:Int = Std.int(lightMap.getWidth());
		
		var val = 0xff202020;
		
		while (i-->0)
		{
			var xv = tileX + i;
			var ambCD:Int = 6;
			var j:Int = 0;
			while (j < lightMap.getHeight())
			{
				var yv = tileY + j;
				if (targetTilemap.getTile(xv, yv) == 0)
					pixels.setPixel32(i, j, ambientValue);
				else
				{
					
					if (ambCD > 0) ambCD--;
					var val2 = ambCD;
					if (val2 >= 5) val2 = 4;
					pixels.setPixel32(i,j, 0xff000000 + val2 * val);
				}
				j++;
			}
		}
		for (l in World.curWorld.lightSources) 
			blitLight_add(l);
		super.draw();
	}
	
}