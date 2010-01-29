//////////////////////////////////////////////////////////////////////////////////////////
//
//  The contents of this file are subject to the Mozilla Public License
//  Version 1.1 (the "License"); you may not use this file except in
//  compliance with the License. You may obtain a copy of the License at
//  http://www.mozilla.org/MPL/
//
//  Software distributed under the License is distributed on an "AS IS"
//  basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. See the
//  License for the specific language governing rights and limitations
//  under the License.
//
//  Copyright 2009 Alec Hill
//  All Rights Reserved.
//
//  NOTICE: Alec Hill permits you to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//
///////////////////////////////////////////////////////////////////////////////////////////

// NOTE - must include TextArea component in library - wont error but you will see no output

import mx.controls.TextArea;
import com.as2flexlogger.logging.targets.LineFormattedTarget;

class com.as2flexlogger.logging.targets.TextAreaTarget extends LineFormattedTarget {
	
	// Constants:	
	public static var CLASS_REF = com.as2flexlogger.logging.targets.TextAreaTarget;

	public static var NEWEST_AT_TOP:Number = 1;
	public static var NEWEST_AT_BOTTOM:Number = 0;
	
	private var _textarea:TextArea;
	
	private var _margin:Number = 20;
	
	private var _direction:Number = NEWEST_AT_BOTTOM;
	
	/**
	 * constructor
	 */
	public function TextAreaTarget(direction:Number) {
		super();
		if(direction != undefined) _direction = direction;
		createTextArea();
	}
	
	/**
	 * output logging to the textarea
	 */
	private function internalLog(message:String, level:Number):Void{
		if( hasTextArea() ){
			if(_direction == NEWEST_AT_TOP){
				_textarea.text = message + "\n" + _textarea.text;
			}else{
				_textarea.text += message + "\n";
				_textarea.vPosition = _textarea.maxVPosition;
			}
		}
	}
	
	/**
	 * create the text area to log to
	 */
	public function createTextArea(){
		if( !hasTextArea() ){
			var depth:Number = _root.getNextHigehstDepth();
			_root.attachMovie(
				mx.controls.TextArea.symbolName, 
				'textAreaLogTarget_' + depth,
				depth, 
				{ 
					_height: (Stage.height * 0.5) - _margin, 
					_width: (Stage.width * 0.7) - _margin,
					_x: _margin, 
					_y: Stage.height * 0.5 ,
					_visible: true
			
				}
			);
			_textarea = _root['textAreaLogTarget_' + depth];
		}
	}
	
	/**
	 * remove the text area (logging will not be sent to it any more)
	 */
	public function removeTextArea(){
		if( hasTextArea() ){
			_textarea.removeMovieClip();
			_textarea = undefined;
		}
	}
	
	/**
	 * is there a text area?
	 *
	 * @return boolean
	 */
	public function hasTextArea(){
		return _textarea != undefined;
	}
	
	/**
	 * show it (will contained everything logged be while hidden)
	 */
	public function show(){
		if( hasTextArea() ){
			_textarea._visible = true;
		}
	}

	
	/**
	 * hide it (will still be logged to in background)
	 */
	public function hide(){
		if( hasTextArea() ){
			_textarea._visible = false;
		}
	}
}