///////////////////////////////////////////////////////////////////////////////////////////
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

/**
 * AbstractLogger
 *
 * Abstract class for loggers to extend, as AS2 does not allow get/set in interfaces
 */

import mx.events.EventDispatcher;
import com.as2flexlogger.logging.ILogger;

class com.as2flexlogger.logging.AbstractLogger extends EventDispatcher implements ILogger {
	
	private var _category:String;
	
	public function get category():String{
		return _category;
	}
	
	private function AbstractLogger(category:String){
		super();
		_category = category;
	}
	
	public function log(level:Number, message:String, values:Array):Void{
		// override 
	}
	
	public function debug(message:String):Void{
		// override 
	}

	public function info(message:String):Void{
		// override 
	}

	public function warn(message:String):Void{
		// override 
	}

	public function error(message:String):Void{
		// override 
	}

	public function fatal(message:String):Void{
		// override 
	}	
	
	public function addEventListener(event:String, listener:Function):Void{
		super.addEventListener(event, listener);
	}
	
	public function removeEventListener(event:String, listener:Function):Void{
		super.removeEventListener(event, listener);
	}
	
	public function dispatchEvent(eventObject:Object):Void{
		super.dispatchEvent(eventObject);
	}
}