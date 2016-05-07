package tgame;
import flixel.FlxSprite;
import flixel.util.FlxColor;

/**
 * ...
 * @author qwerber
 */
class ValueBar extends FlxSprite
{
	private var barWidth:Int;
	private var value:Int;
	private var maxValue:Int;
	
	public function new(_maxVal:Int) 
	{
		super(x, y);
		barWidth = 100;
		value = maxValue = _maxVal;
		origin.x = origin.y = 0;
		makeGraphic(1, 10, FlxColor.RED);
		scrollFactor.x = scrollFactor.y = 0;
		scale.x = barWidth;
	}
	
	public function setValue(_val:Int)
	{
		scale.x = (_val / maxValue) * barWidth;
		value = _val;
	}
	
}