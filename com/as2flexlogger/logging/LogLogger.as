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
//  The Original Code is mx.logging.LogLogger of the Adobe Flex 3 SDK
//
//  The Initial Developer of the Original Code is ADOBE SYSTEMS INCORPORATED
//  Portions created by Alec Hill are Copyright (C) 2009 Alec Hill. All Rights Reserved.
//
//  Contributor(s): Alec Hill
//
//  Modifications:
//		- Ported from Actionscript 3.0 to Actionscript 2.0
//		- Uses proprietry event and delegation classes and interfaces in order to circumvent
//		  the different event model in Actionscript 2.0 (included in distribution)
//
///////////////////////////////////////////////////////////////////////////////////////////

import com.as2flexlogger.logging.*;
import com.as2flexlogger.logging.errors.*;

class com.as2flexlogger.logging.LogLogger extends AbstractLogger implements ILogger {
	
	private var _listeningTo:Array = new Array();
	
	private var _category:String;
	
	public function get category():String{
		return _category;
	}
	
	public function LogLogger(category:String){
		super(category);
		//_category = category;
	}
	
	public function addEventListener(event:String, listener:Function):Void{
		super.addEventListener(event, listener);
		if(_listeningTo[event] == undefined){
			_listeningTo[event] = 0;
		}
		_listeningTo[event]++;
	}
	
	public function removeEventListener(event:String, listener:Function):Void{
		super.removeEventListener(event, listener);
		if(_listeningTo[event] != undefined){
			_listeningTo[event]--;
		}
	}
	
	public function hasEventListener(type:String):Boolean{
		return (_listeningTo[type] != undefined && _listeningTo[type] > 0)
	}
	
	public function log(level:Number, message:String, values:Array):Void{
		if(level == undefined || level < LogEventLevel.DEBUG){
			throw new ArgumentError('Invalid logging LogEventLevel');
		}
		if(message == undefined){
			throw new ArgumentError('Invalid logging message');
		}
		//if(hasEventListener(LogEvent.LOG)){
			dispatchEvent(new LogEvent(LogEvent.LOG, this, { level: level, message: replaceTokens(message, values) }));
		//}
	}
	
	public function debug(message:String):Void{
		log(LogEventLevel.DEBUG, message, arguments.slice(1));
	}

	public function info(message:String):Void{
		log(LogEventLevel.INFO, message, arguments.slice(1));
	}

	public function warn(message:String):Void{
		log(LogEventLevel.WARN, message, arguments.slice(1));
	}

	public function error(message:String):Void{
		log(LogEventLevel.ERROR, message, arguments.slice(1));
	}

	public function fatal(message:String):Void{
		log(LogEventLevel.FATAL, message, arguments.slice(1));
	}	
	
	private function replaceTokens(message:String, values:Array):String{
		var index:Number;
		var token:String;
		for(var i:Number = 0; i < values.length; i++){
			token = '{' + i + '}';
			index = message.indexOf(token);
			if(index != -1){
				message = message.split(token).join(values[i]);
			}
		}
		return message;
	}
	
}