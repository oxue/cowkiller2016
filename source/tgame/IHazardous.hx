package tgame;
import flixel.FlxObject;

/**
 * ...
 * @author q
 */
interface IHazardous 
{
	public function damage(_c:FlxObject):Void;
	public function oneTime():Bool;
	
}