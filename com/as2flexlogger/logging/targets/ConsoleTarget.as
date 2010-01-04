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
 * ConsoleTarget
 *
 * Logging to javascript console using the console's corresponding log levels 
 */

import com.as2flexlogger.logging.LogEventLevel;
import com.as2flexlogger.logging.targets.JavascriptTarget;

class com.as2flexlogger.logging.targets.ConsoleTarget extends JavascriptTarget {
	
	public function ConsoleTarget(){
		super();
	}
	
	private function internalLog(message:String, level:Number):Void{
		var method:String = 'console.';
		switch(level){
			case LogEventLevel.FATAL:
			case LogEventLevel.ERROR:
				method += 'error';
				break;
			case LogEventLevel.WARN:
				method += 'warn';
				break;
			case LogEventLevel.INFO:
				method += 'info';
				break;
			case LogEventLevel.DEBUG:
				method += 'debug';
				break;
			default:
				method += 'log';
		}
		callExternalMethod(method, message);
	}
	
}