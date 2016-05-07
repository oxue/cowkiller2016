package tgame;
import flixel.tile.FlxTilemap;
import openfl.Assets;

/**
 * ...
 * @author q
 */

class Random
{
	public var seed : Int;
	
	public function new(seed = 1)
	{
		this.seed = seed;
	}
	
	public inline function int() : Int
	{
#if neko
		return untyped __dollar__int( seed = (seed * 16807.0) % 2147483647.0 ) & 0x3FFFFFFF;
#elseif flash9
		return (seed = Std.int((seed * 16807.0) % 2147483647.0)) & 0x3FFFFFFF;
#else
		return (seed = (seed * 16807) % 0x7FFFFFFF) & 0x3FFFFFFF;
#end
	}

	public inline function float() : Float
	{
		return int() / 1073741823.0; // divided by 2^30-1
	}
}
 
class FlxBuildingGen
{
	static public function generateBox(_width:Int, _height:Int, _material:Int):Array2D<Int>
	{
		var ret:Array2D<Int> = new Array2D<Int>(_width, _height, 0);
		
		// march around the border and populate that with the material
		var i:Int = _height;
		while (i-->0)
		{
			ret.set(0, i, _material);
			ret.set(_width - 1, i, _material);
		}
		
		var j:Int = _width;
		while (j-->0)
		{
			ret.set(j, 0, _material);
			ret.set(j, _height - 1, _material);
		}
		
		return ret;
	}
	
	static public function generateSolidBox(_width:Int, _height:Int, _material:Int):Array2D<Int>
	{
		var ret:Array2D<Int> = new Array2D<Int>(_width, _height, _material);
		return ret;
	}
	
	static public function blitArray2D(_source:Array2D<Int>, _target:Array2D<Int>, _x:Int, _y:Int):Void
	{
		var i:Int = _source.getHeight();
		while (i-->0)
		{
			var j:Int = _source.getWidth();
			while (j-->0)
			{
				_target.set(_x + j, _y + i, _source.get(j, i));
			}
		}
	}
	
	static public function writeBuildingAt(_map:Array2D<Int>, _x:Int, _y:Int):Void
	{
		var cY:Int = 0;
		var roof:Array2D<Int> = generateSolidBox(8, 2, GameConstants.WOODBOARD);
		blitArray2D(roof, _map, _x + 1, _y);
		cY += 2;
		
		roof = generateSolidBox(10, 2, GameConstants.WOODBOARD);
		blitArray2D(roof, _map, _x, _y + cY);
		cY += 2;
		var walls:Array2D<Int> = generateBox(10, 10, GameConstants.STONEBLOCK);
		blitArray2D(walls, _map, _x, _y + cY);
	}
	
}

class FlxTerraGen
{
	static private var rand:Random;
	
	static public function generateTerramap(_mapWidth:Int, _mapHeight:Int):FlxTilemap
	{
		rand = new Random(33);
		
		var ret:FlxTilemap = new FlxTilemap();
		ret.widthInTiles = _mapWidth;
		ret.heightInTiles = _mapHeight;
		
		var mapData:Array2D<Int> = new Array2D<Int>(_mapWidth, _mapHeight, 0);
		var heights:Array<Float> = generateHeightArray(_mapWidth);
		var i = _mapWidth;
		while (i-->0)
		{
			var hVal;
			var constHVal = hVal = Std.int(heights[i] * cast(_mapHeight, Float));
			if (hVal <= 0) hVal = 1;
			var j:Int = _mapHeight;
			while (hVal-->0)
			{
				j--;
				if (j > _mapHeight - constHVal + Math.sin(i * 0.05) * 4 + 6)
				{
					mapData.set(i, j, 2);
				}
				else
				{
					mapData.set(i, j, 1);
				}
			}
			mapData.set(i, j, 5);
			
			// I and J are the surfacecoordinates
			//if (Math.random() > 0.2)
			//FlxBuildingGen.writeBuildingAt(mapData, i, j);
		}
		ret.loadMap(mapData.getInternalData(), Assets.getBitmapData("assets/images/tiles.png",true), 8, 8, FlxTilemap.OFF);
		//ret.allowCollisions = 15;
		return ret;
	}
	
	inline static public function randBetween(_a:Float, _b:Float):Float
	{
		return _a + rand.float() * (_b -_a);
	}
	
	static public function generateHeightArray(_w:Int):Array<Float>
	{
		var nodes:Array<Float> = [0.4, randBetween(0.4,0.5), 0.4];
		
		var randMax:Float = 0.6;
		
		while (nodes.length < _w)
		{
			var i = nodes.length;
			while (i-->1)
			{
				var val1 = nodes[i];
				var val2 = nodes[i - 1];
				var med = (val1 + val2) * 0.5;
				nodes.insert(i, med + randBetween(-randMax, randMax));
				randMax *= 0.95;
			}
		}
		
		return nodes;
	}
	
	static public function initRand() 
	{
		rand = new Random(100);
	}
	
	// unused ctor
	public function new() 
	{
		
	}
	
}