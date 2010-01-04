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
//  The Original Code is mx.logging.targets.LineFormattedTarget of the Adobe Flex 3 SDK
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

class com.as2flexlogger.logging.targets.LineFormattedTarget extends AbstractTarget {
	
	public var fieldSeparator:String = " ";
	
	public var includeTime:Boolean = true;
	public var includeDate:Boolean = true;
	public var includeCategory:Boolean = true;
	public var includeLevel:Boolean = true;
	
	public function LineFormattedTarget(){
		super();
	}
	
	public function logEvent(event:LogEvent):Void{
		super();
		var date:String = '';
		var level:String = '';
		var category:String = '';
		if (includeDate || includeTime){
			var d:Date = new Date();
			if(includeDate){
				date += d.getDate().toString() + '/';
				date += Number(d.getMonth() + 1).toString() + '/';
				date += d.getFullYear().toString();
				date += fieldSeparator;
			}
			if(includeTime){
				date += padTime(d.getHours()) + ':';
				date += padTime(d.getMinutes()) + ':';
				date += padTime(d.getSeconds()) + ':';
				date += padTime(d.getMilliseconds(), true);
				date += fieldSeparator;
			}
		}
		if(includeLevel){
			level += '[' + LogEvent.getLevelString(event.level) + ']' + fieldSeparator;
		}
		if(includeCategory){
			category += AbstractLogger(event.target).category + fieldSeparator;
		}
		internalLog(date + category + level + event.message, event.level);
	}
	
	private function padTime(value:Number, milliseconds:Boolean):String{
		if(milliseconds || false){
			if(value < 10){
				return '00' + value.toString();
			}else if(value < 100){
				return '0' + value.toString();
			}else{
				return value.toString();
			}
		}else{
			return value > 9 ? value.toString() : '0' + value.toString();
		}
	}
	
	private function internalLog(message:String, level:Number):Void{
		// override this method to perform the redirection to the desired output
	}
	
}