package tgame;

import flash.display.Sprite;
import flash.events.MouseEvent;
import openfl.text.TextField;
import openfl.text.TextFormat;

/**
 * ...
 * @author qwerber
 */
class DialogueBox extends Sprite
{
	private var textBox:TextField;
	private var xButton:Sprite;
	
	public function new() 
	{
		super();
		
		graphics.beginFill(0x222222);
		graphics.drawRect(0, 0, GameConstants.DIALOGUE_BOX_W, GameConstants.DIALOGUE_BOX_H);
		
		textBox = new TextField();
		textBox.x = textBox.y = 10;
		textBox.width = GameConstants.DIALOGUE_BOX_W - 20;
		textBox.height = 100;
		textBox.selectable = false;
		textBox.defaultTextFormat = new TextFormat("arial", 12, 0xfffffff);
		this.addChild(textBox);
		
		xButton = new Sprite();
		xButton.graphics.beginFill(0x333333);
		xButton.graphics.drawRect(0, 0, 10, 10);
		xButton.graphics.lineStyle(2, 0xff0000);
		xButton.graphics.moveTo(0, 0);
		xButton.graphics.lineTo(10, 10);
		xButton.graphics.moveTo(0, 10);
		xButton.graphics.lineTo(10, 0);
		xButton.x = GameConstants.DIALOGUE_BOX_W - 10;
		xButton.addEventListener(MouseEvent.CLICK, destroy);
		addChild(xButton);
	}
	
	private function destroy(e:MouseEvent):Void 
	{
		xButton.removeEventListener(MouseEvent.CLICK, destroy);
		this.parent.removeChild(this);
	}
	
	public function setText(_msg:String) {
		textBox.text = _msg;
		textBox.height = textBox.textHeight;
	}
	
}