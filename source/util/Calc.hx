package util;

/**
 * ...
 * @author q
 */
class Calc
{
	
	public function new()
	{
		
	}
 
	public static function bisectionSolver(f:Float -> Float, _l:Float, _r:Float):Float
	{
		var res:Float = mid(_l, _r);
		var val:Float = f(res);
		var iter:Int = 30;
		
		while (!feq(val, 0) && (iter-->0))
		{
			res = mid(_l, _r);
			val = f(res);
			if (val < 0)
			_l = res;
			else 
			_r = res;
		}
		return res;
	}

	public static function mid(_f1:Float, _f2:Float):Float
	{
		return (_f1 + _f2) * 0.5;
	}

	public static function feq(_f1:Float, _f2:Float):Bool
	{
		return Math.abs(_f1 - _f2) < 0.0001;
	}

}