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
 * JavascriptTarget
 *
 * Logging to javascript function
 */

import com.alechill.logging.targets.LineFormattedTarget;
import flash.external.ExternalInterface;

class com.alechill.logging.targets.JavascriptTarget extends LineFormattedTarget {
	
	public function JavascriptTarget(externalMethod:String){
		super();
	}
	
	private function callExternalMethod(method:String, message:String):Void{
		if(ExternalInterface.available){
			try{
				ExternalInterface.call(method, message)
			}catch(e){}
		}
	}
	
	private function internalLog(message:String, level:Number):Void{
		callExternalMethod('alert', message);
	}
	
}