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
 * Delegate
 *
 * Differs from mx.utils.Delegate by always supplying a reference to itslf as final argument
 * This enables easier removal from event listener / garbage collection
 */

class com.as2flexlogger.utils.Delegate {
	
	public static var CLASS_REF = com.as2flexlogger.utils.Delegate;
	
	public static function create( scope:Object, method:Function ):Function {
		var args:Array = arguments.slice(2);
		return function() {
			return method.apply( scope || arguments.caller, arguments.concat(args, [arguments.callee]) );
		}
	}
	
}