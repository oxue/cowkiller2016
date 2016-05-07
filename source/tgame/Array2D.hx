package tgame;
import flixel.util.FlxPoint;
import sys.db.Types.STinyInt;

/**
 * ...
 * @author q
 */
class Array2D<DataType>
{

	private var data:Array<DataType>;
	private var width:Int;
	private var height:Int;
	
	public function new(_w:Int, _h:Int, _defVal:DataType) 
	{
		var len:Int = _w * _h;
		data = [for (i in 0...len) _defVal];
		
		width = _w;
		height = _h;
	}
	
	public function get(_x:Int, _y:Int):DataType
	{
		return data[_y * width + _x];
	}
	
	public function set(_x:Int, _y:Int, _val:DataType):Void
	{
		data[_y * width + _x] = _val;
	}
	
	public function getWidth():Int
	{
		return width;
	}
	
	public function getHeight():Int
	{
		return height;
	}
	
	public function getInternalData():Array<DataType>
	{
		return data;
	}
	
}