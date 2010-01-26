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
//  The Original Code is mx.logging.Log of the Adobe Flex 3 SDK
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
import com.as2flexlogger.logging.targets.*;
import com.as2flexlogger.logging.errors.*;

class com.as2flexlogger.logging.Log {
	
	private static var NONE:Number = 2147483647;
	
	private static var _illegalCharacters = new Array(
		'[',']','~','$','^','&','(',')','{','}','+','?','=','`',
		'!','@','#','%',',',':',';',"'",'"','<','>',' ',']','/'
	);
	
	private static var _loggers:Array = new Array();
	
	private static var _filters:Array = new Array();
	
	private static var _targets:Array = new Array();
	
	private static var _targetLevel:Number = NONE;
	
	public static function getLogger(category:String):ILogger {
		checkCategory(category);
		
		if(_loggers[category] == undefined){
			_loggers[category] = new LogLogger(category);
			
			var target:AbstractTarget;
			for(var i:Number = 0; i < _targets.length; i++){
				target = _targets[i];
				if( categoryMatchInFilterList(category, target.filters) ){ 
					target.addLogger(_loggers[category]);
				}
			}
		}
		
		return _loggers[category];
	}
	
	public static function isAll():Boolean{
		return (_targetLevel <= LogEventLevel.ALL);
	}
	
	public static function isDebug():Boolean{
		return (_targetLevel <= LogEventLevel.DEBUG);
	}
	
	public static function isInfo():Boolean{
		return (_targetLevel <= LogEventLevel.INFO);
	}
	
	public static function isWarn():Boolean{
		return (_targetLevel <= LogEventLevel.WARN);
	}
	
	public static function isError():Boolean{
		return (_targetLevel <= LogEventLevel.ERROR);
	}
	
	public static function isFatal():Boolean{
		return (_targetLevel <= LogEventLevel.FATAL);
	}
	
	public static function addTarget(target:AbstractTarget):Void{
		if(target){
			if(!Log.hasTarget(target)){
				// check if we already have filters matching this target 
				var filters:Array = target.filters;
				for(var category:String in _loggers){
					if(categoryMatchInFilterList(category, filters)){
						target.addLogger(_loggers[category]);
					}
				}
				// add to queue
				_targets.push(target);
				// set the target level if lower than currently is
				if(_targetLevel == NONE){
					_targetLevel = target.level;
				}else if(target.level < _targetLevel){
					_targetLevel = target.level;
				}
			}
		}else{
			throw new ArgumentError('Invalid target for logging');
		}
	}
	
	public static function removeTarget(target:AbstractTarget):Void{
		if(target){
			// remove from matching loggers 
			var filters:Array = target.filters;
			for(var category:String in _loggers){
				if(categoryMatchInFilterList(category, filters)){
					target.removeLogger(_loggers[category]);
				}
			}
			// remove from queue
			for(var i:Number = 0; i < _targets.length; i++){
				if(target == _targets[i]){
					_targets.splice(i, 1);
					i--;
				}
			}
			resetTargetLevel();
		}else{
			throw new ArgumentError('Invalid target for logging');
		}
	}
	
	public static function hasTarget(target:AbstractTarget):Boolean{
		for(var i:Number = 0; i < _targets.length; i++){
			if(target == _targets[i]) return true;
		}
		return false;
	}
	
	public static function flush():Void{
		_loggers = new Array();
		_filters = new Array();
		_targetLevel = NONE;
	}
	
	public static function hasIllegalCharacters(value:String):Boolean{
		var result:Boolean = false;
		for(var i:Number = 0; i < _illegalCharacters.length; i++){
			if(value.indexOf(_illegalCharacters[i]) != -1) return true;
		}
	}	
	
	private static function categoryMatchInFilterList(category:String, filters:Array):Boolean{
		var filter:String;
		var index:Number = -1
		for(var i:Number = 0; i < filters.length; i++){
			filter = filters[i];
			index = filter.indexOf('*');
			if(index == 0){
				return true;
			}
			index = index < 0 ? index = category.length : index - 1;
			if(category.substring(0, index) == filter.substring(0, index)){
				return true;
			}
		}
		return false;
	}
	
	private static function checkCategory(category:String):Void{
		if(category == undefined || !category.length){ 
			throw new InvalidCategoryError('Invalid length of logging category string');
		}
		if(hasIllegalCharacters(category) || category.indexOf("*") != -1){ 
			throw new InvalidCategoryError('Invalid characters in logging category string');
		}
	}
	
	private static function resetTargetLevel():Void{
		var minLevel:Number = NONE;
		for(var i:Number = 0; i < _targets.length; i++){
			if(minLevel == NONE || _targets[i].level < minLevel){
				minLevel = _targets[i].level;
			}
		}
		_targetLevel =  minLevel;
	}
	
}