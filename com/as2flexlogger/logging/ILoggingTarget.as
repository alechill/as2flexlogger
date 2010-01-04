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
//  The Original Code is mx.logging.ILoggingTarget of the Adobe Flex 3 SDK
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

import com.as2flexlogger.logging.ILogger;

interface com.as2flexlogger.logging.ILoggingTarget {
	
	// get / set methods cannot be defined in interfaces in AS2... 
	// so will be implemented in abstract class instead
	
	function addLogger(logger:ILogger):Void;
	
	function removeLogger(logger:ILogger):Void;
	
}