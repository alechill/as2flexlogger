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
 * Event
 *
 * Event base class makes with events a tiny bit more like AS3 (ie using event constants)
 */

class com.as2flexlogger.events.Event extends Object {
	
	public static var EVENT:String = 'event';
	
	public var type:String;
	
	public var target:Object;
	
	public function Event(type:String, target:Object, data:Object){
		super();
		this.type = type || EVENT;
		this.target = target || arguments.caller;
		for(var property:String in data || {}){
			if(property != 'type' && property != 'target' && data[property] != undefined){
				this[property] = data[property];
			}
		}
	}
	
}