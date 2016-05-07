package tgame;

import flash.display.BitmapData;
import flixel.FlxSubState;
import flixel.util.FlxColor;
import flixel.util.FlxColorUtil;
import flixel.util.FlxPoint;

/**
 * ...
 * @author qwerber
 */
class LightSource extends FlxPoint
{
	
	public var computedLightmap:BitmapData;
	public var radius:Int;
	
	public function new(X:Float=0, Y:Float=0, _color:UInt, _radius:Int) 
	{
		super(X, Y);
			
		radius = _radius;
		computedLightmap = new BitmapData(radius * 2 + 1, radius * 2 + 1, true);
		var w:Int = computedLightmap.width;
		var h:Int = computedLightmap.height;
		var inverseRSq = 1 / (radius * radius);
		while (w-->0)
		{
			var j:Int = h;
			while (j-->0)
			{
				var dx = w  - radius;
				var dy = j  - radius;
				var fval:Float = 1 - Math.pow((dx * dx + dy * dy) * inverseRSq,2);
				fval = fval <= 0?0:fval;
				if (fval >1) trace(fval);
				var c:UInt = 
					FlxColorUtil.getColor32(
						255,
						Std.int(FlxColorUtil.getRed(_color) * fval),
						Std.int(FlxColorUtil.getGreen(_color) * fval),
						Std.int(FlxColorUtil.getBlue(_color) * fval));
				computedLightmap.setPixel(w , j, c);
				trace(StringTools.hex(c));
				trace(StringTools.hex(c));
			}
		}
	}
	
}