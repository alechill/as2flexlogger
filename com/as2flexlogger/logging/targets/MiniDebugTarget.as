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
//  The Original Code is mx.logging.targets.MiniDebugTarget of the Adobe Flex 3 SDK
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

import com.as2flexlogger.logging.targets.LineFormattedTarget;
import com.as2flexlogger.utils.Delegate;
import mx.net.LocalConnection;
import mx.events.StatusEvent;
import mx.events.SecurityErrorEvent;

class com.as2flexlogger.logging.targets.MiniDebugTarget extends LineFormattedTarget {
	
	private var _connection:String;
	
	private var _method:String;
	
	private var _localConnection:LocalConnection;
	
	private var _delegatedOnStatus:Function;
	
	private var _delegatedOnSecurityError:Function;
	
	public function MiniDebugTarget(connection:String, method:String){
		super();
		_connection = connection || "_mdbtrace";
		_method = method || "trace";
		_localConnection = new LocalConnection();
		_delegatedOnStatus = Delegate.create(this, onStatus);
		_delegatedOnSecurityError = Delegate.create(this, onSecurityError);
		_localConnection.addEventListener(StatusEvent.STATUS, _delegatedOnStatus);
		_localConnection.addEventListener(SecurityErrorEvent.SECURITY_ERROR, _delegatedOnSecurityError)
	}
	
	private function internalLog(message:String, level:Number):Void{
		_localConnection.send(_connection, _method, message);
	}
	
	private function onStatus(event:StatusEvent):Void{
		if(event.level == 'error') trace('MiniDebugTarget send failed: ' + event.code);
	}
	
	private function onSecurityError(event:SecurityErrorEvent):Void{
		trace('MiniDebugTarget send failed: Security error');
	}
	
}