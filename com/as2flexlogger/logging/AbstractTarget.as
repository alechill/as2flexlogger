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
//  The Original Code is mx.logging.AbstractTarget of the Adobe Flex 3 SDK
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

import com.alechill.logging.*;
import com.alechill.logging.errors.*;
import com.alechill.utils.Delegate;

class com.alechill.logging.AbstractTarget implements ILoggingTarget {
	
	private var _delegatedLogHandler:Function;
	
	private var _id:String;
	public function get id():String {
		return _id;
	}
	
	private var _loggerCount:Number = 0;
	
	private var _level:Number = LogEventLevel.ALL;
	public function get level():Number{
		return _level;
	}
	public function set level(value:Number):Void{
		Log.removeTarget(this);
		_level = value;
		Log.addTarget(this);
	}
	
	private var _filters:Array = new Array('*');
	public function get filters():Array{
		return _filters;
	}
	public function set filters(value:Array):Void {
		if(value && value.length > 0){
			var filter:String;
			var index:Number;
			for(var i:Number = 0; i < value.length; i++){
				filter = value[i];
				if (Log.hasIllegalCharacters(filter)){
					throw new InvalidFilterError('Filter for logging has invalid characters: ' + filter);
				}
				index = filter.indexOf('*');
				if(index >= 0 && index != (filter.length - 1) ){
					throw new InvalidFilterError('Filter for logging can only have * at end of filter: ' + filter);
				}
			}
		}else{
			value = new Array('*');
		}
		if(_loggerCount > 0){
			Log.removeTarget(this);
			_filters = value;
			Log.addTarget(this);
		}else{
			_filters = value;
		}
	}
	
	private function AbstractTarget(){
		// delegate the event handler
		_delegatedLogHandler = Delegate.create( this, logHandler);
	}
	
	public function addLogger(logger:ILogger):Void{
		if(logger){
			_loggerCount++;
			logger.addEventListener(LogEvent.LOG,  _delegatedLogHandler);
		}
	}
	
	public function removeLogger(logger:ILogger):Void{
		if(logger){
			_loggerCount--;
			logger.removeEventListener(LogEvent.LOG, _delegatedLogHandler);
		}
	}
	
	public function logEvent(event:LogEvent):Void{
		// override this method
	}
	
	private function logHandler(event:LogEvent):Void{
		if (event.level >= level) logEvent(event);
	}
	
}